`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/12 09:46:12
// Design Name: 
// Module Name: tb_CNN_tdm_top
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


module tb_CNN_tdm_top;

//----------------------------------------------------------
// LOAD FILE

parameter P_WIDTH = 320;
parameter P_HEIGHT = 240;
parameter DW = 24;

parameter filename_rgb          = "F:/Prj2020/test_data/1_rgb.txt";
parameter filename_resize       = "F:/Prj2020/test_data/1_resize.txt";

parameter filename_L1_CONV_W    = "F:/Prj2020/test_data/CNN_TDM_TEST/conv1_w_format.txt";
parameter filename_L1_CONV_B    = "F:/Prj2020/test_data/CNN_TDM_TEST/conv1_b_format.txt";
parameter filename_L2_CONV_W1   = "F:/Prj2020/test_data/CNN_TDM_TEST/conv2_w_format_1.txt";
parameter filename_L2_CONV_B1   = "F:/Prj2020/test_data/CNN_TDM_TEST/conv2_b_format_1.txt";
parameter filename_L2_CONV_W2   = "F:/Prj2020/test_data/CNN_TDM_TEST/conv2_w_format_2.txt";
parameter filename_L2_CONV_B2   = "F:/Prj2020/test_data/CNN_TDM_TEST/conv2_b_format_2.txt";
parameter filename_VECTOR_W     = "F:/Prj2020/test_data/CNN_TDM_TEST/fc1_w_format.txt";
parameter filename_VECTOR_B     = "F:/Prj2020/test_data/CNN_TDM_TEST/fc1_b_format.txt";

reg     [11:0]      file_rgb[0:P_WIDTH*P_HEIGHT-1];
reg                 file_resize[0:64*64-1];

reg     [32-1:0]    file_L1_CONV_W[0:9*4-1];
reg     [32-1:0]    file_L1_CONV_B[0:4-1];
reg     [32-1:0]    file_L2_CONV_W1[0:9*4*4-1];
reg     [32-1:0]    file_L2_CONV_B1[0:4-1];
reg     [32-1:0]    file_L2_CONV_W2[0:9*4*4-1];
reg     [32-1:0]    file_L2_CONV_B2[0:4-1];
reg     [32-1:0]    file_VECTOR_W[0:16*6*8-1];
reg     [32-1:0]    file_VECTOR_B[0:6-1];

wire                L1_CONV_W_WEN ;
wire                L1_CONV_B_WEN ;
wire                L2_CONV_W1_WEN;
wire                L2_CONV_B1_WEN;
wire                L2_CONV_W2_WEN;
wire                L2_CONV_B2_WEN;
wire                VECTOR_W_WEN  ;
wire                VECTOR_B_WEN  ;

//----------------------------------------------------------
// SIGNALS

reg                 clk = 1'b0;
reg                 rst_n = 1'b0;

//--------------------------
// CNN INIT

reg                 cnn_init_done;
reg                 reg_cnn_init_done;
reg                 cnn_rst_n;
reg     [9:0]       cnn_init_addr;

wire    [32-1:0]    l1_conv_w  = file_L1_CONV_W[cnn_init_addr];
wire    [32-1:0]    l1_conv_b  = file_L1_CONV_B[cnn_init_addr];
wire    [32-1:0]    l2_conv_w1 = file_L2_CONV_W1[cnn_init_addr];
wire    [32-1:0]    l2_conv_b1 = file_L2_CONV_B1[cnn_init_addr];
wire    [32-1:0]    l2_conv_w2 = file_L2_CONV_W2[cnn_init_addr];
wire    [32-1:0]    l2_conv_b2 = file_L2_CONV_B2[cnn_init_addr];
wire    [32-1:0]    vector_w   = file_VECTOR_W[cnn_init_addr];
wire    [32-1:0]    vector_b   = file_VECTOR_B[cnn_init_addr];

reg     [DW-1:0]    reg_l1_conv_w ;
reg     [DW-1:0]    reg_l1_conv_b ;
reg     [DW-1:0]    reg_l2_conv_w1;
reg     [DW-1:0]    reg_l2_conv_b1;
reg     [DW-1:0]    reg_l2_conv_w2;
reg     [DW-1:0]    reg_l2_conv_b2;
reg     [DW-1:0]    reg_vector_w  ;
reg     [DW-1:0]    reg_vector_b  ;

//--------------------------
// FOR IPU

wire                rgb_valid;
reg     [399:0]     rgb_valid_shifter;

integer             rgb_i;
wire    [11:0]      rgb;

reg                 squeeze_ipu;
wire                phase0_last_pix;

wire                resize_out;
wire                resize_valid;
wire                resize_r_last_in_line;
wire                resize_r_last_pix;
integer             resize_i;
wire                resize_file_result;
wire                resize_err;

//--------------------------
// FOR CNN

wire                ipu_squeeze_out;
wire                cnn_conv_1_last_pix;

wire                cnn_valid;
wire    [DW-1:0]    cnn_output1;
wire    [DW-1:0]    cnn_output2;
wire    [DW-1:0]    cnn_output3;
wire    [DW-1:0]    cnn_output4;
wire    [DW-1:0]    cnn_output5;
wire    [DW-1:0]    cnn_output6;


//----------------------------------------------------------
// LOGICS

initial begin
    $readmemh(filename_rgb, file_rgb);
    $readmemh(filename_resize, file_resize);

    $readmemh(filename_L1_CONV_W , file_L1_CONV_W );
    $readmemh(filename_L1_CONV_B , file_L1_CONV_B );
    $readmemh(filename_L2_CONV_W1, file_L2_CONV_W1);
    $readmemh(filename_L2_CONV_B1, file_L2_CONV_B1);
    $readmemh(filename_L2_CONV_W2, file_L2_CONV_W2);
    $readmemh(filename_L2_CONV_B2, file_L2_CONV_B2);
    $readmemh(filename_VECTOR_W  , file_VECTOR_W  );
    $readmemh(filename_VECTOR_B  , file_VECTOR_B  );
end

always  #10 clk = ~clk;
initial #20 rst_n = 1'b1;

//--------------------------
// CNN INIT

always @(posedge clk)
begin
    if(~rst_n)
        cnn_init_done <= 0;
    else if(cnn_init_addr == 16*6*8-1)
        cnn_init_done <= 1;
end

always @(posedge clk)
begin
    reg_cnn_init_done <= cnn_init_done;
    cnn_rst_n <= reg_cnn_init_done;
end

always @(posedge clk)
begin
    if(~rst_n)
        cnn_init_addr <= 0;
    else if(~cnn_init_done)
        cnn_init_addr <= cnn_init_addr + 1;
end

assign L1_CONV_W_WEN  = (~cnn_init_done & (cnn_init_addr < 9*4    )) ? 1 : 0;
assign L1_CONV_B_WEN  = (~cnn_init_done & (cnn_init_addr < 4      )) ? 1 : 0;
assign L2_CONV_W1_WEN = (~cnn_init_done & (cnn_init_addr < 9*4*4  )) ? 1 : 0;
assign L2_CONV_B1_WEN = (~cnn_init_done & (cnn_init_addr < 4      )) ? 1 : 0;
assign L2_CONV_W2_WEN = (~cnn_init_done & (cnn_init_addr < 9*4*4  )) ? 1 : 0;
assign L2_CONV_B2_WEN = (~cnn_init_done & (cnn_init_addr < 4      )) ? 1 : 0;
assign VECTOR_W_WEN   = (~cnn_init_done & (cnn_init_addr < 16*6*8 )) ? 1 : 0;
assign VECTOR_B_WEN   = (~cnn_init_done & (cnn_init_addr < 6      )) ? 1 : 0;

always @(posedge clk)
begin
    reg_l1_conv_w  <= l1_conv_w[DW-1:0];
    reg_l1_conv_b  <= l1_conv_b[DW-1:0];
    reg_l2_conv_w1 <= l2_conv_w1[DW-1:0];
    reg_l2_conv_b1 <= l2_conv_b1[DW-1:0];
    reg_l2_conv_w2 <= l2_conv_w2[DW-1:0];
    reg_l2_conv_b2 <= l2_conv_b2[DW-1:0];
    reg_vector_w   <= vector_w[DW-1:0];
    reg_vector_b   <= vector_b[DW-1:0];
end


//--------------------------
// IPU DATA

assign rgb_valid = (rgb_i<76800) ? rgb_valid_shifter[399] : 0;

always @(posedge clk)
begin
    if(~rst_n)
        rgb_valid_shifter <= {{80{1'b0}}, {320{1'b1}}};
    else if(~cnn_init_done)
        rgb_valid_shifter <= rgb_valid_shifter;
    else
        rgb_valid_shifter <= {rgb_valid_shifter[398:0], rgb_valid_shifter[399]};
end

always @(posedge clk)
begin
    if(~rst_n)
        rgb_i <= 0;
    else if(rgb_valid)
        rgb_i <= rgb_i + 1;
end

assign rgb = file_rgb[rgb_i];

always @(posedge clk)
begin
    if(~rst_n)
        squeeze_ipu <= 0;
    else if(rgb_i == 76800-1)
        squeeze_ipu <= 1;
    else if(phase0_last_pix)
        squeeze_ipu <= 0;
end

always @(posedge clk)
begin
    if(~rst_n)
        resize_i <= 0;
    else if(resize_valid)
        resize_i <= resize_i + 1;
end

assign resize_file_result = file_resize[resize_i];
assign resize_err = (resize_valid & (resize_out ^ resize_file_result)) ? 1 : 0;

//----------------------------------------------------------
// IPU & CNN

IPU_top_cxy #(
    .rgb2h_filename ("F:/hsv_h.txt"),
    .rgb2s_filename ("F:/hsv_s.txt"),
    .P_WIDTH        (P_WIDTH),
    .P_HEIGHT       (P_HEIGHT)
)
u_IPU_top_cxy (
    .CLK                    (clk),
    .RSTn                   (rst_n),
    .RGB_VALID              (rgb_valid),
    .RGB                    (rgb),

    .H_MAX                  (40),
    .H_MIN                  (10),
    .S_MAX                  (80),
    .S_MIN                  (0),
    .V_MAX                  (25),
    .V_MIN                  (0),

    .SQUEEZE                (squeeze_ipu),

    .P0_BORDER              (1),
    .P0_THRESHOLD           (9),

    .P1_BORDER              (0),
    .P1_THRESHOLD           (1),

    .RESIZE_THRESHOLD       (5),
    
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

    .SQUEEZE_OUT            (ipu_squeeze_out),
    .NEXT_LAST_PIX          (cnn_conv_1_last_pix),

    .centroid_h             (),
    .centroid_v             (),
    .centroid_sum           (),
    .centroid_valid         ()
);

CNN_tdm_top #(
    .SIMULATE(1)
)
u_CNN (
        .CLK                (clk),
        .RSTn               (cnn_rst_n),
        .DIN_VALID          (resize_valid),
        .DIN                (resize_out),
        .SQUEEZE            (ipu_squeeze_out),
        .CONV_LAST_PIX      (cnn_conv_1_last_pix),

        .L1_CONV_W_WEN      (L1_CONV_W_WEN),
        .L1_CONV_W_REN      (1'b0),
        .L1_CONV_W_ADDR     (cnn_init_addr[5:0]),
        .L1_CONV_W_WDATA    (reg_l1_conv_w),
        .L1_CONV_W_RDATA    (),

        .L1_CONV_B_WEN      (L1_CONV_B_WEN),
        .L1_CONV_B_REN      (1'b0),
        .L1_CONV_B_ADDR     (cnn_init_addr[1:0]),
        .L1_CONV_B_WDATA    (reg_l1_conv_b),
        .L1_CONV_B_RDATA    (),

        .L2_CONV_W1_WEN     (L2_CONV_W1_WEN),
        .L2_CONV_W1_REN     (1'b0),
        .L2_CONV_W1_ADDR    (cnn_init_addr[7:0]),
        .L2_CONV_W1_WDATA   (reg_l2_conv_w1),
        .L2_CONV_W1_RDATA   (),

        .L2_CONV_B1_WEN     (L2_CONV_B1_WEN),
        .L2_CONV_B1_REN     (1'b0),
        .L2_CONV_B1_ADDR    (cnn_init_addr[3:0]),
        .L2_CONV_B1_WDATA   (reg_l2_conv_b1),
        .L2_CONV_B1_RDATA   (),

        .L2_CONV_W2_WEN     (L2_CONV_W2_WEN),
        .L2_CONV_W2_REN     (1'b0),
        .L2_CONV_W2_ADDR    (cnn_init_addr[7:0]),
        .L2_CONV_W2_WDATA   (reg_l2_conv_w2),
        .L2_CONV_W2_RDATA   (),

        .L2_CONV_B2_WEN     (L2_CONV_B2_WEN),
        .L2_CONV_B2_REN     (1'b0),
        .L2_CONV_B2_ADDR    (cnn_init_addr[3:0]),
        .L2_CONV_B2_WDATA   (reg_l2_conv_b2),
        .L2_CONV_B2_RDATA   (),

        .VECTOR_W_WEN       (VECTOR_W_WEN),
        .VECTOR_W_REN       (1'b0),
        .VECTOR_W_ADDR      (cnn_init_addr[9:0]),
        .VECTOR_W_WDATA     (reg_vector_w),
        .VECTOR_W_RDATA     (),

        .VECTOR_B_WEN       (VECTOR_B_WEN),
        .VECTOR_B_REN       (1'b0),
        .VECTOR_B_ADDR      (cnn_init_addr[2:0]),
        .VECTOR_B_WDATA     (reg_vector_b),
        .VECTOR_B_RDATA     (),

        .VALID              (cnn_valid),
        .OUTPUT1            (cnn_output1),
        .OUTPUT2            (cnn_output2),
        .OUTPUT3            (cnn_output3),
        .OUTPUT4            (cnn_output4),
        .OUTPUT5            (cnn_output5),
        .OUTPUT6            (cnn_output6)
    );

endmodule
