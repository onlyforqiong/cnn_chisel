`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/17 15:28:33
// Design Name: 
// Module Name: conv_core_3x3_cxy
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


module conv_core_3x3_cxy #(
        parameter   P_WIDTH       = 64,
        parameter   P_HEIGHT      = 64,
        parameter   P_WCNT_W      = 6,
        parameter   P_HCNT_W      = 6,
        parameter   P_PIX_CNT_W   = 12,
        parameter   DW            = 24
    )
    (
        input               CLK,
        input               RSTn,
        input               DIN_VALID,
        input      [DW-1:0] DIN,
        input               SQUEEZE,

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
        output reg          VALID,
        output reg          LAST_IN_LINE,
        output reg          LAST_PIX,
        output reg          SQUEEZE_OUT,
        input               NEXT_LAST_PIX
    );
    localparam OUT_L = DW-6;
    localparam OUT_H = DW*2-7;

    localparam S_FILL      = 0;
    localparam S_IDLE      = 1;
    localparam S_WAIT_SW   = 2;
    localparam S_PROC      = 3;
    // localparam S_WAIT_DONE = 4;
    localparam S_DONE      = 5;


    reg     [3:0]           state;
    reg     [P_WCNT_W:0]    fill_slide_window_cnt;

    reg                     fifo_rd_en;
    reg                     fifo_output_flag;
    wire    [DW-1:0]        fifo_dout;
    wire                    fifo_full;
    wire                    fifo_empty;

    reg                     squeeze_valid;
    reg                     slide_window_din_valid;
    wire    [DW-1:0]        slide_window_din;
    wire                    slide_window_valid;
    wire                    last_in_line;
    wire                    last_pixel;
    reg     [P_WCNT_W-1:0]  h_cnt;
    reg     [P_HCNT_W-1:0]  v_cnt;

    wire    [DW-1:0]        x_11, x_12, x_13;
    wire    [DW-1:0]        x_21, x_22, x_23;
    wire    [DW-1:0]        x_31, x_32, x_33;

    reg     [DW-1:0]        reg_x_11, reg_x_12, reg_x_13;
    reg     [DW-1:0]        reg_x_21, reg_x_22, reg_x_23;
    reg     [DW-1:0]        reg_x_31, reg_x_32, reg_x_33;

    reg     [2*DW-1:0]      sum;

    reg     [3:0]           mult_AB_sel;
    reg     [DW-1:0]        mult_A;
    reg     [DW-1:0]        mult_B;
    wire    [2*DW-1:0]      mult_output;

    //----------------------------------
    // FIFO

    always @(*)
    begin
        case(state)
            S_FILL:
            begin
                fifo_rd_en = ~fifo_empty;
            end
            S_IDLE:
            begin
                if(~fifo_output_flag)
                    fifo_rd_en = ~fifo_empty;
                else
                    fifo_rd_en = 1'b0;
            end
            default:
            begin
                fifo_rd_en = 1'b0;
            end
        endcase
    end

    always @(posedge CLK)
    begin
        if(state == S_IDLE)
            if(fifo_rd_en)
                fifo_output_flag <= 1'b1;
            else
                fifo_output_flag <= fifo_output_flag;
        else
            fifo_output_flag <= 1'b0;
    end

    FIFO_cxy #(
        .DW(DW),
        .AW(P_WCNT_W)
    )
    u_FIFO_cxy
    (
        .fifo_rst   (~RSTn),
        .wr_clk     (CLK),
        .rd_clk     (CLK),

        .din        (DIN),
        .dout       (fifo_dout),

        .wr_en      (DIN_VALID | squeeze_valid),
        .rd_en      (fifo_rd_en),

        .full       (fifo_full),
        .empty      (fifo_empty),

        .wr_rst_busy(),
        .rd_rst_busy()
    );

    //----------------------------------
    // Slide Window

    always @(posedge CLK)
    begin
        slide_window_din_valid <= fifo_rd_en;
    end

    assign slide_window_din = fifo_dout;

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
        .DIN_VALID      (slide_window_din_valid),
        .DIN            (slide_window_din),

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
    // State

    always @(posedge CLK)
    begin
        if(~RSTn)
            fill_slide_window_cnt <= 0;
        else if(state == S_FILL & DIN_VALID)
            fill_slide_window_cnt <= fill_slide_window_cnt + 1;
    end

    always @(posedge CLK)
    begin
        if(~RSTn)
        begin
            state <= S_FILL;
            reg_x_11 <= 0;
            reg_x_12 <= 0;
            reg_x_13 <= 0;
            reg_x_21 <= 0;
            reg_x_22 <= 0;
            reg_x_23 <= 0;
            reg_x_31 <= 0;
            reg_x_32 <= 0;
            reg_x_33 <= 0;
            mult_AB_sel <= 0;
            sum <= 0;
            h_cnt <= 0;
            v_cnt <= 0;
            LAST_IN_LINE <= 0;
            LAST_PIX <= 0;
            VALID <= 0;
            squeeze_valid <= 0;
        end
        else
            case(state)
                S_FILL:
                begin
                    if(fill_slide_window_cnt == P_WIDTH+2)
                        state <= S_IDLE;
                    else
                        state <= S_FILL;
                end
                S_IDLE:
                begin
                    if(slide_window_din_valid)
                        state <= S_WAIT_SW;
                    else
                        state <= S_IDLE;
                    LAST_IN_LINE <= 0;
                    LAST_PIX <= 0;
                    VALID <= 0;
                    squeeze_valid <= 0;
                    // sum <= {6'd0, B, {(DW-6){1'b0}}};
                    mult_AB_sel <= 0;
                end
                S_WAIT_SW:
                begin
                    if(slide_window_valid)
                    begin
                        state <= S_PROC;
                        reg_x_11 <= x_11;
                        reg_x_12 <= x_12;
                        reg_x_13 <= x_13;
                        reg_x_21 <= x_21;
                        reg_x_22 <= x_22;
                        reg_x_23 <= x_23;
                        reg_x_31 <= x_31;
                        reg_x_32 <= x_32;
                        reg_x_33 <= x_33;
                    end
                    else
                        state <= S_WAIT_SW;
                end
                S_PROC:
                begin
                    mult_AB_sel <= mult_AB_sel + 1;
                    if(mult_AB_sel == 0)
                    begin
                        state <= S_PROC;
                        sum <= {6'd0, B, {(DW-6){1'b0}}};
                    end
                    else if(mult_AB_sel == 8)
                    begin
                        state <= S_DONE;
                        sum <= sum + mult_output;
                    end
                    else
                    begin
                        state <= S_PROC;
                        sum <= sum + mult_output;
                    end
                end
                S_DONE:
                begin
                    state <= S_IDLE;
                    sum <= sum + mult_output;
                    if(SQUEEZE)
                    begin
                        squeeze_valid <= 1;
                    end
                    h_cnt <= h_cnt + 1;
                    if(h_cnt == P_WIDTH-1)
                    begin
                        v_cnt <= v_cnt + 1;
                        LAST_IN_LINE <= 1;
                        if(v_cnt == P_HEIGHT-1)
                        begin
                            LAST_PIX <= 1;
                        end
                    end
                    VALID <= 1;
                    // sum = sum + {{8{B[DW-1]}}, B, 8'd0};
                end
                default:
                begin
                    state <= S_IDLE;
                end
            endcase
    end

    always @(*)
    begin
        case(mult_AB_sel)
            4'd0: begin
                mult_A = reg_x_11;
                mult_B = W_11;
            end
            4'd1: begin
                mult_A = reg_x_12;
                mult_B = W_12;
            end
            4'd2: begin
                mult_A = reg_x_13;
                mult_B = W_13;
            end
            4'd3: begin
                mult_A = reg_x_21;
                mult_B = W_21;
            end
            4'd4: begin
                mult_A = reg_x_22;
                mult_B = W_22;
            end
            4'd5: begin
                mult_A = reg_x_23;
                mult_B = W_23;
            end
            4'd6: begin
                mult_A = reg_x_31;
                mult_B = W_31;
            end
            4'd7: begin
                mult_A = reg_x_32;
                mult_B = W_32;
            end
            4'd8: begin
                mult_A = reg_x_33;
                mult_B = W_33;
            end
            default: begin
                mult_A = 0;
                mult_B = 0;
            end
        endcase
    end

    assign OUT = (sum[2*DW-1]) ? 0 : sum[OUT_H:OUT_L];

    mult_for_cnn_cxy u_mult (
        .CLK    (CLK),             // input wire CLK
        .A      (mult_A),          // input wire [15 : 0] A
        .B      (mult_B),          // input wire [15 : 0] B
        .P      (mult_output)      // output wire [31 : 0] P
    );

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
