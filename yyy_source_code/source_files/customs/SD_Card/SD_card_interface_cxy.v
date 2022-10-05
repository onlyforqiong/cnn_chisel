`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/05/07 19:37:32
// Design Name: 
// Module Name: SD_card_interface_cxy
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


module SD_card_interface_cxy (
    // AHB inputs
    input               HCLK,
    input               HRESETn,
    input               HSEL,
    input               HREADY,
    input       [1:0]   HTRANS,
    input       [2:0]   HSIZE,
    input               HWRITE,
    input       [31:0]  HADDR,
    input       [31:0]  HWDATA,

    // AHB outputs
    output              HREADYOUT,
    output reg  [31:0]  HRDATA,

    // SPI SD interface
    output          SD_nCS,
    output          SD_DCLK,
    output          SD_MOSI,
    input           SD_MISO
    );

parameter S_IDLE = 0;
parameter S_READ = 1;
parameter S_END  = 3;

parameter ADDR_REG_READ_ADDR = 32'h4009_0200;
parameter ADDR_REG_LAST_ADDR = 32'h4009_0204;
parameter ADDR_REG_CTRL      = 32'h4009_0208;

reg     [3:0]   state;
wire            sd_init_done;
reg             sd_sec_read;
wire    [31:0]  sd_sec_read_addr;
wire    [7:0]   sd_sec_read_data;
wire            sd_sec_read_data_valid;
wire            sd_sec_read_end;
reg     [9:0]   rd_cnt;
reg     [7:0]   read_data[0:511];

reg             read_data_ren;
reg             reg_read_addr_wen;
reg             reg_read_addr_ren;
reg             reg_last_addr_ren;
reg             reg_ctrl_wen;
reg             reg_ctrl_ren;
reg     [31:0]  reg_read_addr;  // 4009_0200
reg     [31:0]  reg_last_addr;  // 4009_0204
reg     [31:0]  reg_ctrl;       // 4009_0208
reg             sec_read_finished;
wire            sec_read_start;

//---------------------------------------
// AHB

always @(posedge HCLK)
begin
    if(HRESETn == 1'b0)
    begin
        reg_read_addr_wen <= 1'b0;
        reg_ctrl_wen <= 1'b0;
    end
    else if(HSEL & HTRANS[1] & HWRITE)
    begin
        if(HADDR == ADDR_REG_READ_ADDR)
        begin
            reg_read_addr_wen <= 1'b1;
            reg_ctrl_wen <= 1'b0;
        end
        else if(HADDR == ADDR_REG_CTRL)
        begin
            reg_read_addr_wen <= 1'b0;
            reg_ctrl_wen <= 1'b1;
        end
        else
        begin
            reg_read_addr_wen <= 1'b0;
            reg_ctrl_wen <= 1'b0;
        end
    end
    else
    begin
        reg_read_addr_wen <= 1'b0;
        reg_ctrl_wen <= 1'b0;
    end
end

always @(*)
begin
    if(HSEL & HTRANS[1] & ~HWRITE)
    begin
        if(HADDR<ADDR_REG_READ_ADDR)
        begin
            read_data_ren = 1'b1;
            reg_read_addr_ren = 1'b0;
            reg_last_addr_ren = 1'b0;
            reg_ctrl_ren = 1'b0;
        end
        else if(HADDR == ADDR_REG_READ_ADDR)
        begin
            read_data_ren = 1'b0;
            reg_read_addr_ren = 1'b1;
            reg_last_addr_ren = 1'b0;
            reg_ctrl_ren = 1'b0;
        end
        else if(HADDR == ADDR_REG_LAST_ADDR)
        begin
            read_data_ren = 1'b0;
            reg_read_addr_ren = 1'b0;
            reg_last_addr_ren = 1'b1;
            reg_ctrl_ren = 1'b0;
        end
        else if(HADDR == ADDR_REG_CTRL)
        begin
            read_data_ren = 1'b0;
            reg_read_addr_ren = 1'b0;
            reg_last_addr_ren = 1'b0;
            reg_ctrl_ren = 1'b1;
        end
        else
        begin
            read_data_ren = 1'b0;
            reg_read_addr_ren = 1'b0;
            reg_last_addr_ren = 1'b0;
            reg_ctrl_ren = 1'b0;
        end
    end
    else
    begin
        read_data_ren = 1'b0;
        reg_read_addr_ren = 1'b0;
        reg_last_addr_ren = 1'b0;
        reg_ctrl_ren = 1'b0;
    end
end

always @(posedge HCLK)
begin
    if(HRESETn == 1'b0)
        reg_read_addr <= 0;
    else if(reg_read_addr_wen)
        reg_read_addr <= HWDATA;
    else
        reg_read_addr <= reg_read_addr;
end

always @(posedge HCLK)
begin
    if(sec_read_start)
        reg_last_addr <= reg_read_addr;
    else
        reg_last_addr <= reg_last_addr;
end

always @(posedge HCLK)
begin
    if(HRESETn == 1'b0)
        reg_ctrl <= 0;
    else if(reg_ctrl_wen)
        reg_ctrl <= HWDATA;
    else
        reg_ctrl <= {reg_ctrl[31:3], sd_init_done, sec_read_finished, 1'b0};
end

assign sec_read_start = reg_ctrl[0];

always @(posedge HCLK)
begin
    if(~HRESETn)
        sec_read_finished <= 1'b0;
    else if(sec_read_start)
        sec_read_finished <= 1'b0;
    else if(state == S_END)
        sec_read_finished <= 1'b1;
end

assign HREADYOUT = 1'b1;

wire [7:0]  memory_data_0 = read_data[HADDR[8:0]];
wire [7:0]  memory_data_1 = read_data[HADDR[8:0]+1];
wire [7:0]  memory_data_2 = read_data[HADDR[8:0]+2];
wire [7:0]  memory_data_3 = read_data[HADDR[8:0]+3];

always @(posedge HCLK)
begin
    if(~HRESETn)
        HRDATA <= 0;
    else if(read_data_ren)
    begin
        case(HSIZE)
            3'h0:    HRDATA <= {memory_data_0, memory_data_0, memory_data_0, memory_data_0};
            3'h1:    HRDATA <= {memory_data_1, memory_data_0, memory_data_1, memory_data_0};
            default: HRDATA <= {memory_data_3, memory_data_2, memory_data_1, memory_data_0};
        endcase
    end
    else if(reg_read_addr_ren)
        HRDATA <= reg_read_addr;
    else if(reg_last_addr_ren)
        HRDATA <= reg_last_addr;
    else if(reg_ctrl_ren)
        HRDATA <= reg_ctrl;
    else
        HRDATA <= 32'h0;
end

//---------------------------------------
// read data

assign sd_sec_read_addr = reg_read_addr;

always@(posedge HCLK or negedge HRESETn)
begin
    if(HRESETn == 1'b0)
        rd_cnt <= 10'd0;
    else if(state == S_READ)
    begin
        if(sd_sec_read_data_valid == 1'b1)
            rd_cnt <= rd_cnt + 10'd1;
    end
    else
        rd_cnt <= 10'd0;
end

always@(posedge HCLK)
begin
    if(state == S_READ)
    begin
        if(sd_sec_read_data_valid == 1'b1 && rd_cnt < 512)
            read_data[rd_cnt] <= sd_sec_read_data;
    end
end

// integer i;
// initial begin
//     i = 0;
//     repeat(512) begin
//         read_data[i] = i;
//         i = i + 1;
//     end
// end

always@(posedge HCLK or negedge HRESETn)
begin
    if(HRESETn == 1'b0)
    begin
        state <= S_IDLE;
        sd_sec_read <= 1'b0;
    end
    else if(sd_init_done == 1'b0)
    begin
        state <= S_IDLE;
    end
    else
        case(state)
            S_IDLE:
            begin
                state <= S_END;
            end
            S_READ:
            begin
                if(sd_sec_read_end == 1'b1)
                begin
                    state <= S_END;
                    sd_sec_read <= 1'b0;
                end
                else
                begin
                    sd_sec_read <= 1'b1;
                end                 
            end         
            S_END:
            begin
                if(sec_read_start)
                    state <= S_READ;
                else
                    state <= S_END;
            end
            default:
                state <= S_IDLE;
        endcase
end

sd_card_top  sd_card_top_m0(
    .clk                       (HCLK                   ),
    .rst                       (~HRESETn               ),
    .SD_nCS                    (SD_nCS                 ),
    .SD_DCLK                   (SD_DCLK                ),
    .SD_MOSI                   (SD_MOSI                ),
    .SD_MISO                   (SD_MISO                ),
    .sd_init_done              (sd_init_done           ),
    .sd_sec_read               (sd_sec_read            ),
    .sd_sec_read_addr          (sd_sec_read_addr       ),
    .sd_sec_read_data          (sd_sec_read_data       ),
    .sd_sec_read_data_valid    (sd_sec_read_data_valid ),
    .sd_sec_read_end           (sd_sec_read_end        ),
    .sd_sec_write              (                       ),
    .sd_sec_write_addr         (                       ),
    .sd_sec_write_data         (                       ),
    .sd_sec_write_data_req     (                       ),
    .sd_sec_write_end          (                       )
);
endmodule
