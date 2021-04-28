`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/27/2021 12:40:57 PM
// Design Name: 
// Module Name: morse_decoder_2
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


module morse_decoder_2 
    #(parameter TIMER_FINAL_VALUE = 6_999_999)
    (
    input clk, reset_n,
    input b,
    output reg dot, dash, lg, wg
    );
    
    wire unit_en, unit_reset;
    wire [2:0] units;       
    wire timer_tick;
    
    //--------------------------------------------------
    // TIMER/COUNTER STRUCTURE
    //--------------------------------------------------
    timer_parameter #(.FINAL_VALUE(TIMER_FINAL_VALUE)) UNIT_TIMER(
        .clk(clk),
        .reset_n(reset_n & ~unit_reset),
        .enable(unit_en),
        .done(timer_tick)
    );
    
    udl_counter #(.BITS(3)) UNIT_COUNTER(
        .clk(clk),
        .reset_n(reset_n & ~unit_reset),
        .enable(timer_tick),
        .up(1'b1),
        .load((units == 6) & b), // to avoid counter wrap around when the button is kept pressed
        .D(3'd6),
        .Q(units)
    );

    //--------------------------------------------------
    // EDGE DETECTOR 
    //--------------------------------------------------    
    wire b_pedge, b_nedge, b_edge;
    moore_edge_detector ED0(
        .clk(clk),
        .reset_n(reset_n),
        .level(b),
        .p_edge(b_pedge),
        .n_edge(b_nedge),
        ._edge(b_edge)
    );

    //--------------------------------------------------
    // TIMER/COUNTER ENABLE SIGNAL
    //--------------------------------------------------
    T_FF FF0 (
        .clk(clk),
        .T((b_pedge & ~unit_en) | (wg & unit_en) ),
        .reset_n(reset_n),
        .Q(unit_en)
    );
    
    //--------------------------------------------------
    // TIMER/COUNTER RESET SIGNAL
    //--------------------------------------------------            
        
    // create a delayed edge signal for a delayed reset signal
    reg b_edge_delayed;
    always @(posedge clk)
        b_edge_delayed <= b_edge;
    
    
    assign unit_reset = b_edge_delayed | wg;
        
    //--------------------------------------------------
    // DECODER OUTPUTS
    //--------------------------------------------------    
    // Generate the output signals using basic combinational comparators
    always @(posedge clk)
    begin
        dot <= b_nedge & (units <= 2);
        dash <= b_nedge & (units >= 3);
        lg <= b_pedge & (units >= 3) &(units <= 6);
        wg <= ~b & (units >= 7); 
    end
    
endmodule