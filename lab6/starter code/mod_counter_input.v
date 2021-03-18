`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/08/2021 04:38:18 PM
// Design Name: 
// Module Name: mod_counter_input
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


module mod_counter_input
    #(parameter BITS = 4)(
    input clk,
    input reset_n,
    input enable,
    input [BITS - 1:0] FINAL_VALUE,
    output [BITS - 1:0] Q
    );
    
    reg [BITS - 1:0] Q_reg, Q_next;
    wire done;
    
    always @(posedge clk, negedge reset_n)
    begin
        if (~reset_n)
            Q_reg <= 'b0;
        else if(enable)
            Q_reg <= Q_next;
        else
            Q_reg <= Q_reg;
    end
    
    // Next state logic
    assign done = Q_reg == FINAL_VALUE;

    always @(*)
        Q_next = done? 'b0: Q_reg + 1;
    
    // Output logic
    assign Q = Q_reg;
endmodule