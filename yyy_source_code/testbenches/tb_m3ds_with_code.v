`timescale 1ns/1ps

// Comment this out when synthesize
// `define __FOR_SIMULATION__ 1

module tb_m3ds_with_code;

reg         Main_Cortex_M3_Clk = 1'b0;
always #5   Main_Cortex_M3_Clk = ~Main_Cortex_M3_Clk;

reg 		RESETn;
initial begin
	RESETn = 1'b0;

	#220

	RESETn = 1'b1;
end

reg         VGA_RST;
initial begin
    VGA_RST = 1'b1;

    #2200

    VGA_RST = 1'b0;
end

`ifdef __FOR_SIMULATION__
wire           HSEL_rom;
wire           HCLK_rom;
wire           HRESETn_rom;
wire           HREADY_rom;
wire    [31:0] HADDR_rom;
wire     [1:0] HTRANS_rom;
wire           HWRITE_rom;
wire     [2:0] HSIZE_rom;
wire    [31:0] HWDATA_rom;
wire           HREADYOUT_rom;
wire    [31:0] HRDATA_rom;

   // AHB-Lite ROM
   AHB2MEM_Code_tb uAHB2ROM (
       .HSEL          (HSEL_rom),
       .HCLK          (HCLK_rom), 
       .HRESETn       (HRESETn_rom), 
       .HREADY        (HREADY_rom),     
       .HADDR         (HADDR_rom),
       .HTRANS        (HTRANS_rom), 
       .HWRITE        (HWRITE_rom),
       .HSIZE         (HSIZE_rom),
       .HWDATA        (HWDATA_rom), 
       .HRDATA        (HRDATA_rom), 
       .HREADYOUT     (HREADYOUT_rom)
   );
`endif

wire    [15:0] gpio;

assign gpio[0] = gpio[8];

wire           vga_hsync;
wire           vga_vsync;
wire    [3:0]  vga_r;
wire    [3:0]  vga_g;
wire    [3:0]  vga_b;

reg            pclk = 0;
wire           cam_href;
wire           cam_vsync;
reg            cam_d;

wire           uart0_txd;
wire           uart0_rxd = uart0_txd;
wire           uarT1_txd;
wire           uarT1_rxd = uarT1_txd;

wire           scl;
wire           sda;

always #20 pclk = ~pclk;

reg            cam_vsync_en;
initial begin
    cam_vsync_en = 0;

    #46000
    cam_vsync_en = 1;
end

reg    [16:0]  cam_vsync_cnt = 17'h1_ffff;
always @(posedge pclk) begin
    if(cam_vsync_en)
        if(cam_vsync_cnt == 79210-1)
        // if(cam_vsync_cnt == 3000)
            cam_vsync_cnt <= 0;
        else
            cam_vsync_cnt <= cam_vsync_cnt + 1;
    else
        cam_vsync_cnt <= 17'h1_ffff;
end

assign cam_vsync = (cam_vsync_cnt == 0) ? 1 : 0;

reg     [9:0]   cam_href_cnt;
always @(posedge pclk) begin
    if(cam_vsync)
        cam_href_cnt <= 0;
    else if(cam_href_cnt == 650-1)
        cam_href_cnt <= 0;
    else
        cam_href_cnt <= cam_href_cnt + 1;
end

assign cam_href = (cam_href_cnt>=10) ? 1 : 0;





wire            out_pclk;
wire            out_href;
wire            out_vsync;

