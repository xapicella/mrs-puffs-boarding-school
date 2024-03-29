`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/19/2021 01:30:41 PM
// Design Name: 
// Module Name: Memory_Wrapper
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


module Memory_Wrapper(
    input CLK,
    //input BTNL,
    input BTNC,
    input [15:0] SWITCHES,
    input RX,
    output TX,
    output [15:0] LEDS,
    output [7:0] CATHODES,
    output [3:0] ANODES
    );
       
    // INPUT PORT IDS ////////////////////////////////////////////////////////////
    localparam SWITCHES_AD = 32'h11000000;
    localparam CLKCNTLO_AD = 32'h11400000;
    localparam CLKCNTHI_AD = 32'h11400004;
           
    // OUTPUT PORT IDS ///////////////////////////////////////////////////////////
    localparam LEDS_AD     = 32'h11080000;
    localparam SSEG_AD     = 32'h110C0000;
    
    // Signals for connecting OTTER_MCU to OTTER_wrapper /////////////////////////
    logic s_interrupt, s_reset;
    logic sclk = '0;

    // Registers for IOBUS ///////////////////////////////////////////////////////   
    logic [15:0] r_SSEG = '0;
    logic [15:0] r_LEDS = '0;
    logic [63:0] r_CLKCNT = '0;

    // Signals for IOBUS /////////////////////////////////////////////////////////
    logic [31:0] IOBUS_out, IOBUS_in, IOBUS_addr;
    logic IOBUS_wr;
   
    // Declare MEM /////////////////////////////////////////////////////////
    Programmable_Memory MEM(.EXT_RESET(s_reset), .CLK(sclk), 
                  .IOBUS_OUT(IOBUS_out), .IOBUS_IN(IOBUS_in),
                  .IOBUS_ADDR(IOBUS_addr), .IOBUS_WR(IOBUS_wr),
                  .PROG_RX(RX), .PROG_TX(TX));

    // Declare Seven Segment Display /////////////////////////////////////////////
    SevSegDisp SSG_DISP(.DATA_IN(r_SSEG), .CLK(CLK), .MODE(1'b0),
                        .CATHODES(CATHODES), .ANODES(ANODES));

    // Connect LEDS register to port /////////////////////////////////////////////
    assign LEDS = r_LEDS;
   
    // Debounce/one-shot the reset and interrupt buttons /////////////////////////
    debounce_one_shot DB_R(.CLK(sclk), .BTN(BTNC), .DB_BTN(s_reset));
   
    // Clock divider to create 50 MHz clock for MCU //////////////////////////////
    always_ff @(posedge CLK) begin
        sclk <= ~sclk;
    end
   
    // Performance counter (MCU clock cycles) ////////////////////////////////////
    always_ff @(posedge sclk) begin
        r_CLKCNT = r_CLKCNT + 1;
    end
   
    // Connect board peripherals (Memory Mapped IO devices) to IOBUS /////////////
    // Inputs
//    always_comb begin
//        IOBUS_in = 32'b0;
//        case (IOBUS_addr)
//            SWITCHES_AD: IOBUS_in[15:0] = SWITCHES;
//            CLKCNTLO_AD: IOBUS_in = r_CLKCNT[31:0];
//            CLKCNTHI_AD: IOBUS_in = r_CLKCNT[63:32];
//        endcase
//    end

    // Outputs
    always_ff @(posedge sclk) begin
        if (IOBUS_wr) begin
            r_LEDS <= IOBUS_out[15:0];
            r_SSEG <= IOBUS_out[31:16];
        end
    end
    
endmodule
