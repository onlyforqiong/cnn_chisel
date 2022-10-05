`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/22 22:47:59
// Design Name: 
// Module Name: CNN_layer2_conv_pooling
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


module CNN_layer2_conv_pooling #(
        parameter   DW = 24
    )
    (
        input                   CLK,
        input                   RSTn,
        input                   DIN_VALID,
        input       [DW-1:0]    DIN0,
        input       [DW-1:0]    DIN1,
        input       [DW-1:0]    DIN2,
        input       [DW-1:0]    DIN3,
        input                   SQUEEZE,
        output                  CONV_LAST_PIX,

        input                   CONV_W1_WEN,
        input                   CONV_W1_REN,
        input       [7:0]       CONV_W1_ADDR,
        input       [DW-1:0]    CONV_W1_WDATA,
        output reg  [DW-1:0]    CONV_W1_RDATA,

        input                   CONV_W2_WEN,
        input                   CONV_W2_REN,
        input       [7:0]       CONV_W2_ADDR,
        input       [DW-1:0]    CONV_W2_WDATA,
        output reg  [DW-1:0]    CONV_W2_RDATA,

        input                   CONV_B_WEN,
        input                   CONV_B_REN,
        input       [2:0]       CONV_B_ADDR,
        input       [DW-1:0]    CONV_B_WDATA,
        output reg  [DW-1:0]    CONV_B_RDATA,

        input       [2:0]       PHASE_SEL,

        output      [DW-1:0]    OUT,
        output                  VALID,
        output                  LAST_IN_LINE,
        output                  LAST_PIX
    );

    reg     [DW-1:0]    MEM_CONV_W1[0:9*4*4-1];
    reg     [DW-1:0]    MEM_CONV_W2[0:9*4*4-1];
    reg     [DW-1:0]    MEM_CONV_B[0:8-1];

    // integer i;
    // initial begin
    //     i = 0;
    //     repeat(9*4*4) begin
    //         MEM_CONV_W1[i] = 16'ha100 + i;
    //         MEM_CONV_W2[i] = 16'hb200 + i;
    //         i = i + 1;
    //     end
    //     i = 0;
    //     repeat(8) begin
    //         MEM_CONV_B[i] = i + 1;
    //         i = i + 1;
    //     end
    // end

    reg                 reg_conv_w1_wen;
    reg     [7:0]       reg_conv_w1_addr;
    reg                 reg_conv_w2_wen;
    reg     [7:0]       reg_conv_w2_addr;
    reg                 reg_conv_b_wen;
    reg     [2:0]       reg_conv_b_addr;

    reg     [7:0]       conv_w_base;

    wire    [DW-1:0]    channel_0_out;
    wire                channel_0_valid;
    wire                channel_0_last_in_line;
    wire                channel_0_last_pix;

    wire    [DW-1:0]    channel_1_out;
    wire                channel_1_valid;
    wire                channel_1_last_in_line;
    wire                channel_1_last_pix;

    wire    [DW-1:0]    channel_2_out;
    wire                channel_2_valid;
    wire                channel_2_last_in_line;
    wire                channel_2_last_pix;

    wire    [DW-1:0]    channel_3_out;
    wire                channel_3_valid;
    wire                channel_3_last_in_line;
    wire                channel_3_last_pix;

    reg     [DW-1:0]    sum_1, sum_2, sum;
    wire    [DW-1:0]    sum_relu;
    reg                 reg_conv_valid, reg_conv_last_pix;
    reg                 sum_valid, sum_last_pix;

    reg                 sum_squeeze_out;
    wire                pooling_1_squeeze_out;

    wire    [DW-1:0]    pooling_1_out;
    wire                pooling_1_valid;
    wire                pooling_1_last_in_line;
    wire                pooling_1_last_pix;

    //----------------------------------
    // 系数加载

    always @(posedge CLK)
    begin
        reg_conv_w1_wen  <= CONV_W1_WEN;
        reg_conv_w1_addr <= CONV_W1_ADDR;
        reg_conv_w2_wen  <= CONV_W2_WEN;
        reg_conv_w2_addr <= CONV_W2_ADDR;
        reg_conv_b_wen  <= CONV_B_WEN;
        reg_conv_b_addr <= CONV_B_ADDR;
    end

    always @(posedge CLK)
    begin
        if(reg_conv_w1_wen)
            MEM_CONV_W1[reg_conv_w1_addr] <= CONV_W1_WDATA;
    end

    always @(posedge CLK)
    begin
        if(reg_conv_w2_wen)
            MEM_CONV_W2[reg_conv_w2_addr] <= CONV_W2_WDATA;
    end

    always @(posedge CLK)
    begin
        if(reg_conv_b_wen)
            MEM_CONV_B[reg_conv_b_addr] <= CONV_B_WDATA;
    end

    always @(posedge CLK)
    begin
        if(CONV_W1_REN)
            CONV_W1_RDATA <= MEM_CONV_W1[CONV_W1_ADDR];
    end

    always @(posedge CLK)
    begin
        if(CONV_W2_REN)
            CONV_W2_RDATA <= MEM_CONV_W2[CONV_W2_ADDR];
    end

    always @(posedge CLK)
    begin
        if(CONV_B_REN)
            CONV_B_RDATA <= MEM_CONV_B[CONV_B_ADDR];
    end

    always @(*)
    begin
        case(PHASE_SEL[1:0])
            2'd0:
            begin
                conv_w_base = 0;
            end
            2'd1:
            begin
                conv_w_base = 9*4*1;
            end
            2'd2:
            begin
                conv_w_base = 9*4*2;
            end
            2'd3:
            begin
                conv_w_base = 9*4*3;
            end
        endcase
    end

    wire    [DW-1:0]    ch_0_w_11 = (PHASE_SEL[2] == 0) ? MEM_CONV_W1[conv_w_base+9*0+0] : MEM_CONV_W2[conv_w_base+9*0+0];
    wire    [DW-1:0]    ch_0_w_12 = (PHASE_SEL[2] == 0) ? MEM_CONV_W1[conv_w_base+9*0+1] : MEM_CONV_W2[conv_w_base+9*0+1];
    wire    [DW-1:0]    ch_0_w_13 = (PHASE_SEL[2] == 0) ? MEM_CONV_W1[conv_w_base+9*0+2] : MEM_CONV_W2[conv_w_base+9*0+2];
    wire    [DW-1:0]    ch_0_w_21 = (PHASE_SEL[2] == 0) ? MEM_CONV_W1[conv_w_base+9*0+3] : MEM_CONV_W2[conv_w_base+9*0+3];
    wire    [DW-1:0]    ch_0_w_22 = (PHASE_SEL[2] == 0) ? MEM_CONV_W1[conv_w_base+9*0+4] : MEM_CONV_W2[conv_w_base+9*0+4];
    wire    [DW-1:0]    ch_0_w_23 = (PHASE_SEL[2] == 0) ? MEM_CONV_W1[conv_w_base+9*0+5] : MEM_CONV_W2[conv_w_base+9*0+5];
    wire    [DW-1:0]    ch_0_w_31 = (PHASE_SEL[2] == 0) ? MEM_CONV_W1[conv_w_base+9*0+6] : MEM_CONV_W2[conv_w_base+9*0+6];
    wire    [DW-1:0]    ch_0_w_32 = (PHASE_SEL[2] == 0) ? MEM_CONV_W1[conv_w_base+9*0+7] : MEM_CONV_W2[conv_w_base+9*0+7];
    wire    [DW-1:0]    ch_0_w_33 = (PHASE_SEL[2] == 0) ? MEM_CONV_W1[conv_w_base+9*0+8] : MEM_CONV_W2[conv_w_base+9*0+8];

    wire    [DW-1:0]    ch_1_w_11 = (PHASE_SEL[2] == 0) ? MEM_CONV_W1[conv_w_base+9*1+0] : MEM_CONV_W2[conv_w_base+9*1+0];
    wire    [DW-1:0]    ch_1_w_12 = (PHASE_SEL[2] == 0) ? MEM_CONV_W1[conv_w_base+9*1+1] : MEM_CONV_W2[conv_w_base+9*1+1];
    wire    [DW-1:0]    ch_1_w_13 = (PHASE_SEL[2] == 0) ? MEM_CONV_W1[conv_w_base+9*1+2] : MEM_CONV_W2[conv_w_base+9*1+2];
    wire    [DW-1:0]    ch_1_w_21 = (PHASE_SEL[2] == 0) ? MEM_CONV_W1[conv_w_base+9*1+3] : MEM_CONV_W2[conv_w_base+9*1+3];
    wire    [DW-1:0]    ch_1_w_22 = (PHASE_SEL[2] == 0) ? MEM_CONV_W1[conv_w_base+9*1+4] : MEM_CONV_W2[conv_w_base+9*1+4];
    wire    [DW-1:0]    ch_1_w_23 = (PHASE_SEL[2] == 0) ? MEM_CONV_W1[conv_w_base+9*1+5] : MEM_CONV_W2[conv_w_base+9*1+5];
    wire    [DW-1:0]    ch_1_w_31 = (PHASE_SEL[2] == 0) ? MEM_CONV_W1[conv_w_base+9*1+6] : MEM_CONV_W2[conv_w_base+9*1+6];
    wire    [DW-1:0]    ch_1_w_32 = (PHASE_SEL[2] == 0) ? MEM_CONV_W1[conv_w_base+9*1+7] : MEM_CONV_W2[conv_w_base+9*1+7];
    wire    [DW-1:0]    ch_1_w_33 = (PHASE_SEL[2] == 0) ? MEM_CONV_W1[conv_w_base+9*1+8] : MEM_CONV_W2[conv_w_base+9*1+8];

    wire    [DW-1:0]    ch_2_w_11 = (PHASE_SEL[2] == 0) ? MEM_CONV_W1[conv_w_base+9*2+0] : MEM_CONV_W2[conv_w_base+9*2+0];
    wire    [DW-1:0]    ch_2_w_12 = (PHASE_SEL[2] == 0) ? MEM_CONV_W1[conv_w_base+9*2+1] : MEM_CONV_W2[conv_w_base+9*2+1];
    wire    [DW-1:0]    ch_2_w_13 = (PHASE_SEL[2] == 0) ? MEM_CONV_W1[conv_w_base+9*2+2] : MEM_CONV_W2[conv_w_base+9*2+2];
    wire    [DW-1:0]    ch_2_w_21 = (PHASE_SEL[2] == 0) ? MEM_CONV_W1[conv_w_base+9*2+3] : MEM_CONV_W2[conv_w_base+9*2+3];
    wire    [DW-1:0]    ch_2_w_22 = (PHASE_SEL[2] == 0) ? MEM_CONV_W1[conv_w_base+9*2+4] : MEM_CONV_W2[conv_w_base+9*2+4];
    wire    [DW-1:0]    ch_2_w_23 = (PHASE_SEL[2] == 0) ? MEM_CONV_W1[conv_w_base+9*2+5] : MEM_CONV_W2[conv_w_base+9*2+5];
    wire    [DW-1:0]    ch_2_w_31 = (PHASE_SEL[2] == 0) ? MEM_CONV_W1[conv_w_base+9*2+6] : MEM_CONV_W2[conv_w_base+9*2+6];
    wire    [DW-1:0]    ch_2_w_32 = (PHASE_SEL[2] == 0) ? MEM_CONV_W1[conv_w_base+9*2+7] : MEM_CONV_W2[conv_w_base+9*2+7];
    wire    [DW-1:0]    ch_2_w_33 = (PHASE_SEL[2] == 0) ? MEM_CONV_W1[conv_w_base+9*2+8] : MEM_CONV_W2[conv_w_base+9*2+8];

    wire    [DW-1:0]    ch_3_w_11 = (PHASE_SEL[2] == 0) ? MEM_CONV_W1[conv_w_base+9*3+0] : MEM_CONV_W2[conv_w_base+9*3+0];
    wire    [DW-1:0]    ch_3_w_12 = (PHASE_SEL[2] == 0) ? MEM_CONV_W1[conv_w_base+9*3+1] : MEM_CONV_W2[conv_w_base+9*3+1];
    wire    [DW-1:0]    ch_3_w_13 = (PHASE_SEL[2] == 0) ? MEM_CONV_W1[conv_w_base+9*3+2] : MEM_CONV_W2[conv_w_base+9*3+2];
    wire    [DW-1:0]    ch_3_w_21 = (PHASE_SEL[2] == 0) ? MEM_CONV_W1[conv_w_base+9*3+3] : MEM_CONV_W2[conv_w_base+9*3+3];
    wire    [DW-1:0]    ch_3_w_22 = (PHASE_SEL[2] == 0) ? MEM_CONV_W1[conv_w_base+9*3+4] : MEM_CONV_W2[conv_w_base+9*3+4];
    wire    [DW-1:0]    ch_3_w_23 = (PHASE_SEL[2] == 0) ? MEM_CONV_W1[conv_w_base+9*3+5] : MEM_CONV_W2[conv_w_base+9*3+5];
    wire    [DW-1:0]    ch_3_w_31 = (PHASE_SEL[2] == 0) ? MEM_CONV_W1[conv_w_base+9*3+6] : MEM_CONV_W2[conv_w_base+9*3+6];
    wire    [DW-1:0]    ch_3_w_32 = (PHASE_SEL[2] == 0) ? MEM_CONV_W1[conv_w_base+9*3+7] : MEM_CONV_W2[conv_w_base+9*3+7];
    wire    [DW-1:0]    ch_3_w_33 = (PHASE_SEL[2] == 0) ? MEM_CONV_W1[conv_w_base+9*3+8] : MEM_CONV_W2[conv_w_base+9*3+8];

    //----------------------------------
    // 卷积运算

    assign CONV_LAST_PIX = channel_0_last_pix;

    conv_core_parallel_cxy #(
        .DW         (DW)
    )
    u_conv_channel_0
    (
        .CLK            (CLK),
        .RSTn           (RSTn),
        .DIN_VALID      (DIN_VALID),
        .DIN            (DIN0),

        .SQUEEZE        (SQUEEZE),

        .W_11           (ch_0_w_11),
        .W_12           (ch_0_w_12),
        .W_13           (ch_0_w_13),
        .W_21           (ch_0_w_21),
        .W_22           (ch_0_w_22),
        .W_23           (ch_0_w_23),
        .W_31           (ch_0_w_31),
        .W_32           (ch_0_w_32),
        .W_33           (ch_0_w_33),
        .B              (MEM_CONV_B[PHASE_SEL]),

        .OUT            (channel_0_out),
        .VALID          (channel_0_valid),
        .LAST_IN_LINE   (channel_0_last_in_line),
        .LAST_PIX       (channel_0_last_pix)
    );

    conv_core_parallel_cxy #(
        .DW         (DW)
    )
    u_conv_channel_1
    (
        .CLK            (CLK),
        .RSTn           (RSTn),
        .DIN_VALID      (DIN_VALID),
        .DIN            (DIN1),

        .SQUEEZE        (SQUEEZE),

        .W_11           (ch_1_w_11),
        .W_12           (ch_1_w_12),
        .W_13           (ch_1_w_13),
        .W_21           (ch_1_w_21),
        .W_22           (ch_1_w_22),
        .W_23           (ch_1_w_23),
        .W_31           (ch_1_w_31),
        .W_32           (ch_1_w_32),
        .W_33           (ch_1_w_33),
        .B              ({DW{1'b0}}),

        .OUT            (channel_1_out),
        .VALID          (channel_1_valid),
        .LAST_IN_LINE   (channel_1_last_in_line),
        .LAST_PIX       (channel_1_last_pix)
    );

    conv_core_parallel_cxy #(
        .DW         (DW)
    )
    u_conv_channel_2
    (
        .CLK            (CLK),
        .RSTn           (RSTn),
        .DIN_VALID      (DIN_VALID),
        .DIN            (DIN2),

        .SQUEEZE        (SQUEEZE),

        .W_11           (ch_2_w_11),
        .W_12           (ch_2_w_12),
        .W_13           (ch_2_w_13),
        .W_21           (ch_2_w_21),
        .W_22           (ch_2_w_22),
        .W_23           (ch_2_w_23),
        .W_31           (ch_2_w_31),
        .W_32           (ch_2_w_32),
        .W_33           (ch_2_w_33),
        .B              ({DW{1'b0}}),

        .OUT            (channel_2_out),
        .VALID          (channel_2_valid),
        .LAST_IN_LINE   (channel_2_last_in_line),
        .LAST_PIX       (channel_2_last_pix)
    );

    conv_core_parallel_cxy #(
        .DW         (DW)
    )
    u_conv_channel_3
    (
        .CLK            (CLK),
        .RSTn           (RSTn),
        .DIN_VALID      (DIN_VALID),
        .DIN            (DIN3),

        .SQUEEZE        (SQUEEZE),

        .W_11           (ch_3_w_11),
        .W_12           (ch_3_w_12),
        .W_13           (ch_3_w_13),
        .W_21           (ch_3_w_21),
        .W_22           (ch_3_w_22),
        .W_23           (ch_3_w_23),
        .W_31           (ch_3_w_31),
        .W_32           (ch_3_w_32),
        .W_33           (ch_3_w_33),
        .B              ({DW{1'b0}}),

        .OUT            (channel_3_out),
        .VALID          (channel_3_valid),
        .LAST_IN_LINE   (channel_3_last_in_line),
        .LAST_PIX       (channel_3_last_pix)
    );

    always @(posedge CLK)
    begin
        reg_conv_valid <= channel_0_valid;
        sum_valid <= reg_conv_valid;

        reg_conv_last_pix <= channel_0_last_pix;
        sum_last_pix <= reg_conv_last_pix;
    end

    always @(posedge CLK)
    begin
        if(channel_0_valid)
        begin
            sum_1 <= channel_0_out + channel_1_out;
            sum_2 <= channel_2_out + channel_3_out;
        end
        else
        begin
            sum_1 <= 0;
            sum_2 <= 0;
        end
    end

    always @(posedge CLK)
    begin
        if(reg_conv_valid)
            sum <= sum_1 + sum_2;
    end

    assign sum_relu = (sum[DW-1] == 1) ? 0 : sum;

    always @(posedge CLK)
    begin
        if(~RSTn)
            sum_squeeze_out <= 0;
        else if(sum_last_pix)
            sum_squeeze_out <= 1;
        else if(pooling_1_last_pix)
            sum_squeeze_out <= 0;
    end

    pooling_core_parallel_cxy #(
        .P_WIDTH     (16),
        .P_HEIGHT    (16),
        .P_WCNT_W    (4 ),
        .P_HCNT_W    (4 ),
        .P_PIX_CNT_W (8 ),
        .DW          (DW)
    )
    pooling_core_1
    (
        .CLK            (CLK),
        .RSTn           (RSTn),
        .DIN_VALID      (sum_valid),
        .DIN            (sum_relu),

        .SQUEEZE        (sum_squeeze_out),

        .OUT            (pooling_1_out),
        .VALID          (pooling_1_valid),
        .LAST_IN_LINE   (pooling_1_last_in_line),
        .LAST_PIX       (pooling_1_last_pix),
        .SQUEEZE_OUT    (pooling_1_squeeze_out),
        .NEXT_LAST_PIX  (LAST_PIX)
    );

    pooling_core_parallel_cxy #(
        .P_WIDTH     (8),
        .P_HEIGHT    (8),
        .P_WCNT_W    (3 ),
        .P_HCNT_W    (3 ),
        .P_PIX_CNT_W (6 ),
        .DW          (DW)
    )
    pooling_core_2
    (
        .CLK            (CLK),
        .RSTn           (RSTn),
        .DIN_VALID      (pooling_1_valid),
        .DIN            (pooling_1_out),

        .SQUEEZE        (pooling_1_squeeze_out),

        .OUT            (OUT),
        .VALID          (VALID),
        .LAST_IN_LINE   (LAST_IN_LINE),
        .LAST_PIX       (LAST_PIX),
        .SQUEEZE_OUT    (),
        .NEXT_LAST_PIX  ()
    );

endmodule
