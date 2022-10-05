`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/22 23:09:26
// Design Name: 
// Module Name: pooling_core_parallel_cxy
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


module pooling_core_parallel_cxy #(
        parameter   P_WIDTH     = 16,
        parameter   P_HEIGHT    = 16,
        parameter   P_WCNT_W    = 4,
        parameter   P_HCNT_W    = 4,
        parameter   P_PIX_CNT_W = 8,
        parameter   DW          = 24
    )
    (
        input               CLK,
        input               RSTn,
        input               DIN_VALID,
        input      [DW-1:0] DIN,

        input               SQUEEZE,

        output     [DW-1:0] OUT,
        output reg          VALID,
        output reg          LAST_IN_LINE,
        output reg          LAST_PIX,
        output reg          SQUEEZE_OUT,
        input               NEXT_LAST_PIX
    );

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
    // 比较得分                      //     - - - - - - -
                                    //     :   : @ : @ :
    wire    [2:0]   x_12_score;     //     - - - - - - -
    wire    [2:0]   x_13_score;     //     :   : @ : @ :
    wire    [2:0]   x_22_score;     //     - - - - - - -
    wire    [2:0]   x_23_score;     //     :   :   :   :
                                    //     - - - - - - -

    assign x_12_score[0] = (x_12 >= x_13) ? 1 : 0;
    assign x_12_score[1] = (x_12 >= x_22) ? 1 : 0;
    assign x_12_score[2] = (x_12 >= x_23) ? 1 : 0;

    // assign x_13_score[0] = (x_13 >= x_12) ? 1 : 0;
    assign x_13_score[0] = ~x_12_score[0];
    assign x_13_score[1] = (x_13 >= x_22) ? 1 : 0;
    assign x_13_score[2] = (x_13 >= x_23) ? 1 : 0;

    // assign x_22_score[0] = (x_22 >= x_12) ? 1 : 0;
    // assign x_22_score[1] = (x_22 >= x_13) ? 1 : 0;
    assign x_22_score[0] = ~x_12_score[1];
    assign x_22_score[1] = ~x_13_score[1];
    assign x_22_score[2] = (x_22 >= x_23) ? 1 : 0;

    // assign x_23_score[0] = (x_23 >= x_12) ? 1 : 0;
    // assign x_23_score[1] = (x_23 >= x_13) ? 1 : 0;
    // assign x_23_score[2] = (x_23 >= x_22) ? 1 : 0;
    assign x_23_score[0] = ~x_12_score[2];
    assign x_23_score[1] = ~x_13_score[2];
    assign x_23_score[2] = ~x_22_score[2];

    reg     [DW-1:0]    max_data;

    always @(posedge CLK) begin
        if(x_12_score == 3'b111)
            max_data <= x_12;
        else if(x_13_score == 3'b111)
            max_data <= x_13;
        else if(x_22_score == 3'b111)
            max_data <= x_22;
        else
            max_data <= x_23;
    end

    //----------------------------------
    // 状态信号输出

    reg     [P_WCNT_W-2:0]  pooling_col_cnt;
    reg     [P_HCNT_W-2:0]  pooling_row_cnt;
    reg                     w_h_cnt;
    reg                     w_v_cnt;

    always @(posedge CLK) begin
        if(~RSTn)
            w_h_cnt <= 0;
        else if(slide_window_valid)
            w_h_cnt <= ~w_h_cnt;
        else
            w_h_cnt <= w_h_cnt;
    end

    always @(posedge CLK) begin
        if(~RSTn)
            w_v_cnt <= 0;
        else if(slide_window_valid & last_in_line)
            w_v_cnt <= ~w_v_cnt;
        else
            w_v_cnt <= w_v_cnt;
    end

    wire    in_position = ((w_h_cnt == 0) & (w_v_cnt == 1) & slide_window_valid);

    always @(posedge CLK) begin
        if(~RSTn)
            pooling_col_cnt <= 0;
        else if(in_position)
            pooling_col_cnt <= pooling_col_cnt + 1;
        else
            pooling_col_cnt <= pooling_col_cnt;
    end

    always @(posedge CLK) begin
        if(~RSTn)
            pooling_row_cnt <= 0;
        else if(in_position & (pooling_col_cnt == 2**(P_WCNT_W-1)-1))
            pooling_row_cnt <= pooling_row_cnt + 1;
        else
            pooling_row_cnt <= pooling_row_cnt;
    end

    localparam COL_END = 2**(P_WCNT_W-1)-1;

    always @(posedge CLK) begin
        VALID <= in_position;
        LAST_IN_LINE <= in_position & (pooling_col_cnt == COL_END);
        LAST_PIX <= in_position & (pooling_col_cnt == COL_END) & (pooling_row_cnt == COL_END);
    end

    assign OUT = max_data;

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