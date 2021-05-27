`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/26/2021 10:20:20 PM
// Design Name: 
// Module Name: bist_test
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


module bist_test(

    );
    logic [3:0] data_out, data_in;
    logic bist_on;
    logic pass;
    logic clk = 0;
    always #10 clk = ~clk;
    default clocking cb @(posedge clk); endclocking
    
    register_bist bist (.clk(clk), .d_in(data_in), .bist_on(bist_on), .pass(pass), .d_out(data_out));
    
    initial begin
    bist_on = 1;
    data_in = 4'h0;
    while (pass !== 1 || pass !== 0) begin
        @(posedge clk);
        if (pass === 1 || pass === 0)
            break;
    end
    bist_on = 0;
    data_in = 4'h7;
    @(posedge clk);
    if (pass === 1)
        $display("BIST Passed.");
    else
        $display("BIST Failed.");
    
    end
endmodule
