`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineers: James Fulton, Raphael Lepercq, & Wilson Liao
// Create Date: 10/17/2021 09:55:44 AM
//////////////////////////////////////////////////////////////////////////////////

module sub(A, B, out);

    input [63:0] A, B;
    output reg [63:0] out;
    
    always @(A, B) begin
        out = A - B;
    end
    
endmodule
