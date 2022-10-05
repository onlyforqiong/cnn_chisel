`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/18 10:23:32
// Design Name: 
// Module Name: pooling_core_2x2_cxy
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


module pooling_core_2x2_cxy #(
        parameter   P_WIDTH     = 64,
        parameter   P_HEIGHT    = 64,
        parameter   P_WCNT_W    = 6,
        parameter   P_HCNT_W    = 6,
        parameter   P_PIX_CNT_W = 12,
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
    localparam S_IDLE   = 0;
    localparam S_CMP_12 = 1;
    localparam S_CMP_13 = 2;
    localparam S_CMP_22 = 3;
    localparam S_CMP_23 = 4;
    localparam S_FILL_SLIDE_WINDOW = 5;
    localparam S_WAIT_SLIDE_WINDOW = 6;
    localparam S_DONE  = 7;
    localparam S_IGNORE = 8;

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
    reg     [P_WCNT_W-2:0]  h_cnt;
    reg     [P_HCNT_W-2:0]  v_cnt;
    reg                     w_h_cnt;
    reg                     w_v_cnt;

    wire    [DW-1:0]        x_11, x_12, x_13;
    wire    [DW-1:0]        x_21, x_22, x_23;
    wire    [DW-1:0]        x_31, x_32, x_33;

    reg     [DW-1:0]        /*reg_x_11,*/ reg_x_12, reg_x_13;
    reg     [DW-1:0]        /*reg_x_21,*/ reg_x_22, reg_x_23;
    // reg     [DW-1:0]        reg_x_31, reg_x_32, reg_x_33;

    reg     [DW-1:0]        max_data;

    //----------------------------------
    // FIFO

    always @(*)
    begin
        case(state)
            S_FILL_SLIDE_WINDOW:
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

    always @(posedge CLK)
    begin
        if(~RSTn)
            fill_slide_window_cnt <= 0;
        else if(state == S_FILL_SLIDE_WINDOW & DIN_VALID)
            fill_slide_window_cnt <= fill_slide_window_cnt + 1;
    end

    always @(posedge CLK)
    begin
        if(~RSTn)
        begin
            state <= S_FILL_SLIDE_WINDOW;
            reg_x_12 <= 0;
            reg_x_13 <= 0;
            reg_x_22 <= 0;
            reg_x_23 <= 0;
            max_data <= 0;
            h_cnt <= 0;
            v_cnt <= 0;
            LAST_IN_LINE <= 0;
            LAST_PIX <= 0;
            VALID <= 0;
            squeeze_valid <= 0;
        end
        else
        begin
            case(state)
                S_FILL_SLIDE_WINDOW:
                begin
                    if(fill_slide_window_cnt == P_WIDTH+2)
                        state <= S_IDLE;
                    else
                        state <= S_FILL_SLIDE_WINDOW;
                end
                S_IDLE:
                begin
                    if(slide_window_din_valid)
                        if((w_h_cnt == 0) & (w_v_cnt == 1))
                            state <= S_WAIT_SLIDE_WINDOW;
                        else
                            state <= S_IGNORE;
                    else
                        state <= S_IDLE;
                    LAST_IN_LINE <= 0;
                    LAST_PIX <= 0;
                    VALID <= 0;
                    squeeze_valid <= 0;
                end
                S_IGNORE:
                begin
                    state <= S_IDLE;
                    if(SQUEEZE)
                    begin
                        squeeze_valid <= 1;
                    end
                end
                S_WAIT_SLIDE_WINDOW:
                begin
                    if(slide_window_valid)
                    begin
                        state <= S_CMP_13;
                        max_data <= x_12;
                        reg_x_13 <= x_13;
                        reg_x_22 <= x_22;
                        reg_x_23 <= x_23;
                    end
                    else
                        state <= S_WAIT_SLIDE_WINDOW;
                end
                S_CMP_13:
                begin
                    state <= S_CMP_22;
                    if(x_13 > max_data)
                        max_data <= x_13;
                    else
                        max_data <= max_data;
                end
                S_CMP_22:
                begin
                    state <= S_DONE;
                    if(x_22 > max_data)
                        max_data <= x_22;
                    else
                        max_data <= max_data;
                end
                S_DONE:
                begin
                    state <= S_IDLE;
                    if(x_23 > max_data)
                        max_data <= x_23;
                    else
                        max_data <= max_data;
                    if(SQUEEZE)
                    begin
                        squeeze_valid <= 1;
                    end
                    h_cnt <= h_cnt + 1;
                    if(h_cnt == P_WIDTH/2-1)
                    begin
                        v_cnt <= v_cnt + 1;
                        LAST_IN_LINE <= 1;
                        if(v_cnt == P_HEIGHT/2-1)
                        begin
                            LAST_PIX <= 1;
                        end
                    end
                    VALID <= 1;
                end
                default:
                begin
                    state <= S_FILL_SLIDE_WINDOW;
                end
            endcase
        end
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
