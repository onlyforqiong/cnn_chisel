`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/22 22:41:14
// Design Name: 
// Module Name: CNN_layer2_top
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


module CNN_layer2_top #(
        parameter   DW = 24
    )
    (
        input                   CLK,
        input                   RSTn,
        input                   DIN_VALID,
        input       [DW-1:0]    DIN0,
        input       [DW-1:0]    DIN1,
        input       [DW-1:0]    DIN2,
        input       [DW-1:0]    DIN3,
        input                   SQUEEZE,
        output                  CONV_LAST_PIX,

        input                   CONV_W1_WEN,
        input                   CONV_W1_REN,
        input       [7:0]       CONV_W1_ADDR,
        input       [DW-1:0]    CONV_W1_WDATA,
        output      [DW-1:0]    CONV_W1_RDATA,

        input                   CONV_B1_WEN,
        input                   CONV_B1_REN,
        input       [2:0]       CONV_B1_ADDR,
        input       [DW-1:0]    CONV_B1_WDATA,
        output      [DW-1:0]    CONV_B1_RDATA,

        input                   CONV_W2_WEN,
        input                   CONV_W2_REN,
        input       [7:0]       CONV_W2_ADDR,
        input       [DW-1:0]    CONV_W2_WDATA,
        output      [DW-1:0]    CONV_W2_RDATA,

        input                   CONV_B2_WEN,
        input                   CONV_B2_REN,
        input       [1:0]       CONV_B2_ADDR,
        input       [DW-1:0]    CONV_B2_WDATA,
        output      [DW-1:0]    CONV_B2_RDATA,

        input       [2:0]       PHASE_SEL,

        output      [DW-1:0]    CORE_1_OUT,
        // output      [DW-1:0]    CORE_2_OUT,
        output                  VALID,
        output                  LAST_IN_LINE,
        output                  LAST_PIX
    );

    // wire                        core_1_valid;
    // wire                        core_1_last_in_line;
    // wire                        core_1_last_pix;

    // wire                        core_2_valid;
    // wire                        core_2_last_in_line;
    // wire                        core_2_last_pix;

    CNN_layer2_conv_pooling #(
        .DW     (DW)
    )
    u_CNN_layer2_core_1
    (
        .CLK                (CLK),
        .RSTn               (RSTn),
        .DIN_VALID          (DIN_VALID),
        .DIN0               (DIN0),
        .DIN1               (DIN1),
        .DIN2               (DIN2),
        .DIN3               (DIN3),
        .SQUEEZE            (SQUEEZE),
        .CONV_LAST_PIX      (CONV_LAST_PIX),

        .CONV_W1_WEN         (CONV_W1_WEN),
        .CONV_W1_REN         (CONV_W1_REN),
        .CONV_W1_ADDR        (CONV_W1_ADDR),
        .CONV_W1_WDATA       (CONV_W1_WDATA),
        .CONV_W1_RDATA       (CONV_W1_RDATA),

        .CONV_W2_WEN         (CONV_W2_WEN),
        .CONV_W2_REN         (CONV_W2_REN),
        .CONV_W2_ADDR        (CONV_W2_ADDR),
        .CONV_W2_WDATA       (CONV_W2_WDATA),
        .CONV_W2_RDATA       (CONV_W2_RDATA),

        .CONV_B_WEN         (CONV_B1_WEN),
        .CONV_B_REN         (CONV_B1_REN),
        .CONV_B_ADDR        (CONV_B1_ADDR),
        .CONV_B_WDATA       (CONV_B1_WDATA),
        .CONV_B_RDATA       (CONV_B1_RDATA),

        .PHASE_SEL          (PHASE_SEL),

        .OUT                (CORE_1_OUT),
        .VALID              (VALID),
        .LAST_IN_LINE       (LAST_IN_LINE),
        .LAST_PIX           (LAST_PIX)
    );

    // CNN_layer2_conv_pooling #(
    //     .DW     (DW)
    // )
    // u_CNN_layer2_core_2
    // (
    //     .CLK                (CLK),
    //     .RSTn               (RSTn),
    //     .DIN_VALID          (DIN_VALID),
    //     .DIN0               (DIN0),
    //     .DIN1               (DIN1),
    //     .DIN2               (DIN2),
    //     .DIN3               (DIN3),
    //     .SQUEEZE            (SQUEEZE),
    //     .CONV_LAST_PIX      (),

    //     .CONV_W_WEN         (CONV_W2_WEN),
    //     .CONV_W_REN         (CONV_W2_REN),
    //     .CONV_W_ADDR        (CONV_W2_ADDR),
    //     .CONV_W_WDATA       (CONV_W2_WDATA),
    //     .CONV_W_RDATA       (CONV_W2_RDATA),

    //     .CONV_B_WEN         (CONV_B2_WEN),
    //     .CONV_B_REN         (CONV_B2_REN),
    //     .CONV_B_ADDR        (CONV_B2_ADDR),
    //     .CONV_B_WDATA       (CONV_B2_WDATA),
    //     .CONV_B_RDATA       (CONV_B2_RDATA),

    //     .PHASE_SEL          (PHASE_SEL),

    //     .OUT                (CORE_2_OUT),
    //     .VALID              (core_2_valid),
    //     .LAST_IN_LINE       (core_2_last_in_line),
    //     .LAST_PIX           (core_2_last_pix)
    // );

endmodule
