`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineers: James Fulton, Raphael Lepercq, & Wilson Liao 
// Create Date: 10/17/2021 07:49:08 AM
//////////////////////////////////////////////////////////////////////////////////

module leftShift(in, out);
    input [31:0] in;
    output reg [31:0] out;
    
    always @(*) begin
        out = in << 2;
    end
endmodule
