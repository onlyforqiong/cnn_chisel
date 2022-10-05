`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/05 22:44:57
// Design Name: 
// Module Name: erode_dilate_core_cxy
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


module erode_dilate_core_cxy #(
        parameter   P_WIDTH     = 320,
        parameter   P_HEIGHT    = 240,
        parameter   P_WCNT_W    = 9,
        parameter   P_HCNT_W    = 8,
        parameter   P_PIX_CNT_W = 17
    )
    (
        input               CLK,
        input               RSTn,
        input               DIN_VALID,
        input               DIN,

        input               SQUEEZE,

        input               P_BORDER,
        input         [3:0] THRESHOLD,

        output reg          OUT,
        output reg          VALID,
        output reg          LAST_IN_LINE,
        output reg          LAST_PIX,

        output reg          SQUEEZE_OUT,
        input               NEXT_LAST_PIX
    );

    wire            slide_window_valid;
    wire            last_in_line;
    wire            last_pixel;

    wire            x_11, x_12, x_13;
    wire            x_21, x_22, x_23;
    wire            x_31, x_32, x_33;

    reg     [1:0]   sum1, sum2, sum3;
    reg     [3:0]   sum;

    reg             valid_delay1;
    reg             last_in_line_delay1;
    reg             last_pixel_delay1;

//----------------------------------
// Slide Window

    slide_window_3x3_cxy #(
        .P_WIDTH     (P_WIDTH    ),
        .P_HEIGHT    (P_HEIGHT   ),
        .P_WCNT_W    (P_WCNT_W   ),
        .P_HCNT_W    (P_HCNT_W   ),
        .P_PIX_CNT_W (P_PIX_CNT_W),
        .DW          (1          )
    )
    u_slide_window_3x3 (
        .CLK            (CLK),
        .RSTn           (RSTn),
        .DIN_VALID      (DIN_VALID | SQUEEZE),
        .DIN            (DIN),

        .P_BORDER       (P_BORDER),

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
// Calculation

    always @( * ) begin
        sum1 = x_11 + x_12 + x_13;
        sum2 = x_21 + x_22 + x_23;
        sum3 = x_31 + x_32 + x_33;
    end

    always @(posedge CLK) begin
        sum <= sum1 + sum2 + sum3;
    end

    always @(posedge CLK) begin
        OUT <= (sum >= THRESHOLD) ? 1 : 0;
    end

//----------------------------------
// Status Calibration

    always @(posedge CLK) begin
        valid_delay1        <= slide_window_valid;
        last_in_line_delay1 <= last_in_line;
        last_pixel_delay1   <= last_pixel;
    end

    always @(posedge CLK) begin
        VALID        <= valid_delay1;
        LAST_IN_LINE <= last_in_line_delay1;
        LAST_PIX     <= last_pixel_delay1;
    end

//----------------------------------
// Connect with next stage

    always @(posedge CLK)
    begin
        if(~RSTn)
            SQUEEZE_OUT <= 1'b0;
        else if(LAST_PIX)
            SQUEEZE_OUT <= 1'b1;
        else if(NEXT_LAST_PIX)
            SQUEEZE_OUT <= 1'b0;
    end

endmodule


