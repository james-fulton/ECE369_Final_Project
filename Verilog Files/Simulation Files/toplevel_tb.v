`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineers: James Fulton, Raphael Lepercq, & Wilson Liao 
// 
// Create Date: 11/05/2021 02:51:26 PM
// Design Name: 
// Module Name: toplevel_tb
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

module toplevel_tb();

    reg             Clk;
    reg             Reset;
    wire [31:0]     PC_PCRes;
    wire [31:0]     SAD, v0, v1;
    //module toplevel(Clk, Reset, PC_PCRes, SAD, v0, v1);
     
    toplevel u0(
        .Clk(Clk),
        .Reset(Reset),
        .PC_PCRes(PC_PCRes),
        .SAD(SAD),
        .v0(v0),
        .v1(v1)
    );
    //module toplevel(Clk, Reset, PC_PCRes, writeBACK, Instruction, LOout, SAD, v0, v1);
 
    initial begin
		Clk <= 1'b0;
		//forever #2.6 Clk <= ~Clk;
		forever #10 Clk <= ~Clk;
	end
	
	initial begin
	Reset <= 1;
    
    #10;
    Reset <= 0;
	end
	
endmodule
