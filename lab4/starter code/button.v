`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/07/2021 05:52:15 PM
// Design Name: 
// Module Name: button
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


module button(
    input clk,
    input in,
    output out
    );
    
    localparam N = 3;
    
    reg [N - 1:0] Q_reg, Q_next;
    
    always @(posedge clk)
    begin
        Q_reg <= Q_next;
    end
    
    // Next state logic
    always @(Q_reg, in)
    begin
        // Right shift
        Q_next = {in, Q_reg[N - 1:1]};
    end
    
    // Output logic
    assign out = (&Q_reg[N - 1:1]) & ~Q_reg[0];
endmodule
