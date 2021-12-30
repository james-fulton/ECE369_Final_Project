`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// ECE369 - Computer Architecture
// Engineers: James Fulton, Raphael Lepercq, & Wilson Liao 
// 
// Module - ALU32Bit.v
// Description - 32-Bit wide arithmetic logic unit (ALU).
//
// INPUTS:-
// ALUControl: N-Bit input control bits to select an ALU operation.
// A: 32-Bit input port A.
// B: 32-Bit input port B.
//
// OUTPUTS:-
// ALUResult: 32-Bit ALU result output.
// ZERO: 1-Bit output flag. 
//
// FUNCTIONALITY:-
// Design a 32-Bit ALU, so that it supports all arithmetic operations 
// needed by the MIPS instructions given in Labs5-8.docx document. 
//   The 'ALUResult' will output the corresponding result of the operation 
//   based on the 32-Bit inputs, 'A', and 'B'. 
//   The 'Zero' flag is high when 'ALUResult' is '0'. 
//   The 'ALUControl' signal should determine the function of the ALU 
//   You need to determine the bitwidth of the ALUControl signal based on the number of 
//   operations needed to support. 
////////////////////////////////////////////////////////////////////////////////

module ALU32Bit(ALUControl, A, B, ALUResult, Zero, sa);

	input [5:0] ALUControl; // control bits for ALU operation
                                // you need to adjust the bitwidth as needed --- 6 bits for 52 functions
    input [4:0] sa;            // shamt
	input [31:0] A, B;	    // inputs
    
    
	output reg [63:0] ALUResult;	// answer
	output reg Zero;	    // Zero=1 if ALUResult == 0
    
   
    
    /* Please fill in the implementation here... */
    always @(*) begin
        ALUResult = 0;
        Zero = 0;
        
        case(ALUControl)
            
        //Arithmetic    
            //add operation (add)
            0: begin 
                ALUResult = A + B; 
            end
            
            //Add Unsigned Word (addu)
            2: begin 
                ALUResult = A + B; 
            end
            
            //Add Immediate (addi)
            3: begin 
                ALUResult = A + B; 
            end
            
            //Subtract (sub)
            4: begin 
                ALUResult = A - B; 
            end
            
            //Multiply (mul)
            5: begin
                ALUResult = A * B;
            end
            
        //Data
            //Load word (lw)
            10: begin
                ALUResult = A + B;
            end            
            //Store word (sw)
            11: begin
                ALUResult = A + B;
            end
            
        //Branches
         
            //Branch on Equal (beq)
            18: begin
                if(A == B) begin
                    Zero = 1;
                end
                else begin
                    ALUResult = 64'bx;
                end
            end
            
            //Branch not Equal to (bne)
            19: begin
                if (A != B) begin
                    Zero = 1;
                end
                else begin
                    ALUResult = 64'bx;
                end
            end
            
            //Jump (j)
            23: Zero = 1;
            
            //Jump Register (jr)
            24: Zero = 1;
            
            //Jump and Link (jal)
            25: Zero = 1;
            
        //Logical
            //And Immediate (andi)
            27: begin
                ALUResult = A & B;
            end
            
            //Or Immediate (ori)
            31: begin
                ALUResult = A | B;
            end
            
            //Shift Left Logical (sll)
            34: begin
                ALUResult = B << sa;
            end
            
            //Shift Right Logical (srl)
            35: begin
                ALUResult = B >> sa;
            end
            
            //Set on Less than (slt)
            38: begin
                if ($signed(A) < $signed(B)) ALUResult = 1;
            end
            
            //Set on less than Immediate (slti)
            39: begin
                if ($signed(A) < $signed(B)) ALUResult = 1;
            end
            
	    //ABS calculation
            40: begin
                if (A > B) ALUResult = A-B;
                else ALUResult = B-A;
            end
	    
            //Divide (div)
            51: begin
                ALUResult = A / B;
            end
            
            default:
                ALUResult = 0;
        endcase
    
    end

endmodule
