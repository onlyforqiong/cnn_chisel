`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/04/20 09:20:06
// Design Name: 
// Module Name: FIFO_cxy
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


module FIFO_cxy #(
        parameter DW = 12,
        parameter AW = 9
    )
    (
    input               fifo_rst,
    input               wr_clk,
    input               rd_clk,

    input      [DW-1:0] din,
    output reg [DW-1:0] dout,

    input               wr_en,
    input               rd_en,

    output              full,
    output              empty,

    output              wr_rst_busy,
    output              rd_rst_busy
    );

    reg     [DW-1:0]    memory[0:2**AW-1];
    reg     [AW-1:0]    wr_addr;
    wire    [AW-1:0]    wr_addr_plus;
    // wire    [AW-1:0]    wr_addr_plus2;
    reg     [AW-1:0]    rd_addr;
    // wire    [AW-1:0]    rd_addr_plus;

    // wire                mem_full_pre;
    wire                mem_full;
    // wire                mem_empty_pre;
    wire                mem_empty;

    assign wr_rst_busy = 1'b0;
    assign rd_rst_busy = 1'b0;

    always @(posedge wr_clk or posedge fifo_rst) begin
        if(fifo_rst)
            wr_addr <= 0;
        else if(wr_en & ~mem_full)
            wr_addr <= wr_addr + 1;
        else
            wr_addr <= wr_addr;
    end

    always @(posedge rd_clk or posedge fifo_rst) begin
        if(fifo_rst)
            rd_addr <= 0;
        else if(rd_en & ~mem_empty)
            rd_addr <= rd_addr + 1;
        else
            rd_addr <= rd_addr;
    end

    assign wr_addr_plus  = wr_addr + 1;    
    // assign wr_addr_plus2 = wr_addr + 2;
    // assign rd_addr_plus  = rd_addr + 1;

    // assign mem_full_pre  = ((wr_addr_plus2 == rd_addr) & wr_en) ? 1 : 0;
    assign mem_full      = (wr_addr_plus == rd_addr) ? 1 : 0;
    // assign mem_empty_pre = ((rd_addr_plus == wr_addr) & rd_en) ? 1 : 0;
    assign mem_empty     = (rd_addr == wr_addr) ? 1 : 0;

    assign full  = mem_full;
    assign empty = mem_empty;

    always @(posedge wr_clk) begin
        if(wr_en & ~mem_full)
            memory[wr_addr] <= din;
        else
            memory[wr_addr] <= memory[wr_addr];
    end

    always @(posedge rd_clk) begin
        if(rd_en & ~mem_empty)
            dout <= memory[rd_addr];
        // else
        //     dout <= {DW{1'hz}};
    end

endmodule
