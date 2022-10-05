`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/03 16:52:23
// Design Name: 
// Module Name: RGB_binarize_cxy
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


module RGB_binarize_cxy #(
        parameter filename_h = "",
        parameter filename_s = ""
    )
    (
        input               CLK,
        input               RGB_VALID,
        input       [11:0]  RGB,
    
        input        [8:0]  H_MAX,
        input        [8:0]  H_MIN,
        input        [6:0]  S_MAX,
        input        [6:0]  S_MIN,
        input        [5:0]  V_MAX,
        input        [5:0]  V_MIN,

        output              OUT,
        output reg          VALID
    );

    reg     [8:0]       H;
    reg     [6:0]       S;
    reg     [5:0]       V;
    wire                H_bin;
    wire                S_bin;
    wire                V_bin;

    (*ram_style="block"*) reg   [8:0]   reg_rgb2h[0:4095];
    (*ram_style="block"*) reg   [6:0]   reg_rgb2s[0:4095];

    initial begin
        $readmemh(filename_h, reg_rgb2h);
        $readmemh(filename_s, reg_rgb2s);
    end

    wire [3:0]  R = RGB[11:8];
    wire [3:0]  G = RGB[ 7:4];
    wire [3:0]  B = RGB[ 3:0];

    always @(posedge CLK) begin
        if(RGB_VALID) begin
            H <= reg_rgb2h[RGB];
            S <= reg_rgb2s[RGB];
            V <= R + G + B;
        end
        else begin
            H <= H;
            S <= S;
            V <= V;
        end
    end

    assign H_bin = ((H <= H_MAX) & (H >= H_MIN)) ? 1'b1 : 1'b0;
    assign S_bin = ((S <= S_MAX) & (S >= S_MIN)) ? 1'b1 : 1'b0;
    assign V_bin = ((V <= V_MAX) & (V >= V_MIN)) ? 1'b1 : 1'b0;

    assign OUT = H_bin & S_bin & V_bin;
    
    always @(posedge CLK) begin
        VALID <= RGB_VALID;
    end   

endmodule
