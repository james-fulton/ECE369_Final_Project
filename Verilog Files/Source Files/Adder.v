`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineers: James Fulton, Raphael Lepercq, & Wilson Liao 
// Create Date: 10/16/2021 10:58:59 AM 
//////////////////////////////////////////////////////////////////////////////////

module Adder(A, B, out);

    input [31:0] A, B;
    output reg [31:0] out;
    
    always @(*) begin
        out <= A + B;
    end
endmodule
