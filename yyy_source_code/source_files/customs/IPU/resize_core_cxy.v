`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/10 12:22:59
// Design Name: 
// Module Name: resize_core_cxy
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


module resize_core_cxy (
        input               CLK,
        input               RSTn,
        input               DIN_VALID,
        input               DIN,

        input               SQUEEZE,

        input         [3:0] THRESHOLD,

        output reg          OUT,
        output reg          VALID,
        output reg          RESIZE_LAST_IN_LINE,
        output reg          RESIZE_LAST_PIX,
        output reg          FULL_LAST_IN_LINE,
        output reg          FULL_LAST_PIX,

        output reg          SQUEEZE_OUT,
        input               NEXT_LAST_PIX
    );

    parameter       P_WIDTH  = 320;
    parameter       P_HEIGHT = 240;

    reg     [8:0]   phase1_h_cnt;
    reg     [7:0]   phase1_v_cnt;

    wire            resize_area_h;
    wire            resize_area_v;
    wire            resize_area;
    wire            resize_en;

    wire            slide_window_valid;
    wire            last_in_line;
    wire            last_pixel;

    wire            x_11, x_12, x_13;
    wire            x_21, x_22, x_23;
    wire            x_31, x_32, x_33;

    reg     [1:0]   sum1, sum2, sum3;
    reg     [3:0]   sum;

    reg     [5:0]   resize_col_cnt;
    reg     [5:0]   resize_row_cnt;
    reg     [1:0]   w_h_cnt;
    reg     [1:0]   w_v_cnt;
    wire            center_of_w;

    reg             valid_delay1;
    reg             resize_last_in_line_delay1;
    reg             resize_last_pixel_delay1;
    reg             last_in_line_delay1;
    reg             last_pixel_delay1;

//----------------------------------
// Area Select

    always @(posedge CLK) begin
        if(~RSTn)
            phase1_h_cnt <= 0;
        else if(DIN_VALID)
            if(phase1_h_cnt == P_WIDTH-1)
                phase1_h_cnt <= 0;
            else
                phase1_h_cnt <= phase1_h_cnt + 1;
        else
            phase1_h_cnt <= phase1_h_cnt;
    end

    always @(posedge CLK) begin
        if(~RSTn)
            phase1_v_cnt <= 0;
        else if(DIN_VALID & (phase1_h_cnt == P_WIDTH-1))
            if(phase1_v_cnt == P_HEIGHT-1)
                phase1_v_cnt <= 0;
            else
                phase1_v_cnt <= phase1_v_cnt + 1;
        else
            phase1_v_cnt <= phase1_v_cnt;
    end

    assign resize_area_h = ((phase1_h_cnt>=(P_WIDTH-192)/2) & (phase1_h_cnt<=(P_WIDTH-192)/2+191));
    assign resize_area_v = ((phase1_v_cnt>=(P_HEIGHT-192)/2) & (phase1_v_cnt<=(P_HEIGHT-192)/2+191));
    assign resize_area = resize_area_h & resize_area_v;

    assign resize_en = resize_area & DIN_VALID;

//----------------------------------
// Slide Window

    slide_window_3x3_cxy #(
        .P_WIDTH        (192),
        .P_HEIGHT       (192),
        .P_WCNT_W       (8  ),
        .P_HCNT_W       (8  ),
        .P_PIX_CNT_W    (16 ),
        .DW             (1  )
    )
    u_slide_window_3x3 (
        .CLK            (CLK),
        .RSTn           (RSTn),
        .DIN_VALID      (resize_en | SQUEEZE),
        .DIN            (DIN),

        .P_BORDER       (1'b1),

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
// Position cnts

    always @(posedge CLK) begin
        if(~RSTn)
            w_h_cnt <= 0;
        else if(slide_window_valid)
            if((w_h_cnt == 2))
                w_h_cnt <= 0;
            else
                w_h_cnt <= w_h_cnt + 1;
        else
            w_h_cnt <= w_h_cnt;
    end

    always @(posedge CLK) begin
        if(~RSTn)
            w_v_cnt <= 0;
        else if(slide_window_valid & last_in_line)
            if(w_v_cnt == 2)
                w_v_cnt <= 0;
            else
                w_v_cnt <= w_v_cnt + 1;
        else
            w_v_cnt <= w_v_cnt;
    end

    assign center_of_w = ((w_h_cnt == 1) & (w_v_cnt == 1) & slide_window_valid);

    always @(posedge CLK) begin
        if(~RSTn)
            resize_col_cnt <= 0;
        else if(center_of_w)
            resize_col_cnt <= resize_col_cnt + 1;
        else
            resize_col_cnt <= resize_col_cnt;
    end

    always @(posedge CLK) begin
        if(~RSTn)
            resize_row_cnt <= 0;
        else if(center_of_w & (resize_col_cnt == 63))
            resize_row_cnt <= resize_row_cnt + 1;
        else
            resize_row_cnt <= resize_row_cnt;
    end

//----------------------------------
// Status Calibration

    always @(posedge CLK) begin
        valid_delay1               <= center_of_w;
        resize_last_in_line_delay1 <= center_of_w & (resize_col_cnt == 63);
        resize_last_pixel_delay1   <= center_of_w & (resize_col_cnt == 63) & (resize_row_cnt == 63);
        last_in_line_delay1        <= last_in_line;
        last_pixel_delay1          <= last_pixel;
    end

    always @(posedge CLK) begin
        VALID               <= valid_delay1;
        RESIZE_LAST_IN_LINE <= resize_last_in_line_delay1;
        RESIZE_LAST_PIX     <= resize_last_pixel_delay1;
        FULL_LAST_IN_LINE   <= last_in_line_delay1;
        FULL_LAST_PIX       <= last_pixel_delay1;
    end

//----------------------------------
// Connect with next stage

    always @(posedge CLK)
    begin
        if(~RSTn)
            SQUEEZE_OUT <= 1'b0;
        else if(RESIZE_LAST_PIX)
            SQUEEZE_OUT <= 1'b1;
        else if(NEXT_LAST_PIX)
            SQUEEZE_OUT <= 1'b0;
    end

endmodule
