`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineers: James Fulton, Raphael Lepercq, & Wilson Liao 
// 
// Create Date: 10/27/2021 04:40:34 AM
// Design Name: 
// Module Name: TOPTOP
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

module TOPTOP(Reset, Clk, out7, en_out);
    input Reset, Clk;
    output [6:0] out7;
    output [7:0] en_out; 
    
    wire ClkOut;
    wire [31:0] Instruction;
    wire [31:0] PC_PCRes;
    wire [31:0] writeBACK;
    wire [31:0] SAD, v0, v1;
    wire [31:0] LOout;

    //ClkDiv(Clk, Rst, ClkOut);
    ClkDiv clk(.Clk(Clk), .Rst(Reset), .ClkOut(ClkOut));
    
    //module toplevel(Clk, Reset, PC_PCRes, SAD, v0, v1)
    toplevel top(.Clk(ClkOut), .Reset(Reset), .PC_PCRes(PC_PCRes), .SAD(SAD), .v0(v0), .v1(v1));
    
    //Two4DigitDisplay(Clk, NumberA, NumberB, out7, en_out);
    //Two4DigitDisplay display(.Clk(Clk), .NumberA(PC_PCRes[15:0]), .NumberB(writeBACK[15:0]), .out7(out7), .en_out(en_out));
    Two4DigitDisplay display(.Clk(Clk), .NumberA(v1[15:0]), .NumberB(v0[15:0]), .out7(out7), .en_out(en_out));

endmodule
