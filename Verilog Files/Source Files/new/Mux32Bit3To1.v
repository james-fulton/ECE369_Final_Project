`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE 369A - Computer Architecture
// Developers: James Fulton
// 
// Module - MUX32Bit_3x1.v
// Description - 32-Bit 3x1 Mux
//
// INPUTS:-
// inA: 32-Bit input
// inB: 32-Bit input
// inC: 32-Bit input
// select: 2-bit control input
//
// OUTPUTS:-
// outD: selected 32-Bit output
//
// FUNCTIONALITY:-
// if(select == 0){ return inA }
// else if(select == 1){ return inB }
// else{ return inC }
////////////////////////////////////////////////////////////////////////////////

module Mux32Bit3To1(out, inA, inB, inC, sel);

    //Input Ports
    input [31:0] inA, inB, inC;
    input [1:0] sel;

    //Output Port
    output reg [31:0] out;

    always @ (*) begin
        if (sel == 2'b00) begin
            out = inA;
        end
        else if (sel == 2'b01) begin
            out = inB;
        end
        else begin
            out = inC;
        end
    end   

endmodule
