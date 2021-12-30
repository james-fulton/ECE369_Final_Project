`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineers: James Fulton, Raphael Lepercq, & Wilson Liao 
// Create Date: 10/16/2021 12:39:39 PM
//////////////////////////////////////////////////////////////////////////////////

module IDEX(RegWrite, CondWrite, SignedConst, RegDst, Link, ALUSrc, ALUOP, JumpSRC, Jump, Branch, MemWrite, MemRead, HLOp, HLSel
                , WAddy, WriteLo, WriteMem, WriteALU, LOen, HIen, PC, ALUSrc2, Data1, Data2, SE, Dst1, Dst2, j25, RegWriteO, CondWriteO
                , SignedConstO, RegDstO, LinkO, ALUSrcO, ALUOPO, JumpSRCO, JumpO, BranchO, MemWriteO, MemReadO, HLOpO, HLSelO
                , WAddyO, WriteLoO, WriteMemO, WriteALUO, LOenO, HIenO, PCO, ALUSrc2O, Data1O, Data2O, SEO, Dst1O, Dst2O, j25O, Clk, writeCache, sum, writeCacheO, sumO
                , IFID, IDEX);

    input RegWrite, CondWrite, SignedConst, RegDst, Link, ALUSrc, JumpSRC, Jump, Branch, HLOp, HLSel
                , WAddy, WriteLo, WriteMem, WriteALU, LOen, HIen, Clk, writeCache, sum;
    input [1:0] MemWrite, MemRead;
    input [4:0] Dst1, Dst2;
    input [5:0] ALUOP;
    input [25:0] j25;
    input [31:0] SE, Data1, Data2, PC, ALUSrc2, IFID;
    
    
    output reg RegWriteO, CondWriteO
                , SignedConstO, RegDstO, LinkO, ALUSrcO, JumpSRCO, JumpO, BranchO, HLOpO, HLSelO
                , WAddyO, WriteLoO, WriteMemO, WriteALUO, LOenO, HIenO, writeCacheO, sumO;
    output reg [1:0] MemWriteO, MemReadO;
    output reg [5:0] ALUOPO;
    output reg [4:0] Dst1O, Dst2O;
    output reg [25:0] j25O;
    output reg [31:0] SEO, Data1O, Data2O, PCO, ALUSrc2O, IDEX;
    
    reg  RegWriteR, CondWriteR, SignedConstR, RegDstR, LinkR, ALUSrcR, JumpSRCR, JumpR, BranchR, HLOpR, HLSelR
                , WAddyR, WriteLoR, WriteMemR, WriteALUR, LOenR, HIenR;
    reg [1:0] MemWriteR, MemReadR;
    reg [5:0] ALUOPR;
    reg [4:0] Dst1R, Dst2R;
    reg [25:0] j25R;
    reg [31:0] SER, Data1R, Data2R, PCR;


    initial begin
        BranchO <= 0;
    end
    
    always @(posedge Clk) begin
        
        IDEX <= IFID;
        
        RegWriteO <= RegWrite;
        
        CondWriteO <= CondWrite;
        
        SignedConstO <= SignedConst;
        
        RegDstO <= RegDst;
        
        LinkO <= Link;
        
        ALUSrcO <= ALUSrc;
        
        ALUOPO <= ALUOP;
        
        JumpSRCO <= JumpSRC;
        
        JumpO <= Jump;
        
        BranchO <= Branch;
        
        HLOpO <= HLOp;
        
        HLSelO <= HLSel;
        
        WAddyO <= WAddy;
        
        WriteLoO <= WriteLo;
        
        WriteMemO <= WriteMem;
        
        WriteALUO <= WriteALU;
        
        LOenO <= LOen;
        
        HIenO <= HIen;
        
        PCO <= PC;
        
        ALUSrc2O <= ALUSrc2;
        
        Data1O <= Data1;
        
        Data2O <= Data2;
        
        SEO <= SE;
        
        Dst1O <= Dst1;
        
        Dst2O <= Dst2;
        
        j25O <= j25;
        
        MemWriteO <= MemWrite;
        
        MemReadO <= MemRead;
        
        //New Signal
        writeCacheO <= writeCache;
        
        sumO <= sum;
        
        
        RegWriteR <= RegWrite;
       
        CondWriteR <= CondWrite;
       
        SignedConstR <= SignedConst;
       
        RegDstR <= RegDst;
       
        LinkR <= Link;
       
        ALUSrcR <= ALUSrc;
        
        ALUOPR <= ALUOP;
      
        JumpSRCR <= JumpSRC;
      
        JumpR <= Jump;
     
        BranchR <= Branch;
    
        HLOpR <= HLOp;
   
        HLSelR <= HLSel;
   
        WAddyR <= WAddy;
  
        WriteLoR <= WriteLo;

        WriteMemR <= WriteMem;

        WriteALUR <= WriteALU;
        
        LOenR <= LOen;
        
        HIenR <= HIen;
        
        PCR <= PC;
        
        Data1R <= Data1;
        
        Data2R <= Data2;
        
        SER <= SE;
        
        Dst1R <= Dst1;
        
        Dst2R <= Dst2;
        
        j25R <= j25;
        
        MemWriteR <= MemWrite;
        
        MemReadR <= MemRead;
    end
endmodule
