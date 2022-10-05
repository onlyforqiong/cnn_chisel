`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/19 18:20:30
// Design Name: 
// Module Name: vector_multiplier_cxy
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


module vector_multiplier_cxy #(
        parameter   DIM = 16,
        parameter   AW  = 4,
        parameter   DW  = 24
    )
    (
        input                   CLK,
        input                   RSTn,
        input                   DIN_VALID,
        input       [DW-1:0]    DIN,

        input                   W_WEN,
        input                   W_REN,
        input       [AW+2:0]    W_ADDR,
        input       [DW-1:0]    W_WDATA,
        output reg  [DW-1:0]    W_RDATA,

        input       [2:0]       PHASE_SEL,

        // input       [DW-1:0]    BIAS,

        output reg  [DW-1:0]    OUT,
        output reg              OUT_VALID
    );
    localparam OUT_L = DW-6;
    localparam OUT_H = DW*2-7;

    //----------------------------------
    // Weight & Bias

    reg     [DW-1:0]    weight[0:DIM*8-1];

    reg                 reg_w_wen;
    reg     [AW+2:0]    reg_w_addr;

    always @(posedge CLK)
    begin
        reg_w_wen <= W_WEN;
        reg_w_addr <= W_ADDR;
    end

    always @(posedge CLK)
    begin
        if(reg_w_wen)
            weight[reg_w_addr] <= W_WDATA;
        else
            weight[reg_w_addr] <= weight[reg_w_addr];
    end

    always @(posedge CLK)
    begin
        if(W_REN)
            W_RDATA <= weight[W_ADDR];
    end

    //----------------------------------
    // Multiply

    reg     [AW-1:0]    calculation_addr;
    wire    [2*DW-1:0]  mult_result;
    reg                 mult_valid;
    reg                 last_mult_valid;

    always @(posedge CLK)
    begin
        if(~RSTn)
            calculation_addr <= 0;
        else if(DIN_VALID)
            calculation_addr <= calculation_addr + 1;
        else
            calculation_addr <= calculation_addr;
    end

    always @(posedge CLK)
    begin
        mult_valid <= DIN_VALID;
        last_mult_valid <= ((calculation_addr == DIM-1) & DIN_VALID) ? 1 : 0;
    end

    mult_for_cnn_cxy u_mult (
      .CLK  (CLK),
      .A    (DIN),
      .B    (weight[{PHASE_SEL, calculation_addr}]),
      .P    (mult_result)
    );

    //----------------------------------
    // Add up

    reg     [2*DW-1:0]  sum;
    reg                 sum_valid;
    reg                 last_sum_valid;

    always @(posedge CLK)
    begin
        if(~RSTn)
            // sum <= BIAS;
            sum <= 0;
        else if(mult_valid)
            sum <= sum + mult_result;
        else
            sum <= sum;
    end

    always @(posedge CLK)
    begin
        sum_valid <= mult_valid;
        last_sum_valid <= last_mult_valid;
    end

    always @(posedge CLK)
    begin
        if(~RSTn)
            OUT <= 0;
        else if(last_sum_valid)
            OUT <= sum[OUT_H:OUT_L];
        else
            OUT <= OUT;
    end

    always @(posedge CLK)
    begin
        OUT_VALID <= last_sum_valid;
    end

endmodule
