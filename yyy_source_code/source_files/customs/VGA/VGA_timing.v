`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/21 08:55:36
// Design Name: 
// Module Name: VGA_timing
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


module VGA_640x480(pclk, reset, hsync, vsync, valid, h_cnt, v_cnt);
   input        pclk;
   input        reset;
   output reg       hsync;
   output reg       vsync;
   output reg       valid;
   output reg [9:0] h_cnt;
   output reg [9:0] v_cnt;
   
   parameter    h_frontporch = 96;
   parameter    h_active = 144;
   parameter    h_backporch = 784;
   parameter    h_total = 800;
   
   parameter    v_frontporch = 2;
   parameter    v_active = 35;
   parameter    v_backporch = 515;
   parameter    v_total = 525;
   
   reg [9:0]    x_cnt;
   reg [9:0]    y_cnt;
   
   wire         h_valid;
   wire         v_valid;
   
   
   always @(posedge pclk)
      if (reset == 1'b1)
         x_cnt <= 1;
      else 
      begin
         if (x_cnt == h_total)
            x_cnt <= 1;
         else
            x_cnt <= x_cnt + 1;
      end
   
   
   always @(posedge pclk)
      if (reset == 1'b1)
         y_cnt <= 1;
      else 
      begin
         if (y_cnt == v_total & x_cnt == h_total)
            y_cnt <= 1;
         else if (x_cnt == h_total)
            y_cnt <= y_cnt + 1;
      end

    wire        pre_hsync, pre_vsync;
   
   assign pre_hsync = ((x_cnt > h_frontporch)) ? 1'b1 : 
                  1'b0;
   assign pre_vsync = ((y_cnt > v_frontporch)) ? 1'b1 : 
                  1'b0;

   always @(posedge pclk) begin
   //    if(x_cnt == h_total)
   //       hsync <= 1'b0;
   //    else if(x_cnt > h_frontporch - 1)
   //       hsync <= 1'b1;
   //    else
   //       hsync <= 1'b0;
        hsync <= pre_hsync;
   end

   always @(posedge pclk) begin
   //    if(y_cnt == v_total & x_cnt == h_total)
   //       vsync <= 1'b0;
   //    else if(y_cnt > v_frontporch - 1)
   //       vsync <= 1'b1;
   //    else
   //       vsync <= 1'b0;
        vsync <= pre_vsync;
   end
   
   assign h_valid = ((x_cnt > h_active) & (x_cnt <= h_backporch)) ? 1'b1 : 
                    1'b0;
   assign v_valid = ((y_cnt > v_active) & (y_cnt <= v_backporch)) ? 1'b1 : 
                    1'b0;

    wire pre_valid;
    wire [9:0] pre_h_cnt;
    wire [9:0] pre_v_cnt;
   
   assign pre_valid = ((h_valid == 1'b1) & (v_valid == 1'b1)) ? 1'b1 : 
                  1'b0;
   
   assign pre_h_cnt = ((h_valid == 1'b1)) ? x_cnt - 144 : 
                  {10{1'b0}};
   assign pre_v_cnt = ((v_valid == 1'b1)) ? y_cnt - 35 : 
                  {10{1'b0}};
   
    always @(posedge pclk) begin
        valid <= pre_valid;
        h_cnt <= pre_h_cnt;
        v_cnt <= pre_v_cnt;
    end

endmodule
