`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/09 08:48:01
// Design Name: 
// Module Name: centroid_calculator_cxy
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


module centroid_calculator_cxy (
    input                   CLK,
    input                   RSTn,
    input                   DIN_VALID,
    input                   LAST_PIX_VALID,
    input                   DIN,

    output reg      [17:0]  H_TOTAL,
    output reg      [17:0]  V_TOTAL,
    output reg      [12:0]  SUM,
    output reg              VALID
    );

    reg             [5:0]   h_cnt;
    reg             [5:0]   v_cnt;

    always @(posedge CLK)
    begin
        if(~RSTn)
            h_cnt <= 0;
        else if(DIN_VALID)
            h_cnt <= h_cnt + 1;
        else
            h_cnt <= h_cnt;
    end

    always @(posedge CLK)
    begin
        if(~RSTn)
            v_cnt <= 0;
        else if(DIN_VALID & (h_cnt == 63))
            v_cnt <= v_cnt + 1;
        else
            v_cnt <= v_cnt;
    end

    always @(posedge CLK)
    begin
        if(~RSTn)
        begin
            H_TOTAL <= 0;
            V_TOTAL <= 0;
            SUM     <= 0;
        end
        else if(DIN_VALID & DIN)
        begin
            H_TOTAL <= H_TOTAL + h_cnt;
            V_TOTAL <= V_TOTAL + v_cnt;
            SUM     <= SUM     + 1;
        end
        else
        begin
            H_TOTAL <= H_TOTAL;
            V_TOTAL <= V_TOTAL;
            SUM     <= SUM;
        end
    end


    always @(posedge CLK)
    begin
        // if((h_cnt == 63) && (v_cnt == 63) && DIN_VALID)
        //     VALID <= 1'b1;
        // else
        //     VALID <= 1'b0;
        VALID <= LAST_PIX_VALID;
    end

endmodule
