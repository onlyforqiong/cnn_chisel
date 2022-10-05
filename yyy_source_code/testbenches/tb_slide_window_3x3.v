`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/10 21:53:14
// Design Name: 
// Module Name: tb_slide_window_3x3
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


module tb_slide_window_3x3;

parameter filename_data_in  = "F:/Prj2020/C/slide_window_test_data/slide_window_test_data/data_in.txt";
parameter filename_result11 = "F:/Prj2020/C/slide_window_test_data/slide_window_test_data/result11.txt";
parameter filename_result12 = "F:/Prj2020/C/slide_window_test_data/slide_window_test_data/result12.txt";
parameter filename_result13 = "F:/Prj2020/C/slide_window_test_data/slide_window_test_data/result13.txt";
parameter filename_result21 = "F:/Prj2020/C/slide_window_test_data/slide_window_test_data/result21.txt";
parameter filename_result22 = "F:/Prj2020/C/slide_window_test_data/slide_window_test_data/result22.txt";
parameter filename_result23 = "F:/Prj2020/C/slide_window_test_data/slide_window_test_data/result23.txt";
parameter filename_result31 = "F:/Prj2020/C/slide_window_test_data/slide_window_test_data/result31.txt";
parameter filename_result32 = "F:/Prj2020/C/slide_window_test_data/slide_window_test_data/result32.txt";
parameter filename_result33 = "F:/Prj2020/C/slide_window_test_data/slide_window_test_data/result33.txt";

reg             clk = 1'b0;
reg             rst_n = 1'b0;

reg             din_valid;
reg     [31:0]  din_valid_shifter = 32'h0fcb_a273;
reg             squeeze;
wire    [31:0]  data_in;
wire    [31:0]  x_11;
wire    [31:0]  x_12;
wire    [31:0]  x_13;
wire    [31:0]  x_21;
wire    [31:0]  x_22;
wire    [31:0]  x_23;
wire    [31:0]  x_31;
wire    [31:0]  x_32;
wire    [31:0]  x_33;

wire            valid;
wire            last_in_line;
wire            last_pix;

wire            result_err;

integer         data_in_i = 0;
integer         result_i = 0;

reg     [31:0]  file_data_in[0:32*24-1];
reg     [31:0]  file_result11[0:32*24-1];
reg     [31:0]  file_result12[0:32*24-1];
reg     [31:0]  file_result13[0:32*24-1];
reg     [31:0]  file_result21[0:32*24-1];
reg     [31:0]  file_result22[0:32*24-1];
reg     [31:0]  file_result23[0:32*24-1];
reg     [31:0]  file_result31[0:32*24-1];
reg     [31:0]  file_result32[0:32*24-1];
reg     [31:0]  file_result33[0:32*24-1];

wire    [31:0]  result11;
wire    [31:0]  result12;
wire    [31:0]  result13;
wire    [31:0]  result21;
wire    [31:0]  result22;
wire    [31:0]  result23;
wire    [31:0]  result31;
wire    [31:0]  result32;
wire    [31:0]  result33;

always #10 clk = ~clk;

initial begin
    $readmemh(filename_data_in, file_data_in);
    $readmemh(filename_result11, file_result11);
    $readmemh(filename_result12, file_result12);
    $readmemh(filename_result13, file_result13);
    $readmemh(filename_result21, file_result21);
    $readmemh(filename_result22, file_result22);
    $readmemh(filename_result23, file_result23);
    $readmemh(filename_result31, file_result31);
    $readmemh(filename_result32, file_result32);
    $readmemh(filename_result33, file_result33);

    #25
    rst_n = 1'b1;
end

always @(*)
begin
    if(data_in_i == 32*24)
        din_valid = 0;
    else
        din_valid = din_valid_shifter[31];
end

always @(posedge clk)
begin
    din_valid_shifter <= {din_valid_shifter[30:0], din_valid_shifter[31] ^ din_valid_shifter[30]};
end

always @(posedge clk)
begin
    if(~rst_n | last_pix)
        squeeze <= 1'b0;
    else if(data_in_i == 32*24-1)
        squeeze <= 1'b1;
end

always @(posedge clk)
begin
    if(din_valid)
        data_in_i <= data_in_i + 1;
end

always @(posedge clk)
begin
    if(valid)
        result_i <= result_i + 1;
end

assign data_in = file_data_in[data_in_i];
assign result11 = file_result11[result_i];
assign result12 = file_result12[result_i];
assign result13 = file_result13[result_i];
assign result21 = file_result21[result_i];
assign result22 = file_result22[result_i];
assign result23 = file_result23[result_i];
assign result31 = file_result31[result_i];
assign result32 = file_result32[result_i];
assign result33 = file_result33[result_i];

assign result_err = valid & ( ~(result11 == x_11) |
                              ~(result12 == x_12) |
                              ~(result13 == x_13) |
                              ~(result21 == x_21) |
                              ~(result22 == x_22) |
                              ~(result23 == x_23) |
                              ~(result31 == x_31) |
                              ~(result32 == x_32) |
                              ~(result33 == x_33) );

slide_window_3x3_cxy #(
    .P_WIDTH     (32 ),
    .P_HEIGHT    (24 ),
    .P_WCNT_W    (5  ),
    .P_HCNT_W    (5  ),
    .P_PIX_CNT_W (10 ),
    .DW          (32 )
)
u_slide_window (
    .CLK            (clk),
    .RSTn           (rst_n),
    .DIN_VALID      (din_valid | squeeze),
    .DIN            (data_in),

    .P_BORDER       (32'd0),

    .VALID          (valid),
    .LAST_IN_LINE   (last_in_line),
    .LAST_PIXEL     (last_pix),

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

endmodule
