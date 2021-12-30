`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer:  Raphael Lepercq
// Create Date: 11/05/2021 03:53:30 PM
// Module Name: HazardDetector
//////////////////////////////////////////////////////////////////////////////////

/* HazardDetector HazardDetector(.IFID_Instruction(IFID_Instruction), .IFID_RegisterRs(IFID_Instruction[25:21])
                   , .IFID_RegisterRt(IFID_Instruction[20:16]), IDEX_Instruction
                   , .IDEX_RegisterRd(WriteRAddr), .IDEX_RegisterWrite(RegWO), .IDEX_MemRead(MemReadO)
                   , .EXMEM_RegisterRd(DSTOO), .EXMEM_RegisterWrite(RegWriteOO), .EXMEM_MemRead(MemReadOO)
                   , .MEMWB_RegisterRd(WRITEDST), .MEMWB_RegisterWrite(RegWriteOOO)
                   , .PCWrite(PCWrite), .IFIDWrite(IFIDWrite), .IDStall(IDStall)
                   , .SEL(SEL), .IF_Flush(IF_Flush), .PCSRC(PCSRC));
 */

module HazardDetector(IFID_Instruction, IFID_RegisterRs, IFID_RegisterRt, IDEX_Instruction, IDEX_RegisterRd, IDEX_RegisterWrite
            , IDEX_MemRead, EXMEM_Instruction, EXMEM_RegisterRd, EXMEM_RegisterWrite, EXMEM_MemRead, MEMWB_RegisterRd
            , MEMWB_RegisterWrite //inputs 'till here
            , PCWrite, IFIDWrite, IDStall, SEL, IF_Flush, PCSRC); //outputs

    input [31:0] IFID_Instruction, IDEX_Instruction, EXMEM_Instruction;
    input [4:0] IFID_RegisterRs, IFID_RegisterRt, IDEX_RegisterRd, EXMEM_RegisterRd, MEMWB_RegisterRd;
    input [1:0] IDEX_MemRead, EXMEM_MemRead;
    input IDEX_RegisterWrite, EXMEM_RegisterWrite, MEMWB_RegisterWrite, PCSRC;
    
    output reg PCWrite, IFIDWrite, IDStall, IF_Flush;
    output reg [3:0] SEL;
    
    always @ (*) begin
    
        /*if (Branch) begin
            IDStall <= 0;     
            PCWrite <= 0;          //stall PC count
            IFIDWrite <= 0;        //write the same instruction for the next cycle
            IF_Flush <= 0;        
            SEL <= 9;
        end
        
        else if (BranchEX) begin //waiting for branch to be resolved
            IDStall <= 1;     //insert nop
            PCWrite <= 0;          //stall PC count
            IFIDWrite <= 0;        //write the same instruction for the next cycle
            IF_Flush <= 0;        //dont flush
            SEL <= 10;
        end
        else */ if (PCSRC) begin
         //   IDStall <= 1;     //insert nop
         //   PCWrite <= 1;          //write branched PC count to get branch instruciton
         //   IFIDWrite <= 1;        //write the branch instruction for the next cycle
         //   IF_Flush <= 1;        //flush the wrong instruction
         //   SEL <= 11;
        end
        else begin
            IDStall = 0;
            PCWrite = 1;
            IFIDWrite = 1;
            IF_Flush = 0;
            SEL = 12;
        end
        
        if (IFID_Instruction[31:26] == 6'b000001 && IFID_Instruction[5:0] == 6'b000000) begin
            if ((IDEX_MemRead == 1) && (IDEX_RegisterRd == IFID_RegisterRs || (IDEX_RegisterRd == IFID_RegisterRt))) begin
                PCWrite = 0;
                IFIDWrite = 0;
                IDStall = 1;
                IF_Flush = 0;
                SEL = 5;
            end
        end
        //abs operation -- computes the absolute difference and stores result in Cache register
		               
        //sum operation ----- Custom instruction that sums the Cache
     
    ///beq & bne
	    else if (IFID_Instruction[31:26] == 6'b000100 || IFID_Instruction[31:26] == 6'b000101) begin
	           if ((IDEX_MemRead == 1) && ((IDEX_RegisterRd == IFID_RegisterRs) || (IDEX_RegisterRd == IFID_RegisterRt))) begin
                   //stall once
                   PCWrite = 0;
                   IFIDWrite = 0;
                   IDStall = 1;
                   IF_Flush = 0;
                   SEL = 1;
               end  
               
               else if ((EXMEM_MemRead == 1) && ((EXMEM_RegisterRd == IFID_RegisterRs) || (EXMEM_RegisterRd == IFID_RegisterRt))) begin
                   //stall once
                   PCWrite = 0;
                   IFIDWrite = 0;
                   IDStall = 1;
                   IF_Flush = 0;
                   SEL = 1;
               end 
               
               else if ((IDEX_RegisterWrite == 1) && ((IDEX_RegisterRd == IFID_RegisterRs) || (IDEX_RegisterRd == IFID_RegisterRt))) begin //IDEX_RegisterRd has the "muxed" return reg from phase EX
                   //have to stall twice
                   PCWrite = 0;
                   IFIDWrite = 0;
                   IDStall = 1;
                   IF_Flush = 0;
                   SEL = 1;
                end  
                
	    end
        //  For I-Type instructions (At least those with Rt as return reg)
        else if (IFID_Instruction[31:26] == 6'b001000 || IFID_Instruction[31:26] == 6'b001001 || IFID_Instruction[31:26] == 6'b001000 || IFID_Instruction[31:26] == 6'b100011 
        || IFID_Instruction[31:26] == 6'b100001 || IFID_Instruction[31:26] == 6'b100000 || IFID_Instruction[31:26] == 6'b001111 || IFID_Instruction[31:26] == 6'b001100
        || IFID_Instruction[31:26] == 6'b001101 || IFID_Instruction[31:26] == 6'b001110 || IFID_Instruction[31:26] == 6'b001010 || IFID_Instruction[31:26] == 6'b001011) begin
          
               if ((IDEX_MemRead == 1) && (IDEX_RegisterRd == IFID_RegisterRs)) begin
                   //stall once
                   PCWrite = 0;
                   IFIDWrite = 0;
                   IDStall = 1;
                   IF_Flush = 0;
                   SEL = 1;
               end  
        /*     if ((IDEX_RegisterWrite == 1) && (IDEX_RegisterRd == IFID_RegisterRs)) begin //IDEX_RegisterRd has the "muxed" return reg from phase EX
               //have to stall twice
               PCWrite = 0;
               IFIDWrite = 0;
               IDStall = 1;
               IF_Flush = 0;
               SEL = 1;
            end  
            
            else if ((EXMEM_RegisterWrite == 1) && (EXMEM_RegisterRd == IFID_RegisterRs)) begin
                //have to stall once
                PCWrite = 0;
                IFIDWrite = 0;
                IDStall = 1;
                IF_Flush = 0;
                SEL = 2;
            end */
            
     /*       else if ((MEMWB_RegisterWrite == 1) && (MEMWB_RegisterRd == IFID_RegisterRs)) begin
                //stall once
                PCWrite = 0;
                IFIDWrite = 0;
                IDStall = 1;
                IF_Flush = 0;
                SEL = 3;
            end 
            */
        end
        
        else begin //R-Type and all else
            
            if ((IDEX_MemRead == 1) && (IDEX_RegisterRd == IFID_RegisterRs || (IDEX_RegisterRd == IFID_RegisterRt))) begin
                PCWrite = 0;
                IFIDWrite = 0;
                IDStall = 1;
                IF_Flush = 0;
                SEL = 5;
            end
            //if next instruction the custom sum operation
            else if (IDEX_Instruction[31:26] == 6'b000001 && IDEX_Instruction[5:0] == 6'b000001) begin
                PCWrite = 0;
                IFIDWrite = 0;
                IDStall = 1;
                IF_Flush = 0;
                SEL = 5;
            end
            else if (EXMEM_Instruction[31:26] == 6'b000001 && EXMEM_Instruction[5:0] == 6'b000001) begin
                PCWrite = 0;
                IFIDWrite = 0;
                IDStall = 1;
                IF_Flush = 0;
                SEL = 5;
            end
            
            ////sum operation ----- Custom instruction that sums the Cache
		      //        6'b000001
       /*     if ((IDEX_RegisterWrite == 1) && ((IDEX_RegisterRd == IFID_RegisterRs) || (IDEX_RegisterRd == IFID_RegisterRt)))begin
               //stall twice
               PCWrite = 0;
               IFIDWrite = 0;
               IDStall = 1;
               IF_Flush = 0;
               SEL = 5;
            end  
            else if ((EXMEM_RegisterWrite == 1) && ((EXMEM_RegisterRd == IFID_RegisterRs) || (EXMEM_RegisterRd == IFID_RegisterRt))) begin
                //stall once
                PCWrite = 0;
                IFIDWrite = 0;
                IDStall = 1;
                IF_Flush = 0;
                SEL = 6;
            end */
       /*    else if ((MEMWB_RegisterWrite == 1) && ((MEMWB_RegisterRd == IFID_RegisterRs) || (MEMWB_RegisterRd == IFID_RegisterRt))) begin
                //stall once
                PCWrite = 0;
                IFIDWrite = 0;
                IDStall = 1;
                IF_Flush = 0;
                SEL = 7;
            end 
            */
        end
    end
    
endmodule
