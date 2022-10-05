`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/21 08:55:36
// Design Name: 
// Module Name: VGA_timing
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


module VGA_ahb_top (
    // AHB inputs
    input               HCLK,
    input               HRESET,
    input               HSEL,
    input               HREADY,
    input       [1:0]   HTRANS,
    input               HWRITE,
    input       [31:0]  HADDR,
    input       [31:0]  HWDATA,

    output              HREADYOUT,
    output reg  [31:0]  HRDATA,

    // VGA CAM AHB
    input               VGA_CAM_HCLK,
    input               VGA_CAM_HRESET,
    input               VGA_CAM_HSEL,
    input               VGA_CAM_HREADY,
    input       [1:0]   VGA_CAM_HTRANS,
    input               VGA_CAM_HWRITE,
    input       [31:0]  VGA_CAM_HADDR,
    input       [31:0]  VGA_CAM_HWDATA,

    output              VGA_CAM_HREADYOUT,
    output      [31:0]  VGA_CAM_HRDATA,

    // VGA
    input               CLK_25M,
    output              HSYNC,
    output              VSYNC,
    output      [3:0]   VGA_R,
    output      [3:0]   VGA_G,
    output      [3:0]   VGA_B
    );

    wire                valid;
    wire        [9:0]   h_cnt;
    wire        [9:0]   v_cnt;

    reg         [11:0]  vga_data;

    reg         [18:0]  reg_haddr;

    wire        [18:0]  vga_mem_write_addr;
    reg                 vga_mem_write_en;
    wire        [11:0]  vga_mem_data_to_ahb;

    reg                 vga_ctrl_write_en;

    reg         [16:0]  vga_mem_read_addr;
    wire                vga_mem_read_en;
    wire        [11:0]  vga_mem_data_to_vga;
    reg                 reg_vga_mem_read_en;

    //---------------------------------------
    // VGA timing
    
    VGA_640x480 u_VGA_640x480 (
        .pclk       (CLK_25M),
        .reset      (HRESET),

        .hsync      (HSYNC),
        .vsync      (VSYNC),

        .valid      (valid),
        .h_cnt      (h_cnt),
        .v_cnt      (v_cnt)
    );

    reg     [31:0]  reg_vga_rect_pos0  = 0;         // 76800 - 0x4B000
    reg     [31:0]  reg_vga_rect_pos1  = 0;         // 76801 - 0x4B004
    reg     [13:0]  reg_vga_rect_color = 14'h1000;  // 76802 - 0x4B008
    reg     [8:0]   reg_vga_rect_thick = 0;         // 76803 - 0x4B00C

    wire    [18:0]  vga_write_addr_calculated;
    // assign          vga_write_addr_calculated = HADDR[18:0] - 19'h2_0000; // start at 'h4002_0000, deal with it as 'b00_0000_0000_0000_0000
    assign          vga_write_addr_calculated = HADDR[18:0];

    //---------------------------------------
    // VGA addr & en

    always @(posedge HCLK) begin
        if(HRESET) begin
            vga_mem_write_en  <= 1'b0;
            vga_ctrl_write_en <= 1'b0;
            reg_haddr         <= 19'h0;
        end
        else if(~HREADY) begin
            vga_mem_write_en  <= vga_mem_write_en;
            vga_ctrl_write_en <= vga_ctrl_write_en;
            reg_haddr         <= reg_haddr;
        end
        else if(HSEL & HTRANS[1]) begin
            vga_mem_write_en  <= (vga_write_addr_calculated < 19'h4B000) ? HWRITE : 0;
            vga_ctrl_write_en <= (vga_write_addr_calculated >= 19'h4B000) ? HWRITE : 0;
            reg_haddr         <= vga_write_addr_calculated;
        end
        else begin
            vga_mem_write_en  <= 1'b0;
            vga_ctrl_write_en <= 1'b0;
            reg_haddr         <= 19'h0;
        end
    end

    // assign vga_mem_write_addr = (vga_mem_write_en) ? reg_haddr : (HTRANS[1] & (vga_write_addr_calculated[18:0]<19'h4B000)) ?  vga_write_addr_calculated : 0;
    assign vga_mem_write_addr = (vga_mem_write_en) ? reg_haddr : HTRANS[1] ?  vga_write_addr_calculated : 0;


    always @(posedge HCLK) begin
        if(vga_ctrl_write_en & (reg_haddr[3:0] == 4'h0))
            reg_vga_rect_pos0 <= HWDATA;
        else
            reg_vga_rect_pos0 <= reg_vga_rect_pos0;
    end

    always @(posedge HCLK) begin
        if(vga_ctrl_write_en & (reg_haddr[3:0] == 4'h4))
            reg_vga_rect_pos1 <= HWDATA;
        else
            reg_vga_rect_pos1 <= reg_vga_rect_pos1;
    end

    always @(posedge HCLK) begin
        if(vga_ctrl_write_en & (reg_haddr[3:0] == 4'h8))
            reg_vga_rect_color <= HWDATA[13:0];
        else
            reg_vga_rect_color <= reg_vga_rect_color;
    end

    always @(posedge HCLK) begin
        if(vga_ctrl_write_en & (reg_haddr[3:0] == 4'hC))
            reg_vga_rect_thick <= HWDATA[8:0];
        else
            reg_vga_rect_thick <= reg_vga_rect_thick;
    end

    assign HREADYOUT = 1'b1;
    // assign HRDATA    = {20'h0, vga_mem_data_to_ahb};
    always @( * ) begin
        if(reg_haddr < 19'h4B000)
            HRDATA = {20'h0, vga_mem_data_to_ahb};
        else if(reg_haddr[3:0] == 4'h0)
            HRDATA = reg_vga_rect_pos0;
        else if(reg_haddr[3:0] == 4'h4)
            HRDATA = reg_vga_rect_pos1;
        else if(reg_haddr[3:0] == 4'h8)
            HRDATA = {18'h0, reg_vga_rect_color};
        else if(reg_haddr[3:0] == 4'hC)
            HRDATA = {25'h0, reg_vga_rect_thick};
        else
            HRDATA = 32'hcccc_cccc;
    end

    //---------------------------------------
    // VGA rect

    wire                vga_rect_disp_en = ~reg_vga_rect_color[12];

    wire        [9:0]   vga_rect_x0 = {1'b0, reg_vga_rect_pos0[24:16]};
    wire        [9:0]   vga_rect_y0 = {1'b0, reg_vga_rect_pos0[8:0]};
    wire        [9:0]   vga_rect_x1 = {1'b0, reg_vga_rect_pos1[24:16]};
    wire        [9:0]   vga_rect_y1 = {1'b0, reg_vga_rect_pos1[8:0]};
    wire        [12:0]  vga_rect_color = reg_vga_rect_color[12:0];
    wire        [9:0]   vga_rect_thick = {3'h0, reg_vga_rect_thick[6:0]};
    wire        [9:0]   vga_pos_h = {1'b0, h_cnt[9:1]};
    wire        [9:0]   vga_pos_v = {1'b0, v_cnt[9:1]};

    wire                vga_rect_L = ((vga_pos_h >= vga_rect_x0) & (vga_pos_h <= (vga_rect_x0 + vga_rect_thick)) & (vga_pos_v >= vga_rect_y0) & (vga_pos_v <= vga_rect_y1));
    wire                vga_rect_R = ((vga_pos_h <= vga_rect_x1) & (vga_pos_h >= (vga_rect_x1 - vga_rect_thick)) & (vga_pos_v >= vga_rect_y0) & (vga_pos_v <= vga_rect_y1));
    wire                vga_rect_U = ((vga_pos_v >= vga_rect_y0) & (vga_pos_v <= (vga_rect_y0 + vga_rect_thick)) & (vga_pos_h >= vga_rect_x0) & (vga_pos_h <= vga_rect_x1));
    wire                vga_rect_D = ((vga_pos_v <= vga_rect_y1) & (vga_pos_v >= (vga_rect_y1 - vga_rect_thick)) & (vga_pos_h >= vga_rect_x0) & (vga_pos_h <= vga_rect_x1));

    wire                vga_rect_area = vga_rect_L | vga_rect_R | vga_rect_U | vga_rect_D;
    reg                 reg_vga_rect_area;

    always @(posedge CLK_25M) begin
        reg_vga_rect_area <= vga_rect_area;
    end

    //---------------------------------------
    // VGA CAM

    wire                vga_cam_disp_en = reg_vga_rect_color[13];

    reg                 vga_cam_mem_write_en;
    reg         [15:0]  vga_cam_mem_write_addr;
    
    // wire                vga_cam_mem_read_en = (h_cnt>=160 & h_cnt<224 & v_cnt>=120 & v_cnt<184) ? 1 : 0;
    wire                vga_cam_mem_read_en = (h_cnt<=128 & v_cnt<=128 & valid) ? 1 : 0;
    reg                 reg_vga_cam_mem_read_en;
    reg         [11:0]  vga_cam_mem_read_addr;
    wire                vga_cam_mem_data_to_vga;

    reg                 cam_mem_read_stay;
    always @(posedge CLK_25M) begin
        if(~vga_cam_mem_read_en)
            cam_mem_read_stay <= 1'b1;
        else
            cam_mem_read_stay <= ~cam_mem_read_stay;
    end

    reg         [9:0]   cam_mem_read_step_back_cnt;
    always @(posedge CLK_25M) begin
        if(~vga_cam_mem_read_en)
            cam_mem_read_step_back_cnt <= 0;
        else if(cam_mem_read_step_back_cnt == 128-1)
            cam_mem_read_step_back_cnt <= 0;
        else
            cam_mem_read_step_back_cnt <= cam_mem_read_step_back_cnt + 1;
    end

    reg                 cam_mem_read_step_back;
    always @(posedge CLK_25M) begin
        if(~VSYNC)
            cam_mem_read_step_back <= 1'b1;
        else if(cam_mem_read_step_back_cnt == 128-1)
            cam_mem_read_step_back <= ~cam_mem_read_step_back;
        else
            cam_mem_read_step_back <= cam_mem_read_step_back;
    end

    always @(posedge VGA_CAM_HCLK) begin
        vga_cam_mem_write_addr <= VGA_CAM_HADDR[15:0] - 16'hC000;
    end

    always @(posedge VGA_CAM_HCLK) begin
        if(VGA_CAM_HRESET)
            vga_cam_mem_write_en <= 1'b0;
        else if(~VGA_CAM_HREADY)
            vga_cam_mem_write_en <= vga_cam_mem_write_en;
        else if(VGA_CAM_HSEL & VGA_CAM_HTRANS[1])
            vga_cam_mem_write_en <= VGA_CAM_HWRITE;
        else
            vga_cam_mem_write_en <= 1'b0;
    end

    always @(posedge CLK_25M) begin
        if(VGA_CAM_HRESET)
            vga_cam_mem_read_addr <= 0;
        else if(vga_cam_mem_read_en)
            // vga_cam_mem_read_addr <= vga_cam_mem_read_addr + 1;
            if(cam_mem_read_stay)
                vga_cam_mem_read_addr <= vga_cam_mem_read_addr;
            else if(cam_mem_read_step_back_cnt == 128-1 && cam_mem_read_step_back)
                vga_cam_mem_read_addr <= vga_cam_mem_read_addr - (64-1);
            else
                vga_cam_mem_read_addr <= vga_cam_mem_read_addr + 1;
        else if(v_cnt == 0)
            vga_cam_mem_read_addr <= 0;
        else
            vga_cam_mem_read_addr <= vga_cam_mem_read_addr;
    end

    bram_for_vga_cam u_bram_for_vga_cam (
      .clka             (VGA_CAM_HCLK),                 // input wire clka
      .ena              (1'b1),                         // input wire ena
      .wea              (vga_cam_mem_write_en),         // input wire [0 : 0] wea
      .addra            (vga_cam_mem_write_addr[13:2]), // input wire [11 : 0] addra
      .dina             (VGA_CAM_HWDATA[0]),         // input wire [0 : 0] dina
      .douta            (),                             // output wire [0 : 0] douta

      .clkb             (CLK_25M),                      // input wire clkb
      .enb              (1'b1),                         // input wire enb
      .web              (1'b0),          // input wire [0 : 0] web
      .addrb            (vga_cam_mem_read_addr),        // input wire [11 : 0] addrb
      .dinb             (1'b0),                        // input wire [0 : 0] dinb
      .doutb            (vga_cam_mem_data_to_vga)            // output wire [0 : 0] doutb
    );

    always @(posedge CLK_25M) begin
        reg_vga_cam_mem_read_en <= vga_cam_mem_read_en;
    end

    assign VGA_CAM_HREADYOUT = 1'b1;
    assign VGA_CAM_HRDATA    = 32'hcccc_cccc; // M3 CANNOT READ OUT THE VGA CAM MEM

    //---------------------------------------
    // VGA disp

    reg                 mem_read_stay;
    always @(posedge CLK_25M) begin
        if(~valid)
            mem_read_stay <= 1'b1;
        else
            mem_read_stay <= ~mem_read_stay;
    end

    reg         [9:0]   mem_read_step_back_cnt;
    always @(posedge CLK_25M) begin
        if(~valid)
            mem_read_step_back_cnt <= 0;
        else if(mem_read_step_back_cnt == 640-1)
            mem_read_step_back_cnt <= 0;
        else
            mem_read_step_back_cnt <= mem_read_step_back_cnt + 1;
    end

    reg                 mem_read_step_back;
    always @(posedge CLK_25M) begin
        if(~VSYNC)
            mem_read_step_back <= 1'b1;
        else if(mem_read_step_back_cnt == 640-1)
            mem_read_step_back <= ~mem_read_step_back;
        else
            mem_read_step_back <= mem_read_step_back;
    end

    // assign vga_mem_read_en = (h_cnt>=160 & h_cnt<480 & v_cnt>=120 & v_cnt<360) ? 1 : 0;
    assign vga_mem_read_en = valid;

    always @(posedge CLK_25M) begin
        if(HRESET)
            vga_mem_read_addr <= 0;
        else if(vga_mem_read_en)
            if(mem_read_stay)
                vga_mem_read_addr <= vga_mem_read_addr;
            else if(mem_read_step_back_cnt == 640-1 && mem_read_step_back)
                vga_mem_read_addr <= vga_mem_read_addr - (320-1);
            else
                vga_mem_read_addr <= vga_mem_read_addr + 1;
            // vga_mem_read_addr <= vga_mem_read_addr + 1;
        else if(v_cnt == 0)
            vga_mem_read_addr <= 0;
        else
            vga_mem_read_addr <= vga_mem_read_addr;
    end

    bram_for_vga u_bram_for_vga (
        .clka           (HCLK),                     // input wire clka
        .ena            (1'b1),                     // input wire ena
        .wea            (vga_mem_write_en),         // input wire [0 : 0] wea
        .addra          (vga_mem_write_addr[18:2]), // input wire [16 : 0] addra
        .dina           (HWDATA[11:0]),             // input wire [11 : 0] dina
        .douta          (vga_mem_data_to_ahb),      // output wire [11 : 0] douta

        .clkb           (CLK_25M),                  // input wire clkb
        .enb            (1'b1),                     // input wire enb
        .web            (1'b0),                     // input wire [0 : 0] web
        .addrb          (vga_mem_read_addr),        // input wire [16 : 0] addrb
        .dinb           (12'hf00),                  // input wire [11 : 0] dinb
        .doutb          (vga_mem_data_to_vga)       // output wire [11 : 0] doutb
    );

    always @(posedge CLK_25M) begin
        reg_vga_mem_read_en <= vga_mem_read_en;
    end

    always @(posedge CLK_25M) begin
        if(HRESET)
            vga_data <= 12'h0;
        else if(reg_vga_mem_read_en)
        begin
            // vga_data <= (reg_vga_rect_area & vga_rect_disp_en) ? vga_rect_color[11:0] : vga_mem_data_to_vga;
            if(reg_vga_cam_mem_read_en & vga_cam_disp_en)
                vga_data <= {12{vga_cam_mem_data_to_vga}};
            else if(reg_vga_rect_area & vga_rect_disp_en)
                vga_data <= vga_rect_color[11:0];
            else
                vga_data <= vga_mem_data_to_vga;
        end
        else
            vga_data <= 12'h0;
    end

    assign VGA_R = vga_data[11:8];
    assign VGA_G = vga_data[7:4];
    assign VGA_B = vga_data[3:0];

endmodule