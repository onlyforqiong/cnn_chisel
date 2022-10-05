
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/02/25 11:14:46
// Design Name: 
// Module Name: IIC_1
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module IIC (  
                 input              CLK_SYS,        //系统时钟
                 input              RESETn,         //系统复位
                 input       [23:0] addr_data,      //送到I2C的地址和数据
                 input              ready2send,     //I2C的允许发送
                 input              ready2read,     //I2C允许读取
                 inout              SDA,            //I2C串行数据总线
                 output reg         SCL,            //I2C的总线时钟
                 output reg         clk,
                 output reg  [8:0]  rdata_iic,      //读数据寄存器
                 output reg  [3:0]  state           //状态寄存器
          );  


  reg [11:0]     counter_clk;       //分频计数器
  reg            link_sda;          //总线开关
  reg            sda_buf;           //总线数据缓存器
  reg [3:0]      counter;           //数据移位计数器
  reg [7:0]      data;              //待发送控制字、地址、数据寄存器

localparam       ID_W = 120;        //0x78
localparam       ID_R = 121;        //0x79

  assign SDA=(link_sda)?sda_buf:1'hz;

//////////////////////////////////////////////////////////// 
   always @(posedge CLK_SYS )
      begin
          if(!RESETn | counter_clk==499)
              begin
                counter_clk<=0;
              end
          else 
              begin
                counter_clk<=counter_clk+1;
              end
      end

  always @(posedge CLK_SYS)
      begin
          if(!RESETn | state==0)
              begin
                clk<=1'b0;
              end
          else if(counter_clk==124 | counter_clk==374 )
                   begin
                     clk<=1'b1;
                   end
               else 
                   begin
                     clk<=1'b0;
                   end
      end

  always @(posedge CLK_SYS)
      begin
          if(!RESETn | state==0 | state==1 |( state==8 & counter_clk ==249) | (state==10 & counter_clk==249) | state==11)
         //if(!RESETn | state==0)
              begin
                  SCL<=1'b1;
              end
          else if(counter_clk==249)
                 begin
                   SCL<=1'b1;
                 end
               else if(counter_clk==499)
                      begin
                        SCL<=1'b0;
                      end
                    else 
                      begin
                        SCL<=SCL;
                      end

      end
//iic to cam/////////////////////////////////////////////////////// 
  always @(posedge CLK_SYS)
      begin
          if(!RESETn)
              begin
                  state<=0;
                  link_sda<=0;
                  sda_buf<=0;
                  counter<=0;
                  data<=0;
                  rdata_iic<=0;
              end
          else 
              begin 
                  case(state)
  //start-----------------------------------------------------
                      0:begin
                          if( ready2send | ready2read )
                              begin
                                  link_sda<=1;
                                  sda_buf<=1;
                                  state<=1;
                              end
                        end
                      1:begin
                          if(SCL & clk)
                              begin
                                  sda_buf<=0;
                                  state<=2;
                                  data<=ID_W;   
                              end
                        end
 //ID----------------------------------------------------------
                     2:begin
                         if((counter<8)&&(!SCL)&&(clk))
                             begin
                                 counter<=counter+1'b1;
                                 sda_buf<=data[7];
                                 data<={data[6:0],data[7]};
                             end
                         else if((counter==8)&&(!SCL)&&(clk))
                             begin
                                 counter<=0;
                                 state<=3;
                                 link_sda<=0;
                                 data<=addr_data[23:16];       
                             end
                     end
 //ack? -------------------------------------------------------
 //                  3:begin
 //                     if(SCL & clk)
 //                         begin
 //                             if(!SDA)
 //                                 begin
 //                                     state<=4;
 //                                     data<=addr_data[23:16];
 //                                 end
 //                         end
 //                 end
 //high addr---------------------------------------------------
                     3:begin
                         if(clk & ~SCL)
                           begin
                             link_sda<=1;
                           end
                         if((counter<8)&&(!SCL)&&(clk))
                             begin
                                 counter<=counter+1'b1;
                                 sda_buf<=data[7];
                                 data<={data[6:0],data[7]};
                             end
                         else if((counter==8)&&(!SCL)&&(clk))
                             begin
                                 counter<=0;
                                 state<=4;
                                 link_sda<=0;
                                 data<=addr_data[15:8];       
                             end
                     end
