module APB2MEM (
        input  wire          CLK,
        input  wire          PCLKEN,
        input  wire  [11:0]  PADDR,
        input  wire  [31:0]  PWDATA,
        input  wire          PWRITE,
        input  wire          PSEL,
        input  wire          PENABLE,
        output reg   [31:0]  PRDATA
    );
    
    reg     [31:0] memory[0:2**10-1];       // 16kB

    always @(posedge CLK) begin
        if(PCLKEN & PSEL & PENABLE & PWRITE)
            memory[PADDR[11:2]] <= PWDATA;
    end

    always @(posedge CLK) begin
        PRDATA <= memory[PADDR[11:2]];
    end

endmodule
