`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/11 09:26:04
// Design Name: 
// Module Name: tb_IPU_top
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


module tb_IPU_top;

parameter filename_rgb       = "F:/Prj2020/C/IPU_test_data/IPU_test_data/3_rgb.txt";
parameter filename_bin       = "F:/Prj2020/C/IPU_test_data/IPU_test_data/bin.txt";
parameter filename_phase0    = "F:/Prj2020/C/IPU_test_data/IPU_test_data/phase0.txt";
parameter filename_phase1    = "F:/Prj2020/C/IPU_test_data/IPU_test_data/phase1.txt";
parameter filename_resize    = "F:/Prj2020/C/IPU_test_data/IPU_test_data/resize.txt";
parameter filename_threshold = "F:/Prj2020/C/IPU_test_data/IPU_test_data/threshold.txt";

reg             clk = 1'b0;
reg             rst_n = 1'b0;

reg             din_valid;
reg    [399:0]  din_valid_shifter = {{80{1'b0}}, {320{1'b1}}};
reg             squeeze = 1'b0;

reg     [11:0]  file_rgb[0:320*240-1];
reg             file_bin[0:320*240-1];
reg             file_phase0[0:320*240-1];
reg             file_phase1[0:320*240-1];
reg             file_resize[0:64*64-1];
integer         file_threshold[0:8];

wire            p0_border = (file_threshold[6]>=5) ? 1 : 0;
wire            p1_border = (file_threshold[7]>=5) ? 1 : 0;

integer         rgb_i = 0;
wire    [11:0]  rgb;
wire            bin;
wire            bin_out;
reg             bin_valid;

integer         phase0_i = 0;
wire            phase0;
wire            phase0_out;
wire            phase0_valid;
wire            phase0_last_in_line;
wire            phase0_last_pix;

integer         phase1_i = 0;
wire            phase1;
wire            phase1_out;
wire            phase1_valid;
wire            phase1_last_in_line;
wire            phase1_last_pix;

integer         resize_i = 0;
wire            resize;
wire            resize_out;
wire            resize_valid;
wire            resize_r_last_in_line;
wire            resize_r_last_pix;
wire            resize_f_last_in_line;
wire            resize_f_last_pix;

wire            bin_err     = (bin_out    ^ bin   ) & bin_valid;
reg             bin_err_reg;
wire            phase0_err  = (phase0_out ^ phase0) & phase0_valid;
wire            phase1_err  = (phase1_out ^ phase1) & phase1_valid;
wire            resize_err  = (resize_out ^ resize) & resize_valid;

wire    [17:0]  centroid_h;
wire    [17:0]  centroid_v;
wire    [12:0]  centroid_sum;
wire            centroid_valid;

integer         file_bin_output;
integer         file_phase0_output;
integer         file_phase1_output;
integer         file_resize_output;


initial begin
    $readmemh(filename_rgb, file_rgb);
    $readmemh(filename_bin, file_bin);
    $readmemh(filename_phase0, file_phase0);
    $readmemh(filename_phase1, file_phase1);
    $readmemh(filename_resize, file_resize);
    $readmemh(filename_threshold, file_threshold);

    file_bin_output = $fopen("F:/Prj2020/test_data/IPU_TEST/bin_output.txt","w");
    file_phase0_output = $fopen("F:/Prj2020/test_data/IPU_TEST/phase0_output.txt","w");
    file_phase1_output = $fopen("F:/Prj2020/test_data/IPU_TEST/phase1_output.txt","w");
    file_resize_output = $fopen("F:/Prj2020/test_data/IPU_TEST/resize_output.txt","w");

    #20
    rst_n = 1'b1;
end

always #10  clk = ~clk;

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
    bin_valid <= din_valid;
    bin_err_reg <= bin_err;
end

always @(posedge clk)
begin
    if(rgb_i == 320*240-1)
        squeeze <= 1'b1;
    else if(phase0_last_pix)
        squeeze <= 1'b0;
end

//-----------------------------------
// rgb & bin

always @(posedge clk)
begin
    if(~rst_n)
        rgb_i <= 0;
    else if(din_valid)
        rgb_i <= rgb_i + 1;
    else
        rgb_i <= rgb_i;
end

assign rgb = file_rgb[rgb_i];
assign bin = file_bin[rgb_i-1];

always @(posedge clk)
begin
    if(bin_valid)
        if(rgb_i % 320 == 0)
            $fwrite(file_bin_output, "%h\n", bin_out);
        else
            $fwrite(file_bin_output, "%h ", bin_out);
end

//-----------------------------------
// phase0

always @(posedge clk)
begin
    if(~rst_n)
        phase0_i <= 0;
    else if(phase0_valid)
        phase0_i <= phase0_i + 1;
    else
        phase0_i <= phase0_i;
end

assign phase0 = file_phase0[phase0_i];

always @(posedge clk)
begin
    if(phase0_valid)
        if(phase0_last_in_line)
            $fwrite(file_phase0_output, "%h\n", phase0_out);
        else
            $fwrite(file_phase0_output, "%h ", phase0_out);
end

//-----------------------------------
// phase1

always @(posedge clk)
begin
    if(~rst_n)
        phase1_i <= 0;
    else if(phase1_valid)
        phase1_i <= phase1_i + 1;
    else
        phase1_i <= phase1_i;
end

assign phase1 = file_phase1[phase1_i];

always @(posedge clk)
begin
    if(phase1_valid)
        if(phase1_last_in_line)
            $fwrite(file_phase1_output, "%h\n", phase1_out);
        else
            $fwrite(file_phase1_output, "%h ", phase1_out);
end

//-----------------------------------
// resize

always @(posedge clk)
begin
    if(~rst_n)
        resize_i <= 0;
    else if(resize_valid)
        resize_i <= resize_i + 1;
    else
        resize_i <= resize_i;
end

assign resize = file_resize[resize_i];

always @(posedge clk)
begin
    if(resize_valid)
        if(resize_r_last_in_line)
            $fwrite(file_resize_output, "%h\n", resize_out);
        else
            $fwrite(file_resize_output, "%h ", resize_out);
end

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
    
    .binarization           (bin_out),

    .phase0_out             (phase0_out),
    .phase0_valid           (phase0_valid),
    .phase0_last_in_line    (phase0_last_in_line),
    .phase0_last_pix        (phase0_last_pix),

    .phase1_out             (phase1_out),
    .phase1_valid           (phase1_valid),
    .phase1_last_in_line    (phase1_last_in_line),
    .phase1_last_pix        (phase1_last_pix),

    .resize_out             (resize_out),
    .resize_valid           (resize_valid),
    .resize_r_last_in_line  (resize_r_last_in_line),
    .resize_r_last_pix      (resize_r_last_pix),
    .resize_f_last_in_line  (resize_f_last_in_line),
    .resize_f_last_pix      (resize_f_last_pix),

    .SQUEEZE_OUT            (),
    .NEXT_LAST_PIX          (1'b0),

    .centroid_h             (centroid_h),
    .centroid_v             (centroid_v),
    .centroid_sum           (centroid_sum),
    .centroid_valid         (centroid_valid)
);

endmodule
