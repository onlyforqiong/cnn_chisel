`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/10 11:42:06
// Design Name: 
// Module Name: slide_window_cxy
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


module slide_window_3x3_cxy #(
        parameter   P_WIDTH     = 320,
        parameter   P_HEIGHT    = 240,
        parameter   P_WCNT_W    = 9,
        parameter   P_HCNT_W    = 8,
        parameter   P_PIX_CNT_W = 17,
        parameter   DW          = 1
    )
    (
        input                       CLK,
        input                       RSTn,
        input                       DIN_VALID,
        input       [DW-1:0]        DIN,

        input       [DW-1:0]        P_BORDER,

        output reg                  VALID,
        output reg                  LAST_IN_LINE,
        output reg                  LAST_PIXEL,

        output reg  [DW-1:0]        X_11,
        output reg  [DW-1:0]        X_12,
        output reg  [DW-1:0]        X_13,
        output reg  [DW-1:0]        X_21,
        output reg  [DW-1:0]        X_22,
        output reg  [DW-1:0]        X_23,
        output reg  [DW-1:0]        X_31,
        output reg  [DW-1:0]        X_32,
        output reg  [DW-1:0]        X_33
    );

    reg           [DW-1:0]  shifter[0:P_WIDTH*2+2];

    reg                     reg_din_valid = 0;

    reg  [P_PIX_CNT_W-1:0]  pixel_cnt;
    reg                     slide_start = 0;
    reg                     slide_end = 0;
    reg     [P_WCNT_W-1:0]  slide_col_cnt;
    reg     [P_HCNT_W-1:0]  slide_row_cnt;

    wire                    last_in_line;
    wire                    last_pixel;

    wire                    top_edge;
    wire                    bottom_edge;
    wire                    left_edge;
    wire                    right_edge;

//----------------------------------
// Shifter

    always @(posedge CLK) begin
        if(~RSTn)
            shifter[0] <= P_BORDER;
        else if(DIN_VALID)
            shifter[0] <= DIN;
        else
            shifter[0] <= shifter[0];
    end

    generate
        genvar i;
        for (i = 1; i <= P_WIDTH*2+1 ; i = i + 1)
        begin: shifter_bits

            always @(posedge CLK) begin
                if(~RSTn)
                    shifter[i] <= P_BORDER;
                else if(DIN_VALID)
                    shifter[i] <= shifter[i-1];
                else
                    shifter[i] <= shifter[i];
            end

        end
    endgenerate

//----------------------------------
// Position cnts

    assign last_in_line = (slide_col_cnt == P_WIDTH-1) ? 1'b1 : 1'b0;
    assign last_pixel   = (last_in_line & (slide_row_cnt == P_HEIGHT-1)) ? 1'b1 : 1'b0;

    always @(posedge CLK) begin
        if(~RSTn | (pixel_cnt == P_WIDTH*P_HEIGHT))
            pixel_cnt <= 0;
        else if(DIN_VALID)
            pixel_cnt <= pixel_cnt + 1'b1;
        else
            pixel_cnt <= pixel_cnt;
    end

    always @(posedge CLK) begin
        if(~slide_start | ~RSTn)
            slide_col_cnt <= 0;
        else if(DIN_VALID)
            if(slide_col_cnt == P_WIDTH-1)
                slide_col_cnt <= 0;
            else
                slide_col_cnt <= slide_col_cnt + 1;
        else
            slide_col_cnt <= slide_col_cnt;
    end

    always @(posedge CLK) begin
        if(~slide_start | ~RSTn)
            slide_row_cnt <= 0;
        else if(DIN_VALID & (slide_col_cnt == P_WIDTH-1))
            if(slide_row_cnt == P_HEIGHT-1)
                slide_row_cnt <= 0;
            else
                slide_row_cnt <= slide_row_cnt + 1;
        else
            slide_row_cnt <= slide_row_cnt;
    end

    always @(posedge CLK) begin
        if(~RSTn)
            slide_end <= 0;
        else if(last_pixel)
            slide_end <= 1;
    end

    always @(posedge CLK) begin
        if(~RSTn | last_pixel | slide_end)
            slide_start <= 1'b0;
        else if(DIN_VALID & (pixel_cnt == P_WIDTH+1))
            slide_start <= 1'b1;
        else
            slide_start <= slide_start;
    end

//----------------------------------
// Window

    assign top_edge  = (slide_row_cnt == 0         ) ? 1'b1 : 1'b0;
    assign bottom_edge   = (slide_row_cnt == P_HEIGHT-1) ? 1'b1 : 1'b0;
    assign left_edge  = (slide_col_cnt == 0         ) ? 1'b1 : 1'b0;
    assign right_edge = (slide_col_cnt == P_WIDTH-1 ) ? 1'b1 : 1'b0;

    // X_11
    always @(posedge CLK) begin
        if(~slide_start | top_edge | left_edge)
            X_11 <= P_BORDER;
        else
            X_11 <= X_12;
    end

    // X_12
    always @(posedge CLK) begin
        if(~slide_start | top_edge)
            X_12 <= P_BORDER;
        else
            X_12 <= shifter[P_WIDTH*2+1];
    end

    // X_13
    always @(posedge CLK) begin
        if(~slide_start | top_edge | right_edge)
            X_13 <= P_BORDER;
        else
            X_13 <= shifter[P_WIDTH*2];
    end

    // X_21
    always @(posedge CLK) begin
        if(~slide_start | left_edge)
            X_21 <= P_BORDER;
        else
            X_21 <= X_22;
    end

    // X_22
    always @(posedge CLK) begin
        if(~slide_start)
            X_22 <= P_BORDER;
        else
            X_22 <= shifter[P_WIDTH+1];
    end

    // X_23
    always @(posedge CLK) begin
        if(~slide_start | right_edge)
            X_23 <= P_BORDER;
        else
            X_23 <= shifter[P_WIDTH];
    end

    // X_31
    always @(posedge CLK) begin
        if(~slide_start | bottom_edge | left_edge)
            X_31 <= P_BORDER;
        else
            X_31 <= X_32;
    end

    // X_32
    always @(posedge CLK) begin
        if(~slide_start | bottom_edge)
            X_32 <= P_BORDER;
        else
            X_32 <= shifter[1];
    end

    // X_33
    always @(posedge CLK) begin
        if(~slide_start | bottom_edge | right_edge)
            X_33 <= P_BORDER;
        else
            X_33 <= shifter[0];
    end

//----------------------------------
// Status Calibration

    // 'reg_din_valid' and 'last_pixel' are the same stage as 'slide_start', associated with shifter in slide window

    always @(posedge CLK) begin
        reg_din_valid <= DIN_VALID;
        VALID         <= reg_din_valid & slide_start;
        LAST_IN_LINE  <= reg_din_valid & last_in_line;
        LAST_PIXEL    <= reg_din_valid & last_pixel;
    end

endmodule
