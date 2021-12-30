`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineers: James Fulton, Raphael Lepercq, & Wilson Liao 
// Create Date: 10/16/2021 12:39:39 PM
//////////////////////////////////////////////////////////////////////////////////


module EXMEM(RegWrite, CondWrite, Branch, MemWrite, MemRead, HLOp, HLSel, WAddy, LOen, HIen, flag, ALURes
            , Data2, PC, DST
            , RegWriteO, CondWriteO, BranchO, MemWriteO, MemReadO, HLOpO, HLSelO, WAddyO, LOenO, HIenO
            , flagO, ALUResO, Data2O, PCO, DSTO
            , WriteLo, WriteMem, WriteALU, WriteLoO, WriteMemO, WriteALUO, Clk, writeCacheO, sumO
            , writeCacheOO, sumOO, IDEX, EXMEM);
    input Clk, RegWrite, CondWrite, Branch, HLOp, HLSel, WAddy, LOen, HIen, flag, WriteMem, WriteLo, WriteALU, writeCacheO
            , sumO;
    input [1:0] MemWrite, MemRead;
    input [4:0] DST;
    input [31:0] Data2, PC, IDEX;
    input [63:0] ALURes;
    
    output reg RegWriteO, CondWriteO, BranchO, HLOpO, HLSelO, WAddyO, LOenO, HIenO, flagO, WriteMemO, WriteLoO, WriteALUO
            , writeCacheOO, sumOO;
    output reg [4:0] DSTO;
    output reg [1:0] MemWriteO, MemReadO;
    output reg [31:0] Data2O, PCO, EXMEM;
    output reg [63:0] ALUResO;
    
    
     reg RegWriteR, CondWriteR, BranchR, HLOpR, HLSelR, WAddyR, LOenR, HIenR, flagR, WriteMemR, WriteLoR, WriteALUR;
     reg [1:0]  MemWriteR, MemReadR;
     reg [4:0] DSTR;
     reg [31:0] Data2R, PCR;
     reg [63:0] ALUResR;
     
     initial begin
        BranchO = 0;
        flagO = 0;
        
     end
     
     always @(posedge Clk) begin
        
        EXMEM <= IDEX;
        
        BranchO <= Branch;
        
        HLOpO <= HLOp;
        
        HLSelO <= HLSel;
        
        MemWriteO <= MemWrite;
        
        MemReadO <= MemRead;
        
        WAddyO <= WAddy;
        
        LOenO <= LOen;
        
        HIenO <= HIen;
        
        ALUResO <= ALURes;
        
        Data2O <= Data2;
        
        flagO <= flag;
        
        PCO <= PC;
        
        DSTO <= DST;
        
        RegWriteO <= RegWrite;
        
        CondWriteO <= CondWrite;
        
        WriteLoO <= WriteLo;
        
        WriteMemO <= WriteMem;
   
        WriteALUO <= WriteALU;
        
        writeCacheOO <= writeCacheO;
        
        sumOO <= sumO;
        
        
        BranchR <= Branch;
       
        HLOpR <= HLOp;
     
        HLSelR <= HLSel;
       
        MemWriteR <= MemWrite;
       
        MemReadR <= MemRead;
       
        WAddyR <= WAddy;
       
        LOenR <= LOen;
        
        HIenR <= HIen;
        
        ALUResR <= ALURes;
        
        Data2R <= Data2;
        
        flagR <= flag;
        
        PCR <= PC;
       
        DSTR <= DST;
       
        RegWriteR <= RegWrite;
       
        CondWriteR <= CondWrite;

        WriteLoR <= WriteLo;
        
        WriteMemR <= WriteMem;
        
        WriteALUR <= WriteALU;
    end
    
endmodule
