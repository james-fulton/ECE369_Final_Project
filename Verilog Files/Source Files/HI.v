`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineers: James Fulton, Raphael Lepercq, & Wilson Liao 
// Create Date: 10/17/2021 09:43:23 AM
//////////////////////////////////////////////////////////////////////////////////


module HI(in, out, HIen, Clk);
    input HIen, Clk;
    input [31:0] in;
    output reg [31:0] out;
    
    reg [31:0] HIreg;
    
    initial begin
        HIreg <= 0;
    end
    
    always @(posedge Clk) begin
        if (HIen == 1) begin
            HIreg <= in;
        end
    end
    always @(*) begin
        out <= HIreg;
    end

endmodule