`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Raphael Lepercq
// Create Date: 11/05/2021 06:14:12 PM
//////////////////////////////////////////////////////////////////////////////////

module StallingMux(IDStall, RegWrite, CondWrite, SignedConst, RegDst, Link_I, ALUSrc, ALUOp_I, JumpSRC, Jump, Branch_I, MemWrite_I, MemRead_I, HLop_I
                    , HLSel_I, WAddy_I, WriteLo_I, WriteMem_I, WriteALU_I, LOen_I, HIen_I, writeCache_I, sum_I
                    , RegW, CondW, SignedC, RegD, Link, ALUS, ALUOp, JSRC, J, Branch, MemWrite, MemRead, HLop, HLSel, WAddy, WriteLo, WriteMem
                    , WriteALU, LOen, HIen, writeCache, sum);
                    
    input IDStall, RegWrite, CondWrite, SignedConst, RegDst, Link_I, ALUSrc, JumpSRC, Jump, Branch_I, HLop_I, HLSel_I, WAddy_I, WriteLo_I, WriteMem_I
                  , WriteALU_I, LOen_I, HIen_I, writeCache_I, sum_I;
    input [1:0] MemWrite_I, MemRead_I;
    input [5:0] ALUOp_I;
    
    output reg RegW, CondW, SignedC, RegD, Link, ALUS, JSRC, J, Branch, HLop, HLSel, WAddy, WriteLo, WriteMem, WriteALU, LOen, HIen, writeCache, sum;
    output reg [1:0] MemWrite, MemRead;
    output reg [5:0] ALUOp;
    
    always @ (*) begin
        if(IDStall == 1) begin
            RegW <= 0;
            CondW <= 0;
            SignedC <= 0;
            RegD <= 0;
            Link <= 0;
            ALUS <= 0;
            JSRC <= 0;
            J <= 0;
            Branch <= 0;
            HLop <= 0;
            HLSel <= 0;
            WAddy <= 0;
            WriteLo <= 0;
            WriteMem <= 0;
            WriteALU <= 0;
            LOen <= 0;
            HIen <= 0;
            MemWrite <= 0;
            MemRead <= 0;
            ALUOp <= 0;
            writeCache <= 0;
            sum <= 0;
        end
        else begin
            RegW <= RegWrite;
            CondW <= CondWrite;
            SignedC <= SignedConst;
            RegD <= RegDst;
            Link <= Link_I;
            ALUS <= ALUSrc;
            JSRC <= JumpSRC;
            J <= Jump;
            Branch <= Branch_I;
            HLop <= HLop_I;
            HLSel <= HLSel_I;
            WAddy <= WAddy_I;
            WriteLo <= WriteLo_I;
            WriteMem <= WriteMem_I;
            WriteALU <= WriteALU_I;
            LOen <= LOen_I;
            HIen <= HIen_I;
            MemWrite <= MemWrite_I;
            MemRead <= MemRead_I;
            ALUOp <= ALUOp_I;
            writeCache <= writeCache_I;
            sum <= sum_I;
        end
    end
endmodule
