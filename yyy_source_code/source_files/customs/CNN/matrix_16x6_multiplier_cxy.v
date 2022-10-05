`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/19 21:15:35
// Design Name: 
// Module Name: matrix_16x6_multiplier_cxy
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


module matrix_16x6_multiplier_cxy #(
        parameter   DIM = 16,
        parameter   AW  = 4,
        parameter   DW  = 24
    )
    (
        input                   CLK,
        input                   RSTn,
        input                   DIN_VALID,
        input       [DW-1:0]    DIN,

        input                   W_WEN,
        input                   W_REN,
        input       [AW+5:0]    W_ADDR,
        input       [DW-1:0]    W_WDATA,
        output reg  [DW-1:0]    W_RDATA,

        input       [2:0]       PHASE_SEL,

        output                  VALID,
        output      [DW-1:0]    OUTPUT1,
        output      [DW-1:0]    OUTPUT2,
        output      [DW-1:0]    OUTPUT3,
        output      [DW-1:0]    OUTPUT4,
        output      [DW-1:0]    OUTPUT5,
        output      [DW-1:0]    OUTPUT6
    );

    localparam V_W_EN_1 = 6'b000001;
    localparam V_W_EN_2 = 6'b000010;
    localparam V_W_EN_3 = 6'b000100;
    localparam V_W_EN_4 = 6'b001000;
    localparam V_W_EN_5 = 6'b010000;
    localparam V_W_EN_6 = 6'b100000;

    reg     [5:0]       v_w_wen_sel;
    reg     [5:0]       v_w_ren_sel;

    reg     [5:0]       reg_v_w_ren_sel;

    wire    [DW-1:0]    vector_mult_1_rdata;
    wire    [DW-1:0]    vector_mult_2_rdata;
    wire    [DW-1:0]    vector_mult_3_rdata;
    wire    [DW-1:0]    vector_mult_4_rdata;
    wire    [DW-1:0]    vector_mult_5_rdata;
    wire    [DW-1:0]    vector_mult_6_rdata;

    wire                output_valid_1;
    wire                output_valid_2;
    wire                output_valid_3;
    wire                output_valid_4;
    wire                output_valid_5;
    wire                output_valid_6;

    always @(*)
    begin
        if(W_WEN)
        begin
            case(W_ADDR[AW+5:AW+3])
                3'd0: v_w_wen_sel = V_W_EN_1;
                3'd1: v_w_wen_sel = V_W_EN_2;
                3'd2: v_w_wen_sel = V_W_EN_3;
                3'd3: v_w_wen_sel = V_W_EN_4;
                3'd4: v_w_wen_sel = V_W_EN_5;
                3'd5: v_w_wen_sel = V_W_EN_6;
                default: v_w_wen_sel = 0;
            endcase
        end
        else
        begin
            v_w_wen_sel = 0;
        end
    end

    always @(*)
    begin
        if(W_REN)
        begin
            case(W_ADDR[AW+5:AW+3])
                3'd0: v_w_ren_sel = V_W_EN_1;
                3'd1: v_w_ren_sel = V_W_EN_2;
                3'd2: v_w_ren_sel = V_W_EN_3;
                3'd3: v_w_ren_sel = V_W_EN_4;
                3'd4: v_w_ren_sel = V_W_EN_5;
                3'd5: v_w_ren_sel = V_W_EN_6;
                default: v_w_ren_sel = 0;
            endcase
        end
        else
        begin
            v_w_ren_sel = 0;
        end
    end

    always @(posedge CLK)
    begin
        reg_v_w_ren_sel <= v_w_ren_sel;
    end

    always @(*)
    begin
        case(reg_v_w_ren_sel)
            V_W_EN_1: W_RDATA = vector_mult_1_rdata;
            V_W_EN_2: W_RDATA = vector_mult_2_rdata;
            V_W_EN_3: W_RDATA = vector_mult_3_rdata;
            V_W_EN_4: W_RDATA = vector_mult_4_rdata;
            V_W_EN_5: W_RDATA = vector_mult_5_rdata;
            V_W_EN_6: W_RDATA = vector_mult_6_rdata;
            default:  W_RDATA = 0;
        endcase
    end

    assign VALID = output_valid_1;

    vector_multiplier_cxy #(
        .DIM (16),
        .AW  (AW),
        .DW  (DW)
    )
    u_vector_mult_1
    (
        .CLK            (CLK),
        .RSTn           (RSTn),
        .DIN_VALID      (DIN_VALID),
        .DIN            (DIN),

        .W_WEN          (v_w_wen_sel[0]),
        .W_REN          (v_w_ren_sel[0]),
        .W_ADDR         (W_ADDR[AW+2:0]),
        .W_WDATA        (W_WDATA),
        .W_RDATA        (vector_mult_1_rdata),

        .PHASE_SEL      (PHASE_SEL),

        .OUT            (OUTPUT1),
        .OUT_VALID      (output_valid_1)
    );

    vector_multiplier_cxy #(
        .DIM (16),
        .AW  (AW),
        .DW  (DW)
    )
    u_vector_mult_2
    (
        .CLK            (CLK),
        .RSTn           (RSTn),
        .DIN_VALID      (DIN_VALID),
        .DIN            (DIN),

        .W_WEN          (v_w_wen_sel[1]),
        .W_REN          (v_w_ren_sel[1]),
        .W_ADDR         (W_ADDR[AW+2:0]),
        .W_WDATA        (W_WDATA),
        .W_RDATA        (vector_mult_2_rdata),

        .PHASE_SEL      (PHASE_SEL),

        .OUT            (OUTPUT2),
        .OUT_VALID      (output_valid_2)
    );

    vector_multiplier_cxy #(
        .DIM (16),
        .AW  (AW),
        .DW  (DW)
    )
    u_vector_mult_3
    (
        .CLK            (CLK),
        .RSTn           (RSTn),
        .DIN_VALID      (DIN_VALID),
        .DIN            (DIN),

        .W_WEN          (v_w_wen_sel[2]),
        .W_REN          (v_w_ren_sel[2]),
        .W_ADDR         (W_ADDR[AW+2:0]),
        .W_WDATA        (W_WDATA),
        .W_RDATA        (vector_mult_3_rdata),

        .PHASE_SEL      (PHASE_SEL),

        .OUT            (OUTPUT3),
        .OUT_VALID      (output_valid_3)
    );

    vector_multiplier_cxy #(
        .DIM (16),
        .AW  (AW),
        .DW  (DW)
    )
    u_vector_mult_4
    (
        .CLK            (CLK),
        .RSTn           (RSTn),
        .DIN_VALID      (DIN_VALID),
        .DIN            (DIN),

        .W_WEN          (v_w_wen_sel[3]),
        .W_REN          (v_w_ren_sel[3]),
        .W_ADDR         (W_ADDR[AW+2:0]),
        .W_WDATA        (W_WDATA),
        .W_RDATA        (vector_mult_4_rdata),

        .PHASE_SEL      (PHASE_SEL),

        .OUT            (OUTPUT4),
        .OUT_VALID      (output_valid_4)
    );

    vector_multiplier_cxy #(
        .DIM (16),
        .AW  (AW),
        .DW  (DW)
    )
    u_vector_mult_5
    (
        .CLK            (CLK),
        .RSTn           (RSTn),
        .DIN_VALID      (DIN_VALID),
        .DIN            (DIN),

        .W_WEN          (v_w_wen_sel[4]),
        .W_REN          (v_w_ren_sel[4]),
        .W_ADDR         (W_ADDR[AW+2:0]),
        .W_WDATA        (W_WDATA),
        .W_RDATA        (vector_mult_5_rdata),

        .PHASE_SEL      (PHASE_SEL),

        .OUT            (OUTPUT5),
        .OUT_VALID      (output_valid_5)
    );

    vector_multiplier_cxy #(
        .DIM (16),
        .AW  (AW),
        .DW  (DW)
    )
    u_vector_mult_6
    (
        .CLK            (CLK),
        .RSTn           (RSTn),
        .DIN_VALID      (DIN_VALID),
        .DIN            (DIN),

        .W_WEN          (v_w_wen_sel[5]),
        .W_REN          (v_w_ren_sel[5]),
        .W_ADDR         (W_ADDR[AW+2:0]),
        .W_WDATA        (W_WDATA),
        .W_RDATA        (vector_mult_6_rdata),

        .PHASE_SEL      (PHASE_SEL),

        .OUT            (OUTPUT6),
        .OUT_VALID      (output_valid_6)
    );

endmodule
