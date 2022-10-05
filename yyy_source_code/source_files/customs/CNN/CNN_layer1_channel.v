`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/22 11:24:49
// Design Name: 
// Module Name: CNN_layer1_channel
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


module CNN_layer1_channel #(
        parameter   DW = 24
    )
    (
        input               CLK,
        input               RSTn,
        input               DIN_VALID,
        input               DIN,
        input               SQUEEZE,
        output              CONV_LAST_PIX,

        input      [DW-1:0] W_11,
        input      [DW-1:0] W_12,
        input      [DW-1:0] W_13,
        input      [DW-1:0] W_21,
        input      [DW-1:0] W_22,
        input      [DW-1:0] W_23,
        input      [DW-1:0] W_31,
        input      [DW-1:0] W_32,
        input      [DW-1:0] W_33,
        input      [DW-1:0] B,

        output     [DW-1:0] OUT,
        output              VALID,
        output              LAST_IN_LINE,
        output              LAST_PIX,

        output              SQUEEZE_OUT,
        input               NEXT_LAST_PIX
    );

    wire        [DW-1:0]    conv_out;
    wire                    conv_valid;
    wire                    conv_last_in_line;
    wire                    conv_last_pix;
    wire                    conv_squeeze_out;

    wire        [DW-1:0]    pooling_1_out;
    wire                    pooling_1_valid;
    wire                    pooling_1_last_in_line;
    wire                    pooling_1_last_pix;
    wire                    pooling_1_squeeze_out;

    // wire        [DW-1:0]    pooling_2_out;
    // wire                    pooling_2_valid;
    // wire                    pooling_2_last_in_line;
    // wire                    pooling_2_last_pix;
    // wire                    pooling_2_squeeze_out;

    conv_core_3x3_cxy #(
        .P_WIDTH     (64),
        .P_HEIGHT    (64),
        .P_WCNT_W    (6 ),
        .P_HCNT_W    (6 ),
        .P_PIX_CNT_W (12),
        .DW          (DW)
    )
    u_conv_1
    (
        .CLK            (CLK),
        .RSTn           (RSTn),
        .DIN_VALID      (DIN_VALID),
        .DIN            ({5'd0, DIN, {(DW-6){1'b0}}}), // 1 符号位 5 整数位
        .SQUEEZE        (SQUEEZE),

        .W_11           (W_11),
        .W_12           (W_12),
        .W_13           (W_13),
        .W_21           (W_21),
        .W_22           (W_22),
        .W_23           (W_23),
        .W_31           (W_31),
        .W_32           (W_32),
        .W_33           (W_33),
        .B              (B),

        .OUT            (conv_out),
        .VALID          (conv_valid),
        .LAST_IN_LINE   (conv_last_in_line),
        .LAST_PIX       (conv_last_pix),

        .SQUEEZE_OUT    (conv_squeeze_out),
        .NEXT_LAST_PIX  (pooling_1_last_pix)
    );

    assign CONV_LAST_PIX = conv_last_pix;

    pooling_core_2x2_cxy #(
        .P_WIDTH     (64),
        .P_HEIGHT    (64),
        .P_WCNT_W    (6 ),
        .P_HCNT_W    (6 ),
        .P_PIX_CNT_W (12),
        .DW          (DW)
    )
    u_pooling_11
    (
        .CLK            (CLK),
        .RSTn           (RSTn),
        .DIN_VALID      (conv_valid),
        .DIN            (conv_out),
        .SQUEEZE        (conv_squeeze_out),

        .OUT            (pooling_1_out),
        .VALID          (pooling_1_valid),
        .LAST_IN_LINE   (pooling_1_last_in_line),
        .LAST_PIX       (pooling_1_last_pix),

        .SQUEEZE_OUT    (pooling_1_squeeze_out),
        .NEXT_LAST_PIX  (LAST_PIX)
    );

    pooling_core_2x2_cxy #(
        .P_WIDTH     (32),
        .P_HEIGHT    (32),
        .P_WCNT_W    (5 ),
        .P_HCNT_W    (5 ),
        .P_PIX_CNT_W (10),
        .DW          (DW)
    )
    u_pooling_12
    (
        .CLK            (CLK),
        .RSTn           (RSTn),
        .DIN_VALID      (pooling_1_valid),
        .DIN            (pooling_1_out),
        .SQUEEZE        (pooling_1_squeeze_out),

        .OUT            (OUT),
        .VALID          (VALID),
        .LAST_IN_LINE   (LAST_IN_LINE),
        .LAST_PIX       (LAST_PIX),

        .SQUEEZE_OUT    (SQUEEZE_OUT),
        .NEXT_LAST_PIX  (NEXT_LAST_PIX)
    );

endmodule