//ack? ---------------------------------------------------------
 //                   5:begin
 //                      if(SCL & clk)
 //                          begin
 //                              if(!SDA)
 //                                  begin
 //                                      state<=6;
 //                                      data<=addr_data[15:8];
 //                                  end
 //                          end
 //                  end
 //low addr-----------------------------------------------------
                     4:begin
                         if(clk & ~SCL)
                           begin
                             link_sda<=1;
                           end
                         if((counter<8)&&(!SCL)&&(clk))
                             begin
                                 counter<=counter+1'b1;
                                 sda_buf<=data[7];
                                 data<={data[6:0],data[7]};
                             end
                         else if((counter==8)&&(!SCL)&&(clk))
                             begin
                                 counter<=0;
                                 state<=5;
                                 sda_buf<=1;
                                 link_sda<=0;
                             end
                       end
//read or write? -----------------------------------------------
                      5:begin
 //                        if(SCL & clk)
 //                           begin
 //                              if(!SDA)
 //                                 begin
                                      if(ready2send & clk)
                                          begin
                                            state<=6;
                                            link_sda<=0;
                                            data<=addr_data[7:0];
                                           end
                                      else if(ready2read & clk)
                                              begin
                                               state<=9;
                                               link_sda<=0;
                                               data<=ID_R;
                                              end
 //                                  end
 //                            end
                         end

 //data(send)----------------------------------------------------
                     6:begin
                         if(clk & ~SCL)
                           begin
                             link_sda<=1;
                           end
                         if((counter<8)&&(!SCL)&&(clk))
                             begin
                                 counter<=counter+1'b1;
                                 sda_buf<=data[7];
                                 data<={data[6:0],data[7]};
                             end
                         else if((counter==8)&&(!SCL)&&(clk))
                             begin
                                 counter<=0;
                                 state<=7;
                                 link_sda<=0;
                             end
                       end
//ack? -----------------------------------------------------------
//                   9:begin
//                       if(SCL & clk)
//                           begin
//                               if(!SDA)
//                                   begin
//                                       state<=8;
//                                   end
//                           end
//                     end
 //stop write-----------------------------------------------------
                     7:begin
                        if(~SCL & clk)
                          begin
                             link_sda<=1;
                             sda_buf<=0;
                             state<=8;
                          end
                       end

                     8:begin
                         if(SCL & clk)
                           begin
                             sda_buf<=1;
                             state<=0;
                           end
                       end
 //stop & start in trans------------------------------------------------
                     9:begin
                        if(~SCL & clk)
                          begin
                             link_sda<=1;
                             sda_buf<=0;
                             state<=10;
                          end
                       end
                     10:begin
                         if(SCL & clk)
                           begin
                             sda_buf<=1;
                             state<=11;
                           end
                       end
                     11:begin
                         if(SCL & clk)
                           begin
                             sda_buf<=0;
                             state<=12;  
                           end 
                        end
//ID_R------------------------------------------------------------------
                     12:begin
                         if(clk & ~SCL)
                           begin
                             link_sda<=1;
                           end
                        if((counter<8)&&(!SCL)&&(clk))
                            begin
                                counter<=counter+1'b1;
                                sda_buf<=data[7];
                                data<={data[6:0],data[7]};
                            end
                        else if((counter==8)&&(!SCL)&&(clk))
                            begin
                                counter<=0;
                                state<=13;
                                link_sda<=0;     
                            end                         
                       end
//ack? ------------------------------------------------------------------
//                   13:begin
//                       if(SCL & clk)
//                           begin
//                               if(!SDA)
//                                   begin
//                                       state<=8;
//                                   end
//                           end
//                     end
//data(read)-------------------------------------------------------------
                     13:begin
                        //if(clk & ~SCL)
                        //  begin
                        //    link_sda<=1;
                        //  end
                         if((counter<9)&&(SCL)&&(clk))
                            begin
                              counter<=counter+1;
                              rdata_iic[8-counter]<=SDA;
                            end
                          else if(counter==9 & clk)
                                 begin
                                   counter<=0;
                                   state<=14;
                                   sda_buf<=1;
                                   link_sda<=1;
                                 end
                        end
 //stop read-------------------------------------------------------- 
                     14:begin
                        if(~SCL & clk)
                          begin
                             link_sda<=1;
                             sda_buf<=0;
                             state<=8;
                          end
                       end
                 default:state<=0;
                endcase
            end
     end
 endmodule