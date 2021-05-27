`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/26/2021 08:17:04 PM
// Design Name: 
// Module Name: add_test
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


module add_test(

    );
    logic [31:0] A, B;
    logic clk = 0;
    logic [4:0] transition_cnt = 0;
    always #10 clk = ~clk;
    default clocking cb @(posedge clk); endclocking
    
    adder_top test_adder(.A(A), .B(B), .transition_cnt(transition_cnt));
    
    initial begin
        @(posedge clk);
        A = 32'hAAAAAAAA;
        B = 32'h0;
        @(posedge clk);
        A = 32'hdeadbeef;
        B = 32'h0000feed;
        
    end
    
    
endmodule
