`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineers: James Fulton, Raphael Lepercq, & Wilson Liao 
// Create Date: 10/17/2021 09:43:23 AM
//////////////////////////////////////////////////////////////////////////////////

module LO(in, out, LOen, Clk);
    input LOen, Clk;
    input [31:0] in;
    output reg [31:0] out;
    
    reg [31:0] LOreg;
    
    initial begin
        LOreg <= 0;
    end
    
    always @(posedge Clk) begin
        if (LOen == 1) begin
            LOreg <= in;
        end
    end
    always @(*) begin
        out <= LOreg;  
    end

endmodule
