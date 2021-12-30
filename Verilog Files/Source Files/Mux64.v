`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// Engineers: James Fulton, Raphael Lepercq, & Wilson Liao 
// 
// Module - Mux32Bit2To1.v
// Description - Performs signal multiplexing between 2 32-Bit words.
////////////////////////////////////////////////////////////////////////////////

module Mux64(out, inA, inB, sel);

    output reg [63:0] out;
    
    input [63:0] inA;
    input [63:0] inB;
    input sel;

     always @(inA, inB, sel)
     
     begin
         if (sel == 0)
         out = inA;
         else
         out = inB;
     end
   
endmodule
