`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/19/2021 04:45:10 PM
// Design Name: 
// Module Name: add_32bit
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


module adder_top(
   input [31:0] A,
   input [31:0] B,
   output logic [4:0] transition_cnt
);
  
  logic [31:0] sum;
  logic [30:0] check_transition;
  
  add_32bit adder(.A(A), .B(B), .sum(sum));
    
  genvar i;
  generate
    for (i=0; i < 31; i++) begin
        assign check_transition[i] = sum[i] ^ sum[i+1];
    end
  endgenerate
  
  assign transition_cnt = check_transition[0] + check_transition[1] + check_transition[2] + check_transition[3] + 
                          check_transition[4] + check_transition[5] + check_transition[6] + check_transition[7] + 
                          check_transition[8] + check_transition[9] + check_transition[10] + check_transition[11] + 
                          check_transition[12] + check_transition[13] + check_transition[14] + check_transition[15] + 
                          check_transition[16] + check_transition[17] + check_transition[18] + check_transition[19] + 
                          check_transition[20] + check_transition[21] + check_transition[22] + check_transition[23] +
                          check_transition[24] + check_transition[25] + check_transition[26] + check_transition[27] +  
                          check_transition[28] + check_transition[29] + check_transition[30];
  
//  always_comb begin
//    foreach(check_transition[i])
//        transition_cnt += check_transition[i];
//  end
endmodule

module add_32bit(
    input [31:0] A,
    input [31:0] B,
    output logic [31:0] sum
    );
    
    assign sum = A + B;
    
endmodule


