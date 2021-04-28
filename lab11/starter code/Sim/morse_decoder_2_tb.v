`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/27/2021 01:33:12 PM
// Design Name: 
// Module Name: morse_decoder_2_tb
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


module morse_decoder_2_tb(
    
    );
    reg clk, reset_n, b;
    wire dot, dash, lg, wg;
    integer i;
    localparam TIMER_FINAL_VALUE = 5;
    
    morse_decoder_2 #(.TIMER_FINAL_VALUE(TIMER_FINAL_VALUE))uut(
        .clk(clk),
        .reset_n(reset_n),
        .b(b),
        .dot(dot),
        .dash(dash),
        .lg(lg),
        .wg(wg)
    );
    
    localparam T = 10;
    always
    begin
        clk = 1'b0;
        #(T / 2);
        clk = 1'b1;
        #(T / 2);
    end
    
    localparam DELAY = (TIMER_FINAL_VALUE + 1) * T;
    initial
    begin
        reset_n = 1'b0;
        b = 1'b0;
        #2 reset_n = 1'b1;
        
        #40;
        b = 1'b1;
        #(5 * DELAY);
        b = 1'b0;
        
        #DELAY;
        b = 1'b1;
        
        #(1.5 * DELAY);
        b = 1'b0;
        
        #(1.5 * DELAY);
        b = 1'b1;
        
        #(2 * DELAY);
        b = 1'b0;
        
        // wg
        #(15 * DELAY)
        
        // Bunch of dots
        for (i = 0; i < 5; i = i + 1)
        begin
            b = 1'b1;
            #(2 * DELAY);
            b = 1'b0;
            #(2 * DELAY);
        end
        
        // lg
        #(3.5 * DELAY)
        
        // Bunch of dashes
        for (i = 0; i < 5; i = i + 1)
        begin
            b = 1'b1;
            #(4 * DELAY);
            b = 1'b0;
            #(3 * DELAY);
        end        
        
        // wg
        #(15 * DELAY);
        
        // Bunch of dots followed by a very long dash
        for (i = 0; i < 3; i = i + 1)
        begin
            b = 1'b1;
            #(2 * DELAY);
            b = 1'b0;
            #(2 * DELAY);
        end
        b = 1'b1;
        #(19 * DELAY);
        b = 1'b0;

        // wg
        #(15 * DELAY);
                         
        repeat(5) @(negedge clk) $stop;
        
    end
endmodule