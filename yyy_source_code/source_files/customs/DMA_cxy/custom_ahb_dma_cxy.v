`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/03/28 22:13:13
// Design Name: 
// Module Name: custom_ahb_dma_cxy
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


module custom_ahb_dma_cxy (
    input  wire          FCLK,
    input  wire          RESETn,
    input  wire          PCLKEN,
    input  wire  [11:0]  PADDR,
    input  wire  [31:0]  PWDATA,
    input  wire          PWRITE,
    input  wire          PSEL,
    input  wire          PENABLE,
    output reg   [31:0]  PRDATA,

    output reg   [31:0]  HADDR_R,
    output wire  [2:0]   HBURST_R,
    output wire  [2:0]   HSIZE_R,
    output reg   [1:0]   HTRANS_R,
    output wire          HREADYOUT_R,
    input  wire  [31:0]  HRDATA_R,
    input  wire          HREADY_R,

    output reg   [31:0]  HADDR_W,
    output wire  [2:0]   HBURST_W,
    output wire  [2:0]   HSIZE_W,
    output reg   [1:0]   HTRANS_W,
    output wire          HREADYOUT_W,
    output wire          HWRITE_W,
    output wire  [31:0]  HWDATA_W,
    input  wire          HREADY_W,

    output reg           DMA_CXY_INT = 1'b0
    );

    //---------------------------------------
    // APB REG CONFIG

    reg     [31:0] reg_rd_addr   = 32'h0000_0000; // 0x000
    reg     [31:0] reg_wr_addr   = 32'h0000_0000; // 0x004
    reg     [31:0] reg_trans_len = 32'h0000_0000; // 0x008
    reg     [31:0] reg_ctrl      = 32'h0000_0000; // 0x00C

    wire    [31:0] reg_ctrl_nxt;

    wire            ctrl_dma_start   = reg_ctrl[0];
    wire            ctrl_dma_int_en  = reg_ctrl[1];
    wire            ctrl_dma_int_clr = reg_ctrl[2];
    wire            ctrl_dma_rd_inc  = reg_ctrl[3];
    wire            ctrl_dma_wr_inc  = reg_ctrl[4];

    always @(posedge FCLK) begin
        if(PCLKEN & PSEL & PENABLE & PWRITE & (PADDR == 12'h000))
            reg_rd_addr <= PWDATA;
        else
            reg_rd_addr <= reg_rd_addr;
    end

    always @(posedge FCLK) begin
        if(PCLKEN & PSEL & PENABLE & PWRITE & (PADDR == 12'h004))
            reg_wr_addr <= PWDATA;
        else
            reg_wr_addr <= reg_wr_addr;
    end

    always @(posedge FCLK) begin
        if(PCLKEN & PSEL & PENABLE & PWRITE & (PADDR == 12'h008))
            reg_trans_len <= PWDATA;
        else
            reg_trans_len <= reg_trans_len;
    end

    always @(posedge FCLK) begin
        if(PCLKEN & PSEL & PENABLE & PWRITE & (PADDR == 12'h00C))
            reg_ctrl <= PWDATA;
        else
            reg_ctrl <= reg_ctrl_nxt;
    end

    // assign reg_ctrl_nxt = reg_ctrl & 32'hFFFF_FFFA;
    assign reg_ctrl_nxt = {reg_ctrl[31:6], DMA_CXY_INT, ctrl_dma_wr_inc, ctrl_dma_rd_inc, 1'b0, ctrl_dma_int_en, 1'b0};

    always @(posedge FCLK) begin
        case(PADDR)
            12'h000: PRDATA <= reg_rd_addr;
            12'h004: PRDATA <= reg_wr_addr;
            12'h008: PRDATA <= reg_trans_len;
            12'h00C: PRDATA <= reg_ctrl;
            default: PRDATA <= 32'hCCCC_CCCC;
        endcase
    end

    //---------------------------------------
    // FIFO

    wire            fifo_srst;
    wire            fifo_wr_en;
    wire            fifo_rd_en;
    wire            fifo_full;
    wire            fifo_empty;

    fifo_for_dma_cxy u_fifo_for_dma_cxy (
        .clk        (FCLK),      // input wire clk
        .srst       (fifo_srst),    // input wire srst
        .din        (HRDATA_R),      // input wire [31 : 0] din
        .wr_en      (fifo_wr_en),  // input wire wr_en
        .rd_en      (fifo_rd_en),  // input wire rd_en
        .dout       (HWDATA_W),    // output wire [31 : 0] dout
        .full       (fifo_full),    // output wire full
        .empty      (fifo_empty)  // output wire empty
    );

    //---------------------------------------
    // AHB READ

    reg     [31:0]  reg_dma_r_cnt;
    reg             st_dma_r_idle = 1'b1;
    reg             reg_st_dma_r_idle;

    always @(posedge FCLK) begin
        if(ctrl_dma_start | ~RESETn)
            reg_dma_r_cnt <= reg_trans_len;
        else if(~HREADY_R | (reg_dma_r_cnt == 32'h0))
            reg_dma_r_cnt <= reg_dma_r_cnt;
        else
            reg_dma_r_cnt <= reg_dma_r_cnt - 32'h1;
    end

    always @(posedge FCLK) begin
        if(ctrl_dma_start | ~RESETn)
            st_dma_r_idle <= 1'b0;
        else if(HREADY_R & (reg_dma_r_cnt == 32'h1))
            st_dma_r_idle <= 1'b1;
        else
            st_dma_r_idle <= st_dma_r_idle;
    end

    always @(posedge FCLK) begin
        reg_st_dma_r_idle <= st_dma_r_idle;
    end

    assign fifo_wr_en = ~reg_st_dma_r_idle & HREADY_R;
    // assign fifo_wr_en = HREADY_R & (~st_dma_r_idle | ~reg_st_dma_r_idle);

    always @(posedge FCLK) begin
        if(ctrl_dma_start)
            HADDR_R <= reg_rd_addr;
        else if(~st_dma_r_idle)
            if(HREADY_R & ctrl_dma_rd_inc)
                HADDR_R <= HADDR_R + 32'h4;
            else
                HADDR_R <= HADDR_R;
        else
            HADDR_R <= 32'h0;
    end

    assign HBURST_R = (~st_dma_r_idle) ? 3'h1 : 3'h0;
    assign HSIZE_R  = (~st_dma_r_idle) ? 3'h2 : 3'h0;
    
    always @(posedge FCLK) begin
        if(ctrl_dma_start)
            HTRANS_R <= 2'h2;
        else if(~st_dma_r_idle & (reg_dma_r_cnt > 1))
            if(HREADY_R)
                HTRANS_R <= 2'h3;
            else
                HTRANS_R <= HTRANS_R;
        else
            HTRANS_R <= 2'h0;
    end

    assign HREADYOUT_R = 1'b1;

    //---------------------------------------
    // AHB WRITE

    reg             dma_start_delay1;
    reg             dma_start_delay2;
    reg             dma_start_delay3;
    wire            dma_write_start = dma_start_delay3;
    reg     [31:0]  reg_dma_w_cnt;
    reg             st_dma_w_idle = 1'b1;

    always @(posedge FCLK) begin
        dma_start_delay1 <= ctrl_dma_start;
        dma_start_delay2 <= dma_start_delay1;
        dma_start_delay3 <= dma_start_delay2;
    end

    always @(posedge FCLK) begin
        if(dma_write_start | ~RESETn)
            reg_dma_w_cnt <= reg_trans_len;
        else if(~HREADY_W | (reg_dma_w_cnt == 32'h0) | fifo_empty)
            reg_dma_w_cnt <= reg_dma_w_cnt;
        else
            reg_dma_w_cnt <= reg_dma_w_cnt - 32'h1;
    end

    always @(posedge FCLK) begin
        if(dma_write_start | ~RESETn)
            st_dma_w_idle <= 1'b0;
        else if(HREADY_W & (reg_dma_w_cnt == 32'h1))
            st_dma_w_idle <= 1'b1;
        else
            st_dma_w_idle <= st_dma_w_idle;
    end

    assign fifo_rd_en = ~st_dma_w_idle & HREADY_W;
    // assign fifo_rd_en = (~st_dma_w_idle & HREADY_W) | dma_start_delay3;

    assign fifo_srst = dma_start_delay1 | ~RESETn;

    always @(posedge FCLK) begin
        if(dma_write_start)
            HADDR_W <= reg_wr_addr;
        else if(~st_dma_w_idle)
            if(HREADY_W & ctrl_dma_wr_inc & ~fifo_empty)
                HADDR_W <= HADDR_W + 32'h4;
            else
                HADDR_W <= HADDR_W;
        else
            HADDR_W <= 32'h0;
    end

    assign HBURST_W = (~st_dma_w_idle) ? 3'h1 : 3'h0;
    assign HSIZE_W  = (~st_dma_w_idle) ? 3'h2 : 3'h0;

    always @(posedge FCLK) begin
        if(dma_write_start)
            HTRANS_W <= 2'h2;
        else if(~st_dma_w_idle & (reg_dma_w_cnt > 1))
            if(HREADY_W)
                HTRANS_W <= 2'h3;
            else
                HTRANS_W <= HTRANS_W;
        else
            HTRANS_W <= 2'h0;
    end

    assign HREADYOUT_W = 1'b1;

    always @(posedge FCLK) begin
        if(ctrl_dma_int_clr | ~RESETn)
            DMA_CXY_INT <= 1'b0;
        else if(~st_dma_w_idle & HREADY_W & (reg_dma_w_cnt == 32'h1))
            DMA_CXY_INT <= 1'b1;
        else
            DMA_CXY_INT <= DMA_CXY_INT;
    end

    assign HWRITE_W = ~fifo_empty;

endmodule