ARMSOC_TOP_with_busmatrix u_top (
    .SYS_CLK100M        (Main_Cortex_M3_Clk),   // Oscillator
    .SYS_RESETn         (RESETn),               // Reset
    .RESETn_BUTTON      (RESETn),

    .TEST_LED           (),

    // GPIO
    .GPIO(gpio),

    // VGA
    .VGA_RST    (VGA_RST),
    .VGA_HSYNC  (vga_hsync),
    .VGA_VSYNC  (vga_vsync),
    .VGA_R      (vga_r),
    .VGA_G      (vga_g),
    .VGA_B      (vga_b),

    // DCMI
    .PCLK       (pclk),
    .CAM_HREF   (cam_href),
    .CAM_VSYNC  (cam_vsync),
    .CAM_D      (cam_vsync_cnt[7:0]),

    // UART
    .UART0_RXD(uart0_rxd),
    .UART0_TXD(uart0_txd),
    .UART1_RXD(uart1_rxd),
    .UART1_TXD(uart1_txd),

    // CAM I2C
    .SCL                (scl),
    .SDA                (sda),
    .XCLK               (),

    // Debug
    .TDI(),                  // JTAG TDI
    .TCK(),                  // SWD Clk / JTAG TCK
    .TMS(),                  // SWD I/O / JTAG TMS
    .TDO()                   // SWV     / JTAG TDO

`ifdef __FOR_SIMULATION__
    ,.HSEL_rom(HSEL_rom),
    .HCLK_rom(HCLK_rom),
    .HRESETn_rom (HRESETn_rom),
    .HREADY_rom (HREADY_rom),
    .HADDR_rom (HADDR_rom),
    .HTRANS_rom (HTRANS_rom),
    .HWRITE_rom (HWRITE_rom),
    .HSIZE_rom (HSIZE_rom),
    .HWDATA_rom (HWDATA_rom),
    .HREADYOUT_rom (HREADYOUT_rom),
    .HRDATA_rom (HRDATA_rom)
`endif
    );


endmodule


// ////////////////////////////////////////////////////////////////////////////////
// // Testbench Memory Module
// ////////////////////////////////////////////////////////////////////////////////

// // 下载了程序的ROM
//     module AHB2MEM_Code_tb
//     #(parameter MEMWIDTH = 15)               // [15:0] Size = 64KB
//     (
//         input wire           HSEL,
//         input wire           HCLK,
//         input wire           HRESETn,
//         input wire           HREADY,
//         input wire    [31:0] HADDR,
//         input wire     [1:0] HTRANS,
//         input wire           HWRITE,
//         input wire     [2:0] HSIZE,
//         input wire    [31:0] HWDATA,
//         output wire          HREADYOUT, // 
//         output wire   [31:0] HRDATA
//     );

//     wire   [31:0] sram_rdata; // SRAM Read Data
//     wire   [29:0] sram_addr;  // SRAM address
//     wire    [3:0] sram_wen;   // SRAM write enable (active high)
//     wire   [31:0] sram_wdata; // SRAM write data
//     wire          sram_cs;

//     cmsdk_ahb_to_sram #(
//       .AW(32)
//     )
//     u_cmsdk_ahb_to_sram (
//         .HCLK       (HCLK),      // system bus clock
//         .HRESETn    (HRESETn),   // system bus reset
//         .HSEL       (HSEL),      // AHB peripheral select
//         .HREADY     (HREADY),    // AHB ready input
//         .HTRANS     (HTRANS),    // AHB transfer type
//         .HSIZE      (HSIZE),     // AHB hsize
//         .HWRITE     (HWRITE),    // AHB hwrite
//         .HADDR      (HADDR),// AHB address bus
//         .HWDATA     (HWDATA),    // AHB write data bus
//         .HREADYOUT  (HREADYOUT), // AHB ready output to S->M mux
//         .HRESP      (),          // AHB response
//         .HRDATA     (HRDATA),    // AHB read data bus

//         .SRAMRDATA  (sram_rdata), // SRAM Read Data
//         .SRAMADDR   (sram_addr),  // SRAM address
//         .SRAMWEN    (sram_wen),   // SRAM write enable (active high)
//         .SRAMWDATA  (sram_wdata), // SRAM write data
//         .SRAMCS     (sram_cs)
//       );

//     ROM_with_Code_tb u_ROM (
//         .MEMCLK     (HCLK),
//         .RSTn       (HRESETn),
//         .WEN        (sram_wen[0] & sram_cs),
//         .MEMADDR    (sram_addr[13:0]),
//         .WDATA      (sram_wdata),
//         .RDATA      (sram_rdata)
//     );

//     endmodule

