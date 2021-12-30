`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineers: James Fulton, Raphael Lepercq, & Wilson Liao 
// Create Date: 10/16/2021 12:39:39 PM
//////////////////////////////////////////////////////////////////////////////////

module IFID(IFIDWrite, IF_Flush, PC, PC_out, Instruction, Instruction_out, Clk);
    input Clk, IFIDWrite, IF_Flush;
    input [31:0] PC, Instruction;
    output reg [31:0] PC_out, Instruction_out;
    
    reg [31:0] PC_prev, I_prev;
    
    always @(posedge Clk) begin
        if(IFIDWrite == 0) begin
            PC_out = PC_prev;
            Instruction_out = I_prev;
        end
        else if (IF_Flush == 1) begin
            Instruction_out = 32'b0;
            I_prev = 32'b0;
            PC_out = PC; 
        end
        else begin
            PC_prev = PC;
            I_prev = Instruction;
            
            PC_out = PC;
            Instruction_out = Instruction;
        end
    end

endmodule
