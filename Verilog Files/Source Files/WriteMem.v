`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineers: James Fulton, Raphael Lepercq, & Wilson Liao
// Create Date: 10/26/2021 03:01:13 PM
//////////////////////////////////////////////////////////////////////////////////


module WriteMem(Address, MemWrite, WriteDataIN, WriteDataOUT);

    input [1:0] MemWrite;
    input [31:0] Address, WriteDataIN;
    
    output reg [31:0] WriteDataOUT;
    
    always @(*) begin
        if (MemWrite == 1) WriteDataOUT <= WriteDataIN;
        //store byte
        if (MemWrite == 2) begin
            case (Address[1:0])
            
                0: begin
                    WriteDataOUT <= WriteDataIN[7:0];
                end
                
                1: begin
                    WriteDataOUT <= WriteDataIN[7:0];
                end
                
                2: begin
                    WriteDataOUT <= WriteDataIN[7:0];
                end
                
                3: begin
                    WriteDataOUT <= WriteDataIN[7:0];
                end
            endcase
            
        end
        //store half
        if (MemWrite == 3) begin
            case(Address[1:0])
                0: WriteDataOUT[31:16] <= WriteDataIN[15:0];
                2: WriteDataOUT[15:0] <= WriteDataIN[15:0];
            endcase
        end
    end
endmodule
