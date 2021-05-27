`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/19/2021 01:23:27 PM
// Design Name: 
// Module Name: Programmable_Memory
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


module Programmable_Memory(
                input CLK,
                input EXT_RESET,  // CHANGED RESET TO EXT_RESET FOR PROGRAMMER
                input [31:0] IOBUS_IN,
                output logic [31:0] IOBUS_OUT,
                output [31:0] IOBUS_ADDR,       //don't need right now
                output logic IOBUS_WR,
                input PROG_RX,  // ADDED PROG_RX FOR PROGRAMMER
                output PROG_TX  // ADDED PROG_TX FOR PROGRAMMER
);

    wire [31:0] s_prog_ram_addr;
    wire [31:0] s_prog_ram_data;
    wire s_prog_ram_we;
    wire s_prog_mcu_reset;
    
    logic [31:0] addr_counter1 = 32'b0;
    logic mem_read1 = 1'b1;
    
    logic [31:0] counter = 32'b0;
    assign IOBUS_WR = 1'b1;     //hardcode to 1 to always write to IObus
    
    always_ff @(posedge CLK)
    begin
        if (EXT_RESET) begin
            counter <= 32'b0;
            addr_counter1 <= 32'b0;
        end
        else
            begin
            if (counter >= 32'h5F5E100) 
                begin
                addr_counter1 <= addr_counter1 + 4;
                counter <= 32'b0;
                end
            else counter <= counter + 1;
            end
    end
    
    
     programmer #(.CLK_RATE(50), .BAUD(115200), .IB_TIMEOUT(200),
                 .WAIT_TIMEOUT(500))
        programmer(.clk(CLK), .rst(EXT_RESET), .srx(PROG_RX), .stx(PROG_TX),
                   .mcu_reset(s_prog_mcu_reset), .ram_addr(s_prog_ram_addr),
                   .ram_data(s_prog_ram_data), .ram_we(s_prog_ram_we));
                   
     OTTER_mem_byte #(14) memory  (.MEM_CLK(CLK),.MEM_ADDR1(addr_counter1),.MEM_ADDR2(s_prog_ram_addr),.MEM_DIN2(s_prog_ram_data),
                               .MEM_WRITE2(s_prog_ram_we),.MEM_READ1(mem_read1),.MEM_READ2(),
                               .ERR(),.MEM_DOUT1(IOBUS_OUT),.MEM_DOUT2(),.IO_IN(IOBUS_IN),.IO_WR(),
                               .MEM_SIZE(2'b10),.MEM_SIGN(1'b0));
    // ^ CHANGED aluResult to mem_addr_after FOR PROGRAMMER
    // ^ CHANGED B to mem_data_after FOR PROGRAMMER
    // ^ CHANGED memWrite to mem_we_after FOR PROGRAMMER
    // ^ CHANGED IR[13:12] to mem_size_after FOR PROGRAMMER
    // ^ CHANGED IR[14] to mem_sign_after FOR PROGRAMMER


endmodule
