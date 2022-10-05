`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/22 11:11:18
// Design Name: 
// Module Name: CNN_tdm_top
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


module CNN_tdm_top #(
        parameter DW = 24,
        parameter SIMULATE = 0
    )
    (
        input                   CLK,
        input                   RSTn,
        input                   DIN_VALID,
        input                   DIN,
        input                   SQUEEZE,
        output                  CONV_LAST_PIX,

        input                   L1_CONV_W_WEN,
        input                   L1_CONV_W_REN,
        input       [5:0]       L1_CONV_W_ADDR,
        input       [DW-1:0]    L1_CONV_W_WDATA,
        output      [DW-1:0]    L1_CONV_W_RDATA,

        input                   L1_CONV_B_WEN,
        input                   L1_CONV_B_REN,
        input       [1:0]       L1_CONV_B_ADDR,
        input       [DW-1:0]    L1_CONV_B_WDATA,
        output      [DW-1:0]    L1_CONV_B_RDATA,

        input                   L2_CONV_W1_WEN,
        input                   L2_CONV_W1_REN,
        input       [7:0]       L2_CONV_W1_ADDR,
        input       [DW-1:0]    L2_CONV_W1_WDATA,
        output      [DW-1:0]    L2_CONV_W1_RDATA,

        input                   L2_CONV_B1_WEN,
        input                   L2_CONV_B1_REN,
        input       [2:0]       L2_CONV_B1_ADDR,
        input       [DW-1:0]    L2_CONV_B1_WDATA,
        output      [DW-1:0]    L2_CONV_B1_RDATA,

        input                   L2_CONV_W2_WEN,
        input                   L2_CONV_W2_REN,
        input       [7:0]       L2_CONV_W2_ADDR,
        input       [DW-1:0]    L2_CONV_W2_WDATA,
        output      [DW-1:0]    L2_CONV_W2_RDATA,

        input                   L2_CONV_B2_WEN,
        input                   L2_CONV_B2_REN,
        input       [1:0]       L2_CONV_B2_ADDR,
        input       [DW-1:0]    L2_CONV_B2_WDATA,
        output      [DW-1:0]    L2_CONV_B2_RDATA,

        input                   VECTOR_W_WEN,
        input                   VECTOR_W_REN,
        input       [9:0]       VECTOR_W_ADDR,
        input       [DW-1:0]    VECTOR_W_WDATA,
        output      [DW-1:0]    VECTOR_W_RDATA,

        input                   VECTOR_B_WEN,
        input                   VECTOR_B_REN,
        input       [2:0]       VECTOR_B_ADDR,
        input       [DW-1:0]    VECTOR_B_WDATA,
        output reg  [DW-1:0]    VECTOR_B_RDATA,

        output reg              VALID,
        output reg  [DW-1:0]    OUTPUT1,
        output reg  [DW-1:0]    OUTPUT2,
        output reg  [DW-1:0]    OUTPUT3,
        output reg  [DW-1:0]    OUTPUT4,
        output reg  [DW-1:0]    OUTPUT5,
        output reg  [DW-1:0]    OUTPUT6
    );
    localparam S_LAYER1             = 0;
    localparam S_LAYER2_PREP        = 1;
    localparam S_LAYER2_PROC        = 2;
    localparam S_LAYER2_SQUEEZE     = 3;
    localparam S_FULLCONNECT_WAIT   = 4;
    localparam S_END                = 5;

    reg         [DW-1:0]    MEM_VECTOR_B[0:5];

    reg                     reg_vector_b_wen;
    reg         [DW-1:0]    reg_vector_b_addr;

    reg         [2:0]       state;

    wire                    layer1_finished;
    reg         [7:0]       layer1_data_read_addr;
    reg                     layer1_data_read_en;
    wire                    layer1_data_read_valid;
    wire        [DW-1:0]    layer1_data_out0;
    wire        [DW-1:0]    layer1_data_out1;
    wire        [DW-1:0]    layer1_data_out2;
    wire        [DW-1:0]    layer1_data_out3;

    reg                     layer2_rst_n;
    reg                     layer2_squeeze;
    wire                    layer2_conv_last_pix;
    reg         [2:0]       layer2_phase_sel;
    wire        [DW-1:0]    layer2_core_1_out;
    // wire        [DW-1:0]    layer2_core_2_out;
    wire                    layer2_valid;
    wire                    layer2_last_in_line;
    wire                    layer2_last_pix;

    wire                    fullconnect_valid;
    wire        [DW-1:0]    fullconnect_output1;
    wire        [DW-1:0]    fullconnect_output2;
    wire        [DW-1:0]    fullconnect_output3;
    wire        [DW-1:0]    fullconnect_output4;
    wire        [DW-1:0]    fullconnect_output5;
    wire        [DW-1:0]    fullconnect_output6;

    //-------------------------------------------------
    // MEM_VECTOR_B

    always @(posedge CLK)
    begin
        reg_vector_b_wen <= VECTOR_B_WEN;
        reg_vector_b_addr <= VECTOR_B_ADDR;
    end

    always @(posedge CLK)
    begin
        if(reg_vector_b_wen)
            MEM_VECTOR_B[reg_vector_b_addr] <= VECTOR_B_WDATA;
        else
            MEM_VECTOR_B[reg_vector_b_addr] <= MEM_VECTOR_B[reg_vector_b_addr];
    end

    always @(posedge CLK)
    begin
        if(VECTOR_B_REN)
            VECTOR_B_RDATA <= MEM_VECTOR_B[VECTOR_B_ADDR];
    end

    //-------------------------------------------------
    // 状态机

    always @(posedge CLK)
    begin
        if(~RSTn)
        begin
            state <= S_LAYER1;
            layer1_data_read_addr <= 0;
            layer1_data_read_en <= 0;
            layer2_rst_n <= 0;
            layer2_squeeze <= 0;
            layer2_phase_sel <= 0;

            VALID <= 0;
            OUTPUT1 <= MEM_VECTOR_B[0];
            OUTPUT2 <= MEM_VECTOR_B[1];
            OUTPUT3 <= MEM_VECTOR_B[2];
            OUTPUT4 <= MEM_VECTOR_B[3];
            OUTPUT5 <= MEM_VECTOR_B[4];
            OUTPUT6 <= MEM_VECTOR_B[5];
        end
        else
        begin
            case(state)
                S_LAYER1:
                begin
                    if(layer1_finished)
                    begin
                        state <= S_LAYER2_PREP;
                        OUTPUT1 <= MEM_VECTOR_B[0];
                        OUTPUT2 <= MEM_VECTOR_B[1];
                        OUTPUT3 <= MEM_VECTOR_B[2];
                        OUTPUT4 <= MEM_VECTOR_B[3];
                        OUTPUT5 <= MEM_VECTOR_B[4];
                        OUTPUT6 <= MEM_VECTOR_B[5];
                    end
                    else
                        state <= S_LAYER1;
                end
                S_LAYER2_PREP:
                begin
                    state <= S_LAYER2_PROC;
                    layer1_data_read_addr <= 0;
                    layer1_data_read_en <= 1;
                    layer2_rst_n <= 1;
                    layer2_squeeze <= 0;
                end
                S_LAYER2_PROC:
                begin
                    if(layer1_data_read_addr == 256-1)
                    begin
                        state <= S_LAYER2_SQUEEZE;
                        layer1_data_read_addr <= 0;
                        layer1_data_read_en <= 0;
                    end
                    else
                    begin
                        state <= S_LAYER2_PROC;
                        layer1_data_read_addr <= layer1_data_read_addr + 1;
                        layer1_data_read_en <= 1;
                    end
                end
                S_LAYER2_SQUEEZE:
                begin
                    if(layer2_conv_last_pix)
                    begin
                        state <= S_FULLCONNECT_WAIT;
                        layer2_squeeze <= 0;
                    end
                    else
                    begin
                        state <= S_LAYER2_SQUEEZE;
                        layer2_squeeze <= 1;
                    end
                end
                S_FULLCONNECT_WAIT:
                begin
                    if(fullconnect_valid)
                    begin
                        layer2_rst_n <= 0;
                        OUTPUT1 <= OUTPUT1 + fullconnect_output1;
                        OUTPUT2 <= OUTPUT2 + fullconnect_output2;
                        OUTPUT3 <= OUTPUT3 + fullconnect_output3;
                        OUTPUT4 <= OUTPUT4 + fullconnect_output4;
                        OUTPUT5 <= OUTPUT5 + fullconnect_output5;
                        OUTPUT6 <= OUTPUT6 + fullconnect_output6;
                        // if(layer2_phase_sel == 3)
                        if(layer2_phase_sel == 7)
                        begin
                            state <= S_END;
                            VALID <= 1;
                        end
                        else
                        begin
                            state <= S_LAYER2_PREP;
                            VALID <= 0;
                            layer2_phase_sel <= layer2_phase_sel + 1;
                        end
                    end
                    else
                    begin
                        state <= S_FULLCONNECT_WAIT;
                        VALID <= 0;
                    end
                end
                S_END:
                begin
                    state <= S_END;
                    VALID <= 0;
                end
            endcase
        end
    end

    //-------------------------------------------------
    // 卷积+池化层

    CNN_layer1_top #(
        .DW             (DW),
        .SIMULATE       (SIMULATE)
    )
    u_layer1 (
        .CLK            (CLK),
        .RSTn           (RSTn),
        .DIN_VALID      (DIN_VALID),
        .DIN            (DIN),
        .SQUEEZE        (SQUEEZE),
        .CONV_LAST_PIX  (CONV_LAST_PIX),

        .CONV_W_WEN     (L1_CONV_W_WEN),
        .CONV_W_REN     (L1_CONV_W_REN),
        .CONV_W_ADDR    (L1_CONV_W_ADDR),
        .CONV_W_WDATA   (L1_CONV_W_WDATA),
        .CONV_W_RDATA   (L1_CONV_W_RDATA),

        .CONV_B_WEN     (L1_CONV_B_WEN),
        .CONV_B_REN     (L1_CONV_B_REN),
        .CONV_B_ADDR    (L1_CONV_B_ADDR),
        .CONV_B_WDATA   (L1_CONV_B_WDATA),
        .CONV_B_RDATA   (L1_CONV_B_RDATA),

        .FINISHED       (layer1_finished),

        .READ_ADDR      (layer1_data_read_addr),
        .READ_EN        (layer1_data_read_en),
        .READ_VALID     (layer1_data_read_valid),
        .DATA_OUT0      (layer1_data_out0),
        .DATA_OUT1      (layer1_data_out1),
        .DATA_OUT2      (layer1_data_out2),
        .DATA_OUT3      (layer1_data_out3)
    );

    CNN_layer2_top #(
        .DW             (DW)
    )
    u_layer2 (
        .CLK            (CLK),
        .RSTn           (layer2_rst_n),
        .DIN_VALID      (layer1_data_read_valid),
        .DIN0           (layer1_data_out0),
        .DIN1           (layer1_data_out1),
        .DIN2           (layer1_data_out2),
        .DIN3           (layer1_data_out3),
        .SQUEEZE        (layer2_squeeze),
        .CONV_LAST_PIX  (layer2_conv_last_pix),

        .CONV_W1_WEN    (L2_CONV_W1_WEN),
        .CONV_W1_REN    (L2_CONV_W1_REN),
        .CONV_W1_ADDR   (L2_CONV_W1_ADDR),
        .CONV_W1_WDATA  (L2_CONV_W1_WDATA),
        .CONV_W1_RDATA  (L2_CONV_W1_RDATA),

        .CONV_B1_WEN    (L2_CONV_B1_WEN),
        .CONV_B1_REN    (L2_CONV_B1_REN),
        .CONV_B1_ADDR   (L2_CONV_B1_ADDR),
        .CONV_B1_WDATA  (L2_CONV_B1_WDATA),
        .CONV_B1_RDATA  (L2_CONV_B1_RDATA),

        .CONV_W2_WEN    (L2_CONV_W2_WEN),
        .CONV_W2_REN    (L2_CONV_W2_REN),
        .CONV_W2_ADDR   (L2_CONV_W2_ADDR),
        .CONV_W2_WDATA  (L2_CONV_W2_WDATA),
        .CONV_W2_RDATA  (L2_CONV_W2_RDATA),

        .CONV_B2_WEN    (L2_CONV_B2_WEN),
        .CONV_B2_REN    (L2_CONV_B2_REN),
        .CONV_B2_ADDR   (L2_CONV_B2_ADDR),
        .CONV_B2_WDATA  (L2_CONV_B2_WDATA),
        .CONV_B2_RDATA  (L2_CONV_B2_RDATA),

        .PHASE_SEL      (layer2_phase_sel),

        .CORE_1_OUT     (layer2_core_1_out),
        // .CORE_2_OUT     (layer2_core_2_out),
        .VALID          (layer2_valid),
        .LAST_IN_LINE   (layer2_last_in_line),
        .LAST_PIX       (layer2_last_pix)
    );

    //-------------------------------------------------
    // 全连接层

    CNN_fullconnect_top #(
        .DW                 (DW)
    )
    u_fullconnect
    (
        .CLK                (CLK),
        .RSTn               (layer2_rst_n),
        .DIN_VALID          (layer2_valid),
        .DIN0               (layer2_core_1_out),
        // .DIN1               (layer2_core_2_out),

        .PHASE_SEL          (layer2_phase_sel),

        .VECTOR_W_WEN       (VECTOR_W_WEN),
        .VECTOR_W_REN       (VECTOR_W_REN),
        .VECTOR_W_ADDR      (VECTOR_W_ADDR),
        .VECTOR_W_WDATA     (VECTOR_W_WDATA),
        .VECTOR_W_RDATA     (VECTOR_W_RDATA),

        .VALID              (fullconnect_valid),
        .OUTPUT1            (fullconnect_output1),
        .OUTPUT2            (fullconnect_output2),
        .OUTPUT3            (fullconnect_output3),
        .OUTPUT4            (fullconnect_output4),
        .OUTPUT5            (fullconnect_output5),
        .OUTPUT6            (fullconnect_output6)
    );

    //--------------------------------------------------
    // 将中间结果保存到文件

    generate
        if(SIMULATE == 1)
        begin: files_for_simulation
            integer file_layer2_data0;
            integer file_layer2_data1;
            integer file_layer2_data2;
            integer file_layer2_data3;
            integer file_layer2_data4;
            integer file_layer2_data5;
            integer file_layer2_data6;
            integer file_layer2_data7;

            initial begin
                file_layer2_data0 = $fopen("F:/Prj2020/test_data/CNN_TDM_TEST/layer2_core0.txt","w");
                file_layer2_data1 = $fopen("F:/Prj2020/test_data/CNN_TDM_TEST/layer2_core1.txt","w");
                file_layer2_data2 = $fopen("F:/Prj2020/test_data/CNN_TDM_TEST/layer2_core2.txt","w");
                file_layer2_data3 = $fopen("F:/Prj2020/test_data/CNN_TDM_TEST/layer2_core3.txt","w");
                file_layer2_data4 = $fopen("F:/Prj2020/test_data/CNN_TDM_TEST/layer2_core4.txt","w");
                file_layer2_data5 = $fopen("F:/Prj2020/test_data/CNN_TDM_TEST/layer2_core5.txt","w");
                file_layer2_data6 = $fopen("F:/Prj2020/test_data/CNN_TDM_TEST/layer2_core6.txt","w");
                file_layer2_data7 = $fopen("F:/Prj2020/test_data/CNN_TDM_TEST/layer2_core7.txt","w");
            end

            always @(posedge CLK)
            begin
                if(layer2_valid)
                begin
                    if(layer2_last_in_line)
                    begin
                        case(layer2_phase_sel)
                            2'd0:
                            begin
                                $fwrite(file_layer2_data0, "%h\n", layer2_core_1_out);
                                $fwrite(file_layer2_data1, "%h\n", layer2_core_2_out);
                            end
                            2'd1:
                            begin
                                $fwrite(file_layer2_data2, "%h\n", layer2_core_1_out);
                                $fwrite(file_layer2_data3, "%h\n", layer2_core_2_out);
                            end
                            2'd2:
                            begin
                                $fwrite(file_layer2_data4, "%h\n", layer2_core_1_out);
                                $fwrite(file_layer2_data5, "%h\n", layer2_core_2_out);
                            end
                            2'd3:
                            begin
                                $fwrite(file_layer2_data6, "%h\n", layer2_core_1_out);
                                $fwrite(file_layer2_data7, "%h\n", layer2_core_2_out);
                            end
                        endcase
                    end
                    else
                    begin
                        case(layer2_phase_sel)
                            2'd0:
                            begin
                                $fwrite(file_layer2_data0, "%h ", layer2_core_1_out);
                                $fwrite(file_layer2_data1, "%h ", layer2_core_2_out);
                            end
                            2'd1:
                            begin
                                $fwrite(file_layer2_data2, "%h ", layer2_core_1_out);
                                $fwrite(file_layer2_data3, "%h ", layer2_core_2_out);
                            end
                            2'd2:
                            begin
                                $fwrite(file_layer2_data4, "%h ", layer2_core_1_out);
                                $fwrite(file_layer2_data5, "%h ", layer2_core_2_out);
                            end
                            2'd3:
                            begin
                                $fwrite(file_layer2_data6, "%h ", layer2_core_1_out);
                                $fwrite(file_layer2_data7, "%h ", layer2_core_2_out);
                            end
                        endcase
                    end
                end
            end

            integer file_fullconnect_data;

            initial begin
                file_fullconnect_data = $fopen("F:/Prj2020/test_data/CNN_TDM_TEST/fullconnect_data.txt","w");
            end

            always @(posedge CLK)
            begin
                if(VALID)
                begin
                    $fwrite(file_fullconnect_data, "%h ",  OUTPUT1);
                    $fwrite(file_fullconnect_data, "%h ",  OUTPUT2);
                    $fwrite(file_fullconnect_data, "%h ",  OUTPUT3);
                    $fwrite(file_fullconnect_data, "%h ",  OUTPUT4);
                    $fwrite(file_fullconnect_data, "%h ",  OUTPUT5);
                    $fwrite(file_fullconnect_data, "%h\n", OUTPUT6);
                end
            end
        end
    endgenerate

endmodule
