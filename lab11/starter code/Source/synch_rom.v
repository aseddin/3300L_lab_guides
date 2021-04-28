`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2021 12:08:11 PM
// Design Name: 
// Module Name: synch_rom
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


module synch_rom(
    input clk,
    input [7:0] addr,
    output reg [7:0] data
    );

    (*rom_style = "block"*) reg [7:0] rom [0:255];
    
    initial
        $readmemh("morse2ascii_lut.mem", rom);
        
    always @(posedge clk)
    begin
        data <= rom[addr];
    end    
endmodule
