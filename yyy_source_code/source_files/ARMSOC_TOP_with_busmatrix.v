// Comment this out for EGO1
`define FOR_NEXYS_A7    1

`define ROM_FILENAME    "F:/Prj2020/C/init_code/code.txt"
`define RGB2H_FILENAME  "F:/hsv_h.txt"
`define RGB2S_FILENAME  "F:/hsv_s.txt"

module ARMSOC_TOP_with_busmatrix (
    input  wire          SYS_CLK100M,              // Oscillator
    input  wire          SYS_RESETn,               // Reset_n cable
    input  wire          RESETn_BUTTON,            // Reset# button

    // TEST_LED
    output wire          TEST_LED,

    // GPIO
    inout  wire   [15:0] GPIO,

    // VGA
    input                VGA_RST,
    output               VGA_HSYNC,
    output               VGA_VSYNC,
    output        [3:0]  VGA_R,
    output        [3:0]  VGA_G,
    output        [3:0]  VGA_B,

    // DCMI
    input                PCLK,
    input                CAM_HREF,
    input                CAM_VSYNC,
    input         [7:0]  CAM_D,

    // 7 Seg Disp
`ifdef FOR_NEXYS_A7
    output        [7:0]  SEG_SELECT,
    output        [7:0]  SEG_DATA_OUT,
`else
    output        [7:0]  SEG_SELECT,
    output        [7:0]  SEG_DATA_OUT_0,
    output        [7:0]  SEG_DATA_OUT_1,
`endif

    // SPI SD Card
    output               SD_nCS,
    output               SD_DCLK,
    output               SD_MOSI,
    input                SD_MISO,

    // UART
    input  wire          UART0_RXD,
    output wire          UART0_TXD,
    input  wire          UART1_RXD,
    output wire          UART1_TXD,

    // CAM I2C
    output wire          SCL,
    inout  wire          SDA,
    output wire          XCLK,

    // Debug
    input  wire          TDI,                  // JTAG TDI
    input  wire          TCK,                  // SWD Clk / JTAG TCK
    inout  wire          TMS,                  // SWD I/O / JTAG TMS
    output wire          TDO                   // SWV     / JTAG TDO
    );

    /////////////////////////////////////////////////////////////////////////////
    // Test Led
    /////////////////////////////////////////////////////////////////////////////

    // Always toggling to show the SYS_CLK100M is working

    reg     [25:0]  test_led_cnt = 0;

    always @(posedge SYS_CLK100M) begin
        if(~RESETn_BUTTON)
        begin
            test_led_cnt <= 0;
        end
        else if(test_led_cnt == 26'd49_999_999)
        begin
            test_led_cnt <= 0;
        end
        else
        begin
            test_led_cnt <= test_led_cnt + 1;
        end
    end

    assign TEST_LED = (test_led_cnt<26'd24_999_999) ? 1 : 0;

    /////////////////////////////////////////////////////////////////////////////
    // Clock and Reset
    /////////////////////////////////////////////////////////////////////////////

    // Clock divider, divide the frequency by 2 for M3, hence less time constraint

    // wire            clk_wiz_100m;
    // wire            clk_wiz_50m;
    // wire            clk_wiz_25m;
    reg     [1:0]   clk_div_cnt = 2'd0;
    wire            sys_clk100m;
    wire            sys_clk50m;
    wire            sys_clk25m;

    wire            fclk;               // Free running clock
    wire            reset_n_input;      // DAPLink & User reset_n

    // System level reset
    wire            lockup;             // Lockup signal from CPU
    wire            sys_reset_req;      // System reset request from CPU or debug host
    reg             reg_sys_rst_n;
    reg     [2:0]   sys_reset_cnt;      // Reset M3 for more than 3 FCLK periods

    wire            pclk_buf;

    // clk_wiz_0 u_clk_wiz (
    //     .clk_out1   (clk_wiz_100m),
    //     .clk_out2   (clk_wiz_50m ),
    //     .clk_out3   (clk_wiz_25m ),

    //     .clk_in1    (SYS_CLK100M)
    // );

    always @(posedge SYS_CLK100M) begin
        clk_div_cnt <= clk_div_cnt + 2'd1;
    end

    BUFG BUFG100m (
        .O(sys_clk100m),
        // .I(clk_wiz_100m)
        .I(SYS_CLK100M)
    );

    BUFG BUFG50m (
        .O(sys_clk50m),
        // .I(clk_wiz_50m)
        .I(clk_div_cnt[0])
    );

    BUFG BUFG25m (
        .O(sys_clk25m),
        // .I(clk_wiz_25m)
        .I(clk_div_cnt[1])
    );

    assign fclk = sys_clk50m;
    assign reset_n_input = SYS_RESETn & RESETn_BUTTON;

    always @(posedge fclk or negedge reset_n_input) begin
        if(~reset_n_input)
        begin
            sys_reset_cnt <= 3'd0;
            reg_sys_rst_n <= 1'b0;
        end
        else if(sys_reset_req | lockup)
        begin
            sys_reset_cnt <= 3'd0;
            reg_sys_rst_n <= 1'b0;
        end
        else if(sys_reset_cnt == 3'd7)
        begin
            sys_reset_cnt <= sys_reset_cnt;
            reg_sys_rst_n <= 1'b1;
        end
        else
        begin
            sys_reset_cnt <= sys_reset_cnt + 1;
            reg_sys_rst_n <= reg_sys_rst_n;
        end
    end

    BUFG sys_reset_n_BUFG (
            .O(sys_reset_n_buf),
            .I(reg_sys_rst_n)
        );

    BUFG pclk_BUFG (
        .O(pclk_buf),
        .I(PCLK)
    );

    /////////////////////////////////////////////////////////////////////////////
    // Connect Code Bus to ROM
    /////////////////////////////////////////////////////////////////////////////

    // CPU I-Code bus
    wire   [31:0] haddri;
    wire    [1:0] htransi;
    wire    [2:0] hsizei;
    wire    [2:0] hbursti;
    wire    [3:0] hproti;
    wire    [1:0] memattri;
    wire   [31:0] hrdatai;
    wire          hreadyi;
    wire    [1:0] hrespi = 2'b00;      // System generates no error response;

    // CPU D-Code bus
    wire   [31:0] haddrd;
    wire    [1:0] htransd;
    wire    [1:0] hmasterd;
    wire    [2:0] hsized;
    wire    [2:0] hburstd;
    wire    [3:0] hprotd;
    wire    [1:0] memattrd;
    wire   [31:0] hwdatad;
    wire          hwrited;
    wire          exreqd;
    wire   [31:0] hrdatad;
    wire          hreadyd;
    wire    [1:0] hrespd = 2'b00;      // System generates no error response;
    wire          exrespd = 1'b0;

    // Code bus mux
    wire   [31:0] haddrc     = htransd[1] ? haddrd  : haddri;
    wire    [2:0] hburstc    = htransd[1] ? hburstd : hbursti;
    wire          hmastlockc = 1'b0;
    wire    [3:0] hprotc     = htransd[1] ? hprotd  : hproti;
    wire    [2:0] hsizec     = htransd[1] ? hsized  : hsizei;
    wire    [1:0] htransc    = htransd[1] ? htransd : htransi;
    wire   [31:0] hwdatac    = hwdatad;
    wire          hwritec    = htransd[1] ? hwrited : 1'b0;
    wire   [31:0] hrdatac; 
    wire          hreadyc; 
    assign        hreadyi    = hreadyc;
    assign        hreadyd    = hreadyc;
    assign        hrdatai    = hrdatac;
    assign        hrdatad    = hrdatac;

    // CPU System bus
    wire   [31:0] haddrs;
    wire    [2:0] hbursts;
    wire          hmastlocks;
    wire    [3:0] hprots;
    wire    [2:0] hsizes;
    wire    [1:0] htranss;
    wire   [31:0] hwdatas;
    wire          hwrites;
    wire    [1:0] hresps;               // System generates no error response
    wire          exresps = 1'b0;
    
    wire   [31:0] hrdatas;
    wire          hreadys;
    AHB2MEM #(
        .MEMWIDTH   (15),
        .INIT       (1),
        .FILENAME   (`ROM_FILENAME)
    )
    uAHB2ROM (
        .HSEL          (1'b1),
        .HCLK          (fclk), 
        .HRESETn       (sys_reset_n_buf), 
        .HREADY        (hreadyc),     
        .HADDR         (haddrc),
        .HTRANS        (htransc), 
        .HWRITE        (hwritec),
        .HSIZE         (hsizec),
        .HWDATA        (hwdatac), 
        .HRDATA        (hrdatac), 
        .HREADYOUT     (hreadyc)
    );

    /////////////////////////////////////////////////////////////////////////////
    // AHB System Bus Connections
    /////////////////////////////////////////////////////////////////////////////

    //---------------------------------------
    // AHB RAM

    // from AHB Bus Matrix
    wire            RAM_hsel;
    wire    [31:0]  RAM_haddr;
    wire    [1:0]   RAM_htrans;
    wire            RAM_hwrite;
    wire    [2:0]   RAM_hsize;
    wire    [2:0]   RAM_hburst;
    wire    [3:0]   RAM_hprot;
    wire    [3:0]   RAM_hmaster;
    wire    [31:0]  RAM_hwdata;
    wire            RAM_hmastlock;
    wire            RAM_hready;

    // to AHB Bus Matrix
    wire    [31:0]  RAM_hrdata;
    wire            RAM_hreadyout;

    // AHB-Lite RAM
    AHB2MEM #(
        .MEMWIDTH   (15),
        .INIT       (0)
    ) 
    uAHB2RAM (
        .HSEL          (RAM_hsel),
        .HCLK          (fclk), 
        .HRESETn       (sys_reset_n_buf), 
        .HREADY        (RAM_hready),
        .HADDR         (RAM_haddr),
        .HTRANS        (RAM_htrans),
        .HWRITE        (RAM_hwrite),
        .HSIZE         (RAM_hsize),
        .HWDATA        (RAM_hwdata),

        .HRDATA        (RAM_hrdata),
        .HREADYOUT     (RAM_hreadyout)
    );

    //---------------------------------------
    // AHB GPIO

    // from AHB Bus Matrix
    wire            GPIO_hsel;
    wire    [31:0]  GPIO_haddr;
    wire    [1:0]   GPIO_htrans;
    wire            GPIO_hwrite;
    wire    [2:0]   GPIO_hsize;
    wire    [2:0]   GPIO_hburst;
    wire    [3:0]   GPIO_hprot;
    wire    [3:0]   GPIO_hmaster;
    wire    [31:0]  GPIO_hwdata;
    wire            GPIO_hmastlock;
    wire            GPIO_hready;

    // to AHB Bus Matrix
    wire    [31:0]  GPIO_hrdata;
    wire            GPIO_hreadyout;

    // Functional Signals
    wire    [15:0]  GPIO_input = GPIO;
    wire    [15:0]  GPIO_output;
    wire    [15:0]  GPIO_outen;
    wire    [15:0]  GPIO_int;
    wire            GPIO_combint;

    generate
        genvar gpio_i;
        for (gpio_i = 0; gpio_i < 16; gpio_i = gpio_i + 1)
        begin: gpio_tri
            assign GPIO[gpio_i] = GPIO_outen[gpio_i] ? GPIO_output[gpio_i] : 1'bz;
        end
    endgenerate

    cmsdk_ahb_gpio #(
        .ALTERNATE_FUNC_MASK(16'h0000)
    )
    u_cmsdk_ahb_gpio (
        // AHB Inputs
        .HCLK       (fclk),             // system bus clock
        .HRESETn    (sys_reset_n_buf),  // system bus reset
        .FCLK       (fclk),             // system bus clock

        .HSEL       (GPIO_hsel),        // AHB peripheral select
        .HREADY     (GPIO_hready),      // AHB ready input
        .HTRANS     (GPIO_htrans),      // AHB transfer type
        .HSIZE      (GPIO_hsize),       // AHB hsize
        .HWRITE     (GPIO_hwrite),      // AHB hwrite
        .HADDR      (GPIO_haddr[11:0]), // AHB address bus
        .HWDATA     (GPIO_hwdata),      // AHB write data bus

        .ECOREVNUM  (4'b0000),          // Engineering-change-order revision bits

        .PORTIN     (GPIO_input),       // GPIO Interface input

        // AHB Outputs
        .HREADYOUT  (GPIO_hreadyout),   // AHB ready output to S->M mux
        .HRESP      (),                 // AHB response
        .HRDATA     (GPIO_hrdata),

        .PORTOUT    (GPIO_output),      // GPIO output
        .PORTEN     (GPIO_outen),       // GPIO output enable
        .PORTFUNC   (),                 // Alternate function control

        .GPIOINT    (GPIO_int),         // Interrupt output for each pin
        .COMBINT    (GPIO_combint)      // Combined interrupt
    );

    //---------------------------------------
    // AHB VGA

    // from AHB Bus Matrix
    wire            VGA_hsel;
    wire    [31:0]  VGA_haddr;
    wire    [1:0]   VGA_htrans;
    wire            VGA_hwrite;
    wire    [2:0]   VGA_hsize;
    wire    [2:0]   VGA_hburst;
    wire    [3:0]   VGA_hprot;
    wire    [3:0]   VGA_hmaster;
    wire    [31:0]  VGA_hwdata;
    wire            VGA_hmastlock;
    wire            VGA_hready;

    wire            VGA_CAM_hsel;
    wire    [31:0]  VGA_CAM_haddr;
    wire    [1:0]   VGA_CAM_htrans;
    wire            VGA_CAM_hwrite;
    wire    [2:0]   VGA_CAM_hsize;
    wire    [2:0]   VGA_CAM_hburst;
    wire    [3:0]   VGA_CAM_hprot;
    wire    [3:0]   VGA_CAM_hmaster;
    wire    [31:0]  VGA_CAM_hwdata;
    wire            VGA_CAM_hmastlock;
    wire            VGA_CAM_hready;

    // to AHB Bus Matrix
    wire    [31:0]  VGA_hrdata;
    wire            VGA_hreadyout;

    wire    [31:0]  VGA_CAM_hrdata;
    wire            VGA_CAM_hreadyout;

    // Functional Signals

    VGA_ahb_top u_VGA_ahb_top (
        .HCLK               (fclk),
        .HRESET             (VGA_RST),
        .HSEL               (VGA_hsel),
        .HREADY             (VGA_hready),
        .HTRANS             (VGA_htrans),
        .HWRITE             (VGA_hwrite),
        .HADDR              (VGA_haddr),
        .HWDATA             (VGA_hwdata),
        .HREADYOUT          (VGA_hreadyout),
        .HRDATA             (VGA_hrdata),

        .VGA_CAM_HCLK       (fclk),
        .VGA_CAM_HRESET     (VGA_RST),
        .VGA_CAM_HSEL       (VGA_CAM_hsel),
        .VGA_CAM_HREADY     (VGA_CAM_hready),
        .VGA_CAM_HTRANS     (VGA_CAM_htrans),
        .VGA_CAM_HWRITE     (VGA_CAM_hwrite),
        .VGA_CAM_HADDR      (VGA_CAM_haddr),
        .VGA_CAM_HWDATA     (VGA_CAM_hwdata),
        .VGA_CAM_HREADYOUT  (VGA_CAM_hreadyout),
        .VGA_CAM_HRDATA     (VGA_CAM_hrdata),

        .CLK_25M            (sys_clk25m),
        .HSYNC              (VGA_HSYNC),
        .VSYNC              (VGA_VSYNC),
        .VGA_R              (VGA_R),
        .VGA_G              (VGA_G),
        .VGA_B              (VGA_B)
    );

    //---------------------------------------
    // AHB DCMI

    // from AHB Bus Matrix
    wire            DCMI_hsel;
    wire    [31:0]  DCMI_haddr;
    wire    [1:0]   DCMI_htrans;
    wire            DCMI_hwrite;
    wire    [2:0]   DCMI_hsize;
    wire    [2:0]   DCMI_hburst;
    wire    [3:0]   DCMI_hprot;
    wire    [3:0]   DCMI_hmaster;
    wire    [31:0]  DCMI_hwdata;
    wire            DCMI_hmastlock;
    wire            DCMI_hready;

    // to AHB Bus Matrix
    wire    [31:0]  DCMI_hrdata;
    wire            DCMI_hreadyout;

    // Functional Signals
    wire            DCMI_int;

    AHB_DCMI u_AHB_DCMI (
        .HCLK       (fclk),
        .HRESETn    (sys_reset_n_buf),
        .HSEL       (DCMI_hsel),
        .HREADY     (DCMI_hready),
        .HTRANS     (DCMI_htrans),
        .HWRITE     (DCMI_hwrite),
        .HADDR      (DCMI_haddr),
        .HWDATA     (DCMI_hwdata),
        .HREADYOUT  (DCMI_hreadyout),
        .HRDATA     (DCMI_hrdata),

        .PCLK       (pclk_buf),
        .CAM_HREF   (CAM_HREF),
        .CAM_VSYNC  (CAM_VSYNC),
        .CAM_D      (CAM_D),
        .INT        (DCMI_int)
    );

    //------------------------------------------
    // AHB IPU
    
    // AHB Slave
    // from AHB Bus Matrix
    wire    [31:0]  IPU_haddrm;
    wire    [1:0]   IPU_htransm;
    wire            IPU_hwritem;
    wire    [2:0]   IPU_hsizem;
    wire    [2:0]   IPU_hburstm;
    wire    [3:0]   IPU_hprotm;
    wire    [3:0]   IPU_hmasterm;
    wire    [31:0]  IPU_hwdatam;
    wire            IPU_hmastlockm;
    wire            IPU_hreadym;

    // to AHB Bus Matrix
    wire    [31:0]  IPU_hrdatam;
    wire            IPU_hreadyoutm;

    //AHB Master
    // from AHB Bus Matrix
    wire            IPU_hsels;
    wire    [31:0]  IPU_haddrs;
    wire    [1:0]   IPU_htranss;
    wire            IPU_hwrites;
    wire            IPU_hreadys;
    wire    [31:0]  IPU_hwdatas;

    // to AHB Bus Matrix
    wire    [31:0]  IPU_hrdatas;
    wire            IPU_hreadyouts;

    // Functional Signals
    wire            IPU_resize_out;
    wire            IPU_resize_valid;
    wire            IPU_squeeze_out;
    wire            IPU_next_last_pix;

`ifdef FOR_NEXYS_A7
    wire    [7:0]   seg_select_out;
    wire    [7:0]   seg_data_out;

    assign SEG_SELECT = ~seg_select_out;
    assign SEG_DATA_OUT = ~seg_data_out;
`endif

    IPU_for_M3_cxy #(
        .RGB2H_FILENAME(`RGB2H_FILENAME),
        .RGB2S_FILENAME(`RGB2S_FILENAME)
    )
    u_IPU_for_M3 (
        .HCLK           (fclk),
        .HRESETn        (sys_reset_n_buf),
        .HREADYM        (IPU_hreadym),
        .HSELM          (IPU_hselm),
        .HTRANSM        (IPU_htransm),
        .HWRITEM        (IPU_hwritem),
        .HADDRM         (IPU_haddrm),
        .HWDATAM        (IPU_hwdatam),

        .HREADYOUTM     (IPU_hreadyoutm),
        .HRDATAM        (IPU_hrdatam),

        .HWRITES        (IPU_hwrites),
        .HADDRS         (IPU_haddrs),
        .HTRANSS        (IPU_htranss),
        .HWDATAS        (IPU_hwdatas),
        .HREADYS        (IPU_hreadys),

        .HREADYOUTS     (IPU_hreadyouts),
        .HRDATAS        (IPU_hrdatas),

        .RESIZE_OUT     (IPU_resize_out),
        .RESIZE_VALID   (IPU_resize_valid),
        .SQUEEZE_OUT    (IPU_squeeze_out),
        .NEXT_LAST_PIX  (IPU_next_last_pix),

`ifdef FOR_NEXYS_A7
        .SEG_SELECT     (seg_select_out),
        .SEG_DATA_OUT_0 (seg_data_out),
        .SEG_DATA_OUT_1 ()
`else
        .SEG_SELECT     (SEG_SELECT),
        .SEG_DATA_OUT_0 (SEG_DATA_OUT_0),
        .SEG_DATA_OUT_1 (SEG_DATA_OUT_1)
`endif
    );

    //------------------------------------------
    // AHB CNN

    // from AHB Bus Matrix
    wire            CNN_hsel;
    wire    [31:0]  CNN_haddr;
    wire    [1:0]   CNN_htrans;
    wire            CNN_hwrite;
    wire    [2:0]   CNN_hsize;
    wire    [2:0]   CNN_hburst;
    wire    [3:0]   CNN_hprot;
    wire    [3:0]   CNN_hmaster;
    wire    [31:0]  CNN_hwdata;
    wire            CNN_hmastlock;
    wire            CNN_hready;

    // to AHB Bus Matrix
    wire    [31:0]  CNN_hrdata;
    wire            CNN_hreadyout;

    CNN_for_M3_cxy u_CNN_for_M3_cxy (
        // AHB inputs Slave
        .HCLK               (fclk),
        .HRESETn            (sys_reset_n_buf),
        .HREADY             (CNN_hready),
        .HSEL               (CNN_hsel),
        .HTRANS             (CNN_htrans),
        .HWRITE             (CNN_hwrite),
        .HADDR              (CNN_haddr),
        .HWDATA             (CNN_hwdata),

        // AHB outputs Slave
        .HREADYOUT          (CNN_hreadyout),
        .HRDATA             (CNN_hrdata),

        // from IPU
        .DIN                (IPU_resize_out),
        .DIN_VALID          (IPU_resize_valid),
        .SQUEEZE            (IPU_squeeze_out),
        .CONV_1_LAST_PIX    (IPU_next_last_pix)
    );

    //------------------------------------------
    // AHB SD Card interface

    // from AHB Bus Matrix
    wire            SD_Card_hsel;
    wire    [31:0]  SD_Card_haddr;
    wire    [1:0]   SD_Card_htrans;
    wire            SD_Card_hwrite;
    wire    [2:0]   SD_Card_hsize;
    wire    [2:0]   SD_Card_hburst;
    wire    [3:0]   SD_Card_hprot;
    wire    [3:0]   SD_Card_hmaster;
    wire    [31:0]  SD_Card_hwdata;
    wire            SD_Card_hmastlock;
    wire            SD_Card_hready;

    // to AHB Bus Matrix
    wire    [31:0]  SD_Card_hrdata;
    wire            SD_Card_hreadyout;

    SD_card_interface_cxy u_SD_card_interface_cxy (
        // AHB inputs
        .HCLK           (fclk),
        .HRESETn        (sys_reset_n_buf),
        .HSEL           (SD_Card_hsel),
        .HREADY         (SD_Card_hready),
        .HTRANS         (SD_Card_htrans),
        .HSIZE          (SD_Card_hsize),
        .HWRITE         (SD_Card_hwrite),
        .HADDR          (SD_Card_haddr),
        .HWDATA         (SD_Card_hwdata),

        // AHB outputs
        .HREADYOUT      (SD_Card_hreadyout),
        .HRDATA         (SD_Card_hrdata),

        // SPI SD interface
        .SD_nCS         (SD_nCS ),
        .SD_DCLK        (SD_DCLK),
        .SD_MOSI        (SD_MOSI),
        .SD_MISO        (SD_MISO)
    );

    /////////////////////////////////////////////////////////////////////////////
    // APB Bus Connections
    /////////////////////////////////////////////////////////////////////////////

    // from AHB Bus Matrix
    wire            AHB_to_APB_hsel;
    wire    [31:0]  AHB_to_APB_haddr;
    wire    [1:0]   AHB_to_APB_htrans;
    wire            AHB_to_APB_hwrite;
    wire    [2:0]   AHB_to_APB_hsize;
    wire    [2:0]   AHB_to_APB_hburst;
    wire    [3:0]   AHB_to_APB_hprot;
    wire    [3:0]   AHB_to_APB_hmaster;
    wire    [31:0]  AHB_to_APB_hwdata;
    wire            AHB_to_APB_hmastlock;
    wire            AHB_to_APB_hready;

    // to AHB Bus Matrix
    wire    [31:0]  AHB_to_APB_hrdata;
    wire            AHB_to_APB_hreadyout;

    // APB Bridge Signals
    reg             AHB_to_APB_pclken;

    // to APB bus
    wire    [15:0]  AHB_to_APB_paddr;
    wire            AHB_to_APB_pwrite;
    wire    [31:0]  AHB_to_APB_pwdata;
    wire            AHB_to_APB_psel;
    wire            AHB_to_APB_penable;

    wire            AHB_to_APB_apbactive;

    // to APB Mux
    wire    [31:0]  AHB_to_APB_prdata;
    wire            AHB_to_APB_pready;
    wire            AHB_to_APB_pslverr;

    //---------------------------------------
    // APB CLK

    reg     [2:0]  pclken_cnt;
    reg            pclkg;

    always @(posedge fclk) begin
        if(~AHB_to_APB_apbactive)
            pclken_cnt <= 3'd0;
        else
            pclken_cnt <= pclken_cnt + 3'd1;
    end

    always @(negedge fclk) begin
        if(~AHB_to_APB_apbactive)
            AHB_to_APB_pclken <= 1'b0;
        else
            AHB_to_APB_pclken <= (pclken_cnt == 3'd0) ? 1'b1 : 1'b0;
    end

    always @(posedge fclk) begin
        if(AHB_to_APB_pclken)
            pclkg <= 1'b1;
        else
            pclkg <= 1'b0;
    end

    //---------------------------------------
    // APB MEM

    wire           APB_MEM_cs;
    reg            APB_MEM_cs_latch;
    wire    [31:0] APB_MEM_prdata;
    wire           APB_MEM_preadyout = 1'b1;
    wire           APB_MEM_pslverr = 1'b0;

    APB2MEM u_APB2MEM (
        .CLK        (fclk),
        .PCLKEN     (AHB_to_APB_pclken),
        .PADDR      (AHB_to_APB_paddr[11:0]),
        .PWDATA     (AHB_to_APB_pwdata),
        .PWRITE     (AHB_to_APB_pwrite),
        .PENABLE    (AHB_to_APB_penable),
        .PSEL       (APB_MEM_cs_latch),
        .PRDATA     (APB_MEM_prdata)
    );

    always @( * ) begin
        if(APB_MEM_cs)
            APB_MEM_cs_latch = 1'b1;
        else if(AHB_to_APB_hready)
            APB_MEM_cs_latch = 1'b0;
        else
            APB_MEM_cs_latch = APB_MEM_cs_latch;
    end

    //---------------------------------------
    // APB TIMER

    wire           APB_TIMER1_cs;
    reg            APB_TIMER1_cs_latch;
    wire    [31:0] APB_TIMER1_prdata;
    wire           APB_TIMER1_preadyout;
    wire           APB_TIMER1_pslverr;

    wire           APB_TIMER1_timer1int;

    cmsdk_apb_timer u_cmsdk_apb_timer1 (
        .PCLK           (fclk),                     // PCLK for timer operation
        .PCLKG          (pclkg),                    // Gated clock
        .PRESETn        (sys_reset_n_buf),            // Reset

        .PSEL           (APB_TIMER1_cs_latch),            // Device select
        .PADDR          (AHB_to_APB_paddr[11:2]),   // Address
        .PENABLE        (AHB_to_APB_penable),       // Transfer control
        .PWRITE         (AHB_to_APB_pwrite),        // Write control
        .PWDATA         (AHB_to_APB_pwdata),        // Write data

        .ECOREVNUM      (4'b0000),                  // Engineering-change-order revision bits

        .PRDATA         (APB_TIMER1_prdata),        // Read data
        .PREADY         (APB_TIMER1_preadyout),     // Device ready
        .PSLVERR        (APB_TIMER1_pslverr),       // Device error response

        .EXTIN          (1'b0),                         // Extenal input

        .TIMERINT       (APB_TIMER1_timer1int)      // Timer interrupt output
    );

    always @( * ) begin
        if(APB_TIMER1_cs)
            APB_TIMER1_cs_latch = 1'b1;
        else if(AHB_to_APB_hready)
            APB_TIMER1_cs_latch = 1'b0;
        else
            APB_TIMER1_cs_latch = APB_TIMER1_cs_latch;
    end

    //---------------------------------------
    // APB UART 0

    wire           APB_UART0_rxd;
    wire           APB_UART0_txd;
    wire           APB_UART0_txen;
    wire           APB_UART0_baudtic;
    wire           APB_UART0_txint;
    wire           APB_UART0_rxint;
    wire           APB_UART0_txovrint;
    wire           APB_UART0_rxovrint;
    wire           APB_UART0_uartint;

    wire           APB_UART0_cs;
    reg            APB_UART0_cs_latch;
    wire    [31:0] APB_UART0_prdata;
    wire           APB_UART0_preadyout;
    wire           APB_UART0_pslverr;

    assign APB_UART0_rxd = UART0_RXD;
    assign UART0_TXD = APB_UART0_txd;

    cmsdk_apb_uart u_cmsdk_apb_uart0 (
        .PCLK       (fclk),                     // Clock
        .PCLKG      (pclkg),                    // Gated Clock
        .PRESETn    (sys_reset_n_buf),          // Reset

        .PSEL       (APB_UART0_cs_latch),       // Device select
        .PADDR      (AHB_to_APB_paddr[11:2]),   // Address
        .PENABLE    (AHB_to_APB_penable),       // Transfer control
        .PWRITE     (AHB_to_APB_pwrite),        // Write control
        .PWDATA     (AHB_to_APB_pwdata),        // Write data

        .ECOREVNUM  (4'b0000),                  // Engineering-change-order revision bits

        .PRDATA     (APB_UART0_prdata),         // Read data
        .PREADY     (APB_UART0_preadyout),      // Device ready
        .PSLVERR    (APB_UART0_pslverr),        // Device error response

        .RXD        (APB_UART0_rxd),            // Serial input
        .TXD        (APB_UART0_txd),            // Transmit data output
        .TXEN       (APB_UART0_txen),           // Transmit enabled
        .BAUDTICK   (APB_UART0_baudtic),        // Baud rate (x16) Tick

        .TXINT      (APB_UART0_txint),          // Transmit Interrupt
        .RXINT      (APB_UART0_rxint),          // Receive Interrupt
        .TXOVRINT   (APB_UART0_txovrint),       // Transmit overrun Interrupt
        .RXOVRINT   (APB_UART0_rxovrint),       // Receive overrun Interrupt
        .UARTINT    (APB_UART0_uartint)         // Combined interrupt
    );

    always @( * ) begin
        if(APB_UART0_cs)
            APB_UART0_cs_latch = 1'b1;
        else if(AHB_to_APB_hready)
            APB_UART0_cs_latch = 1'b0;
        else
            APB_UART0_cs_latch = APB_UART0_cs_latch;
    end

    //---------------------------------------
    // APB UART 1

    wire           APB_UART1_rxd;
    wire           APB_UART1_txd;
    wire           APB_UART1_txen;
    wire           APB_UART1_baudtic;
    wire           APB_UART1_txint;
    wire           APB_UART1_rxint;
    wire           APB_UART1_txovrint;
    wire           APB_UART1_rxovrint;
    wire           APB_UART1_uartint;

    wire           APB_UART1_cs;
    reg            APB_UART1_cs_latch;
    wire    [31:0] APB_UART1_prdata;
    wire           APB_UART1_preadyout;
    wire           APB_UART1_pslverr;

    assign APB_UART1_rxd = UART1_RXD;
    assign UART1_TXD = APB_UART1_txd;

    cmsdk_apb_uart u_cmsdk_apb_uart1 (
        .PCLK       (fclk),                     // Clock
        .PCLKG      (pclkg),                    // Gated Clock
        .PRESETn    (sys_reset_n_buf),          // Reset

        .PSEL       (APB_UART1_cs_latch),       // Device select
        .PADDR      (AHB_to_APB_paddr[11:2]),   // Address
        .PENABLE    (AHB_to_APB_penable),       // Transfer control
        .PWRITE     (AHB_to_APB_pwrite),        // Write control
        .PWDATA     (AHB_to_APB_pwdata),        // Write data

        .ECOREVNUM  (4'b0000),                  // Engineering-change-order revision bits

        .PRDATA     (APB_UART1_prdata),         // Read data
        .PREADY     (APB_UART1_preadyout),      // Device ready
        .PSLVERR    (APB_UART1_pslverr),        // Device error response

        .RXD        (APB_UART1_rxd),            // Serial input
        .TXD        (APB_UART1_txd),            // Transmit data output
        .TXEN       (APB_UART1_txen),           // Transmit enabled
        .BAUDTICK   (APB_UART1_baudtic),        // Baud rate (x16) Tick

        .TXINT      (APB_UART1_txint),          // Transmit Interrupt
        .RXINT      (APB_UART1_rxint),          // Receive Interrupt
        .TXOVRINT   (APB_UART1_txovrint),       // Transmit overrun Interrupt
        .RXOVRINT   (APB_UART1_rxovrint),       // Receive overrun Interrupt
        .UARTINT    (APB_UART1_uartint)         // Combined interrupt
    );

    always @( * ) begin
        if(APB_UART1_cs)
            APB_UART1_cs_latch = 1'b1;
        else if(AHB_to_APB_hready)
            APB_UART1_cs_latch = 1'b0;
        else
            APB_UART1_cs_latch = APB_UART1_cs_latch;
    end

    //---------------------------------------
    // APB CAM

    wire           APB_CAM_cs;
    reg            APB_CAM_cs_latch;
    wire    [31:0] APB_CAM_prdata;
    wire           APB_CAM_preadyout = 1'b1;
    wire           APB_CAM_pslverr = 1'b0;

    camera_driver u_camera_driver (
        .CLK        (fclk),                     //系统时钟
        .RESETn     (sys_reset_n_buf),            //系统复位
        .PCLKEN     (AHB_to_APB_pclken),        //apb总线时钟
        .PADDR      (AHB_to_APB_paddr[11:0]),   //apb地址总线 
        .PWRITE     (AHB_to_APB_pwrite),        //apb写控制信号
        .PSEL       (APB_CAM_cs_latch),         //apb片选信号
        .PENABLE    (AHB_to_APB_penable),       //apb读使能信号
        .PWDATA     (AHB_to_APB_pwdata),        //apb数据总线
        .PRDATA     (APB_CAM_prdata),           //apb数据总线
        .SCL        (SCL),                      //I2C总线时钟
        .SDA        (SDA)                       //I2C串行数据线
    );

    always @( * ) begin
        if(APB_CAM_cs)
            APB_CAM_cs_latch = 1'b1;
        else if(AHB_to_APB_hready)
            APB_CAM_cs_latch = 1'b0;
        else
            APB_CAM_cs_latch = APB_CAM_cs_latch;
    end

    assign XCLK = sys_clk25m;

    //---------------------------------------
    // DMAC CXY

    wire            APB_DMAC_cxy_cs;
    reg             APB_DMAC_cxy_cs_latch;
    wire    [31:0]  APB_DMAC_cxy_prdata;
    wire            APB_DMAC_cxy_preadyout = 1'b1;
    wire            APB_DMAC_cxy_pslverr = 1'b0;

    wire    [31:0]  haddr_dma_cxy_r;
    wire    [2:0]   hburst_dma_cxy_r;
    wire    [2:0]   hsize_dma_cxy_r;
    wire    [1:0]   htrans_dma_cxy_r;
    wire            hreadyout_dma_cxy_r;
    wire    [31:0]  hrdata_dma_cxy_r;
    wire            hready_dma_cxy_r;

    wire    [31:0]  haddr_dma_cxy_w;
    wire    [2:0]   hburst_dma_cxy_w;
    wire    [2:0]   hsize_dma_cxy_w;
    wire    [1:0]   htrans_dma_cxy_w;
    wire            hreadyout_dma_cxy_w;
    wire            hwrite_dma_cxy_w;
    wire    [31:0]  hwdata_dma_cxy_w;
    wire            hready_dma_cxy_w;

    wire            DMA_cxy_int;

    custom_ahb_dma_cxy u_custom_ahb_dma_cxy (
        .FCLK           (fclk),
        .RESETn         (sys_reset_n_buf),
        .PCLKEN         (AHB_to_APB_pclken),
        .PADDR          (AHB_to_APB_paddr[11:0]),
        .PWDATA         (AHB_to_APB_pwdata),
        .PWRITE         (AHB_to_APB_pwrite),
        .PSEL           (APB_DMAC_cxy_cs_latch),
        .PENABLE        (AHB_to_APB_penable),
        .PRDATA         (APB_DMAC_cxy_prdata),

        .HADDR_R        (haddr_dma_cxy_r),
        .HBURST_R       (hburst_dma_cxy_r),
        .HSIZE_R        (hsize_dma_cxy_r),
        .HTRANS_R       (htrans_dma_cxy_r),
        .HREADYOUT_R    (hreadyout_dma_cxy_r),
        .HRDATA_R       (hrdata_dma_cxy_r),
        .HREADY_R       (hready_dma_cxy_r),

        .HADDR_W        (haddr_dma_cxy_w),
        .HBURST_W       (hburst_dma_cxy_w),
        .HSIZE_W        (hsize_dma_cxy_w),
        .HTRANS_W       (htrans_dma_cxy_w),
        .HREADYOUT_W    (hreadyout_dma_cxy_w),
        .HWRITE_W       (hwrite_dma_cxy_w),
        .HWDATA_W       (hwdata_dma_cxy_w),
        .HREADY_W       (hready_dma_cxy_w),

        .DMA_CXY_INT    (DMA_cxy_int)
    );

    always @( * ) begin
        if(APB_DMAC_cxy_cs)
            APB_DMAC_cxy_cs_latch = 1'b1;
        else if(AHB_to_APB_hready)
            APB_DMAC_cxy_cs_latch = 1'b0;
        else
            APB_DMAC_cxy_cs_latch = APB_DMAC_cxy_cs_latch;
    end

    //---------------------------------------
    // AHB to APB

    cmsdk_ahb_to_apb #(
        .ADDRWIDTH  (16)
    )
    u_cmsdk_ahb_to_apb
    (
        .HCLK        (fclk),                    // Clock
        .HRESETn     (sys_reset_n_buf),         // Reset
        .PCLKEN      (AHB_to_APB_pclken),       // APB clock enable signal

        .HSEL        (AHB_to_APB_hsel),         // Device select
        .HADDR       (AHB_to_APB_haddr[15:0]),  // Address
        .HTRANS      (AHB_to_APB_htrans),       // Transfer control
        .HSIZE       (AHB_to_APB_hsize),        // Transfer size
        .HPROT       (AHB_to_APB_hprot),        // Protection control
        .HWRITE      (AHB_to_APB_hwrite),       // Write control
        .HREADY      (AHB_to_APB_hready),       // Transfer phase done
        .HWDATA      (AHB_to_APB_hwdata),       // Write data

        .HREADYOUT   (AHB_to_APB_hreadyout),    // Device ready
        .HRDATA      (AHB_to_APB_hrdata),       // Read data output
        .HRESP       (),                        // Device response
        
        // APB Output
        .PADDR       (AHB_to_APB_paddr),        // APB Address
        .PENABLE     (AHB_to_APB_penable),      // APB Enable
        .PWRITE      (AHB_to_APB_pwrite),       // APB Write
        .PSTRB       (),                        // APB Byte Strobe
        .PPROT       (),                        // APB Prot
        .PWDATA      (AHB_to_APB_pwdata),       // APB write data
        .PSEL        (AHB_to_APB_psel),         // APB Select

        .APBACTIVE   (AHB_to_APB_apbactive),    // APB bus is active, for clock gating of APB bus

        // APB Input
        .PRDATA      (AHB_to_APB_prdata),       // Read data for each APB slave
        .PREADY      (AHB_to_APB_pready),       // Ready for each APB slave
        .PSLVERR     (AHB_to_APB_pslverr)       // Error state for each APB slave
    );

    /////////////////////////////////////////////////////////////////////////////
    // AHB System Port Mux
    /////////////////////////////////////////////////////////////////////////////

    custom_ahb_busmatrix u_custom_ahb_busmatrix (

    // Common AHB signals
    .HCLK           (fclk),
    .HRESETn        (sys_reset_n_buf),

    // System address remapping control
    .REMAP          (4'd0),

    // Input port SI0 (inputs from master 0)
    .HSELS0         (1'b1),
    .HADDRS0        (haddrs),
    .HTRANSS0       (htranss),
    .HWRITES0       (hwrites),
    .HSIZES0        (hsizes),
    .HBURSTS0       (hbursts),
    .HPROTS0        (hprots),
    .HMASTERS0      (4'd0),
    .HWDATAS0       (hwdatas),
    .HMASTLOCKS0    (hmastlocks),
    .HREADYS0       (hreadys),

    // Input port SI1 (inputs from master 1)
    .HSELS1         (1'b1),
    .HADDRS1        (haddr_dma_cxy_w),
    .HTRANSS1       (htrans_dma_cxy_w),
    .HWRITES1       (hwrite_dma_cxy_w),
    .HSIZES1        (hsize_dma_cxy_w),
    .HBURSTS1       (hburst_dma_cxy_w),
    .HPROTS1        (4'd7),
    .HMASTERS1      (4'd1),
    .HWDATAS1       (hwdata_dma_cxy_w),
    .HMASTLOCKS1    (1'b0),
    .HREADYS1       (hreadyout_dma_cxy_w),

    // Input port SI2 (inputs from master 2)
    .HSELS2         (1'b1),
    .HADDRS2        (haddr_dma_cxy_r),
    .HTRANSS2       (htrans_dma_cxy_r),
    .HWRITES2       (1'b0),
    .HSIZES2        (hsize_dma_cxy_r),
    .HBURSTS2       (hburst_dma_cxy_r),
    .HPROTS2        (4'd7),
    .HMASTERS2      (4'd2),
    .HWDATAS2       (32'd0),
    .HMASTLOCKS2    (1'b0),
    .HREADYS2       (hreadyout_dma_cxy_r),

    // Input port SI3 (inputs from master 3)
    .HSELS3         (1'b1),
    .HADDRS3        (IPU_haddrs),
    .HTRANSS3       (IPU_htranss),
    .HWRITES3       (IPU_hwrites),
    .HSIZES3        (3'd2),
    .HBURSTS3       (3'd0),
    .HPROTS3        (4'd7),
    .HMASTERS3      (4'd3),
    .HWDATAS3       (IPU_hwdatas),
    .HMASTLOCKS3    (1'b0),
    .HREADYS3       (IPU_hreadys),

    // Output port MI0 (inputs from slave 0)
    .HRDATAM0       (RAM_hrdata),
    .HREADYOUTM0    (RAM_hreadyout),
    .HRESPM0        (2'd0),

    // Output port MI1 (inputs from slave 1)
    .HRDATAM1       (AHB_to_APB_hrdata),
    .HREADYOUTM1    (AHB_to_APB_hreadyout),
    .HRESPM1        (2'd0),

    // Output port MI2 (inputs from slave 2)
    .HRDATAM2       (GPIO_hrdata),
    .HREADYOUTM2    (GPIO_hreadyout),
    .HRESPM2        (2'd0),

    // Output port MI3 (inputs from slave 3)
    .HRDATAM3       (VGA_hrdata),
    .HREADYOUTM3    (VGA_hreadyout),
    .HRESPM3        (2'd0),

    // Output port MI4 (inputs from slave 4)
    .HRDATAM4       (VGA_CAM_hrdata),
    .HREADYOUTM4    (VGA_CAM_hreadyout),
    .HRESPM4        (2'd0),

    // Output port MI5 (inputs from slave 5)
    .HRDATAM5       (DCMI_hrdata),
    .HREADYOUTM5    (DCMI_hreadyout),
    .HRESPM5        (2'd0),

    // Output port MI6 (inputs from slave 6)
    .HRDATAM6       (IPU_hrdatam),
    .HREADYOUTM6    (IPU_hreadyoutm),
    .HRESPM6        (2'd0),

    // Output port MI7 (inputs from slave 7)
    .HRDATAM7       (CNN_hrdata),
    .HREADYOUTM7    (CNN_hreadyout),
    .HRESPM7        (2'd0),

    // Output port MI8 (inputs from slave 8)
    .HRDATAM8       (SD_Card_hrdata),
    .HREADYOUTM8    (SD_Card_hreadyout),
    .HRESPM8        (2'd0),

    // Scan test dummy signals; not connected until scan insertion
    .SCANENABLE     (1'b0),   // Scan Test Mode Enable
    .SCANINHCLK     (1'b0),   // Scan Chain Input


    // Output port MI0 (outputs to slave 0)
    .HSELM0         (RAM_hsel),
    .HADDRM0        (RAM_haddr),
    .HTRANSM0       (RAM_htrans),
    .HWRITEM0       (RAM_hwrite),
    .HSIZEM0        (RAM_hsize),
    .HBURSTM0       (RAM_hburst),
    .HPROTM0        (RAM_hprot),
    .HMASTERM0      (RAM_hmaster),
    .HWDATAM0       (RAM_hwdata),
    .HMASTLOCKM0    (RAM_hmastlock),
    .HREADYMUXM0    (RAM_hready),

    // Output port MI1 (outputs to slave 1)
    .HSELM1         (AHB_to_APB_hsel),
    .HADDRM1        (AHB_to_APB_haddr),
    .HTRANSM1       (AHB_to_APB_htrans),
    .HWRITEM1       (AHB_to_APB_hwrite),
    .HSIZEM1        (AHB_to_APB_hsize),
    .HBURSTM1       (AHB_to_APB_hburst),
    .HPROTM1        (AHB_to_APB_hprot),
    .HMASTERM1      (AHB_to_APB_hmaster),
    .HWDATAM1       (AHB_to_APB_hwdata),
    .HMASTLOCKM1    (AHB_to_APB_hmastlock),
    .HREADYMUXM1    (AHB_to_APB_hready),

    // Output port MI2 (outputs to slave 2)
    .HSELM2         (GPIO_hsel),
    .HADDRM2        (GPIO_haddr),
    .HTRANSM2       (GPIO_htrans),
    .HWRITEM2       (GPIO_hwrite),
    .HSIZEM2        (GPIO_hsize),
    .HBURSTM2       (GPIO_hburst),
    .HPROTM2        (GPIO_hprot),
    .HMASTERM2      (GPIO_hmaster),
    .HWDATAM2       (GPIO_hwdata),
    .HMASTLOCKM2    (GPIO_hmastlock),
    .HREADYMUXM2    (GPIO_hready),

    // Output port MI3 (outputs to slave 3)
    .HSELM3         (VGA_hsel),
    .HADDRM3        (VGA_haddr),
    .HTRANSM3       (VGA_htrans),
    .HWRITEM3       (VGA_hwrite),
    .HSIZEM3        (VGA_hsize),
    .HBURSTM3       (VGA_hburst),
    .HPROTM3        (VGA_hprot),
    .HMASTERM3      (VGA_hmaster),
    .HWDATAM3       (VGA_hwdata),
    .HMASTLOCKM3    (VGA_hmastlock),
    .HREADYMUXM3    (VGA_hready),

    // Output port MI4 (outputs to slave 4)
    .HSELM4         (VGA_CAM_hsel),
    .HADDRM4        (VGA_CAM_haddr),
    .HTRANSM4       (VGA_CAM_htrans),
    .HWRITEM4       (VGA_CAM_hwrite),
    .HSIZEM4        (VGA_CAM_hsize),
    .HBURSTM4       (VGA_CAM_hburst),
    .HPROTM4        (VGA_CAM_hprot),
    .HMASTERM4      (VGA_CAM_hmaster),
    .HWDATAM4       (VGA_CAM_hwdata),
    .HMASTLOCKM4    (VGA_CAM_hmastlock),
    .HREADYMUXM4    (VGA_CAM_hready),

    // Output port MI5 (outputs to slave 5)
    .HSELM5         (DCMI_hsel),
    .HADDRM5        (DCMI_haddr),
    .HTRANSM5       (DCMI_htrans),
    .HWRITEM5       (DCMI_hwrite),
    .HSIZEM5        (DCMI_hsize),
    .HBURSTM5       (DCMI_hburst),
    .HPROTM5        (DCMI_hprot),
    .HMASTERM5      (DCMI_hmaster),
    .HWDATAM5       (DCMI_hwdata),
    .HMASTLOCKM5    (DCMI_hmastlock),
    .HREADYMUXM5    (DCMI_hready),

    // Output port MI6 (outputs to slave 6)
    .HSELM6         (IPU_hselm),
    .HADDRM6        (IPU_haddrm),
    .HTRANSM6       (IPU_htransm),
    .HWRITEM6       (IPU_hwritem),
    .HSIZEM6        (IPU_hsizem),
    .HBURSTM6       (IPU_hburstm),
    .HPROTM6        (IPU_hprotm),
    .HMASTERM6      (IPU_hmasterm),
    .HWDATAM6       (IPU_hwdatam),
    .HMASTLOCKM6    (IPU_hmastlockm),
    .HREADYMUXM6    (IPU_hreadym),

    // Output port MI7 (outputs to slave 7)
    .HSELM7         (CNN_hsel),
    .HADDRM7        (CNN_haddr),
    .HTRANSM7       (CNN_htrans),
    .HWRITEM7       (CNN_hwrite),
    .HSIZEM7        (CNN_hsize),
    .HBURSTM7       (CNN_hburst),
    .HPROTM7        (CNN_hprot),
    .HMASTERM7      (CNN_hmaster),
    .HWDATAM7       (CNN_hwdata),
    .HMASTLOCKM7    (CNN_hmastlock),
    .HREADYMUXM7    (CNN_hready),

    // Output port MI8 (outputs to slave 8)
    .HSELM8         (SD_Card_hsel),
    .HADDRM8        (SD_Card_haddr),
    .HTRANSM8       (SD_Card_htrans),
    .HWRITEM8       (SD_Card_hwrite),
    .HSIZEM8        (SD_Card_hsize),
    .HBURSTM8       (SD_Card_hburst),
    .HPROTM8        (SD_Card_hprot),
    .HMASTERM8      (SD_Card_hmaster),
    .HWDATAM8       (SD_Card_hwdata),
    .HMASTLOCKM8    (SD_Card_hmastlock),
    .HREADYMUXM8    (SD_Card_hready),

    // Input port SI0 (outputs to master 0)
    .HRDATAS0       (hrdatas),
    .HREADYOUTS0    (hreadys),
    .HRESPS0        (hresps),

    // Input port SI1 (outputs to master 1)
    .HRDATAS1       (),
    .HREADYOUTS1    (hready_dma_cxy_w),
    .HRESPS1        (),

    // Input port SI2 (outputs to master 2)
    .HRDATAS2       (hrdata_dma_cxy_r),
    .HREADYOUTS2    (hready_dma_cxy_r),
    .HRESPS2        (),

    // Input port SI3 (outputs to master 3)
    .HRDATAS3       (IPU_hrdatas),
    .HREADYOUTS3    (IPU_hreadyouts),
    .HRESPS3        (),

    // Scan test dummy signals; not connected until scan insertion
    .SCANOUTHCLK    ()   // Scan Chain Output

    );

    /////////////////////////////////////////////////////////////////////////////
    // APB Slave Mux
    /////////////////////////////////////////////////////////////////////////////

    cmsdk_apb_slave_mux #(
        .PORT0_ENABLE  (1), // MEM
        .PORT1_ENABLE  (1), // TIMER1 
        .PORT2_ENABLE  (0),
        .PORT3_ENABLE  (0),
        .PORT4_ENABLE  (1), // UART0
        .PORT5_ENABLE  (1), // UART1
        .PORT6_ENABLE  (0),
        .PORT7_ENABLE  (0),
        .PORT8_ENABLE  (1), // CAM
        .PORT9_ENABLE  (0),
        .PORT10_ENABLE (0),
        .PORT11_ENABLE (0),
        .PORT12_ENABLE (1), // DMAC
        .PORT13_ENABLE (1), // DMAC_cxy
        .PORT14_ENABLE (0),
        .PORT15_ENABLE (0)
    )
    u_cmsdk_apb_slave_mux
    (
        .DECODE4BIT    (AHB_to_APB_paddr[15:12]),
        .PSEL          (AHB_to_APB_hsel),

        .PSEL0         (APB_MEM_cs),
        .PREADY0       (APB_MEM_preadyout),
        .PRDATA0       (APB_MEM_prdata),
        .PSLVERR0      (APB_MEM_pslverr),

        .PSEL1         (APB_TIMER1_cs),
        .PREADY1       (APB_TIMER1_preadyout),
        .PRDATA1       (APB_TIMER1_prdata),
        .PSLVERR1      (APB_TIMER1_pslverr),

        .PSEL2         (),
        .PREADY2       (),
        .PRDATA2       (),
        .PSLVERR2      (),

        .PSEL3         (),
        .PREADY3       (),
        .PRDATA3       (),
        .PSLVERR3      (),

        .PSEL4         (APB_UART0_cs),
        .PREADY4       (APB_UART0_preadyout),
        .PRDATA4       (APB_UART0_prdata),
        .PSLVERR4      (APB_UART0_pslverr),

        .PSEL5         (APB_UART1_cs),
        .PREADY5       (APB_UART1_preadyout),
        .PRDATA5       (APB_UART1_prdata),
        .PSLVERR5      (APB_UART1_pslverr),

        .PSEL6         (),
        .PREADY6       (),
        .PRDATA6       (),
        .PSLVERR6      (),

        .PSEL7         (),
        .PREADY7       (),
        .PRDATA7       (),
        .PSLVERR7      (),

        .PSEL8         (APB_CAM_cs),
        .PREADY8       (APB_CAM_preadyout),
        .PRDATA8       (APB_CAM_prdata),
        .PSLVERR8      (APB_CAM_pslverr),

        .PSEL9         (),
        .PREADY9       (),
        .PRDATA9       (),
        .PSLVERR9      (),

        .PSEL10        (),
        .PREADY10      (),
        .PRDATA10      (),
        .PSLVERR10     (),

        .PSEL11        (),
        .PREADY11      (),
        .PRDATA11      (),
        .PSLVERR11     (),

        .PSEL12        (),
        .PREADY12      (),
        .PRDATA12      (),
        .PSLVERR12     (),

        .PSEL13        (APB_DMAC_cxy_cs),
        .PREADY13      (APB_DMAC_cxy_preadyout),
        .PRDATA13      (APB_DMAC_cxy_prdata),
        .PSLVERR13     (APB_DMAC_cxy_pslverr),

        .PSEL14        (),
        .PREADY14      (),
        .PRDATA14      (),
        .PSLVERR14     (),

        .PSEL15        (),
        .PREADY15      (),
        .PRDATA15      (),
        .PSLVERR15     (),

        .PREADY        (AHB_to_APB_pready),
        .PRDATA        (AHB_to_APB_prdata),
        .PSLVERR       (AHB_to_APB_pslverr)
    );

    /////////////////////////////////////////////////////////////////////////////
    // Debug Signals
    /////////////////////////////////////////////////////////////////////////////

    // Debug signals (TDO pin is used for SWV unless JTAG mode is active)
    wire          dbg_tdo;                    // SWV / JTAG TDO
    wire          dbg_tdo_nen;                // SWV / JTAG TDO tristate enable (active low)
    wire          dbg_swdo;                   // SWD I/O 3-state output
    wire          dbg_swdo_en;                // SWD I/O 3-state enable
    wire          dbg_jtag_nsw;               // SWD in JTAG state (HIGH)
    wire          dbg_swo;                    // Serial wire viewer/output
    wire          tdo_enable     = !dbg_tdo_nen | !dbg_jtag_nsw;
    wire          tdo_tms        = dbg_jtag_nsw         ? dbg_tdo    : dbg_swo;
    assign        TMS            = dbg_swdo_en          ? dbg_swdo   : 1'bz;
    assign        TDO            = tdo_enable           ? tdo_tms    : 1'bz;

    // CoreSight requires a loopback from REQ to ACK for a minimal
    // debug power control implementation
    wire          cpu0cdbgpwrupreq;          // Debug Power Domain up request
    wire          cpu0cdbgpwrupack;          // Debug Power Domain up acknowledge
    assign        cpu0cdbgpwrupack = cpu0cdbgpwrupreq;

    /////////////////////////////////////////////////////////////////////////////
    // Cortex-M0 Core
    /////////////////////////////////////////////////////////////////////////////

    // wire  [239:0] irq = {240'b0000_0000_0000_0000};    // Interrupts
    wire    [239:0] irq = { 234'h0,
                            GPIO_combint,
                            DCMI_int,
                            APB_TIMER1_timer1int,
                            APB_UART0_uartint,
                            APB_UART1_uartint,
                            DMA_cxy_int
                        };

    // DesignStart simplified integration level
    CORTEXM3INTEGRATIONDS u_CORTEXM3INTEGRATION (
        // Inputs
        .ISOLATEn       (1'b1),               // Active low to isolate core power domain
        .RETAINn        (1'b1),               // Active low to retain core state during power-down

        // Resets
        .PORESETn       (reset_n_input),      // Power on reset - reset processor and debugSynchronous to FCLK and HCLK
        .SYSRESETn      (sys_reset_n_buf),    // System reset   - reset processor onlySynchronous to FCLK and HCLK
        .RSTBYPASS      (1'b0),               // Reset bypass - active high to disable internal generated reset for testing (e.gATPG)
        .CGBYPASS       (1'b0),               // Clock gating bypass - active high to disable internal clock gating for testing
        .SE             (1'b0),               // DFT is tied off in this example

        // Clocks
        .FCLK           (fclk),               // Free running clock - NVIC, SysTick, debug
        .HCLK           (fclk),               // System clock - AHB, processor
                                              // it is separated so that it can be gated off when no debugger is attached
        .TRACECLKIN     (fclk),               // Trace clock input.  REVISIT, does it want its own named signal as an input?
        // SysTick
        .STCLK          (1'b1),               // External reference clock for SysTick (Not really a clock, it is sampled by DFF)
                                              // Must be synchronous to FCLK or tied when no alternative clock source
        .STCALIB        ({1'b1,               // No alternative clock source
                          1'b0,               // Exact multiple of 10ms from FCLK
                          24'h07A11F}),       // Calibration value for SysTick for 50 MHz source

        .AUXFAULT       ({32{1'b0}}),         // Auxiliary Fault Status Register inputs: Connect to fault status generating logic
                                              // if required. Result appears in the Auxiliary Fault Status Register at address
                                              // 0xE000ED3C. A one-cycle pulse of information results in the information being stored
                                              // in the corresponding bit until a write-clear occurs.

        // Configuration - system
        .BIGEND         (1'b0),               // Select when exiting system reset - Peripherals in this system do not support BIGEND
        .DNOTITRANS     (1'b1),               // I-CODE & D-CODE merging configuration.
                                              // This disable I-CODE from generating a transfer when D-CODE bus need a transfer
                                              // Must be HIGH when using the Designstart system

        // SWJDAP signal for single processor mode
        .nTRST          (1'b1),               // JTAG TAP Reset
        .SWCLKTCK       (TCK),                // SW/JTAG Clock
        .SWDITMS        (TMS),                // SW Debug Data In / JTAG Test Mode Select
        .TDI            (TDI),                // JTAG TAP Data In / Alternative input function
        .CDBGPWRUPACK   (cpu0cdbgpwrupack),   // Debug Power Domain up acknowledge.

        // IRQs
        .INTISR         (irq[239:0]),         // Interrupts
        .INTNMI         (1'b0),               // Non-maskable Interrupt

        // I-CODE Bus
        .HREADYI        (hreadyi),            // I-CODE bus ready
        .HRDATAI        (hrdatai),            // I-CODE bus read data
        .HRESPI         (hrespi),             // I-CODE bus response
        .IFLUSH         (1'b0),               // Prefetch flush - fixed when using the Designstart system

        // D-CODE Bus
        .HREADYD        (hreadyd),            // D-CODE bus ready
        .HRDATAD        (hrdatad),            // D-CODE bus read data
        .HRESPD         (hrespd),             // D-CODE bus response
        .EXRESPD        (exrespd),            // D-CODE bus exclusive response

        // System Bus
        .HREADYS        (hreadys),            // System bus ready
        .HRDATAS        (hrdatas),            // System bus read data
        .HRESPS         (hresps),             // System bus response
        .EXRESPS        (exresps),            // System bus exclusive response

        // Sleep
        .RXEV           (1'b0),               // Receive Event input
        .SLEEPHOLDREQn  (1'b1),               // Extend Sleep request

        // External Debug Request
        .EDBGRQ         (1'b0),               // External Debug request to CPU
        .DBGRESTART     (1'b0),               // Debug Restart request - Not needed in a single CPU system

        // DAP HMASTER override
        .FIXMASTERTYPE  (1'b0),               // Tie High to override HMASTER for AHB-AP accesses

        // WIC
        .WICENREQ       (1'b0),               // Active HIGH request for deep sleep to be WIC-based deep sleep
                                              // This should be driven from a PMU

        // Timestamp interface
        .TSVALUEB       ({48{1'b0}}),         // Binary coded timestamp value for trace - Trace is not used in this course
                                              // Timestamp clock ratio change is rarely used

        // Configuration - debug
        .DBGEN          (1'b1),               // Halting Debug Enable
        .NIDEN          (1'b1),               // Non-invasive debug enable for ETM
        .MPUDISABLE     (1'b0),               // Tie high to emulate processor with no MPU

        // SWJDAP signal for single processor mode
        .TDO            (dbg_tdo),            // JTAG TAP Data Out // REVISIT needs mux for SWV
        .nTDOEN         (dbg_tdo_nen),        // TDO enable
        .CDBGPWRUPREQ   (cpu0cdbgpwrupreq),   // Debug Power Domain up request
        .SWDO           (dbg_swdo),           // SW Data Out
        .SWDOEN         (dbg_swdo_en),        // SW Data Out Enable
        .JTAGNSW        (dbg_jtag_nsw),       // JTAG/not Serial Wire Mode

        // Single Wire Viewer
        .SWV            (dbg_swo),            // SingleWire Viewer Data

        // TPIU signals for single processor mode
        .TRACECLK       (),                   // TRACECLK output
        .TRACEDATA      (),                   // Trace Data

        // CoreSight AHB Trace Macrocell (HTM) bus capture interface
        // Connected here for visibility but usually not used in SoC.
        .HTMDHADDR      (),                   // HTM data HADDR
        .HTMDHTRANS     (),                   // HTM data HTRANS
        .HTMDHSIZE      (),                   // HTM data HSIZE
        .HTMDHBURST     (),                   // HTM data HBURST
        .HTMDHPROT      (),                   // HTM data HPROT
        .HTMDHWDATA     (),                   // HTM data HWDATA
        .HTMDHWRITE     (),                   // HTM data HWRITE
        .HTMDHRDATA     (),                   // HTM data HRDATA
        .HTMDHREADY     (),                   // HTM data HREADY
        .HTMDHRESP      (),                   // HTM data HRESP

        // AHB I-Code bus
        .HADDRI         (haddri),             // I-CODE bus address
        .HTRANSI        (htransi),            // I-CODE bus transfer type
        .HSIZEI         (hsizei),             // I-CODE bus transfer size
        .HBURSTI        (hbursti),            // I-CODE bus burst length
        .HPROTI         (hproti),             // i-code bus protection
        .MEMATTRI       (memattri),           // I-CODE bus memory attributes

        // AHB D-Code bus
        .HADDRD         (haddrd),             // D-CODE bus address
        .HTRANSD        (htransd),            // D-CODE bus transfer type
        .HSIZED         (hsized),             // D-CODE bus transfer size
        .HWRITED        (hwrited),            // D-CODE bus write not read
        .HBURSTD        (hburstd),            // D-CODE bus burst length
        .HPROTD         (hprotd),             // D-CODE bus protection
        .MEMATTRD       (memattrd),           // D-CODE bus memory attributes
        .HMASTERD       (hmasterd),           // D-CODE bus master
        .HWDATAD        (hwdatad),            // D-CODE bus write data
        .EXREQD         (exreqd),             // D-CODE bus exclusive request

        // AHB System bus
        .HADDRS         (haddrs),             // System bus address
        .HTRANSS        (htranss),            // System bus transfer type
        .HSIZES         (hsizes),             // System bus transfer size
        .HWRITES        (hwrites),            // System bus write not read
        .HBURSTS        (hbursts),            // System bus burst length
        .HPROTS         (hprots),             // System bus protection
        .HMASTLOCKS     (hmastlocks),         // System bus lock
        .MEMATTRS       (),                   // System bus memory attributes
        .HMASTERS       (),                   // System bus master
        .HWDATAS        (hwdatas),            // System bus write data
        .EXREQS         (),                   // System bus exclusive request

        // Status
        .BRCHSTAT       (),                   // Branch State
        .HALTED         (),                   // The processor is halted
        .DBGRESTARTED   (),                   // Debug Restart interface handshaking
        .LOCKUP         (lockup),             // The processor is locked up
        .SLEEPING       (),                   // The processor is in sleep mdoe (sleep/deep sleep)
        .SLEEPDEEP      (),                   // The processor is in deep sleep mode
        .SLEEPHOLDACKn  (),                   // Acknowledge for SLEEPHOLDREQn
        .ETMINTNUM      (),                   // Current exception number
        .ETMINTSTAT     (),                   // Exception/Interrupt activation status
        .CURRPRI        (),                   // Current exception priority
        .TRCENA         (),                   // Trace Enable

        // Reset Request
        .SYSRESETREQ    (sys_reset_req),      // System Reset Request

        // Events
        .TXEV           (),                   // Transmit Event

        // Clock gating control
        .GATEHCLK       (),                   // when high, HCLK can be turned off

        .WAKEUP         (),                   // Active HIGH signal from WIC to the PMU that indicates a wake-up event has
                                              // occurred and the system requires clocks and power
        .WICENACK       ()                    // Acknowledge for WICENREQ - WIC operation deep sleep mode
    );

endmodule
