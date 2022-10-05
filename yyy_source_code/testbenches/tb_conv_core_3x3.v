`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/12 07:36:08
// Design Name: 
// Module Name: tb_conv_core_3x3
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


module tb_conv_core_3x3;

parameter filename_rgb       = "F:/Prj2020/C/IPU_test_data/IPU_test_data/3_rgb.txt";
parameter filename_threshold = "F:/Prj2020/C/IPU_test_data/IPU_test_data/threshold.txt";
parameter filename_conv_w = "F:/Prj2020/C/CNN_test_data/CNN_test_data/conv1_w_format.txt";
parameter filename_conv_b = "F:/Prj2020/C/CNN_test_data/CNN_test_data/conv1_b_format.txt";
parameter filename_result = "F:/Prj2020/C/CNN_test_data/CNN_test_data/conv1_result.txt";

reg             clk = 1'b0;
reg             rst_n = 1'b0;

reg             din_valid;
reg    [399:0]  din_valid_shifter = {{80{1'b0}}, {320{1'b1}}};
reg             squeeze = 1'b0;
wire            phase0_last_pix;
wire            resize_squeeze_out;

reg     [11:0]  file_rgb[0:320*240-1];
integer         file_threshold[0:8];
reg     [23:0]  file_conv_w[0:8];
reg     [23:0]  file_conv_b[0:0];
reg     [23:0]  file_result[0:64*64-1];

wire            p0_border = (file_threshold[6]>=5) ? 1 : 0;
wire            p1_border = (file_threshold[7]>=5) ? 1 : 0;

integer         rgb_i = 0;
wire    [11:0]  rgb;

integer         result_i = 0;
wire    [23:0]  result;
wire            result_err;

wire    [23:0]  conv_out;
wire            conv_valid;
wire            conv_last_in_line;
wire            conv_last_pix;




initial begin
    $readmemh(filename_rgb, file_rgb);
    $readmemh(filename_threshold, file_threshold);
    $readmemh(filename_conv_w, file_conv_w, 0, 8);
    $readmemh(filename_conv_b, file_conv_b, 0, 0);
    $readmemh(filename_result, file_result);

    #25 
    rst_n = 1'b1;
end

always #10 clk = ~clk;

always @(posedge clk)
begin
    din_valid_shifter <= {din_valid_shifter[398:0], din_valid_shifter[399]};
end

always @(*)
begin
    if(rgb_i == 320*240)
        din_valid = 0;
    else
        din_valid = din_valid_shifter[399];
end

always @(posedge clk)
begin
    if(din_valid)
        rgb_i <= rgb_i + 1;
end

assign rgb = file_rgb[rgb_i];

always @(posedge clk)
begin
    if(rgb_i == 320*240-1)
        squeeze <= 1'b1;
    else if(phase0_last_pix)
        squeeze <= 1'b0;
end

always @(posedge clk)
begin
    if(conv_valid)
        result_i <= result_i + 1;
end

assign result = file_result[result_i];

//-----------------------------------
// IPU top

IPU_top_cxy #(
    .rgb2h_filename  ("F:/hsv_h.txt"),
    .rgb2s_filename  ("F:/hsv_s.txt")
)
u_IPU_top_cxy (
    .CLK                    (clk),
    .RSTn                   (rst_n),
    .RGB_VALID              (din_valid),
    .RGB                    (rgb),

    .H_MAX                  (file_threshold[0][8:0]),
    .H_MIN                  (file_threshold[1][8:0]),
    .S_MAX                  (file_threshold[2][6:0]),
    .S_MIN                  (file_threshold[3][6:0]),
    .V_MAX                  (file_threshold[4][5:0]),
    .V_MIN                  (file_threshold[5][5:0]),

    .SQUEEZE                (squeeze),

    .P0_BORDER              (p0_border),
    .P0_THRESHOLD           (file_threshold[6][3:0]),

    .P1_BORDER              (p1_border),
    .P1_THRESHOLD           (file_threshold[7][3:0]),

    .RESIZE_THRESHOLD       (file_threshold[8][3:0]),
    
    .binarization           (),

    .phase0_out             (),
    .phase0_valid           (),
    .phase0_last_in_line    (),
    .phase0_last_pix        (phase0_last_pix),

    .phase1_out             (),
    .phase1_valid           (),
    .phase1_last_in_line    (),
    .phase1_last_pix        (),

    .resize_out             (resize_out),
    .resize_valid           (resize_valid),
    .resize_r_last_in_line  (resize_r_last_in_line),
    .resize_r_last_pix      (resize_r_last_pix),
    .resize_f_last_in_line  (),
    .resize_f_last_pix      (),

    .SQUEEZE_OUT            (resize_squeeze_out),
    .NEXT_LAST_PIX          (conv_last_pix),

    .centroid_h             (),
    .centroid_v             (),
    .centroid_sum           (),
    .centroid_valid         ()
);

// conv_core_3x3_cxy u_conv_core (
//         .CLK            (clk),
//         .RSTn           (rst_n),
//         .DIN_VALID      (resize_valid),
//         .DIN            (resize_out),
//         .SQUEEZE        (resize_squeeze_out),

//         .W_11           (file_conv_w[0]),
//         .W_12           (file_conv_w[1]),
//         .W_13           (file_conv_w[2]),
//         .W_21           (file_conv_w[3]),
//         .W_22           (file_conv_w[4]),
//         .W_23           (file_conv_w[5]),
//         .W_31           (file_conv_w[6]),
//         .W_32           (file_conv_w[7]),
//         .W_33           (file_conv_w[8]),

//         .B              (file_conv_b[0]),

//         .OUT            (conv_out),
//         .VALID          (conv_valid),
//         .LAST_IN_LINE   (conv_last_in_line),
//         .LAST_PIX       (conv_last_pix),
//         .SQUEEZE_OUT    (),
//         .NEXT_LAST_PIX  (1'b0)
//     );

CNN_layer1_top u_layer1 (
    .CLK            (CLK),
    .RSTn           (RSTn),
    .DIN_VALID      (DIN_VALID),
    .DIN            (DIN),
    .SQUEEZE        (SQUEEZE),
    .CONV_LAST_PIX  (CONV_LAST_PIX),

    .CONV_W_WEN     (L1_CONV_W_WEN),
    .CONV_W_REN     (L1_CONV_W_REN),
    .CONV_W_ADDR    (L1_CONV_W_ADDR),
    .CONV_W_WDATA   (L1_CONV_W_WDATA),
    .CONV_W_RDATA   (L1_CONV_W_RDATA),

    .CONV_B_WEN     (L1_CONV_B_WEN),
    .CONV_B_REN     (L1_CONV_B_REN),
    .CONV_B_ADDR    (L1_CONV_B_ADDR),
    .CONV_B_WDATA   (L1_CONV_B_WDATA),
    .CONV_B_RDATA   (L1_CONV_B_RDATA),

    .FINISHED       (layer1_finished),

    .READ_ADDR      (layer1_data_read_addr),
    .READ_EN        (layer1_data_read_en),
    .READ_VALID     (layer1_data_read_valid),
    .DATA_OUT0      (layer1_data_out0),
    .DATA_OUT1      (layer1_data_out1),
    .DATA_OUT2      (layer1_data_out2),
    .DATA_OUT3      (layer1_data_out3)
);

endmodule
