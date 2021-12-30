`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Raphael Lepercq
// Create Date: 12/08/2021 12:08:51 AM
//////////////////////////////////////////////////////////////////////////////////

//Forwarding Forwarding(.IDEX_Instruction(IDEX_Instruction)
 //                  , .IDEX_RegisterWrite(RegWO), .IDEX_MemRead(MemReadO), .IDEX_RegisterRs(IDEX_Instruction[25:21])
 ///                  , .IDEX_RegisterRt(DST1), .EXMEM_RegisterWrite(RegWriteOO), .EXMEM_RegisterRd(DSTOO)
 //                  , .MEMWB_RegisterWrite(RegWriteOOO), .MEMWB_RegisterRd(WRITEDST)
  //                 , .ALUSelMuxA(ALUSelMuxA), .ALUSelMuxB(ALUSelMuxB));
module Forwarding(IDEX_Instruction, IDEX_RegisterRs
           , IDEX_RegisterRt, EXMEM_RegisterWrite, EXMEM_RegisterRd, MEMWB_RegisterWrite, MEMWB_RegisterRd
           , ALUSelMuxA, ALUSelMuxB);
    
    input [31:0] IDEX_Instruction;
    input [4:0]  IDEX_RegisterRs, IDEX_RegisterRt, EXMEM_RegisterRd, MEMWB_RegisterRd;
    input EXMEM_RegisterWrite, MEMWB_RegisterWrite;
    
    output reg [1:0] ALUSelMuxA, ALUSelMuxB;
    
    initial begin
        ALUSelMuxA <= 0;
        ALUSelMuxB <= 0;
    end
    
    always @ (*) begin
        
        //sw
    /*    if (IDEX_Instruction[31:26] == 6'b101011) begin
            ALUSelMuxA = 0;
            ALUSelMuxB = 0;
        end 
        //  For I-Type instructions (At least those with Rt as return reg)
        else */ if (IDEX_Instruction[31:26] == 6'b001000 || IDEX_Instruction[31:26] == 6'b001001 || IDEX_Instruction[31:26] == 6'b001000 || IDEX_Instruction[31:26] == 6'b100011 
        || IDEX_Instruction[31:26] == 6'b100001 || IDEX_Instruction[31:26] == 6'b100000 || IDEX_Instruction[31:26] == 6'b001111 || IDEX_Instruction[31:26] == 6'b001100
        || IDEX_Instruction[31:26] == 6'b001101 || IDEX_Instruction[31:26] == 6'b001110 || IDEX_Instruction[31:26] == 6'b001010 || IDEX_Instruction[31:26] == 6'b001011) begin
            if ((EXMEM_RegisterWrite == 1) && (EXMEM_RegisterRd == IDEX_RegisterRs)) begin
             
                    ALUSelMuxA = 1;
            end
            else if ((MEMWB_RegisterWrite == 1) && (MEMWB_RegisterRd == IDEX_RegisterRs)) begin
                    
                    ALUSelMuxA = 2;
            end
            else  begin
                    
                    ALUSelMuxA = 0;
            end
         end
         
         else begin  
            if ((EXMEM_RegisterWrite == 1) && (EXMEM_RegisterRd == IDEX_RegisterRs)) begin
             
                    ALUSelMuxA = 1;
            end
            else if ((MEMWB_RegisterWrite == 1) && (MEMWB_RegisterRd == IDEX_RegisterRs)) begin
                    
                    ALUSelMuxA = 2;
            end
            else  begin
                    
                    ALUSelMuxA = 0;
            end
             
            if ((EXMEM_RegisterWrite == 1) && (EXMEM_RegisterRd == IDEX_RegisterRt)) begin
            
                    ALUSelMuxB = 1;
            end
            else if ((MEMWB_RegisterWrite == 1) && (MEMWB_RegisterRd == IDEX_RegisterRt)) begin
                    
                    ALUSelMuxB = 2;
            end
            else  begin
                    
                    ALUSelMuxB = 0;
            end
         end
    end
endmodule
