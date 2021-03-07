`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/07/2021 05:58:20 PM
// Design Name: 
// Module Name: button_tb
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


module button_tb(

    );
    
    // Declare local reg and wire
    reg clk, in;
    wire out;
    
    // Instantiate unit under test
    button uut(
        .clk(clk),
        .in(in),
        .out(out)
    );
    
    // Generate stimuli
    
    //Generating a clk signal
    localparam T = 10;
    always
    begin
        clk = 1'b0;
        #(T / 2);
        clk = 1'b1;
        #(T / 2);
    end 
    
    // Generate different push button inputs
    initial
    begin
        in = 1'b0;
        
        # 7;
        in = 1'b1;
        
        # (3 * T);
        in = 1'b0;
        
        repeat(3) @(negedge clk);
        in = 1'b1;
        repeat(5) @(negedge clk);
        
        #20 $stop; 
       
    end
endmodule
