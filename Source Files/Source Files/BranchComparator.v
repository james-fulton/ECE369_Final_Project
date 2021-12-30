`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineers: James Fulton, Raphael Lepercq, & Wilson Liao 
// 
// Create Date: 11/14/2021 10:24:45 AM
// Design Name: 
// Module Name: EqualComparator
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

//EqualComparator(A, B, equalControl, equalFlag);
module EqualComparator(A, B, equalControl, equalFlag);
    input [31:0] A, B;
    input [5:0]  equalControl;
                                
	output reg equalFlag;
        
    always @(*) begin
        equalFlag = 0;
        
        case(equalControl)
        
        //Branches
            //branch on equal (beq)
            18: begin
                if(A == B) equalFlag = 1;
            end
            
            //branch on not equal to (bne)
            19: begin
                if (A != B) equalFlag = 1;
            end
            
            //Jump (j)
            23: equalFlag = 1;
            
            //Jump Register (jr)
            24: equalFlag = 1;
            
            //Jump and Link (jal)
            25: equalFlag = 1;
            
       endcase  
    end

endmodule
