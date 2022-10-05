
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/05 10:58:38
// Design Name: 
// Module Name: cam_ini
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


module camera_ini(
                 input                   CLK_SYS,           //系统时钟
                 input                   clk,               //分频时钟
                 input                   RESETn,            //系统复位
                 input                   PCLKEN,            //apb总线时钟
                 input      [11:0]       PADDR,             //apb地址总线 
                 input                   PWRITE,            //apb读写信号线
                 input                   PSEL,              //apb片选
                 input                   PENABLE,           //apb读写使能
                 input      [31:0]       PWDATA,            //apb数据总线
                 input      [8:0]        rdata_iic,
                 input      [3:0]        state,
                 inout                   SDA,               //I2C串行数据总线
                 output reg [31:0]       PRDATA,            //apb读数据总线
                 output reg [23:0]       addr_data,         //送到I2C的地址和数据
                 output wire             SCL,               //I2C的总线时钟
                 output reg              ready2send,
                 output reg              ready2read
    );   
   
reg [7:0]        cntr_reg;               //控制寄存器
reg [7:0]        rdata_reg;              //读数据寄存器
reg [7:0]        wdata_reg;              //写数据寄存器
reg [15:0]       addr_reg;               //地址寄存器
   
    
localparam        wdata_reg_ADDR = 0;    // 0x000
localparam        rdata_reg_ADDR = 4;    // 0x004
localparam         addr_reg_ADDR = 8;    // 0x008
localparam         cntr_reg_ADDR = 12;   // 0x00C

IIC IIC (
                 .CLK_SYS                (CLK_SYS),
                 .RESETn                 (RESETn),
                 .addr_data              (addr_data),
                 .rdata_iic              (rdata_iic),
                 .SCL                    (SCL),
                 .SDA                    (SDA),
                 .clk                    (clk),
                 .ready2send             (ready2send),
                 .ready2read             (ready2read),
                 .state                  (state)
      );

//apb to ini/////////////////////////////////////////////////

  always @(posedge CLK_SYS )
      begin
            if(!RESETn)
              begin
                 wdata_reg<=0;
              end
            else  if(PCLKEN & PENABLE & PSEL & PWRITE & (PADDR == wdata_reg_ADDR))
                    begin
                      wdata_reg<=PWDATA[7:0];
                    end
                  else 
                    begin
                      wdata_reg<=wdata_reg;
                    end                       
       end  

  always @(posedge CLK_SYS )
      begin
            if(!RESETn)
              begin
                addr_reg<=0; 
              end
            else  if(PCLKEN & PENABLE & PSEL & PWRITE & (PADDR == addr_reg_ADDR))
                    begin
                      addr_reg<=PWDATA[15:0];
                    end
                  else 
                    begin
                      addr_reg<=addr_reg;
                    end
       end 

  always @(posedge CLK_SYS )
      begin
           if(!RESETn)
             begin
                cntr_reg<=8'b00001010;
             end
           else if(PCLKEN & PENABLE & PSEL & PWRITE & (PADDR == cntr_reg_ADDR))
                  begin
                   cntr_reg<=PWDATA[7:0];
                  end

                 else 
                   begin
                      if((state==0) & clk & ~SCL)
                        begin
                          cntr_reg[1]<=1;
                          cntr_reg[3]<=1;
                        end
                      else if(state==7 & clk & ~SCL)
                             begin
                               cntr_reg[3]<=1;
                               cntr_reg[1]<=1;
                               cntr_reg[0]<=0;
                             end
                           else if(state==14 & clk & ~SCL)
                                  begin
                                    cntr_reg[3]<=1;
                                    cntr_reg[2]<=0;
                                    cntr_reg[1]<=1;
                                  end
                                else 
                                  begin
                                    cntr_reg<=cntr_reg;
                                  end
                      if(PCLKEN & PENABLE & PSEL & PWRITE & (rdata_reg!=0))
                         begin
                           cntr_reg[4]<=1;
                         end
                      else 
                         begin
                           cntr_reg[4]<=0;
                         end
                    end
       end

//ini to iic////////////////////////////////////////////////////
  always @(posedge CLK_SYS )
          begin
            if(!RESETn)
               begin
                    addr_data<=0;
               end
            else if(ready2send | ready2read)
                    begin
                        addr_data<=addr_data;
                    end
                 else if(cntr_reg[0]==1 | cntr_reg[2]==1)
                        begin
                          addr_data[23:8]<=addr_reg;
                           addr_data[7:0]<=wdata_reg;
                        end
                      else 
                        begin
                          addr_data<=0;
                        end
        end

  always @(posedge CLK_SYS )
        begin
              if((cntr_reg[0]==1))
                    begin
                       if(state==8)
                         begin
                           ready2send<=0;
                         end
                       else 
                         begin
                           ready2send<=1;
                         end
                    end
              else 
                  begin
                    ready2send<=0;
                  end
        end
  always @(posedge CLK_SYS )
        begin
               if(cntr_reg[2]==1)
                    begin
                      ready2read<=1;
                    end
               else 
                    begin 
                      ready2read<=0;
                    end
        end 

//ini to apb//////////////////////////////////////////////////
    always @(posedge CLK_SYS)
      begin
         if(!RESETn)
            begin
              rdata_reg<=0;
            end
         else if( PENABLE & PSEL & ~PWRITE)
            case(PADDR[11:0])
              wdata_reg_ADDR: PRDATA <= wdata_reg;
              rdata_reg_ADDR: begin
                                rdata_reg = rdata_iic[7:0];
                                   PRDATA = rdata_reg;
                                rdata_reg = 0;
                              end
               addr_reg_ADDR: PRDATA <= addr_reg;
               cntr_reg_ADDR: PRDATA <= cntr_reg;
                     default: PRDATA <= 32'hcccc_cccc;
            endcase
      end

endmodule