// //read hex file to initial ROM or RAM
// module ROM_with_Code_tb (
//     input               MEMCLK,
//     input               RSTn,
//     input               WEN,
//     input       [13:0]  MEMADDR,
//     input       [31:0]  WDATA,
//     output reg  [31:0]  RDATA
//     );
 
//     // parameter filename = "F:/Prj2020/Modelsim/debugs/ahb_to_apb/Software_reference/Code.hex";
//     // parameter filename = "F:/software_DCMI_with_Interrupt_test/Code.hex";
//     // parameter filename = "F:/0422_IPU_test/Code.hex";
//     // parameter filename = "F:/software_dma_interrupt_debugging/Code.hex";
//     parameter filename = "F:/0422_IPU_test_IPU_for_M3_0508/Code.hex";

//     reg[ 7:0] char_1st;
//     reg[15:0] address; // Rom address
//     reg[ 7:0] len; // bytes of one line in the hex file
//     reg[ 7:0] dat;
//     reg[ 7:0] data_type;
//     reg[7:0] sum; // intel hex file verification
//     reg[640:1] errstr;
//     reg[7:0] rom[0:65535];
//     reg CanRead;
//     integer i,fp,code;
 
//     always@(posedge MEMCLK)
//     if(!RSTn)begin
 
//         char_1st = 0;
//         address =0;
//         len =0;
//         dat =0;
//         sum =0;
//         CanRead =1;
 
//         fp=$fopen(filename,"r");
 
//         if(fp==0)begin
//             $display($time,"ERROR: Hex File %s cann't be open!",filename);
//             $stop; // stop when no such file
//         end
//         else begin
//             $display($time,"Message: Hex File %s open succese!",filename);
//         end
 
//         if($ferror(fp,errstr))begin
//             $display("%s",errstr);
//             $display($time,"ERROR: Hex File %s error",filename);
//             $stop;
//         end
 
//         while(CanRead)begin
//             //first byte should be ":"
//             char_1st=$fgetc(fp);
 
//             if(char_1st=="\n")begin //if it is blank line read next char
//                 char_1st=$fgetc(fp);
//             end
//             else if(char_1st!=":")begin // every line begin with ":"
//                 //if one line is not start with ":" this file maybe not a hex file
//                 $display($time,"Error: The 1st char isn't [:]Hex File convert end! ");
//                 CanRead = 0;
//             end
//             else begin
//                 //the second and third byte means how many data in this line
//                 code=$fscanf(fp,"%2x",len);
 
//                 if(len==0)begin
//                     $display($time,"Message:Initial Rom Finish!");
//                     CanRead = 0;
//                 end
//                 else begin
 
//                     sum=len;
//                     code=$fscanf(fp,"%4x",address);
//                     sum=sum+address;
//                     sum=sum+(address>>8); // unsigned sum
//                     code=$fscanf(fp,"%2x",data_type); // data type 这里需要判断一下本行的 DATA TYPE 否则非数据部分可能会替换ROM中的数据
//                     sum=sum+data_type;
 
//                     for(i=0;i<len;i=i+1)begin
//                         code=$fscanf(fp,"%2x",dat);
//                         sum=sum+dat;
//                         if(!data_type) begin // 如果是数据才保存在ROM中
//                             rom[address]=dat; // ram read data from file
//                             address=address+1;
//                         end
//                     end
 
//                     code=$fscanf(fp,"%2x\n",dat); // check data
//                     sum=sum+dat;
 
//                     if(sum!=0)begin
//                         $display("Error:verification code is not zero!");
//                         CanRead = 0;
//                     end
 
//                 end
 
//             end
 
//         end
//     end
//     else begin
//         if(WEN) begin // 将8位ROM组合成位宽为32bit的ROM
//             {rom[MEMADDR*4+3], rom[MEMADDR*4+2], rom[MEMADDR*4+1], rom[MEMADDR*4]} <= WDATA;
//             RDATA <= RDATA;
//         end
//         else
//             RDATA <= {rom[MEMADDR*4+3], rom[MEMADDR*4+2], rom[MEMADDR*4+1], rom[MEMADDR*4]};
//     end
 
// endmodule
