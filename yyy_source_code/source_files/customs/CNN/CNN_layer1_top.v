`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/22 11:12:24
// Design Name: 
// Module Name: CNN_layer1_top
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


module CNN_layer1_top #(
        parameter   DW = 24,
        parameter   SIMULATE = 0
    )
    (
        input               CLK,
        input               RSTn,
        input               DIN_VALID,
        input               DIN,
        input               SQUEEZE,
        output              CONV_LAST_PIX,

        input               CONV_W_WEN,
        input               CONV_W_REN,
        input      [5:0]    CONV_W_ADDR,
        input      [DW-1:0] CONV_W_WDATA,
        output reg [DW-1:0] CONV_W_RDATA,

        input               CONV_B_WEN,
        input               CONV_B_REN,
        input      [1:0]    CONV_B_ADDR,
        input      [DW-1:0] CONV_B_WDATA,
        output reg [DW-1:0] CONV_B_RDATA,

        output reg          FINISHED,

        input      [7:0]    READ_ADDR,
        input               READ_EN,
        output reg          READ_VALID,
        output reg [DW-1:0] DATA_OUT0,
        output reg [DW-1:0] DATA_OUT1,
        output reg [DW-1:0] DATA_OUT2,
        output reg [DW-1:0] DATA_OUT3
    );

    parameter S_PROCESS = 0;
    parameter S_END     = 1;

    reg         [DW-1:0]    MEM_CONV_W[0:9*4-1];
    reg         [DW-1:0]    MEM_CONV_B[0:4-1];
    reg         [DW-1:0]    MEM_DATA0[0:16*16-1];
    reg         [DW-1:0]    MEM_DATA1[0:16*16-1];
    reg         [DW-1:0]    MEM_DATA2[0:16*16-1];
    reg         [DW-1:0]    MEM_DATA3[0:16*16-1];

    reg                     reg_conv_w_wen;
    reg         [5:0]       reg_conv_w_addr;
    reg                     reg_conv_b_wen;
    reg         [1:0]       reg_conv_b_addr;

    reg         [7:0]       mem_data_addr;

    reg                     state;

    wire                    channel_0_conv_last_pix;
    wire        [DW-1:0]    channel_0_out;
    wire                    channel_0_valid;
    wire                    channel_0_last_in_line;
    wire                    channel_0_last_pix;
    wire                    channel_0_squeeze_out;

    wire                    channel_1_conv_last_pix;
    wire        [DW-1:0]    channel_1_out;
    wire                    channel_1_valid;
    wire                    channel_1_last_in_line;
    wire                    channel_1_last_pix;
    wire                    channel_1_squeeze_out;

    wire                    channel_2_conv_last_pix;
    wire        [DW-1:0]    channel_2_out;
    wire                    channel_2_valid;
    wire                    channel_2_last_in_line;
    wire                    channel_2_last_pix;
    wire                    channel_2_squeeze_out;

    wire                    channel_3_conv_last_pix;
    wire        [DW-1:0]    channel_3_out;
    wire                    channel_3_valid;
    wire                    channel_3_last_in_line;
    wire                    channel_3_last_pix;
    wire                    channel_3_squeeze_out;

    //----------------------------------
    // 系数加载

    always @(posedge CLK)
    begin
        reg_conv_w_wen  <= CONV_W_WEN;
        reg_conv_w_addr <= CONV_W_ADDR;
        reg_conv_b_wen  <= CONV_B_WEN;
        reg_conv_b_addr <= CONV_B_ADDR;
    end

    always @(posedge CLK)
    begin
        if(reg_conv_w_wen)
            MEM_CONV_W[reg_conv_w_addr] <= CONV_W_WDATA;
    end

    always @(posedge CLK)
    begin
        if(reg_conv_b_wen)
            MEM_CONV_B[reg_conv_b_addr] <= CONV_B_WDATA;
    end

    always @(posedge CLK)
    begin
        if(CONV_W_REN)
            CONV_W_RDATA <= MEM_CONV_W[CONV_W_ADDR];
    end

    always @(posedge CLK)
    begin
        if(CONV_B_REN)
            CONV_B_RDATA <= MEM_CONV_B[CONV_B_ADDR];
    end

    //----------------------------------
    // 状态机

    always @(posedge CLK)
    begin
        if(~RSTn)
        begin
            state <= S_PROCESS;
            mem_data_addr <= 0;
            FINISHED <= 0;
        end
        else
        begin
            case(state)
                S_PROCESS:
                begin
                    if(channel_0_valid)
                    begin
                        mem_data_addr <= mem_data_addr + 1;
                        if(channel_0_last_pix)
                        begin
                            state <= S_END;
                            FINISHED <= 1;
                        end
                        else
                        begin
                            state <= S_PROCESS;
                            FINISHED <= 0;
                        end
                    end
                    else
                    begin
                        mem_data_addr <= mem_data_addr;
                        state <= S_PROCESS;
                        FINISHED <= 0;
                    end
                end
                S_END:
                begin
                    mem_data_addr <= 0;
                    state <= S_END;
                    FINISHED <= 1;
                end
            endcase
        end
    end

    //----------------------------------
    // 第一层卷积池化运算及结果暂存

    // integer file_mem_data0;
    // integer file_mem_data1;
    // integer file_mem_data2;
    // integer file_mem_data3;

    // initial begin
    //     file_mem_data0 = $fopen("F:/Prj2020/test_data/CNN_TDM_TEST/layer1_channel0.txt","w");
    //     file_mem_data1 = $fopen("F:/Prj2020/test_data/CNN_TDM_TEST/layer1_channel1.txt","w");
    //     file_mem_data2 = $fopen("F:/Prj2020/test_data/CNN_TDM_TEST/layer1_channel2.txt","w");
    //     file_mem_data3 = $fopen("F:/Prj2020/test_data/CNN_TDM_TEST/layer1_channel3.txt","w");
    // end

    // integer i;
    always @(posedge CLK)
    begin
        if(channel_0_valid && (state == S_PROCESS))
        begin
            MEM_DATA0[mem_data_addr] <= channel_0_out;
            MEM_DATA1[mem_data_addr] <= channel_1_out;
            MEM_DATA2[mem_data_addr] <= channel_2_out;
            MEM_DATA3[mem_data_addr] <= channel_3_out;
            // // i = 0;
            // if(channel_0_last_in_line)
            // begin
            //     $fwrite(file_mem_data0, "%h\n", channel_0_out);
            //     $fwrite(file_mem_data1, "%h\n", channel_1_out);
            //     $fwrite(file_mem_data2, "%h\n", channel_2_out);
            //     $fwrite(file_mem_data3, "%h\n", channel_3_out);
            // end
            // else
            // begin
            //     $fwrite(file_mem_data0, "%h ", channel_0_out);
            //     $fwrite(file_mem_data1, "%h ", channel_1_out);
            //     $fwrite(file_mem_data2, "%h ", channel_2_out);
            //     $fwrite(file_mem_data3, "%h ", channel_3_out);
            // end
        end
        else
        begin
            MEM_DATA0[mem_data_addr] <= MEM_DATA0[mem_data_addr];
            MEM_DATA1[mem_data_addr] <= MEM_DATA1[mem_data_addr];
            MEM_DATA2[mem_data_addr] <= MEM_DATA2[mem_data_addr];
            MEM_DATA3[mem_data_addr] <= MEM_DATA3[mem_data_addr];
        end
    end

    assign CONV_LAST_PIX = channel_0_conv_last_pix;

    CNN_layer1_channel #(
        .DW             (DW)
    )
    u_CNN_layer1_channel_0
    (
        .CLK            (CLK),
        .RSTn           (RSTn),
        .DIN_VALID      (DIN_VALID),
        .DIN            (DIN),
        .SQUEEZE        (SQUEEZE),
        .CONV_LAST_PIX  (channel_0_conv_last_pix),

        .W_11           (MEM_CONV_W[9*0+0]),
        .W_12           (MEM_CONV_W[9*0+1]),
        .W_13           (MEM_CONV_W[9*0+2]),
        .W_21           (MEM_CONV_W[9*0+3]),
        .W_22           (MEM_CONV_W[9*0+4]),
        .W_23           (MEM_CONV_W[9*0+5]),
        .W_31           (MEM_CONV_W[9*0+6]),
        .W_32           (MEM_CONV_W[9*0+7]),
        .W_33           (MEM_CONV_W[9*0+8]),
        .B              (MEM_CONV_B[  0  ]),

        .OUT            (channel_0_out),
        .VALID          (channel_0_valid),
        .LAST_IN_LINE   (channel_0_last_in_line),
        .LAST_PIX       (channel_0_last_pix),

        .SQUEEZE_OUT    (channel_0_squeeze_out),
        .NEXT_LAST_PIX  (1'b1)
    );

    CNN_layer1_channel #(
        .DW             (DW)
    )
    u_CNN_layer1_channel_1
    (
        .CLK            (CLK),
        .RSTn           (RSTn),
        .DIN_VALID      (DIN_VALID),
        .DIN            (DIN),
        .SQUEEZE        (SQUEEZE),
        .CONV_LAST_PIX  (channel_1_conv_last_pix),

        .W_11           (MEM_CONV_W[9*1+0]),
        .W_12           (MEM_CONV_W[9*1+1]),
        .W_13           (MEM_CONV_W[9*1+2]),
        .W_21           (MEM_CONV_W[9*1+3]),
        .W_22           (MEM_CONV_W[9*1+4]),
        .W_23           (MEM_CONV_W[9*1+5]),
        .W_31           (MEM_CONV_W[9*1+6]),
        .W_32           (MEM_CONV_W[9*1+7]),
        .W_33           (MEM_CONV_W[9*1+8]),
        .B              (MEM_CONV_B[  1  ]),

        .OUT            (channel_1_out),
        .VALID          (channel_1_valid),
        .LAST_IN_LINE   (channel_1_last_in_line),
        .LAST_PIX       (channel_1_last_pix),

        .SQUEEZE_OUT    (channel_1_squeeze_out),
        .NEXT_LAST_PIX  (1'b1)
    );

    CNN_layer1_channel #(
        .DW             (DW)
    )
    u_CNN_layer1_channel_2
    (
        .CLK            (CLK),
        .RSTn           (RSTn),
        .DIN_VALID      (DIN_VALID),
        .DIN            (DIN),
        .SQUEEZE        (SQUEEZE),
        .CONV_LAST_PIX  (channel_2_conv_last_pix),

        .W_11           (MEM_CONV_W[9*2+0]),
        .W_12           (MEM_CONV_W[9*2+1]),
        .W_13           (MEM_CONV_W[9*2+2]),
        .W_21           (MEM_CONV_W[9*2+3]),
        .W_22           (MEM_CONV_W[9*2+4]),
        .W_23           (MEM_CONV_W[9*2+5]),
        .W_31           (MEM_CONV_W[9*2+6]),
        .W_32           (MEM_CONV_W[9*2+7]),
        .W_33           (MEM_CONV_W[9*2+8]),
        .B              (MEM_CONV_B[  2  ]),

        .OUT            (channel_2_out),
        .VALID          (channel_2_valid),
        .LAST_IN_LINE   (channel_2_last_in_line),
        .LAST_PIX       (channel_2_last_pix),

        .SQUEEZE_OUT    (channel_2_squeeze_out),
        .NEXT_LAST_PIX  (1'b1)
    );

    CNN_layer1_channel #(
        .DW             (DW)
    )
    u_CNN_layer1_channel_3
    (
        .CLK            (CLK),
        .RSTn           (RSTn),
        .DIN_VALID      (DIN_VALID),
        .DIN            (DIN),
        .SQUEEZE        (SQUEEZE),
        .CONV_LAST_PIX  (channel_3_conv_last_pix),

        .W_11           (MEM_CONV_W[9*3+0]),
        .W_12           (MEM_CONV_W[9*3+1]),
        .W_13           (MEM_CONV_W[9*3+2]),
        .W_21           (MEM_CONV_W[9*3+3]),
        .W_22           (MEM_CONV_W[9*3+4]),
        .W_23           (MEM_CONV_W[9*3+5]),
        .W_31           (MEM_CONV_W[9*3+6]),
        .W_32           (MEM_CONV_W[9*3+7]),
        .W_33           (MEM_CONV_W[9*3+8]),
        .B              (MEM_CONV_B[  3  ]),

        .OUT            (channel_3_out),
        .VALID          (channel_3_valid),
        .LAST_IN_LINE   (channel_3_last_in_line),
        .LAST_PIX       (channel_3_last_pix),

        .SQUEEZE_OUT    (channel_3_squeeze_out),
        .NEXT_LAST_PIX  (1'b1)
    );

    //----------------------------------
    // 下一层将结果读出

    always @(posedge CLK)
    begin
        if(READ_EN && (state == S_END))
        begin
            READ_VALID <= 1;
            DATA_OUT0 <= MEM_DATA0[READ_ADDR];
            DATA_OUT1 <= MEM_DATA1[READ_ADDR];
            DATA_OUT2 <= MEM_DATA2[READ_ADDR];
            DATA_OUT3 <= MEM_DATA3[READ_ADDR];
        end
        else
        begin
            READ_VALID <= 0;
            DATA_OUT0 <= 0;
            DATA_OUT1 <= 0;
            DATA_OUT2 <= 0;
            DATA_OUT3 <= 0;
        end
    end

    //----------------------------------
    // 中间结果保存到文件

    generate
        if(SIMULATE == 1)
        begin: output_files_for_simulation

            integer file_mem_data0;
            integer file_mem_data1;
            integer file_mem_data2;
            integer file_mem_data3;

            initial begin
                file_mem_data0 = $fopen("F:/Prj2020/test_data/CNN_TDM_TEST/layer1_channel0.txt","w");
                file_mem_data1 = $fopen("F:/Prj2020/test_data/CNN_TDM_TEST/layer1_channel1.txt","w");
                file_mem_data2 = $fopen("F:/Prj2020/test_data/CNN_TDM_TEST/layer1_channel2.txt","w");
                file_mem_data3 = $fopen("F:/Prj2020/test_data/CNN_TDM_TEST/layer1_channel3.txt","w");
            end

            always @(posedge CLK)
            begin
                if(channel_0_valid && (state == S_PROCESS))
                begin
                    if(channel_0_last_in_line)
                    begin
                        $fwrite(file_mem_data0, "%h\n", channel_0_out);
                        $fwrite(file_mem_data1, "%h\n", channel_1_out);
                        $fwrite(file_mem_data2, "%h\n", channel_2_out);
                        $fwrite(file_mem_data3, "%h\n", channel_3_out);
                    end
                    else
                    begin
                        $fwrite(file_mem_data0, "%h ", channel_0_out);
                        $fwrite(file_mem_data1, "%h ", channel_1_out);
                        $fwrite(file_mem_data2, "%h ", channel_2_out);
                        $fwrite(file_mem_data3, "%h ", channel_3_out);
                    end
                end
            end
            
        end
    endgenerate

endmodule
