`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineers: James Fulton, Raphael Lepercq, & Wilson Liao
// Create Date: 10/26/2021 03:01:13 PM
//////////////////////////////////////////////////////////////////////////////////


module ReadMem(Address, MemRead, MemDataIN, MemDataOUT);

    input [1:0] MemRead;
    input [31:0] MemDataIN;
    input [1:0] Address;
    
    output reg [31:0] MemDataOUT;
    
    always @(*) begin
    	MemDataOUT <= 0;
            if (MemRead == 1) MemDataOUT <= MemDataIN;
            //load byte
            else if (MemRead == 2) begin
                case(Address)
                        0: begin
                            if (MemDataIN[31] == 1)
                                MemDataOUT <= {24'b111111111111111111111111, MemDataIN[31:24]};
                            else
                                MemDataOUT <= MemDataIN[31:24];
                        end
                        1: begin
                            if (MemDataIN[23] == 1)
                                MemDataOUT <= {24'b111111111111111111111111, MemDataIN[23:16]};
                            else
                                MemDataOUT <= MemDataIN[23:16];
                        end
                        2: begin
                            if (MemDataIN[15] == 1)
                                MemDataOUT <= {24'b111111111111111111111111, MemDataIN[15:8]};
                            else
                                MemDataOUT <= MemDataIN[15:8];
                        end
                        3: begin
                            if (MemDataIN[7] == 1)
                                MemDataOUT <= {24'b111111111111111111111111, MemDataIN[7:0]};
                            else
                                MemDataOUT <= MemDataIN[7:0];
                        end
                    endcase
            end
            
            //load half
            else if (MemRead == 3) begin
                case(Address)
                        0: begin
                            if (MemDataIN[31] == 1)
                                MemDataOUT <= {16'b1111111111111111, MemDataIN[31:16]};
                            else
                                MemDataOUT <= MemDataIN[31:16];
                        end
                        2: begin
                            if (MemDataIN[15] == 1)
                                MemDataOUT <= {16'b1111111111111111, MemDataIN[15:0]};
                            else
                                MemDataOUT <= MemDataIN[15:0];
                        end
                    endcase
            end
    end
endmodule
