`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/07 10:40:54
// Design Name: 
// Module Name: seg_scan_decode
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


module seg_scan_decode(
    input               CLK50M,
    input               RSTn,
    input       [3:0]   seg_data_0,
    input       [3:0]   seg_data_1,
    input       [3:0]   seg_data_2,
    input       [3:0]   seg_data_3,
    input       [3:0]   seg_data_4,
    input       [3:0]   seg_data_5,
    input       [3:0]   seg_data_6,
    input       [3:0]   seg_data_7,

    output reg  [7:0]   seg_select,
    output      [7:0]   seg_data_out0,
    output      [7:0]   seg_data_out1
    );

    reg         [16:0]  seg_div_cnt;
    reg         [ 3:0]  seg_data_selected;
    reg         [ 7:0]  seg_data_decode;

    always @(posedge CLK50M) begin
        if(~RSTn)
            seg_div_cnt <= 0;
        else if(seg_div_cnt == 50000-1)
            seg_div_cnt <= 0;
        else
            seg_div_cnt <= seg_div_cnt + 1;
    end

    always @(posedge CLK50M) begin
        if(~RSTn)
            seg_select <= 8'h1;
        else if(seg_div_cnt == 50000-1)
            seg_select <= {seg_select[6:0], seg_select[7]};
        else
            seg_select <= seg_select;
    end

    always @( * ) begin
        case(seg_select)
            8'h01:   seg_data_selected = seg_data_0;
            8'h02:   seg_data_selected = seg_data_1;
            8'h04:   seg_data_selected = seg_data_2;
            8'h08:   seg_data_selected = seg_data_3;
            8'h10:   seg_data_selected = seg_data_4;
            8'h20:   seg_data_selected = seg_data_5;
            8'h40:   seg_data_selected = seg_data_6;
            8'h80:   seg_data_selected = seg_data_7;
            default: seg_data_selected = seg_data_7;
        endcase
    end

    always @( * ) begin
        case(seg_data_selected)
            8'h0: seg_data_decode = 8'b0011_1111;
            8'h1: seg_data_decode = 8'b0000_0110;
            8'h2: seg_data_decode = 8'b0101_1011;
            8'h3: seg_data_decode = 8'b0100_1111;

            8'h4: seg_data_decode = 8'b0110_0110;
            8'h5: seg_data_decode = 8'b0110_1101;
            8'h6: seg_data_decode = 8'b0111_1101;
            8'h7: seg_data_decode = 8'b0000_0111;

            8'h8: seg_data_decode = 8'b0111_1111;
            8'h9: seg_data_decode = 8'b0110_1111;
            8'ha: seg_data_decode = 8'b0111_0111;
            8'hb: seg_data_decode = 8'b0111_1100;

            8'hc: seg_data_decode = 8'b0101_1000;
            8'hd: seg_data_decode = 8'b0101_1110;
            8'he: seg_data_decode = 8'b0111_1001;
            8'hf: seg_data_decode = 8'b0111_0001;
        endcase
    end

    assign seg_data_out0 = seg_data_decode;
    assign seg_data_out1 = seg_data_decode;

    // always @( * ) begin
    //     case(seg_select)
    //         8'h01:   seg_data_out0 = 8'h01;
    //         8'h02:   seg_data_out0 = 8'h02;
    //         8'h04:   seg_data_out0 = 8'h04;
    //         8'h08:   seg_data_out0 = 8'h08;
    //         default: seg_data_out0 = 8'h0;
    //     endcase
    // end

    // always @( * ) begin
    //     case(seg_select)
    //         8'h10:   seg_data_out1 = 8'h10;
    //         8'h20:   seg_data_out1 = 8'h20;
    //         8'h40:   seg_data_out1 = 8'h40;
    //         8'h80:   seg_data_out1 = 8'h80;
    //         default: seg_data_out1 = 8'h0;
    //     endcase
    // end

endmodule
