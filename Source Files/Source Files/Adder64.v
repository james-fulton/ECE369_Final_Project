`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineers: James Fulton, Raphael Lepercq, & Wilson Liao 
// Create Date: 10/16/2021 10:58:59 AM
//////////////////////////////////////////////////////////////////////////////////

module Adder64(A, B, out);

    input [63:0] A, B;
    output reg [63:0] out;
    
    always @(A, B) begin
        out = A + B;
    end
    
endmodule
