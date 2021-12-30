`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Raphael Lepercq
// Create Date: 12/08/2021 12:08:51 AM
//////////////////////////////////////////////////////////////////////////////////

/* ForwardingID ForwardingID(.IFID_Instruction(IFID_Instruction), .IFID_RegisterRs(IFID_Instruction[25:21])
                   , .IFID_RegisterRt(IFID_Instruction[20:16]), .EXMEM_RegisterWrite(RegWriteOO), .EXMEM_RegisterRd(DSTOO)
                   , .MEMWB_RegisterWrite(RegWriteOOO), .MEMWB_RegisterRd(WRITEDST)
                   , .ReadRegSelA(ReadRegSelMuxA), .ReadRegSelB(ReadRegSelMuxB)); */
module ForwardingID(IFID_Instruction, IFID_RegisterRs
           , IFID_RegisterRt, EXMEM_RegisterWrite, EXMEM_RegisterRd, MEMWB_RegisterWrite, MEMWB_RegisterRd
           , ReadRegSelA, ReadRegSelB);
    
    input [31:0] IFID_Instruction;
    input [4:0]  IFID_RegisterRs, IFID_RegisterRt, EXMEM_RegisterRd, MEMWB_RegisterRd;
    input EXMEM_RegisterWrite, MEMWB_RegisterWrite;
    
    output reg [1:0] ReadRegSelA, ReadRegSelB;
    
    initial begin
        ReadRegSelA <= 0;
        ReadRegSelB <= 0;
    end
    ///beq
	//		6'b000100
    always @ (*) begin
    //  For I-Type instructions (At least those with Rt as return reg)
        if (IFID_Instruction[31:26] == 6'b001000 || IFID_Instruction[31:26] == 6'b001001 || IFID_Instruction[31:26] == 6'b001000 || IFID_Instruction[31:26] == 6'b100011 
        || IFID_Instruction[31:26] == 6'b100001 || IFID_Instruction[31:26] == 6'b100000 || IFID_Instruction[31:26] == 6'b001111 || IFID_Instruction[31:26] == 6'b001100
        || IFID_Instruction[31:26] == 6'b001101 || IFID_Instruction[31:26] == 6'b001110 || IFID_Instruction[31:26] == 6'b001010 || IFID_Instruction[31:26] == 6'b001011) begin
            if ((EXMEM_RegisterWrite == 1) && (EXMEM_RegisterRd == IFID_RegisterRs)) begin
             
                    ReadRegSelA = 1;
            end
            else if ((MEMWB_RegisterWrite == 1) && (MEMWB_RegisterRd == IFID_RegisterRs)) begin
                    
                    ReadRegSelA = 2;
            end
            else  begin
                    
                    ReadRegSelA = 0;
            end
        end
        
        else begin
            if ((EXMEM_RegisterWrite == 1) && (EXMEM_RegisterRd == IFID_RegisterRs)) begin
             
                    ReadRegSelA = 1;
            end
            else if ((MEMWB_RegisterWrite == 1) && (MEMWB_RegisterRd == IFID_RegisterRs)) begin
                    
                    ReadRegSelA = 2;
            end
            else  begin
                    
                    ReadRegSelA = 0;
            end
            if ((EXMEM_RegisterWrite == 1) && (EXMEM_RegisterRd == IFID_RegisterRt)) begin
            
                    ReadRegSelB = 1;
            end
            else if ((MEMWB_RegisterWrite == 1) && (MEMWB_RegisterRd == IFID_RegisterRt)) begin
                    
                    ReadRegSelB = 2;
            end
            else  begin
                    
                    ReadRegSelB = 0;
            end
        end
    end
endmodule
