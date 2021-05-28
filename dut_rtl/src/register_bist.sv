`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/20/2021 11:10:08 AM
// Design Name: 
// Module Name: register_bist
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


module register_bist(
    input clk,
    input [3:0] d_in,
    input bist_on,
    output logic pass,
    output logic [3:0] d_out
    );
    
    logic [3:0] test_d_in, r_d_in;
    
    assign r_d_in = bist_on ? test_d_in : d_in;
    
    always_ff@(posedge clk) begin
        d_out <= r_d_in;
    end
    
    bist_controller bist(.clk(clk), .dut_out(d_out), .start_test(bist_on), .rst(1'b0), .dut_in(test_d_in), .pass(pass));
    
endmodule

module bist_controller (
    input [3:0] dut_out,
    input clk, start_test, rst,
    output logic [3:0] dut_in,
    output logic pass
);

  logic [3:0] count = 0;
  logic cnt_en, cnt_clr;
  typedef enum {IDLE, TEST_DATA_INPUT, TEST_DATA_CHECK, PASSED, FAILED} t_state;
  t_state s_next_state;

  t_state r_state = IDLE;

  always_comb begin
          s_next_state = r_state;
          pass = 'Z;
          dut_in = 'Z;
          cnt_en = 0;
          cnt_clr = 0;
          case (r_state)
              IDLE: begin
                pass = 'Z;
                dut_in = 'Z;
                cnt_en = 0;
                cnt_clr = 0;
                if (start_test)
                    s_next_state = TEST_DATA_INPUT;
                else
                    s_next_state = IDLE;
              end
              
              //load data into register
              TEST_DATA_INPUT: begin
                pass = 'Z;
                dut_in = count;
                cnt_en = 0;
                cnt_clr = 0;
                s_next_state = TEST_DATA_CHECK;
              end
              
              //compare reg output with input
              TEST_DATA_CHECK: begin
                pass = 'Z;
                dut_in = count;
                cnt_clr = 0;
                if (dut_out == dut_in) begin
                   cnt_en = 1;
                   if (dut_in == 4'hF)
                     s_next_state = PASSED;
                   else
                     s_next_state = TEST_DATA_INPUT;
                 end
                 else begin
                    cnt_en = 0;
                    s_next_state = FAILED;
                 end
              end
              
              PASSED: begin
                pass = 1;
                dut_in = 'Z;
                cnt_en = 0;
                if (rst) begin
                  cnt_clr = 1;
                  s_next_state = IDLE;
                end
                else begin
                  cnt_clr = 0;
                  s_next_state = PASSED;
                end
              end
              
              FAILED: begin
                pass = 0;
                dut_in = 'Z;
                cnt_en = 0;
                if (rst) begin
                  cnt_clr = 1;
                  s_next_state = IDLE;
                end
                else begin
                  cnt_clr = 0;
                  s_next_state = PASSED;
                end
              end

              default: begin
               pass = 'Z;
               dut_in = 'Z;
               cnt_en = 0;
               cnt_clr = 0;
              end

          endcase
      end

      always_ff @(posedge clk) begin
          r_state <= s_next_state;
      end
      
      // counter
      always_ff @(posedge clk) begin
         if (cnt_clr)
            count <= 0;
         else if (cnt_en)
            count <= count + 1;
      end
    
endmodule