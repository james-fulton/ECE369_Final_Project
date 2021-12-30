`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineers: James Fulton, Raphael Lepercq, & Wilson Liao
// Create Date: 10/16/2021 12:35:12 PM
//////////////////////////////////////////////////////////////////////////////////

module toplevel(Clk, Reset, PC_PCRes, SAD, v0, v1);
    
    input Clk, Reset;
 
    output wire [31:0] PC_PCRes;
    wire [31:0] Instruction;
    wire [31:0] HIout, WriteALURes, LOout;
    
    //PC STAGE START *******************************************************************************************************
    //*****************************************************************************************************************
    
    //Mux32Bit2To1(out, inA, inB, sel);
    wire [31:0] PC_added;
    //wire [31:0] JumpAddrO;
    wire [31:0] JumpAddr;
    wire [31:0] PCRes;
    wire PCSRC; //if sel is high it goes for b (if(sel==0) go A) => if (PCSRC == 1) go JumpAddrO
    Mux32Bit2To1 PCSrc(.out(PCRes), .inA(PC_added), .inB(JumpAddr), .sel(PCSRC));
    
    //module ProgramCounter(Address, PCResult, PCWrite, Reset, Clk
    wire PCWrite;
    ProgramCounter PC(.Address(PCRes), .PCResult(PC_PCRes), .PCWrite(PCWrite), .Reset(Reset), .Clk(Clk));
    
    //module InstructionMemory(Address, Instruction); 
    InstructionMemory IM(.Address(PC_PCRes), .Instruction(Instruction));
    
    //module Adder(A, B, out);
    Adder PCadder(.A(PC_PCRes), .B(4), .out(PC_added));
    
    //PC STAGE END *******************************************************************************************************
    //*****************************************************************************************************************
    
    //IFID STAGE START *****************************************************************************************************
    //*****************************************************************************************************************
    
    //module IFID(PC, PC_out, Instruction, Instruction_out);
    wire [31:0] IFID_PC;
    wire [31:0] IFID_Instruction;
    wire IFIDWrite;
    wire IF_Flush;
    IFID IFID(.IFIDWrite(IFIDWrite), .IF_Flush(IF_Flush), .PC(PC_added), .PC_out(IFID_PC), .Instruction(Instruction)
            , .Instruction_out(IFID_Instruction), .Clk(Clk));
    
    //module Controller(opcode, func, RegWrite, CondWrite, SignedConst, RegDst, Link, ALUSrc, ALUOp, JumpSRC, Jump, Branch
    //                              , MemWrite, MemRead, HLop, HLSel, WAddy, WriteLo, WriteMem, WriteALU, LOen, HIen, control_five
    //                              , control_ten_six);
    wire RegW_I, CondW_I, SignedC_I, RegD_I, Link_I, ALUS_I, JSRC_I, J_I, Branch_I, HLop_I, HLSel_I
        , WAddy_I, WriteLo_I, WriteMem_I, WriteALU_I, LOen_I, HIen_I;
    wire [1:0] MemWrite_I, MemRead_I;
    wire [5:0] ALUO_I;
    
    //New Instructions
    // wire [15:0] position;
    wire writeCache, sum, writeCache_I, sum_I;
    wire [31:0] sumOut;
    Controller Controller(.Instruction(IFID_Instruction)
               , .RegWrite(RegW_I), .CondWrite(CondW_I), .SignedConst(SignedC_I), .RegDst(RegD_I), .Link(Link_I)
               , .ALUSrc(ALUS_I), .ALUOp(ALUO_I), .JumpSRC(JSRC_I), .Jump(J_I), .Branch(Branch_I)
               , .MemWrite(MemWrite_I), .MemRead(MemRead_I), .HLop(HLop_I), .HLSel(HLSel_I), .WAddy(WAddy_I)
               , .WriteLo(WriteLo_I), .WriteMem(WriteMem_I), .WriteALU(WriteALU_I), .LOen(LOen_I), .HIen(HIen_I), .writeCache(writeCache_I), .sum(sum_I));
 //TODO add PCSrc sel bit here to go to PCSrc sel mux
 //check what hazard is doing with that PCSrc sel bit              
    
    wire Branch;
    wire RegW, CondW, SignedC, RegD, Link, JSRC, J, HLop, HLSel
        , WAddy, WriteLo, WriteMem, WriteALU, LOen, HIen, IDStall;
    wire ALUS;
    wire [1:0] MemWrite, MemRead;
    wire [5:0] ALUO;
    wire [4:0] IDEX_RegisterRd, IDEX_RegisterRt, EXMEM_RegisterRd, EXMEM_RegisterRt, MEMWB_RegisterRd; 
    wire [4:0] DST1, DST2;
    wire [4:0] Link0;
    wire [4:0] WriteRAddr;
    wire [1:0] MemWriteO, MemReadO, IDEX_MemRead, EXMEM_MemRead;
    wire [1:0] MemWriteOO;
    wire [1:0] MemReadOO;
    wire [4:0] DSTOO;
    wire [4:0] WRITEDST;
    wire RegWriteOOO, flagOO, CondWriteOO, flagOOO, CondWriteOOO, WriteLoOOO, WriteALUOOO, WriteMemOOO, BranchO;
    wire IDEX_RegisterWrite, EXMEM_RegisterWrite, MEMWB_RegisterWrite, RegWO, RegWriteOO;
    wire [3:0] SEL;
    //module HazardDetector(IFID_Instruction, IFID_RegisterRs, IFID_RegisterRt, IDEX_RegisterRd, IDEX_RegisterWrite
    //        , IDEX_MemRead, EXMEM_RegisterRd, EXMEM_RegisterWrite, MEMWB_RegisterRd, MEMWB_RegisterWrite //inputs 'till here
    //        , PCWrite, IFIDWrite, IDStall, Branch, BranchEX, SEL, IF_Flush, PCSRC); //outputs
    HazardDetector HazardDetector(.IFID_Instruction(IFID_Instruction), .IFID_RegisterRs(IFID_Instruction[25:21])
                   , .IFID_RegisterRt(IFID_Instruction[20:16]), .IDEX_Instruction(IDEX_Instruction) 
                   , .IDEX_RegisterRd(WriteRAddr), .IDEX_RegisterWrite(RegWO), .IDEX_MemRead(MemReadO), .EXMEM_Instruction(EXMEM_Instruction)
                   , .EXMEM_RegisterRd(DSTOO), .EXMEM_RegisterWrite(RegWriteOO), .EXMEM_MemRead(MemReadOO)
                   , .MEMWB_RegisterRd(WRITEDST), .MEMWB_RegisterWrite(RegWriteOOO)
                   , .PCWrite(PCWrite), .IFIDWrite(IFIDWrite), .IDStall(IDStall)
                   , .SEL(SEL), .IF_Flush(IF_Flush), .PCSRC(PCSRC));
                                    // IDStall, branch, IDEX_branch
    
    //module StallingMux(IDStall, RegWrite, CondWrite, SignedConst, RegDst, Link_I, ALUSrc, ALUOp_I, JumpSRC, Jump, Branch_I, MemWrite_I, MemRead_I, HLop_I
    //                , HLSel_I, WAddy_I, WriteLo_I, WriteMem_I, WriteALU_I, LOen_I, HIen_I
    //                , RegW, CondW, SignedC, RegD, Link, ALUS, ALUOp, JSRC, J, Branch, MemWrite, MemRead, HLop, HLSel, WAddy, WriteLo, WriteMem
    //                , WriteALU, LOen, HIen);
    StallingMux StallingMux(.IDStall(IDStall), .RegWrite(RegW_I), .CondWrite(CondW_I), .SignedConst(SignedC_I), .RegDst(RegD_I)
                , .Link_I(Link_I), .ALUSrc(ALUS_I), .ALUOp_I(ALUO_I), .JumpSRC(JSRC_I), .Jump(J_I), .Branch_I(Branch_I), .MemWrite_I(MemWrite_I)
                , .MemRead_I(MemRead_I), .HLop_I(HLop_I), .HLSel_I(HLSel_I), .WAddy_I(WAddy_I), .WriteLo_I(WriteLo_I), .WriteMem_I(WriteMem_I)
                , .WriteALU_I(WriteALU_I), .LOen_I(LOen_I), .HIen_I(HIen_I), .writeCache_I(writeCache_I), .sum_I(sum_I)
                , .RegW(RegW), .CondW(CondW), .SignedC(SignedC), .RegD(RegD), .Link(Link), .ALUS(ALUS), .ALUOp(ALUO), .JSRC(JSRC), .J(J)
                , .Branch(Branch), .MemWrite(MemWrite), .MemRead(MemRead), .HLop(HLop), .HLSel(HLSel), .WAddy(WAddy), .WriteLo(WriteLo)
                , .WriteMem(WriteMem), .WriteALU(WriteALU), .LOen(LOen), .HIen(HIen), .writeCache(writeCache), .sum(sum));
    
    
    //Mux32Bit2To1(out, inA, inB, sel); //mux in front of register file
    wire [31:0] REGWRITE_OUT;
    wire CondWrite;
    Mux32Bit2To1 RegWRITE(.out(REGWRITE_OUT), .inA(RegWriteOOO), .inB(flagOOO), .sel(CondWriteOOO));
    
    
    //module RegisterFile(ReadRegister1, ReadRegister2, WriteRegister, WriteData, RegWrite, Clk, ReadData1, ReadData2, SAD, v0, v1);
    //WriteRegister = WRITEDST
    //WriteData = WriteALURes
    wire [31:0] ReadData1, ReadData2, ReadData1_I, ReadData2_I;
    output [31:0] SAD, v0, v1;
	//new signal
    wire [31:0] writeBACK;
    RegisterFile GPR(.ReadRegister1(IFID_Instruction[25:21]), .ReadRegister2(IFID_Instruction[20:16])
                    , .WriteRegister(WRITEDST), .WriteData(writeBACK)
                    , .RegWrite(REGWRITE_OUT[0]), .Clk(Clk), .ReadData1(ReadData1_I), .ReadData2(ReadData2_I)
                    , .SAD(SAD), .v0(v0), .v1(v1));
    
    
    //module SignExtension(SignedConst, in, out);
    wire [31:0] SignEXed;
    SignExtension SE(.SignedConst(SignedC), .in(IFID_Instruction[15:0]), .out(SignEXed));
    
    //module leftShift(in, out);
    wire [31:0] leftShifted; //imm * 4
    leftShift LS(.in(SignEXed), .out(leftShifted));
    
    //module Adder(A, B, out);
    wire [31:0] JumpSrc0;
    Adder addJump(.A(leftShifted), .B(IFID_PC), .out(JumpSrc0)); //TODO Can I not just take JumpSrc0 and bring it to the PCSrcMux?
    
    //Mux32Bit2To1(out, inA, inB, sel);
    wire [31:0] Jump0;
    Mux32Bit2To1 JumpSrc(.out(Jump0), .inA(JumpSrc0), .inB(ReadData1_I), .sel(JSRC)); //TODO I guess this selects between jr and j/beq/etc
    
    //module leftShift(in, out);
    wire [31:0] leftShiftedJ25;
    leftShift J25LS(.in({6'b0, IFID_Instruction[25:0]}), .out(leftShiftedJ25));     //TODO for j instrctns I guess
    
    //Mux32Bit2To1(out, inA, inB, sel);
    //wire [31:0] JumpAddr;
    Mux32Bit2To1 Jump(.out(JumpAddr), .inA(Jump0), .inB(leftShiftedJ25), .sel(J));
    
    wire [1:0] ReadRegSelMuxA, ReadRegSelMuxB;
    wire [63:0] ALUResOO;
    //module ForwardingID(IFID_Instruction, IFID_RegisterRs
    //       , IFID_RegisterRt, EXMEM_RegisterWrite, EXMEM_RegisterRd, MEMWB_RegisterWrite, MEMWB_RegisterRd
     //      , ReadRegSelA, ReadRegSelB);
    ForwardingID ForwardingID(.IFID_Instruction(IFID_Instruction), .IFID_RegisterRs(IFID_Instruction[25:21])
                   , .IFID_RegisterRt(IFID_Instruction[20:16]), .EXMEM_RegisterWrite(RegWriteOO), .EXMEM_RegisterRd(DSTOO)
                   , .MEMWB_RegisterWrite(RegWriteOOO), .MEMWB_RegisterRd(WRITEDST)
                   , .ReadRegSelA(ReadRegSelMuxA), .ReadRegSelB(ReadRegSelMuxB));

    //module Mux32Bit3To1(out, inA, inB, inC, sel);
    Mux32Bit3To1 EquMuxA(ReadData1, ReadData1_I, ALUResOO, writeBACK, ReadRegSelMuxA);
    
    //module Mux32Bit3To1(out, inA, inB, inC, sel);
    Mux32Bit3To1 EquMuxB(ReadData2, ReadData2_I, ALUResOO, writeBACK, ReadRegSelMuxB);
    
    //EqualComparator(A, B, equalControl, equalFlag);
    wire eqflag;
    EqualComparator Comparator(.A(ReadData1), .B(ReadData2), .equalControl(ALUO), .equalFlag(eqflag));
    
    //module And(A, B, out);
    And BranchAnd(.A(Branch), .B(eqflag), .out(PCSRC));
    
    //IFID STAGE END ************************************************************************************************
    //*****************************************************************************************************************
    
    
    //IDEX STAGE START *****************************************************************************************************
    //*****************************************************************************************************************
    
    //module IDEX(RegWrite, CondWrite, SignedConst, RegDst, Link, ALUSrc, ALUOP, JumpSRC, Jump, Branch, MemWrite, MemRead, HLOp, HLSel
    //            , WAddy, WriteLo, WriteMem, WriteALU, LOen, HIen, PC, ALUSrc2, Data1, Data2, SE, Dst1, Dst2, j25, RegWriteO, CondWriteO
    //            , SignedConstO, RegDstO, LinkO, ALUSrcO, ALUOPO, JumpSRCO, JumpO, BranchO, MemWriteO, MemReadO, HLOpO, HLSelO
    //            , WAddyO, WriteLoO, WriteMemO, WriteALUO, LOenO, HIenO, PCO, ALUSrc2O, Data1O, Data2O, SEO, Dst1O, Dst2O, j25O, Clk);
    wire CondWO, SignedCO, RegDO, LinkO, ALUSO, JSRCO, JO, HLopO, HLSelO
        , WAddyO, WriteLoO, WriteMemO, WriteALUO, LOenO, HIenO, control_fiveO, control_ten_sixO;
    wire [25:0] J25;
    wire [5:0] ALUOO;
    wire [31:0] SignEXedO; //, PC_addedO, ReadData2O; //, ALUSrc2O;
    wire [31:0] PC_addedO, ReadData2O;
    wire [31:0] ALUSrc2O;
    wire [31:0] ReadData1O;
    
    //new signal
    wire writeCacheO, sumO;
    wire [31:0] ALUSrc2;
    wire [31:0] IDEX_Instruction;
    IDEX IDEX(.RegWrite(RegW), .CondWrite(CondW), .SignedConst(SignedC), .RegDst(RegD), .Link(Link)
               , .ALUSrc(ALUS), .ALUOP(ALUO), .JumpSRC(JSRC), .Jump(J), .Branch(Branch)
               , .MemWrite(MemWrite), .MemRead(MemRead), .HLOp(HLop), .HLSel(HLSel), .WAddy(WAddy)
               , .WriteLo(WriteLo), .WriteMem(WriteMem), .WriteALU(WriteALU)
               , .LOen(LOen), .HIen(HIen), .PC(IFID_PC), .ALUSrc2(ALUSrc2), .Data1(ReadData1), .Data2(ReadData2)
               , .SE(SignEXed), .Dst1(IFID_Instruction[20:16]), .Dst2(IFID_Instruction[15:11])
               , .j25(IFID_Instruction[25:0])
               , .RegWriteO(RegWO), .CondWriteO(CondWO), .SignedConstO(SignedCO), .RegDstO(RegDO), .LinkO(LinkO)
               , .ALUSrcO(ALUSO), .ALUOPO(ALUOO), .JumpSRCO(JSRCO), .JumpO(JO), .BranchO(BranchO)
               , .MemWriteO(MemWriteO), .MemReadO(MemReadO), .HLOpO(HLopO), .HLSelO(HLSelO), .WAddyO(WAddyO)
               , .WriteLoO(WriteLoO), .WriteMemO(WriteMemO), .WriteALUO(WriteALUO)
               , .LOenO(LOenO), .HIenO(HIenO), .PCO(PC_addedO), .ALUSrc2O(ALUSrc2O), .Data1O(ReadData1O), .Data2O(ReadData2O)
               , .SEO(SignEXedO), .Dst1O(DST1), .Dst2O(DST2) , .j25O(J25), .Clk(Clk), .writeCache(writeCache), .sum(sum), .writeCacheO(writeCacheO), .sumO(sumO)
               , .IFID(IFID_Instruction), .IDEX(IDEX_Instruction));
    
    wire [1:0] ALUSelMuxA, ALUSelMuxB;
    wire [31:0] ALUSrcA, ALUSrcB;

    //module Forwarding(IDEX_Instruction, IDEX_RegisterRs
    //       , IDEX_RegisterRt, EXMEM_RegisterWrite, EXMEM_RegisterRd, MEMWB_RegisterWrite, MEMWB_RegisterRd
    //       , ALUSelMuxA, ALUSelMuxB);
    Forwarding Forwarding(.IDEX_Instruction(IDEX_Instruction), .IDEX_RegisterRs(IDEX_Instruction[25:21])
                   , .IDEX_RegisterRt(IDEX_Instruction[20:16]), .EXMEM_RegisterWrite(RegWriteOO), .EXMEM_RegisterRd(DSTOO)
                   , .MEMWB_RegisterWrite(RegWriteOOO), .MEMWB_RegisterRd(WRITEDST)
                   , .ALUSelMuxA(ALUSelMuxA), .ALUSelMuxB(ALUSelMuxB));
                   
    //module Mux32Bit3To1(out, inA, inB, inC, sel);
    Mux32Bit3To1 ALUMuxA(ALUSrcA, ReadData1O, ALUResOO, writeBACK, ALUSelMuxA);
    
    //module Mux32Bit3To1(out, inA, inB, inC, sel);
    Mux32Bit3To1 ALUMuxB(ALUSrcB, ReadData2O, ALUResOO, writeBACK, ALUSelMuxB);
     
    //Mux32Bit2To1(out, inA, inB, sel);
    Mux32Bit2To1 ALUSrc(.out(ALUSrc2), .inA(ALUSrcB), .inB(SignEXedO), .sel(ALUSO));
 
    //module ALU32Bit(ALUControl, A, B, ALUResult, Zero, sa);
    wire [63:0] ALURes;
    wire flag;
    ALU32Bit ALU(.ALUControl(ALUOO), .A(ALUSrcA), .B(ALUSrc2), .ALUResult(ALURes), .Zero(flag)
                        , .sa(SignEXedO[10:6]));
    
    //Mux32Bit2To1(out, inA, inB, sel);
    Mux32Bit2To1 RegDst(.out(Link0), .inA(DST1), .inB(DST2), .sel(RegDO));
    
    //Mux32Bit2To1(out, inA, inB, sel);
    Mux32Bit2To1 LinkMux(.out(WriteRAddr), .inA(Link0), .inB(31), .sel(LinkO));
    
    //IDEX STAGE END*****************************************************************************************************
    //*****************************************************************************************************************

    //EXMEM STAGE START **************************************************************************************************
    //*****************************************************************************************************************

    wire HLOpOO, HLSelOO, WAddyOO, LOenOO, HIenOO, BranchOO;
    wire [31:0] Data2OO, PCOO;
    wire WriteLoOO, WriteMemOO, WriteALUOO;
    wire writeCacheOO, sumOO;
    wire [31:0] EXMEM_Instruction;
    EXMEM EXMEM(.RegWrite(RegWO), .CondWrite(CondWO), .Branch(BranchO), .MemWrite(MemWriteO)
            , .MemRead(MemReadO), .HLOp(HLopO), .HLSel(HLSelO), .WAddy(WAddyO), .LOen(LOenO), .HIen(HIenO)
            , .flag(flag), .ALURes(ALURes), .Data2(ALUSrcB), .PC(PC_addedO), .DST(WriteRAddr)
            , .RegWriteO(RegWriteOO), .CondWriteO(CondWriteOO), .BranchO(BranchOO), .MemWriteO(MemWriteOO)
            , .MemReadO(MemReadOO), .HLOpO(HLOpOO), .HLSelO(HLSelOO), .WAddyO(WAddyOO), .LOenO(LOenOO)
            , .HIenO(HIenOO), .flagO(flagOO), .ALUResO(ALUResOO), .Data2O(Data2OO), .PCO(PCOO), .DSTO(DSTOO)
            , .WriteLo(WriteLoO), .WriteMem(WriteMemO), .WriteALU(WriteALUO)
            , .WriteLoO(WriteLoOO), .WriteMemO(WriteMemOO), .WriteALUO(WriteALUOO), .Clk(Clk), .writeCacheO(writeCacheO), .sumO(sumO), .writeCacheOO(writeCacheOO), .sumOO(sumOO)
            , .IDEX(IDEX_Instruction), .EXMEM(EXMEM_Instruction));
            
    //module Adder(A, B, out);
    wire [63:0] HLadd;
    Adder64 HILOAdder(.A(ALUResOO), .B({HIout, LOout}), .out(HLadd));
    
    wire [63:0] HLsub;
    sub HILOSubtractor(.A({HIout, LOout}), .B(ALUResOO), .out(HLsub));
    
    //Mux64(out, inA, inB, sel);
    wire [63:0] HLsel1;
    Mux64 HLOp(.out(HLsel1), .inA(HLadd), .inB(HLsub), .sel(HLOpOO));
    
    //Mux64(out, inA, inB, sel);
    wire [63:0] HILO;
    Mux64 HLsel(.out(HILO), .inA(ALUResOO), .inB(HLsel1), .sel(HLSelOO));
    
    //HI(in, out, HIen, Clk);
    HI HIreg(.in(HILO[63:32]), .out(HIout), .HIen(HIenOO), .Clk(Clk));
    
    //LO(in, out);
    LO LOreg(.in(HILO[31:0]), .out(LOout), .LOen(LOenOO), .Clk(Clk));
    
    
    //module WriteMem(Address, MemWrite, WriteDataIN, WriteDataOUT);
    wire [31:0] WriteDataOUT;
    WriteMem WriteChange(.Address(ALUResOO), .MemWrite(MemWriteOO), .WriteDataIN(Data2OO), .WriteDataOUT(WriteDataOUT));
    
    
    //module DataMemory(Address, WriteData, Clk, MemWrite, MemRead, ReadData);  //MemRead is control signal, ReadData is output
    wire [31:0] MemReadData;
    wire [31:0] ReadIN;
    DataMemory Memory(.Address(ALUResOO), .WriteData(WriteDataOUT), .Clk(Clk), .MemWrite(MemWriteOO)
                            , .MemRead(MemReadOO), .ReadData(ReadIN));
    
    
    //module ReadMem(Address, MemRead, MemDataIN, MemDataOUT
    ReadMem ReadChange(.Address(ALUResOO), .MemRead(MemReadOO), .MemDataIN(ReadIN), .MemDataOUT(MemReadData));
    
    //Mux32 Bit2To1(out, inA, inB, sel);
    wire [31:0] WAddyRes;
    Mux32Bit2To1 WAddyMux(.out(WAddyRes), .inA(ALUResOO), .inB(PCOO), .sel(WAddyOO));
   
    //module cache(WriteData, position, writeCache, sum, sumOut);
    //Writes Absolute difference into Cache, computes sum when necessary
    //module cache(writeData, writeCache, sum, sumOut);
    cache Cache(.writeData(ALUResOO[31:0]), .writeCache(writeCacheOO), .sum(sumOO), .sumOut(sumOut));
    
    //EXMEM STAGE END **************************************************************************************************
    //*****************************************************************************************************************
    
    //MEMWB STAGE **************************************************************************************************
    //*****************************************************************************************************************
    
    //module MEMWB(RegWrite, flag, CondWrite, WriteLo, WriteMem, WriteALU, HI, LO, MEM_DATA, WADDY_VAL
    //              , Write_Reg ,RegWriteO, flagO, CondWriteO, WriteLoO, WriteMemO, WriteALUO, HIO, LOO, MEM_DATAO
    //              , WADDY_VALO, Write_RegO);
     
    wire [31:0] HIOUT, MEMDATAO;
    wire [31:0] LOOUT;
    wire [31:0] WADDYO;
    
    //New signal
    wire [31:0] sumOutO;
    wire sumOOO;
    MEMWB MEMWB(.RegWrite(RegWriteOO), .flag(flagOO), .CondWrite(CondWriteOO), .WriteLo(WriteLoOO)
            , .WriteMem(WriteMemOO), .WriteALU(WriteALUOO), .HI(HIout), .LO(LOout), .MEM_DATA(MemReadData)
            , .WADDY_VAL(WAddyRes[31:0]), .Write_Reg(DSTOO)
            , .RegWriteO(RegWriteOOO), .flagO(flagOOO), .CondWriteO(CondWriteOOO), .WriteLoO(WriteLoOOO)
            , .WriteMemO(WriteMemOOO), .WriteALUO(WriteALUOOO)
            , .HIO(HIOUT), .LOO(LOOUT), .MEM_DATAO(MEMDATAO)
            , .WADDY_VALO(WADDYO), .Write_RegO(WRITEDST), .Clk(Clk), .sumOO(sumOO), .sumOOO(sumOOO), .sumOut(sumOut), .sumOutO(sumOutO));
   
    //Mux32Bit2To1(out, inA, inB, sel);
    wire [31:0] WriteLoRes;
    Mux32Bit2To1 WriteLoMux(.out(WriteLoRes), .inA(HIOUT), .inB(LOOUT), .sel(WriteLoOOO));
    
    //Mux32Bit2To1(out, inA, inB, sel);
    wire [31:0] WriteMemRes;
    Mux32Bit2To1 WriteMemMux(.out(WriteMemRes), .inA(WriteLoRes), .inB(MEMDATAO), .sel(WriteMemOOO));
            
    //Mux32Bit2To1(out, inA, inB, sel);
    Mux32Bit2To1 WriteALUMux(.out(WriteALURes), .inA(WriteMemRes), .inB(WADDYO), .sel(WriteALUOOO));
    
    //new component
    //Mux32Bit2To1(out, inA, inB, sel);
    Mux32Bit2To1 writeCacheOut(.out(writeBACK), .inA(WriteALURes), .inB(sumOutO), .sel(sumOOO));
    
endmodule
