`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/24 18:24:59
// Design Name: 
// Module Name: AHB_DCMI
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


module AHB_DCMI(
    // AHB inputs
    input               HCLK,
    input               HRESETn,
    input               HSEL,
    input               HREADY,
    input       [1:0]   HTRANS,
    input               HWRITE,
    input       [31:0]  HADDR,
    input       [31:0]  HWDATA,

    // AHB outputs
    output              HREADYOUT,
    output      [31:0]  HRDATA,

    // DCMI
    input               PCLK,
    input               CAM_HREF,
    input               CAM_VSYNC,
    input       [7:0]   CAM_D,

    //interrupt
    output reg          INT = 1'b0
    );

    //------------------------------------------
    // DCMI
   
    reg     [7:0]   reg_cam_din;
    reg             cam_d_low_byte;
    reg     [8:0]   h_cnt;
    reg     [15:0]  v_cnt;
    reg             reg_href;

    always @(posedge PCLK) begin
        if(~CAM_HREF)
            cam_d_low_byte <= 1'b0;
        else if(h_cnt < 320)
            cam_d_low_byte <= ~cam_d_low_byte;
        else
            cam_d_low_byte <= 1'b0;
    end

    always @(posedge PCLK) begin
        if(~CAM_HREF)
            reg_cam_din <= 0;
        else if(~cam_d_low_byte)
            reg_cam_din <= CAM_D;
    end

    always @(posedge PCLK) begin
        reg_href <= CAM_HREF;
    end

    always @(posedge PCLK) begin
        if(~CAM_HREF | ~HRESETn)
            h_cnt <= 0;
        else if(cam_d_low_byte)
            h_cnt <= h_cnt + 1;
        else
            h_cnt <= h_cnt;
    end

    always @(posedge PCLK) begin
        if(CAM_VSYNC | ~HRESETn)
            v_cnt <= 0;
        else if(CAM_HREF & cam_d_low_byte & (h_cnt == 320-2))
            v_cnt <= v_cnt + 1;
        else
            v_cnt <= v_cnt;
    end

    wire    [3:0]   cam_din_r = reg_cam_din[6:3];
    wire    [3:0]   cam_din_g = {reg_cam_din[0], CAM_D[7:5]};
    wire    [3:0]   cam_din_b = CAM_D[3:0];
    wire    [11:0]  cam_din   = {cam_din_r, cam_din_g, cam_din_b};

    //------------------------------------------
    // Control reg

    reg     [31:0]  Ctrl_reg = 32'h0;
    
    wire            int_clr = Ctrl_reg[0];
    wire            int_en  = Ctrl_reg[1];
    wire            dcmi_en = Ctrl_reg[3];

    reg             Ctrl_wr_en;
    reg             Ctrl_rd_en;

    always @(posedge HCLK) begin
        if(HSEL & HTRANS[1] & (HADDR[11:0] == 12'h004)) begin
            Ctrl_wr_en <= HWRITE;
            Ctrl_rd_en <= ~HWRITE;
        end

        else if(~HREADY) begin
            Ctrl_wr_en <= Ctrl_wr_en;
            Ctrl_rd_en <= Ctrl_rd_en;
        end

        else begin
            Ctrl_wr_en <= 1'b0;
            Ctrl_rd_en <= 1'b0;
        end
    end

    always @(posedge HCLK) begin
        if(~HRESETn) begin
            Ctrl_reg <= 0;
        end

        else if(Ctrl_wr_en) begin
            Ctrl_reg <= HWDATA;
        end

        else begin
            Ctrl_reg <= {Ctrl_reg[31:20], v_cnt, dcmi_en, INT, int_en, 1'b0};
        end
    end

    //------------------------------------------
    // FIFO

    reg                 fifo_rst;
    wire        [11:0]  fifo_din = cam_din;
    wire        [11:0]  fifo_dout;

    wire                fifo_write_en;
    wire                fifo_read_en;

    wire                fifo_full;
    wire                fifo_empty;
    wire                fifo_wr_rst_busy;
    wire                fifo_rd_rst_busy;

    assign fifo_read_en  = (HSEL & HTRANS[1] & ~HWRITE & ~fifo_empty & (HADDR[11:0] == 12'h000)) ? 1 : 0;
    assign fifo_write_en = (~fifo_rst & cam_d_low_byte & CAM_HREF & (h_cnt<320)) ? 1 : 0;

    always @( * ) begin
        if(fifo_full | ~dcmi_en)
            fifo_rst = 1;
        else if(~CAM_HREF)
            fifo_rst = 0;
        else
            fifo_rst = fifo_rst;
    end

    fifo_for_dcmi u_fifo_for_dcmi (
        .rst                  (fifo_rst),         // input wire rst
        .wr_clk               (PCLK),             // input wire wr_clk
        .rd_clk               (HCLK),             // input wire rd_clk

        .din                  (fifo_din),         // input wire [11 : 0] din
        .dout                 (fifo_dout),        // output wire [11 : 0] dout

        .wr_en                (fifo_write_en),    // input wire wr_en
        .rd_en                (fifo_read_en),     // input wire rd_en

        // state
        .full                 (fifo_full),        // output wire full
        .empty                (fifo_empty),       // output wire empty

        .wr_rst_busy          (fifo_wr_rst_busy), // output wire wr_rst_busy
        .rd_rst_busy          (fifo_rd_rst_busy)  // output wire rd_rst_busy
    );

    //------------------------------------------
    // INT
    
    always @(posedge HCLK) begin
        if(int_clr | fifo_rst | ~HRESETn)
            INT <= 0;
        else if(int_en & (h_cnt == 320-1) & cam_d_low_byte)
            INT <= 1;
        else
            INT <= INT;
    end

    //------------------------------------------
    // AHB

    reg     [31:0]  reg_haddr;

    always @(posedge HCLK) begin
        reg_haddr <= HADDR;
    end

    assign HRDATA    = (reg_haddr[11:0] == 12'h000) ? fifo_dout : ((Ctrl_rd_en) ? Ctrl_reg : 32'hcccc_cccc);
    assign HREADYOUT = (reg_haddr[11:0] == 12'h000) ? ~fifo_empty : 1;
    // assign HREADYOUT = 1'b1;

endmodule
