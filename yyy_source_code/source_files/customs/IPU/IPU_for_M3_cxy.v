`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/08 09:28:55
// Design Name: 
// Module Name: IPU_for_M3_cxy
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


module IPU_for_M3_cxy #(
        parameter RGB2H_FILENAME = "",
        parameter RGB2S_FILENAME = ""
    )
    (
    input               HCLK,
    input               HRESETn,
    
    // AHB inputs Slave
    input               HREADYM,
    input               HSELM,
    input       [1:0]   HTRANSM,
    input               HWRITEM,
    input       [31:0]  HADDRM,
    input       [31:0]  HWDATAM,

    // AHB outputs Slave
    output              HREADYOUTM,
    output reg  [31:0]  HRDATAM,

    // AHB outputs Master
    // output              HSELS,
    output              HWRITES,
    output      [31:0]  HADDRS,
    output      [1:0]   HTRANSS,
    output reg  [31:0]  HWDATAS,
    output              HREADYS,

    // AHB inputs Master
    input               HREADYOUTS,
    input       [31:0]  HRDATAS,

    // 7 Seg Disp
    output      [7:0]   SEG_SELECT,
    output      [7:0]   SEG_DATA_OUT_0,
    output      [7:0]   SEG_DATA_OUT_1,

    // to CNN
    output              RESIZE_OUT,
    output              RESIZE_VALID,
    output              SQUEEZE_OUT,
    input               NEXT_LAST_PIX
    );

    parameter S_IDLE        = 0;
    parameter S_PROCESSING  = 1;
    parameter S_END         = 3;

    parameter M_ORIGINAL    = 4'b0000;
    parameter M_BINARIZE    = 4'b0001;
    parameter M_PHASE0      = 4'b0010;
    parameter M_PHASE1      = 4'b0100;
    parameter M_RESIZE      = 4'b1000;

    parameter ADDR_REG_CTRL          = 32'h4008_0000;
    parameter ADDR_REG_STATE         = 32'h4008_0004;
    parameter ADDR_REG_H             = 32'h4008_0008;
    parameter ADDR_REG_S             = 32'h4008_000C;
    parameter ADDR_REG_V             = 32'h4008_0010;
    parameter ADDR_REG_RESIZE_TH     = 32'h4008_0014;
    parameter ADDR_REG_PHASE_TH      = 32'h4008_0018;
    parameter ADDR_REG_CENTROID_H    = 32'h4008_001C;
    parameter ADDR_REG_CENTROID_V    = 32'h4008_0020;
    parameter ADDR_REG_CENTROID_SUM  = 32'h4008_0024;
    parameter ADDR_REG_7SEG_DISPLAY  = 32'h4008_0028;
    parameter ADDR_IPU_IN            = 32'h4008_0100;

    // Registers
    reg     [31:0]  reg_ctrl         = 32'h0;
    reg     [31:0]  reg_state        = 32'h0;
    reg     [31:0]  reg_h            = 32'h0;
    reg     [31:0]  reg_s            = 32'h0;
    reg     [31:0]  reg_v            = 32'h0;
    reg     [31:0]  reg_resize_th    = 32'h0;
    reg     [31:0]  reg_phase_th     = 32'h0;
    reg     [31:0]  reg_centroid_h   = 32'h0;
    reg     [31:0]  reg_centroid_v   = 32'h0;
    reg     [31:0]  reg_centroid_sum = 32'h0;
    reg     [31:0]  reg_7seg_display = 32'h0;

    // Write Enable
    reg     [11:0]  reg_wen_sel;
    wire            reg_ctrl_wen;
    wire            reg_state_wen;
    wire            reg_h_wen;
    wire            reg_s_wen;
    wire            reg_v_wen;
    wire            reg_resize_th_wen;
    wire            reg_phase_th_wen;
    wire            reg_centroid_h_wen;
    wire            reg_centroid_v_wen;
    wire            reg_centroid_sum_wen;
    wire            reg_7seg_display_wen;
    wire            reg_IPU_in_wen;

    // Read Enable
    reg     [11:0]  reg_ren_sel;
    wire            reg_ctrl_ren;
    wire            reg_state_ren;
    wire            reg_h_ren;
    wire            reg_s_ren;
    wire            reg_v_ren;
    wire            reg_resize_th_ren;
    wire            reg_phase_th_ren;
    wire            reg_centroid_h_ren;
    wire            reg_centroid_v_ren;
    wire            reg_centroid_sum_ren;
    wire            reg_7seg_display_ren;
    wire            reg_IPU_in_ren;

    reg     [ 1:0]  state;

    // for Ctrl & State Register
    wire    [ 3:0]  mode;
    wire            IPU_reset;

    wire            s_processing;
    reg             s_binarize_finished;
    reg             s_p0_finished;
    reg             s_p1_finished;
    reg             s_resize_finished;
    wire            s_output_finished;

    // for AHB Slave
    reg     [31:0]  output_addr;
    reg     [16:0]  pix_out_cnt;

    // IPU
    reg     [16:0]  pix_in_cnt;
    wire    [11:0]  rgb;
    wire            rgb_valid;
    reg             squeeze;

    wire            p0_border;
    wire    [ 3:0]  p0_threshold;
    wire            p1_border;
    wire    [ 3:0]  p1_threshold;

    wire            IPU_binarize_output;
    reg             IPU_binarize_valid;
    wire            IPU_phase0_output;
    wire            IPU_phase0_valid;
    wire            IPU_phase0_last_in_line;
    wire            IPU_phase0_last_pix;
    wire            IPU_phase1_output;
    wire            IPU_phase1_valid;
    wire            IPU_phase1_last_in_line;
    wire            IPU_phase1_last_pix;
    wire            IPU_resize_output;
    wire            IPU_resize_valid;
    wire            IPU_resize_last_in_line;
    wire            IPU_resize_last_pix;
    wire    [17:0]  IPU_centroid_h;
    wire    [17:0]  IPU_centroid_v;
    wire    [12:0]  IPU_centroid_sum;
    wire            IPU_centroid_valid;
    reg             IPU_output_valid;
    reg     [11:0]  IPU_output_data;

    //---------------------------------------
    // FSM

    always @(posedge HCLK)
    begin
        case(state)
            S_IDLE:
            begin
                if(reg_IPU_in_wen)
                    state <= S_PROCESSING;
                else
                    state <= S_IDLE;
            end
            S_PROCESSING:
            begin
                if(IPU_reset)
                begin
                    state <= S_IDLE;
                end
                else
                begin
                    case(mode)
                        M_ORIGINAL, M_BINARIZE, M_PHASE0, M_PHASE1:
                        begin
                            if(pix_out_cnt == 76800-1 && IPU_output_valid)
                                state <= S_END;
                            else
                                state <= S_PROCESSING;
                        end
                        M_RESIZE:
                        begin
                            if(pix_out_cnt == 4096-1 && IPU_output_valid)
                                state <= S_END;
                            else
                                state <= S_PROCESSING;
                        end
                    endcase
                end
            end
            S_END:
            begin
                if(IPU_reset)
                    state <= S_IDLE;
                else
                    state <= S_END;
            end
            default:
            begin
                state <= S_END;
            end
        endcase
    end

    //---------------------------------------
    // AHB Master Interface

    assign reg_ctrl_wen         = reg_wen_sel[0];
    assign reg_state_wen        = reg_wen_sel[1];
    assign reg_h_wen            = reg_wen_sel[2];
    assign reg_s_wen            = reg_wen_sel[3];
    assign reg_v_wen            = reg_wen_sel[4];
    assign reg_resize_th_wen    = reg_wen_sel[5];
    assign reg_phase_th_wen     = reg_wen_sel[6];
    assign reg_centroid_h_wen   = reg_wen_sel[7];
    assign reg_centroid_v_wen   = reg_wen_sel[8];
    assign reg_centroid_sum_wen = reg_wen_sel[9];
    assign reg_7seg_display_wen = reg_wen_sel[10];
    assign reg_IPU_in_wen       = reg_wen_sel[11];

    always @(posedge HCLK)
    begin
        if(~HRESETn)
        begin
            reg_wen_sel <= 0;
        end
        else if(HSELM & HTRANSM[1] & HWRITEM)
        begin
            case(HADDRM)
                ADDR_REG_CTRL:          reg_wen_sel <= 12'b0000_0000_0001;
                ADDR_REG_STATE:         reg_wen_sel <= 12'b0000_0000_0010;
                ADDR_REG_H:             reg_wen_sel <= 12'b0000_0000_0100;
                ADDR_REG_S:             reg_wen_sel <= 12'b0000_0000_1000;
                ADDR_REG_V:             reg_wen_sel <= 12'b0000_0001_0000;
                ADDR_REG_RESIZE_TH:     reg_wen_sel <= 12'b0000_0010_0000;
                ADDR_REG_PHASE_TH:      reg_wen_sel <= 12'b0000_0100_0000;
                ADDR_REG_CENTROID_H:    reg_wen_sel <= 12'b0000_1000_0000;
                ADDR_REG_CENTROID_V:    reg_wen_sel <= 12'b0001_0000_0000;
                ADDR_REG_CENTROID_SUM:  reg_wen_sel <= 12'b0010_0000_0000;
                ADDR_REG_7SEG_DISPLAY:  reg_wen_sel <= 12'b0100_0000_0000;
                ADDR_IPU_IN:            reg_wen_sel <= 12'b1000_0000_0000;
                default:
                begin
                    reg_wen_sel <= 0;
                end
            endcase
        end
        else
        begin
            reg_wen_sel <= 0;
        end
    end

    assign reg_ctrl_ren         = reg_ren_sel[0];
    assign reg_state_ren        = reg_ren_sel[1];
    assign reg_h_ren            = reg_ren_sel[2];
    assign reg_s_ren            = reg_ren_sel[3];
    assign reg_v_ren            = reg_ren_sel[4];
    assign reg_resize_th_ren    = reg_ren_sel[5];
    assign reg_phase_th_ren     = reg_ren_sel[6];
    assign reg_centroid_h_ren   = reg_ren_sel[7];
    assign reg_centroid_v_ren   = reg_ren_sel[8];
    assign reg_centroid_sum_ren = reg_ren_sel[9];
    assign reg_7seg_display_ren = reg_ren_sel[10];
    assign reg_IPU_in_ren       = reg_ren_sel[11];

    always @(*)
    begin
        if(~HRESETn)
        begin
            reg_ren_sel = 0;
        end
        else if(HSELM & HTRANSM[1] & ~HWRITEM)
        begin
            case(HADDRM)
                ADDR_REG_CTRL:          reg_ren_sel = 12'b0000_0000_0001;
                ADDR_REG_STATE:         reg_ren_sel = 12'b0000_0000_0010;
                ADDR_REG_H:             reg_ren_sel = 12'b0000_0000_0100;
                ADDR_REG_S:             reg_ren_sel = 12'b0000_0000_1000;
                ADDR_REG_V:             reg_ren_sel = 12'b0000_0001_0000;
                ADDR_REG_RESIZE_TH:     reg_ren_sel = 12'b0000_0010_0000;
                ADDR_REG_PHASE_TH:      reg_ren_sel = 12'b0000_0100_0000;
                ADDR_REG_CENTROID_H:    reg_ren_sel = 12'b0000_1000_0000;
                ADDR_REG_CENTROID_V:    reg_ren_sel = 12'b0001_0000_0000;
                ADDR_REG_CENTROID_SUM:  reg_ren_sel = 12'b0010_0000_0000;
                ADDR_REG_7SEG_DISPLAY:  reg_ren_sel = 12'b0100_0000_0000;
                ADDR_IPU_IN:            reg_ren_sel = 12'b1000_0000_0000;
                default:
                begin
                    reg_ren_sel = 0;
                end
            endcase
        end
        else
        begin
            reg_ren_sel = 0;
        end
    end

    // reg_ctrl
    always @(posedge HCLK)
    begin
        if(~HRESETn)
            reg_ctrl <= 32'h0000_0010;
        else if(reg_ctrl_wen)
            reg_ctrl <= HWDATAM;
        else
            reg_ctrl <= {28'd0, reg_ctrl[3:0]};
    end

    // reg_state
    always @(posedge HCLK)
    begin
        if(~HRESETn)
            reg_state <= 32'd0;
        else
            reg_state <= {  26'h0,
                            s_output_finished,
                            s_resize_finished,
                            s_p1_finished,
                            s_p0_finished,
                            s_binarize_finished,
                            s_processing};
    end

    // reg_h
    always @(posedge HCLK)
    begin
        if(~HRESETn)
            reg_h <= 32'h0;
        else if(reg_h_wen)
            reg_h <= HWDATAM;
    end

    // reg_s
    always @(posedge HCLK)
    begin
        if(~HRESETn)
            reg_s <= 32'h0;
        else if(reg_s_wen)
            reg_s <= HWDATAM;
    end

    // reg_v
    always @(posedge HCLK)
    begin
        if(~HRESETn)
            reg_v <= 32'h0;
        else if(reg_v_wen)
            reg_v <= HWDATAM;
    end

    // reg_resize_th
    always @(posedge HCLK)
    begin
        if(~HRESETn)
            reg_resize_th <= 32'h0;
        else if(reg_resize_th_wen)
            reg_resize_th <= HWDATAM;
    end

    // reg_phase_th
    always @(posedge HCLK)
    begin
        if(~HRESETn)
            reg_phase_th <= 32'h0;
        else if(reg_phase_th_wen)
            reg_phase_th <= HWDATAM;
    end

    // reg_centroid_h
    always @(posedge HCLK)
    begin
        if(~HRESETn)
            reg_centroid_h <= 0;
        else if(reg_centroid_h_wen)
            reg_centroid_h <= HWDATAM;
        else if(IPU_centroid_valid)
            reg_centroid_h <= IPU_centroid_h;
    end

    // reg_centroid_v
    always @(posedge HCLK)
    begin
        if(~HRESETn)
            reg_centroid_v <= 0;
        else if(reg_centroid_v_wen)
            reg_centroid_v <= HWDATAM;
        else if(IPU_centroid_valid)
            reg_centroid_v <= IPU_centroid_v;
    end

    // reg_centroid_sum
    always @(posedge HCLK)
    begin
        if(~HRESETn)
            reg_centroid_sum <= 0;
        else if(reg_centroid_sum_wen)
            reg_centroid_sum <= HWDATAM;
        else if(IPU_centroid_valid)
            reg_centroid_sum <= IPU_centroid_sum;
    end

    // reg_7seg_display_wen
    always @(posedge HCLK)
    begin
        if(~HRESETn)
            reg_7seg_display <= 0;
        else if(reg_7seg_display_wen)
            reg_7seg_display <= HWDATAM;
    end

    assign HREADYOUTM = 1'b1;

    always @(posedge HCLK)
    begin
        if(reg_ctrl_ren)
            HRDATAM <= reg_ctrl;
        else if(reg_state_ren)
            HRDATAM <= reg_state;
        else if(reg_h_ren)
            HRDATAM <= reg_h;
        else if(reg_s_ren)
            HRDATAM <= reg_s;
        else if(reg_v_ren)
            HRDATAM <= reg_v;
        else if(reg_resize_th_ren)
            HRDATAM <= reg_resize_th;
        else if(reg_phase_th_ren)
            HRDATAM <= reg_phase_th;
        else if(reg_centroid_h_ren)
            HRDATAM <= reg_centroid_h;
        else if(reg_centroid_v_ren)
            HRDATAM <= reg_centroid_v;
        else if(reg_centroid_sum_ren)
            HRDATAM <= reg_centroid_sum;
        else if(reg_7seg_display_ren)
            HRDATAM <= reg_7seg_display;
        else
            HRDATAM <= 32'h0;
    end

    //---------------------------------------
    // AHB Slave Interface

    assign output_binarization = reg_ctrl[0];
    assign output_phase0       = reg_ctrl[1];
    assign output_phase1       = reg_ctrl[2];
    assign output_resize       = reg_ctrl[3];

    assign HWRITES = (state == S_PROCESSING) ? IPU_output_valid : 1'b0;
    assign HTRANSS = ((state == S_PROCESSING) & IPU_output_valid) ? 2'b10 : 2'b00;
    // assign HWDATAS = IPU_output_data;
    assign HADDRS  = output_addr;
    assign HREADYS = 1'b1;

    always @(posedge HCLK)
    begin
        HWDATAS <= {20'h0, IPU_output_data};
    end

    always @(posedge HCLK)
    begin
        // if(state == S_IDLE)
        if(IPU_reset)
            pix_out_cnt <= 0;
        else if(IPU_output_valid)
            pix_out_cnt <= pix_out_cnt + 1;
        else
            pix_out_cnt <= pix_out_cnt;
    end

    always @(posedge HCLK)
    begin
        // if(state == S_IDLE)
        if(IPU_reset)
        begin
            case(mode)
                M_ORIGINAL, M_BINARIZE, M_PHASE0, M_PHASE1:
                begin
                    output_addr <= 32'h5000_0000;
                end
                M_RESIZE:
                begin
                    output_addr <= 32'h5004_C000;
                end
            endcase
        end
        else if(IPU_output_valid)
            output_addr <= output_addr + 4;
        else
            output_addr <= output_addr;
    end

    //---------------------------------------
    // IPU

    assign IPU_reset = reg_ctrl[4];
    assign mode      = reg_ctrl[3:0];

    assign rgb          = HWDATAM[11:0];
    assign rgb_valid    = (pix_in_cnt<76800) ? reg_IPU_in_wen : 1'b0;
    assign p0_border    = (p0_threshold>=5) ? 1'b1 : 1'b0;
    assign p0_threshold = reg_phase_th[7:4];
    assign p1_border    = (p1_threshold>=5) ? 1'b1 : 1'b0;
    assign p1_threshold = reg_phase_th[3:0];

    always @(posedge HCLK)
    begin
        if(state == S_IDLE)
            pix_in_cnt <= 1;
        else if(reg_IPU_in_wen)
        begin
            if(pix_in_cnt == 76800)
                pix_in_cnt <= pix_in_cnt;
            else
                pix_in_cnt <= pix_in_cnt + 1;
        end
        else
            pix_in_cnt <= pix_in_cnt;
    end

    always @(posedge HCLK)
    begin
        if(state == S_IDLE)
            squeeze <= 1'b0;
        else if(state == S_END)
            squeeze <= 1'b0;
        else if(pix_in_cnt == 76800)
            squeeze <= 1'b1;
    end

    always @(posedge HCLK)
    begin
        IPU_binarize_valid <= reg_IPU_in_wen;
    end

    assign s_processing = (state == S_PROCESSING) ? 1'b1 : 1'b0;

    always @(posedge HCLK)
    begin
        if(state == S_IDLE)
            s_binarize_finished <= 1'b0;
        else if(pix_in_cnt == 76800-1 && reg_IPU_in_wen == 1'b1)
            s_binarize_finished <= 1'b1;
    end

    always @(posedge HCLK)
    begin
        if(state == S_IDLE)
            s_p0_finished <= 1'b0;
        else if(IPU_phase0_last_pix)
            s_p0_finished <= 1'b1;
    end

    always @(posedge HCLK)
    begin
        if(state == S_IDLE)
            s_p1_finished <= 1'b0;
        else if(IPU_phase1_last_pix)
            s_p1_finished <= 1'b1;
    end

    always @(posedge HCLK)
    begin
        if(state == S_IDLE)
            s_resize_finished <= 1'b0;
        else if(IPU_resize_last_pix)
            s_resize_finished <= 1'b1;
    end

    assign s_output_finished = (state == S_END) ? 1'b1 : 1'b0;

    always @(*)
    begin
        case(mode)
            M_ORIGINAL:
            begin
                IPU_output_data  = rgb;
                IPU_output_valid = rgb_valid;
            end
            M_BINARIZE:
            begin
                IPU_output_data  = {12{IPU_binarize_output}};
                IPU_output_valid = IPU_binarize_valid;
            end
            M_PHASE0:
            begin
                IPU_output_data  = {12{IPU_phase0_output}};
                IPU_output_valid = IPU_phase0_valid;
            end
            M_PHASE1:
            begin
                IPU_output_data  = {12{IPU_phase1_output}};
                IPU_output_valid = IPU_phase1_valid;
            end
            M_RESIZE:
            begin
                IPU_output_data  = {12{IPU_resize_output}};
                IPU_output_valid = IPU_resize_valid;
            end
            default:
            begin
                IPU_output_data  = rgb;
                IPU_output_valid = rgb_valid;
            end
        endcase
    end

    IPU_top_cxy #(
        .rgb2h_filename(RGB2H_FILENAME ),
        .rgb2s_filename(RGB2S_FILENAME ),
        .P_WIDTH       (320            ),
        .P_HEIGHT      (240            )
    )
    u_IPU_top_cxy (
        .CLK                    (HCLK),
        .RSTn                   (~IPU_reset),
        .RGB_VALID              (rgb_valid),
        .RGB                    (rgb),

        .H_MAX                  (reg_h[17:9]),
        .H_MIN                  (reg_h[8:0]),
        .S_MAX                  (reg_s[13:7]),
        .S_MIN                  (reg_s[6:0]),
        .V_MAX                  (reg_v[11:6]),
        .V_MIN                  (reg_v[5:0]),

        .SQUEEZE                (squeeze),

        .P0_BORDER              (p0_border),
        .P0_THRESHOLD           (p0_threshold),

        .P1_BORDER              (p1_border),
        .P1_THRESHOLD           (p1_threshold),

        .RESIZE_THRESHOLD       (reg_resize_th[3:0]),

        .binarization           (IPU_binarize_output),

        .phase0_out             (IPU_phase0_output),
        .phase0_valid           (IPU_phase0_valid),
        .phase0_last_in_line    (IPU_phase0_last_in_line),
        .phase0_last_pix        (IPU_phase0_last_pix),

        .phase1_out             (IPU_phase1_output),
        .phase1_valid           (IPU_phase1_valid),
        .phase1_last_in_line    (IPU_phase1_last_in_line),
        .phase1_last_pix        (IPU_phase1_last_pix),

        .resize_out             (IPU_resize_output),
        .resize_valid           (IPU_resize_valid),
        .resize_r_last_in_line  (IPU_resize_last_in_line),
        .resize_r_last_pix      (IPU_resize_last_pix),
        .resize_f_last_in_line  (),
        .resize_f_last_pix      (),

        .SQUEEZE_OUT            (SQUEEZE_OUT),
        .NEXT_LAST_PIX          (NEXT_LAST_PIX),

        .centroid_h             (IPU_centroid_h),
        .centroid_v             (IPU_centroid_v),
        .centroid_sum           (IPU_centroid_sum),
        .centroid_valid         (IPU_centroid_valid)
    );

    assign RESIZE_OUT   = IPU_resize_output;
    assign RESIZE_VALID = IPU_resize_valid;

    //---------------------------------------
    // 7 Seg Disp

    seg_scan_decode u_seg_scan_decode (
        .CLK50M             (HCLK),
        .RSTn               (HRESETn),
        .seg_data_0         (reg_7seg_display[31:28]),
        .seg_data_1         (reg_7seg_display[27:24]),
        .seg_data_2         (reg_7seg_display[23:20]),
        .seg_data_3         (reg_7seg_display[19:16]),
        .seg_data_4         (reg_7seg_display[15:12]),
        .seg_data_5         (reg_7seg_display[11: 8]),
        .seg_data_6         (reg_7seg_display[ 7: 4]),
        .seg_data_7         (reg_7seg_display[ 3: 0]),

        .seg_select         (SEG_SELECT),
        .seg_data_out0      (SEG_DATA_OUT_0),
        .seg_data_out1      (SEG_DATA_OUT_1)
    );

endmodule
