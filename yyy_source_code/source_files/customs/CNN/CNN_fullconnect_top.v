`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/23 11:05:51
// Design Name: 
// Module Name: CNN_fullconnect_top
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


module CNN_fullconnect_top #(
        parameter   DW = 24
    )
    (
        input                   CLK,
        input                   RSTn,
        input                   DIN_VALID,
        input       [DW-1:0]    DIN0,
        // input       [DW-1:0]    DIN1,

        input       [2:0]       PHASE_SEL,

        input                   VECTOR_W_WEN,
        input                   VECTOR_W_REN,
        input       [9:0]       VECTOR_W_ADDR,
        input       [DW-1:0]    VECTOR_W_WDATA,
        output reg  [DW-1:0]    VECTOR_W_RDATA,

        output reg              VALID,
        output reg  [DW-1:0]    OUTPUT1,
        output reg  [DW-1:0]    OUTPUT2,
        output reg  [DW-1:0]    OUTPUT3,
        output reg  [DW-1:0]    OUTPUT4,
        output reg  [DW-1:0]    OUTPUT5,
        output reg  [DW-1:0]    OUTPUT6
    );

    // localparam VECTOR_W_EN_0 = 2'b01;
    // localparam VECTOR_W_EN_1 = 2'b10;

    reg         /*[1:0]*/       vector_w_wen_sel;
    reg         /*[1:0]*/       vector_w_ren_sel;

    reg         /*[1:0]*/       reg_vector_w_ren_sel;

    wire        [DW-1:0]    matrix_0_w_rdata;
    // wire        [DW-1:0]    matrix_1_w_rdata;

    wire                    matrix_0_valid;
    wire        [DW-1:0]    matrix_0_output1;
    wire        [DW-1:0]    matrix_0_output2;
    wire        [DW-1:0]    matrix_0_output3;
    wire        [DW-1:0]    matrix_0_output4;
    wire        [DW-1:0]    matrix_0_output5;
    wire        [DW-1:0]    matrix_0_output6;

    // wire                    matrix_1_valid;
    // wire        [DW-1:0]    matrix_1_output1;
    // wire        [DW-1:0]    matrix_1_output2;
    // wire        [DW-1:0]    matrix_1_output3;
    // wire        [DW-1:0]    matrix_1_output4;
    // wire        [DW-1:0]    matrix_1_output5;
    // wire        [DW-1:0]    matrix_1_output6;

    always @(*)
    begin
        if(VECTOR_W_WEN)
        begin
            // case(VECTOR_W_ADDR[6])
            //     1'b0: vector_w_wen_sel = VECTOR_W_EN_0;
            //     1'b1: vector_w_wen_sel = VECTOR_W_EN_1;
            //     default: vector_w_wen_sel = 0;
            // endcase
            vector_w_wen_sel = 1;
        end
        else
        begin
            vector_w_wen_sel = 0;
        end
    end

    always @(*)
    begin
        if(VECTOR_W_REN)
        begin
            // case(VECTOR_W_ADDR[6])
            //     1'b0: vector_w_ren_sel = VECTOR_W_EN_0;
            //     1'b1: vector_w_ren_sel = VECTOR_W_EN_1;
            //     default: vector_w_ren_sel = 0;
            // endcase
            vector_w_ren_sel = 1;
        end
        else
        begin
            vector_w_ren_sel = 0;
        end
    end

    always @(posedge CLK)
    begin
        reg_vector_w_ren_sel <= vector_w_ren_sel;
    end

    always @(*)
    begin
        // case(reg_vector_w_ren_sel)
        //     2'b01: VECTOR_W_RDATA = matrix_0_w_rdata;
        //     2'b10: VECTOR_W_RDATA = matrix_1_w_rdata;
        //     default: VECTOR_W_RDATA = 0;
        // endcase
        VECTOR_W_RDATA = matrix_0_w_rdata;
    end

    matrix_16x6_multiplier_cxy #(
        .DIM (16),
        .AW  (4),
        .DW  (DW)
    )
    u_matrix_0
    (
        .CLK        (CLK),
        .RSTn       (RSTn),
        .DIN_VALID  (DIN_VALID),
        .DIN        (DIN0),

        // .W_WEN      (vector_w_wen_sel[0]),
        .W_WEN      (vector_w_wen_sel),
        // .W_REN      (vector_w_ren_sel[0]),
        .W_REN      (vector_w_ren_sel),
        // .W_ADDR     ({VECTOR_W_ADDR[9:7], VECTOR_W_ADDR[5:0]}),
        .W_ADDR     (VECTOR_W_ADDR),
        .W_WDATA    (VECTOR_W_WDATA),
        .W_RDATA    (matrix_0_w_rdata),

        .PHASE_SEL  (PHASE_SEL),

        .VALID      (matrix_0_valid),
        .OUTPUT1    (matrix_0_output1),
        .OUTPUT2    (matrix_0_output2),
        .OUTPUT3    (matrix_0_output3),
        .OUTPUT4    (matrix_0_output4),
        .OUTPUT5    (matrix_0_output5),
        .OUTPUT6    (matrix_0_output6)
    );

    // matrix_16x6_multiplier_cxy #(
    //     .DIM (16),
    //     .AW  (4),
    //     .DW  (DW)
    // )
    // u_matrix_1
    // (
    //     .CLK        (CLK),
    //     .RSTn       (RSTn),
    //     .DIN_VALID  (DIN_VALID),
    //     .DIN        (DIN1),

    //     .W_WEN      (vector_w_wen_sel[1]),
    //     .W_REN      (vector_w_ren_sel[1]),
    //     .W_ADDR     ({VECTOR_W_ADDR[9:7], VECTOR_W_ADDR[5:0]}),
    //     .W_WDATA    (VECTOR_W_WDATA),
    //     .W_RDATA    (matrix_1_w_rdata),

    //     .PHASE_SEL  (PHASE_SEL),

    //     .VALID      (matrix_1_valid),
    //     .OUTPUT1    (matrix_1_output1),
    //     .OUTPUT2    (matrix_1_output2),
    //     .OUTPUT3    (matrix_1_output3),
    //     .OUTPUT4    (matrix_1_output4),
    //     .OUTPUT5    (matrix_1_output5),
    //     .OUTPUT6    (matrix_1_output6)
    // );

    always @(posedge CLK)
    begin
        if(~RSTn)
        begin
            VALID <= 1'b0;
            OUTPUT1 <= 0;
            OUTPUT2 <= 0;
            OUTPUT3 <= 0;
            OUTPUT4 <= 0;
            OUTPUT5 <= 0;
            OUTPUT6 <= 0;
        end
        else if(matrix_0_valid)
        begin
            VALID <= 1'b1;
            OUTPUT1 <= matrix_0_output1;// + matrix_1_output1;
            OUTPUT2 <= matrix_0_output2;// + matrix_1_output2;
            OUTPUT3 <= matrix_0_output3;// + matrix_1_output3;
            OUTPUT4 <= matrix_0_output4;// + matrix_1_output4;
            OUTPUT5 <= matrix_0_output5;// + matrix_1_output5;
            OUTPUT6 <= matrix_0_output6;// + matrix_1_output6;
        end
        else
        begin
            VALID <= 1'b0;
            OUTPUT1 <= OUTPUT1;
            OUTPUT2 <= OUTPUT2;
            OUTPUT3 <= OUTPUT3;
            OUTPUT4 <= OUTPUT4;
            OUTPUT5 <= OUTPUT5;
            OUTPUT6 <= OUTPUT6;
        end
    end

endmodule
