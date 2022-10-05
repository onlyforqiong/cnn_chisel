`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/22 22:01:20
// Design Name: 
// Module Name: conv_core_parallel_cxy
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


module conv_core_parallel_cxy #(
        parameter   P_WIDTH     = 16,
        parameter   P_HEIGHT    = 16,
        parameter   P_WCNT_W    = 4,
        parameter   P_HCNT_W    = 4,
        parameter   P_PIX_CNT_W = 8,
        parameter   DW          = 24
    )
    (
        input                   CLK,
        input                   RSTn,
        input                   DIN_VALID,
        input       [DW-1:0]    DIN,

        input                   SQUEEZE,

        input       [DW-1:0]    W_11,
        input       [DW-1:0]    W_12,
        input       [DW-1:0]    W_13,
        input       [DW-1:0]    W_21,
        input       [DW-1:0]    W_22,
        input       [DW-1:0]    W_23,
        input       [DW-1:0]    W_31,
        input       [DW-1:0]    W_32,
        input       [DW-1:0]    W_33,
        input       [DW-1:0]    B,

        output reg  [DW-1:0]    OUT,
        output reg              VALID,
        output reg              LAST_IN_LINE,
        output reg              LAST_PIX
    );
    localparam OUT_L = DW-6;
    localparam OUT_H = DW*2-7;

    //----------------------------------
    // 滑动窗

    wire           slide_window_valid;
    wire           last_in_line;
    wire           last_pixel;

    wire    [DW-1:0] x_11, x_12, x_13;
    wire    [DW-1:0] x_21, x_22, x_23;
    wire    [DW-1:0] x_31, x_32, x_33;

    slide_window_3x3_cxy #(
        .P_WIDTH     (P_WIDTH    ),
        .P_HEIGHT    (P_HEIGHT   ),
        .P_WCNT_W    (P_WCNT_W   ),
        .P_HCNT_W    (P_HCNT_W   ),
        .P_PIX_CNT_W (P_PIX_CNT_W),
        .DW          (DW         )
    )
    u_slide_window_3x3 (
        .CLK            (CLK),
        .RSTn           (RSTn),
        .DIN_VALID      (DIN_VALID | SQUEEZE),
        .DIN            (DIN),

        .P_BORDER       ({DW{1'b0}}),

        .VALID          (slide_window_valid),
        .LAST_IN_LINE   (last_in_line),
        .LAST_PIXEL     (last_pixel),

        .X_11           (x_11),
        .X_12           (x_12),
        .X_13           (x_13),
        .X_21           (x_21),
        .X_22           (x_22),
        .X_23           (x_23),
        .X_31           (x_31),
        .X_32           (x_32),
        .X_33           (x_33)
    );

    //----------------------------------
    // 计算输出结果

    wire    [2*DW-1:0]  result_11, result_12, result_13;
    wire    [2*DW-1:0]  result_21, result_22, result_23;
    wire    [2*DW-1:0]  result_31, result_32, result_33;

    reg     [2*DW-1:0]  sum_1, sum_2, sum_3, sum;

    mult_for_cnn_cxy u_mult_11 (
      .CLK      (CLK),      // input  wire          CLK
      .A        (x_11),   // input  wire [23 : 0] A
      .B        (W_11),     // input  wire [23 : 0] B
      .P        (result_11) // output wire [47 : 0] P
    );

    mult_for_cnn_cxy u_mult_12 (
      .CLK      (CLK),      // input  wire          CLK
      .A        (x_12),   // input  wire [23 : 0] A
      .B        (W_12),     // input  wire [23 : 0] B
      .P        (result_12) // output wire [47 : 0] P
    );

    mult_for_cnn_cxy u_mult_13 (
      .CLK      (CLK),      // input  wire          CLK
      .A        (x_13),   // input  wire [23 : 0] A
      .B        (W_13),     // input  wire [23 : 0] B
      .P        (result_13) // output wire [47 : 0] P
    );

    mult_for_cnn_cxy u_mult_21 (
      .CLK      (CLK),      // input  wire          CLK
      .A        (x_21),   // input  wire [23 : 0] A
      .B        (W_21),     // input  wire [23 : 0] B
      .P        (result_21) // output wire [47 : 0] P
    );

    mult_for_cnn_cxy u_mult_22 (
      .CLK      (CLK),      // input  wire          CLK
      .A        (x_22),   // input  wire [23 : 0] A
      .B        (W_22),     // input  wire [23 : 0] B
      .P        (result_22) // output wire [47 : 0] P
    );

    mult_for_cnn_cxy u_mult_23 (
      .CLK      (CLK),      // input  wire          CLK
      .A        (x_23),   // input  wire [23 : 0] A
      .B        (W_23),     // input  wire [23 : 0] B
      .P        (result_23) // output wire [47 : 0] P
    );

    mult_for_cnn_cxy u_mult_31 (
      .CLK      (CLK),      // input  wire          CLK
      .A        (x_31),   // input  wire [23 : 0] A
      .B        (W_31),     // input  wire [23 : 0] B
      .P        (result_31) // output wire [47 : 0] P
    );

    mult_for_cnn_cxy u_mult_32 (
      .CLK      (CLK),      // input  wire          CLK
      .A        (x_32),   // input  wire [23 : 0] A
      .B        (W_32),     // input  wire [23 : 0] B
      .P        (result_32) // output wire [47 : 0] P
    );

    mult_for_cnn_cxy u_mult_33 (
      .CLK      (CLK),      // input  wire          CLK
      .A        (x_33),   // input  wire [23 : 0] A
      .B        (W_33),     // input  wire [23 : 0] B
      .P        (result_33) // output wire [47 : 0] P
    );

    always @(posedge CLK)
    begin
        sum_1 <= result_11 + result_12 + result_13;
        sum_2 <= result_21 + result_22 + result_23;
        sum_3 <= result_31 + result_32 + result_33;
        sum <= sum_1 + sum_2 + sum_3;
    end

    //----------------------------------
    // 输出状态信号

    reg         reg_valid_1, reg_valid_2, reg_valid_3;
    reg         reg_last_in_line_1, reg_last_in_line_2, reg_last_in_line_3;
    reg         reg_last_pix_1, reg_last_pix_2, reg_last_pix_3;

    always @(posedge CLK)
    begin
        reg_valid_1 <= slide_window_valid;
        reg_last_in_line_1 <= last_in_line;
        reg_last_pix_1 <= last_pixel;

        reg_valid_2 <= reg_valid_1;
        reg_last_in_line_2 <= reg_last_in_line_1;
        reg_last_pix_2 <= reg_last_pix_1;

        reg_valid_3 <= reg_valid_2;
        reg_last_in_line_3 <= reg_last_in_line_2;
        reg_last_pix_3 <= reg_last_pix_2;
    end

    always @(posedge CLK)
    begin
        if(reg_valid_3)
            OUT <= sum[OUT_H:OUT_L] + B;
    end

    always @(posedge CLK)
    begin
        VALID <= reg_valid_3;
        LAST_IN_LINE <= reg_last_in_line_3;
        LAST_PIX <= reg_last_pix_3;
    end

endmodule
