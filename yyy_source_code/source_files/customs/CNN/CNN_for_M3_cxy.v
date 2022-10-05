`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/21 11:54:51
// Design Name: 
// Module Name: CNN_for_M3_cxy
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


module CNN_for_M3_cxy (
    // AHB inputs Slave
    input               HCLK,
    input               HRESETn,
    input               HREADY,
    input               HSEL,
    input       [1:0]   HTRANS,
    input               HWRITE,
    input       [31:0]  HADDR,
    input       [31:0]  HWDATA,

    // AHB outputs Slave
    output              HREADYOUT,
    output reg  [31:0]  HRDATA,

    // from IPU
    input               DIN,
    input               DIN_VALID,
    input               SQUEEZE,
    output              CONV_1_LAST_PIX
    );

    localparam DW = 16;

    //--------------------------------------------------------
    // Registers

    parameter SEL_CTRL  = 15'b000000000000001;
    parameter SEL_OUT1  = 15'b000000000000010;
    parameter SEL_OUT2  = 15'b000000000000100;
    parameter SEL_OUT3  = 15'b000000000001000;
    parameter SEL_OUT4  = 15'b000000000010000;
    parameter SEL_OUT5  = 15'b000000000100000;
    parameter SEL_OUT6  = 15'b000000001000000;
    parameter SEL_L1_W  = 15'b000000010000000;
    parameter SEL_L1_B  = 15'b000000100000000;
    parameter SEL_L2_W1 = 15'b000001000000000;
    parameter SEL_L2_B1 = 15'b000010000000000;
    parameter SEL_L2_W2 = 15'b000100000000000;
    parameter SEL_L2_B2 = 15'b001000000000000;
    parameter SEL_V_W   = 15'b010000000000000;
    parameter SEL_V_B   = 15'b100000000000000;

    reg         [31:0]  reg_cnn_ctrl;
    reg         [31:0]  reg_cnn_output1;
    reg         [31:0]  reg_cnn_output2;
    reg         [31:0]  reg_cnn_output3;
    reg         [31:0]  reg_cnn_output4;
    reg         [31:0]  reg_cnn_output5;
    reg         [31:0]  reg_cnn_output6;

    //--------------------------------------------------------
    // Signals

    reg         [14:0]  addr_sel;
    reg         [14:0]  reg_addr_sel;

    wire                ctrl_sel;
    wire                cnn_output1_sel;
    wire                cnn_output2_sel;
    wire                cnn_output3_sel;
    wire                cnn_output4_sel;
    wire                cnn_output5_sel;
    wire                cnn_output6_sel;
    wire                layer1_w_sel;
    wire                layer1_b_sel;
    wire                layer2_w1_sel;
    wire                layer2_b1_sel;
    wire                layer2_w2_sel;
    wire                layer2_b2_sel;
    wire                vector_w_sel;
    wire                vector_b_sel;

    reg                 reg_ctrl_wen;

    wire      [DW-1:0]  layer1_w_rdata;
    wire      [DW-1:0]  layer1_b_rdata;
    wire      [DW-1:0]  layer2_w1_rdata;
    wire      [DW-1:0]  layer2_b1_rdata;
    wire      [DW-1:0]  layer2_w2_rdata;
    wire      [DW-1:0]  layer2_b2_rdata;
    wire      [DW-1:0]  vector_w_rdata;
    wire      [DW-1:0]  vector_b_rdata;

    wire      [DW-1:0]  cnn_output1;
    wire      [DW-1:0]  cnn_output2;
    wire      [DW-1:0]  cnn_output3;
    wire      [DW-1:0]  cnn_output4;
    wire      [DW-1:0]  cnn_output5;
    wire      [DW-1:0]  cnn_output6;
    wire                cnn_output_valid;

    wire                cnn_rst_n;
    reg                 cnn_finished;
    wire                cnn_en;

    //--------------------------------------------------------
    // AHB Read & Write Logic

    assign ctrl_sel        = addr_sel[0];
    assign cnn_output1_sel = addr_sel[1];
    assign cnn_output2_sel = addr_sel[2];
    assign cnn_output3_sel = addr_sel[3];
    assign cnn_output4_sel = addr_sel[4];
    assign cnn_output5_sel = addr_sel[5];
    assign cnn_output6_sel = addr_sel[6];

    assign layer1_w_sel    = addr_sel[7];
    assign layer1_b_sel    = addr_sel[8];
    assign layer2_w1_sel   = addr_sel[9];
    assign layer2_b1_sel   = addr_sel[10];
    assign layer2_w2_sel   = addr_sel[11];
    assign layer2_b2_sel   = addr_sel[12];
    assign vector_w_sel    = addr_sel[13];
    assign vector_b_sel    = addr_sel[14];

    always @(*)
    begin
        if(~HRESETn)
        begin
            addr_sel = 0;
        end
        else if(HSEL & HTRANS[1])
        begin
            case(HADDR[15:12])
                4'h1:
                begin
                    case(HADDR[11:0])
                        12'h000: addr_sel = SEL_CTRL;
                        12'h004: addr_sel = SEL_OUT1;
                        12'h008: addr_sel = SEL_OUT2;
                        12'h00c: addr_sel = SEL_OUT3;
                        12'h010: addr_sel = SEL_OUT4;
                        12'h014: addr_sel = SEL_OUT5;
                        12'h018: addr_sel = SEL_OUT6;
                        default: addr_sel = 0;
                    endcase
                end
                4'h2: addr_sel = (HADDR[11:2] <  36) ? SEL_L1_W  : 0;
                4'h3: addr_sel = (HADDR[11:2] <   4) ? SEL_L1_B  : 0;
                4'h4: addr_sel = (HADDR[11:2] < 144) ? SEL_L2_W1 : 0;
                // 4'h4: addr_sel = (HADDR[11:2] < 288) ? SEL_L2_W1 : 0;
                // 4'h5: addr_sel = (HADDR[11:2] <   4) ? SEL_L2_B1 : 0;
                4'h5: addr_sel = (HADDR[11:2] <   8) ? SEL_L2_B1 : 0;
                4'h6: addr_sel = (HADDR[11:2] < 144) ? SEL_L2_W2 : 0;
                4'h7: addr_sel = /*(HADDR[11:2] <   4) ? SEL_L2_B2 :*/ 0;
                4'h8: addr_sel = (HADDR[11:2] < 768) ? SEL_V_W   : 0;
                4'h9: addr_sel = (HADDR[11:2] <   6) ? SEL_V_B   : 0;
                default: addr_sel = 0;
            endcase
        end
        else
        begin
            addr_sel = 0;
        end
    end

    always @(posedge HCLK)
    begin
        reg_addr_sel <= addr_sel;
    end

    always @(*)
    begin
        case(reg_addr_sel)
            SEL_CTRL : HRDATA = reg_cnn_ctrl    ;
            SEL_OUT1 : HRDATA = reg_cnn_output1 ;
            SEL_OUT2 : HRDATA = reg_cnn_output2 ;
            SEL_OUT3 : HRDATA = reg_cnn_output3 ;
            SEL_OUT4 : HRDATA = reg_cnn_output4 ;
            SEL_OUT5 : HRDATA = reg_cnn_output5 ;
            SEL_OUT6 : HRDATA = reg_cnn_output6 ;
            SEL_L1_W : HRDATA = layer1_w_rdata  ;
            SEL_L1_B : HRDATA = layer1_b_rdata  ;
            SEL_L2_W1: HRDATA = layer2_w1_rdata ;
            SEL_L2_B1: HRDATA = layer2_b1_rdata ;
            SEL_L2_W2: HRDATA = layer2_w2_rdata ;
            SEL_L2_B2: HRDATA = layer2_b2_rdata ;
            SEL_V_W  : HRDATA = vector_w_rdata  ;
            SEL_V_B  : HRDATA = vector_b_rdata  ;
            default  : HRDATA = 32'h0;
        endcase
    end

    assign HREADYOUT = 1'b1;

    //--------------------------------------------------------
    // Registers Logic

    always @(posedge HCLK)
    begin
        reg_ctrl_wen <= ctrl_sel & HWRITE;
    end

    // reg_cnn_ctrl
    always @(posedge HCLK)
    begin
        if(~HRESETn)
            reg_cnn_ctrl <= 0;
        else if(reg_ctrl_wen)
            reg_cnn_ctrl <= HWDATA;
        else
            reg_cnn_ctrl <= {reg_cnn_ctrl[31:2], cnn_finished, 1'b0};
    end

    // reg_cnn_output
    always @(posedge HCLK)
    begin
        if(~HRESETn | ~cnn_rst_n | ~cnn_en)
        begin
            reg_cnn_output1 <= 32'hc1;
            reg_cnn_output2 <= 32'hc2;
            reg_cnn_output3 <= 32'hc3;
            reg_cnn_output4 <= 32'hc4;
            reg_cnn_output5 <= 32'hc5;
            reg_cnn_output6 <= 32'hc6;
        end
        else if(cnn_output_valid)
        begin
            reg_cnn_output1 <= {{(32-DW){cnn_output1[DW-1]}}, cnn_output1};
            reg_cnn_output2 <= {{(32-DW){cnn_output2[DW-1]}}, cnn_output2};
            reg_cnn_output3 <= {{(32-DW){cnn_output3[DW-1]}}, cnn_output3};
            reg_cnn_output4 <= {{(32-DW){cnn_output4[DW-1]}}, cnn_output4};
            reg_cnn_output5 <= {{(32-DW){cnn_output5[DW-1]}}, cnn_output5};
            reg_cnn_output6 <= {{(32-DW){cnn_output6[DW-1]}}, cnn_output6};
        end
        else
        begin
            reg_cnn_output1 <= reg_cnn_output1;
            reg_cnn_output2 <= reg_cnn_output2;
            reg_cnn_output3 <= reg_cnn_output3;
            reg_cnn_output4 <= reg_cnn_output4;
            reg_cnn_output5 <= reg_cnn_output5;
            reg_cnn_output6 <= reg_cnn_output6;
        end
    end

    //--------------------------------------------------------
    // Functional Signals Logic

    assign cnn_rst_n = ~reg_cnn_ctrl[0];
    assign cnn_en = reg_cnn_ctrl[2];

    always @(posedge HCLK)
    begin
        if(~cnn_rst_n | ~cnn_en)
            cnn_finished <= 1'b0;
        else if(cnn_output_valid)
            cnn_finished <= 1'b1;
        else
            cnn_finished <= cnn_finished;
    end

    //--------------------------------------------------------
    // CNN

    CNN_tdm_top #(
        .DW                 (DW)
    )
    u_CNN (
        .CLK                (HCLK),
        .RSTn               (cnn_rst_n & cnn_en),
        .DIN_VALID          (DIN_VALID),
        .DIN                (DIN),
        .SQUEEZE            (SQUEEZE),
        .CONV_LAST_PIX      (CONV_1_LAST_PIX),

        .L1_CONV_W_WEN      (layer1_w_sel & HWRITE),
        .L1_CONV_W_REN      (1'b1),
        .L1_CONV_W_ADDR     (HADDR[7:2]),
        .L1_CONV_W_WDATA    (HWDATA[DW-1:0]),
        .L1_CONV_W_RDATA    (layer1_w_rdata),

        .L1_CONV_B_WEN      (layer1_b_sel & HWRITE),
        .L1_CONV_B_REN      (1'b1),
        .L1_CONV_B_ADDR     (HADDR[3:2]),
        .L1_CONV_B_WDATA    (HWDATA[DW-1:0]),
        .L1_CONV_B_RDATA    (layer1_b_rdata),

        .L2_CONV_W1_WEN     (layer2_w1_sel & HWRITE),
        .L2_CONV_W1_REN     (1'b1),
        .L2_CONV_W1_ADDR    (HADDR[9:2]),
        .L2_CONV_W1_WDATA   (HWDATA[DW-1:0]),
        .L2_CONV_W1_RDATA   (layer2_w1_rdata),

        .L2_CONV_B1_WEN     (layer2_b1_sel & HWRITE),
        .L2_CONV_B1_REN     (1'b1),
        .L2_CONV_B1_ADDR    (HADDR[4:2]),
        .L2_CONV_B1_WDATA   (HWDATA[DW-1:0]),
        .L2_CONV_B1_RDATA   (layer2_b1_rdata),

        .L2_CONV_W2_WEN     (layer2_w2_sel & HWRITE),
        .L2_CONV_W2_REN     (1'b1),
        .L2_CONV_W2_ADDR    (HADDR[9:2]),
        .L2_CONV_W2_WDATA   (HWDATA[DW-1:0]),
        .L2_CONV_W2_RDATA   (layer2_w2_rdata),

        .L2_CONV_B2_WEN     (layer2_b2_sel & HWRITE),
        .L2_CONV_B2_REN     (1'b1),
        .L2_CONV_B2_ADDR    (HADDR[3:2]),
        .L2_CONV_B2_WDATA   (HWDATA[DW-1:0]),
        .L2_CONV_B2_RDATA   (layer2_b2_rdata),

        .VECTOR_W_WEN       (vector_w_sel & HWRITE),
        .VECTOR_W_REN       (1'b1),
        .VECTOR_W_ADDR      (HADDR[11:2]),
        .VECTOR_W_WDATA     (HWDATA[DW-1:0]),
        .VECTOR_W_RDATA     (vector_w_rdata),

        .VECTOR_B_WEN       (vector_b_sel & HWRITE),
        .VECTOR_B_REN       (1'b1),
        .VECTOR_B_ADDR      (HADDR[4:2]),
        .VECTOR_B_WDATA     (HWDATA[DW-1:0]),
        .VECTOR_B_RDATA     (vector_b_rdata),

        .VALID              (cnn_output_valid),
        .OUTPUT1            (cnn_output1),
        .OUTPUT2            (cnn_output2),
        .OUTPUT3            (cnn_output3),
        .OUTPUT4            (cnn_output4),
        .OUTPUT5            (cnn_output5),
        .OUTPUT6            (cnn_output6)
    );


endmodule
