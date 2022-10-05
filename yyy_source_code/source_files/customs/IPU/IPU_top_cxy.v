`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/05 16:46:22
// Design Name: 
// Module Name: IPU_top_cxy
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


module IPU_top_cxy #(
        parameter   rgb2h_filename = "",
        parameter   rgb2s_filename = "",
        parameter   P_WIDTH  = 320,
        parameter   P_HEIGHT = 240
    )
    (
    input               CLK,
    input               RSTn,
    input               RGB_VALID,
    input       [11:0]  RGB,
    
    input        [8:0]  H_MAX,
    input        [8:0]  H_MIN,
    input        [6:0]  S_MAX,
    input        [6:0]  S_MIN,
    input        [5:0]  V_MAX,
    input        [5:0]  V_MIN,

    input               SQUEEZE,

    input               P0_BORDER,
    input        [3:0]  P0_THRESHOLD,

    input               P1_BORDER,
    input        [3:0]  P1_THRESHOLD,

    input        [3:0]  RESIZE_THRESHOLD,

    output              binarization,

    output              phase0_out,
    output              phase0_valid,
    output              phase0_last_in_line,
    output              phase0_last_pix,

    output              phase1_out,
    output              phase1_valid,
    output              phase1_last_in_line,
    output              phase1_last_pix,

    output              resize_out,
    output              resize_valid,
    output              resize_r_last_in_line,
    output              resize_r_last_pix,
    output              resize_f_last_in_line,
    output              resize_f_last_pix,

    output              SQUEEZE_OUT,
    input               NEXT_LAST_PIX,

    output      [17:0]  centroid_h,
    output      [17:0]  centroid_v,
    output      [12:0]  centroid_sum,
    output              centroid_valid
    );

    wire        binarization_valid;
    wire        phase0_squeeze_out;
    wire        phase1_squeeze_out;

//------------------------------------
// RGB 2 HUE & VAL

    RGB_binarize_cxy #(
        .filename_h   (rgb2h_filename),
        .filename_s   (rgb2s_filename)
    )
    u_RGB_binarize (
        .CLK        (CLK),
        .RGB_VALID  (RGB_VALID),
        .RGB        (RGB),
        .H_MAX      (H_MAX),
        .H_MIN      (H_MIN),
        .S_MAX      (S_MAX),
        .S_MIN      (S_MIN),
        .V_MAX      (V_MAX),
        .V_MIN      (V_MIN),
        .OUT        (binarization),
        .VALID      (binarization_valid)
    );

//-------------------------------------
// EROSION & EXPANSION

    erode_dilate_core_cxy #(
        .P_WIDTH       (P_WIDTH),
        .P_HEIGHT      (P_HEIGHT)
    )
    u_phase0_core (
        .CLK            (CLK),
        .RSTn           (RSTn),
        .DIN_VALID      (binarization_valid),
        .DIN            (binarization),

        .SQUEEZE        (SQUEEZE),

        .P_BORDER       (P0_BORDER),
        .THRESHOLD      (P0_THRESHOLD),

        .OUT            (phase0_out),
        .VALID          (phase0_valid),
        .LAST_IN_LINE   (phase0_last_in_line),
        .LAST_PIX       (phase0_last_pix),

        .SQUEEZE_OUT    (phase0_squeeze_out),
        .NEXT_LAST_PIX  (phase1_last_pix)
    );

    erode_dilate_core_cxy #(
        .P_WIDTH       (P_WIDTH),
        .P_HEIGHT      (P_HEIGHT)
    )
    u_phase1_core (
        .CLK            (CLK),
        .RSTn           (RSTn),
        .DIN_VALID      (phase0_valid),
        .DIN            (phase0_out),

        .SQUEEZE        (phase0_squeeze_out),

        .P_BORDER       (P1_BORDER),
        .THRESHOLD      (P1_THRESHOLD),

        .OUT            (phase1_out),
        .VALID          (phase1_valid),
        .LAST_IN_LINE   (phase1_last_in_line),
        .LAST_PIX       (phase1_last_pix),

        .SQUEEZE_OUT    (phase1_squeeze_out),
        .NEXT_LAST_PIX  (resize_f_last_pix)
    );

//-------------------------------------
// RESIZE

    resize_core_cxy u_resize_core (
        .CLK                (CLK),
        .RSTn               (RSTn),
        .DIN_VALID          (phase1_valid),
        .DIN                (phase1_out),

        .SQUEEZE            (phase1_squeeze_out),

        .THRESHOLD          (RESIZE_THRESHOLD),

        .OUT                (resize_out),
        .VALID              (resize_valid),
        .RESIZE_LAST_IN_LINE(resize_r_last_in_line),
        .RESIZE_LAST_PIX    (resize_r_last_pix),
        .FULL_LAST_IN_LINE  (resize_f_last_in_line),
        .FULL_LAST_PIX      (resize_f_last_pix),

        .SQUEEZE_OUT        (SQUEEZE_OUT),
        .NEXT_LAST_PIX      (NEXT_LAST_PIX)
    );

    centroid_calculator_cxy u_centroid_calculator_cxy (
        .CLK                (CLK),
        .RSTn               (RSTn),
        .DIN_VALID          (resize_valid),
        .LAST_PIX_VALID     (resize_r_last_pix),
        .DIN                (resize_out),

        .H_TOTAL            (centroid_h),
        .V_TOTAL            (centroid_v),
        .SUM                (centroid_sum),
        .VALID              (centroid_valid)
    );

endmodule
