
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/02/25 11:25:59
// Design Name: 
// Module Name: IIC_top
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


 module camera_driver (
                 input              CLK,    //系统时钟
                 input              RESETn,       //系统复位
                 input              PCLKEN,     //apb总线时钟
                 input      [11:0]  PADDR,      //apb地址总线 
                 input              PWRITE,     //apb写控制信号
                 input              PSEL,       //apb片选信号
                 input              PENABLE,    //apb读使能信号
                 input      [31:0]  PWDATA,      //apb数据总线
                 output     [31:0]  PRDATA,      //apb数据总线
                 output             SCL,        //I2C总线时钟
                 inout              SDA         //I2C串行数据线
                ); 

 camera_ini camera_ini (
                 .CLK_SYS           (CLK),
                 .RESETn            (RESETn),
                 //apb总线
                 .PCLKEN            (PCLKEN),
                 .PADDR             (PADDR),
                 .PWRITE            (PWRITE),
                 .PSEL              (PSEL),
                 .PENABLE           (PENABLE),
                 .PWDATA            (PWDATA),
                 .PRDATA            (PRDATA),
                 //SCCB总线
                 .SCL               (SCL),
                 .SDA               (SDA),
                 //内部状态
                 .clk               (),
                 .rdata_iic         (),
                 .ready2send        (),
                 .ready2read        (),
                 .state             (),
                 .addr_data         ()
                 );
 
  endmodule 
