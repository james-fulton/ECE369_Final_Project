`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineers: James Fulton, Raphael Lepercq, & Wilson Liao 
// Create Date: 10/16/2021 12:35:12 PM
//////////////////////////////////////////////////////////////////////////////////

module MEMWB(RegWrite, flag, CondWrite, WriteLo, WriteMem, WriteALU, HI, LO, MEM_DATA, WADDY_VAL, Write_Reg
            , RegWriteO, flagO, CondWriteO, WriteLoO, WriteMemO, WriteALUO, HIO, LOO
            , MEM_DATAO, WADDY_VALO, Write_RegO, Clk, sumOO, sumOOO, sumOut, sumOutO);
            
            input Clk, RegWrite, flag, CondWrite, WriteLo, WriteMem, WriteALU, sumOO;
            input [4:0] Write_Reg;
            input [31:0] HI, LO, MEM_DATA, WADDY_VAL, sumOut;
            
            output reg RegWriteO, flagO, CondWriteO, WriteLoO, WriteMemO, WriteALUO, sumOOO;
            output reg [4:0] Write_RegO;
            output reg [31:0] HIO, LOO, MEM_DATAO, WADDY_VALO, sumOutO;
           
            reg RegWriteR, flagR, CondWriteR, WriteLoR, WriteMemR, WriteALUR;
            reg [4:0] Write_RegR;
            reg [31:0] HIR, LOR, MEM_DATAR, WADDY_VALR;
            
            always @(posedge Clk) begin
            
                RegWriteO <= RegWrite;
                
                flagO <= flag;
                
                CondWriteO <= CondWrite;
                
                WriteLoO <= WriteLo;
                
                WriteMemO <= WriteMem;
                
                WriteALUO <= WriteALU;
            
                Write_RegO <= Write_Reg;
                
                HIO <= HIR;
                
                LOO <= LO;
                
                MEM_DATAO <= MEM_DATA;
                
                WADDY_VALO <= WADDY_VAL;
                
                sumOOO <= sumOO;
                
                sumOutO <= sumOut;
                
                
                RegWriteR <= RegWrite;
              
                flagR <= flag;
               
                CondWriteR <= CondWrite;
               
                WriteLoR <= WriteLo;
              
                WriteMemR <= WriteMem;
              
                WriteALUR <= WriteALU;
             
                Write_RegR <= Write_Reg;
               
                HIR <= HI;
               
                LOR <= LO;
               
                MEM_DATAR <= MEM_DATA;
           
                WADDY_VALR <= WADDY_VAL;
            end
endmodule            
