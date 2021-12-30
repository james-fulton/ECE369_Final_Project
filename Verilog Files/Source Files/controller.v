//////////////////////////////////////////////////////////////////////////////////
// Engineers: James Fulton, & Wilson Liao 
// Create Date: 10/16/2021 12:35:12 PM
//////////////////////////////////////////////////////////////////////////////////

module Controller(Instruction, RegWrite, CondWrite, SignedConst, RegDst, Link, ALUSrc, ALUOp, JumpSRC, Jump, Branch, MemWrite, MemRead, HLop, HLSel, WAddy, WriteLo, WriteMem, WriteALU, LOen, HIen, writeCache, sum);
	
	input [31:0] Instruction;

	output reg RegWrite, CondWrite, SignedConst, RegDst, Link, ALUSrc, JumpSRC, Jump, Branch, HLop, HLSel, WAddy, WriteLo, WriteMem, WriteALU, LOen, HIen, writeCache, sum;
	output reg [1:0] MemWrite, MemRead;

	output reg [5:0] ALUOp;
	
	initial begin
	   Branch <= 0;
    end

	always @(*) begin
	   
        
		case(Instruction[31:26])
		
		    
		    6'b000001: begin
		    
		        case (Instruction [5:0])
		                
		                //abs operation -- computes the absolute difference and stores result in Cache register
		                6'b000000: begin
		                
                            RegWrite <= 0;
                            CondWrite <= 0;	
                            SignedConst <= 0;
                            RegDst	<= 0;
                            Link <= 0;
                            ALUSrc <= 0;
                            ALUOp <= 40;
                            JumpSRC <= 0;
                            Jump <= 0;
                            Branch <= 0;
                            MemWrite <= 0;
                            MemRead <= 0;
                            HLop <= 0;
                            HLSel <= 0;
                            WAddy	<= 0;
                            WriteLo	<= 0;
                            WriteMem <= 0;
                            WriteALU <= 0;
                            LOen <= 0;
                            HIen <= 0;
                            
                            //New signals
                            writeCache <= 1;
                            sum <= 0;
		              end
		              
		              //sum operation ----- Custom instruction that sums the Cache
		              6'b000001: begin
		                    
                            RegWrite <= 1;
                            CondWrite <= 0;	
                            SignedConst <= 0;
                            RegDst	<= 1;
                            Link <= 0;
                            ALUSrc <= 0;
                            ALUOp <= 0;
                            JumpSRC <= 0;
                            Jump <= 0;
                            Branch <= 0;
                            MemWrite <= 0;
                            MemRead <= 0;
                            HLop <= 0;
                            HLSel <= 0;
                            WAddy	<= 0;
                            WriteLo	<= 0;
                            WriteMem <= 0;
                            WriteALU <= 0;
                            LOen <= 0;
                            HIen <= 0;
                            
                            //New signals
                            writeCache <= 0;
                            sum <= 1;
		               end
		        endcase
		    end
		      

			6'b000000: begin
			     
			    
			
				case (Instruction[5:0])

					//add
					6'b100000: begin

						RegWrite <= 1;
						CondWrite <= 0;
						RegDst <= 1;
						Link <= 0;
						ALUSrc <= 0;
						ALUOp <= 0;
						Branch <= 0;
						MemWrite <= 0;
						MemRead <= 0;
						WAddy <= 0;
						WriteALU <= 1;
						LOen <= 0;
						HIen <= 0;
						
						//New signals
			                        writeCache <= 0;
			                        sum <= 0;
    
					end

					//addu
					6'b100001: begin

						RegWrite <= 1;
						CondWrite <= 0;
						RegDst <= 1;
						Link <= 0;
						ALUSrc <= 0;
						ALUOp <= 2;
						Branch <= 0;
						MemWrite <= 0;
						MemRead <= 0;
						WAddy <= 0;
						WriteALU <= 1;
						LOen <= 0;
						HIen <= 0;
						
						//New signals
			                        writeCache <= 0;
			                        sum <= 0;

					end

					//sub
					6'b100010: begin

						RegWrite <= 1;
						CondWrite <= 0;
						RegDst <= 1;
						Link <= 0;
						ALUSrc <= 0;
						ALUOp <= 4;
						Branch <= 0;
						MemWrite <= 0;
						MemRead <= 0;
						WAddy <= 0;
						WriteALU <= 1;
						LOen <= 0;
						HIen <= 0;
						
						//New signals
			                        writeCache <= 0;
			                        sum <= 0;
					end

					//jr
					6'b001000: begin

						RegWrite <= 0;
						CondWrite <= 0;
						ALUOp <= 24;
						Branch <= 0;
						JumpSRC <= 1;
						Jump <= 0;
						Branch <= 1;
						MemWrite <= 0;
						MemRead <= 0;
						LOen <= 0;
						HIen <= 0;
						
						//New signals
			                        writeCache <= 0;
			                        sum <= 0;
					end

					//sll
					6'b000000: begin
                        
						RegWrite <= 1;
						CondWrite <= 0;
						SignedConst <= 0;
						RegDst <= 1;
						Link <= 0;
						ALUSrc <= 0;
						ALUOp <= 34;
						Branch <= 0;
						MemWrite <= 0;
						MemRead <= 0;
						WAddy <= 0;
						WriteALU <= 1;
						LOen <= 0;
						HIen <= 0;
						
						//New signals
                        writeCache <= 0;
                        sum <= 0;

					end
					
					6'b000010: begin
                        
                        case (Instruction[21]) 
                            //srl
                            1'b0: begin
                                RegWrite <= 1;
                                CondWrite <= 0;
                                SignedConst <= 0;
                                RegDst <= 1;
                                Link <= 0;
                                ALUSrc <= 0;
                                ALUOp <= 35;
                                Branch <= 0;
                                MemWrite <= 0;
                                MemRead <= 0;
                                WAddy <= 0;
                                WriteALU <= 1;
                                LOen <= 0;
                                HIen <= 0;
                                
                                //New signals
                                writeCache <= 0;
                                sum <= 0;
					         end
					         
					         default: begin
                                    RegWrite <= 0;
                                    CondWrite <= 0;	
                                    SignedConst <= 0;
                                    RegDst	<= 0;
                                    Link <= 0;
                                    ALUSrc <= 0;
                                    ALUOp <= 0;
                                    JumpSRC <= 0;
                                    Jump <= 0;
                                    Branch <= 0;
                                    MemWrite <= 0;
                                    MemRead <= 0;
                                    HLop <= 0;
                                    HLSel <= 0;
                                    WAddy	<= 0;
                                    WriteLo	<= 0;
                                    WriteMem <= 0;
                                    WriteALU <= 0;
                                    LOen <= 0;
                                    HIen <= 0;
                                    
                                    //New signals
                                    writeCache <= 0;
                                    sum <= 0;
                                end
                        endcase
                    end

					//slt
					6'b101010: begin

						RegWrite <= 1;
						CondWrite <= 0;
						SignedConst <= 0;
						RegDst <= 1;
						Link <= 0;
						ALUSrc <= 0;
						ALUOp <= 38;
						Branch <= 0;
						MemWrite <= 0;
						MemRead <= 0;
						WAddy <= 0;
						WriteALU <= 1;
						LOen <= 0;
						HIen <= 0;
						
						//New signals
			                        writeCache <= 0;
			                        sum <= 0;

					end
			        
					//srlv
		                        6'b000110: begin
		                            case (Instruction[6])
		                                0: begin
		                                    RegWrite <= 1;
		                                    CondWrite <= 0;
		                                    SignedConst <= 0;
		                                    RegDst <= 1;
		                                    Link <= 0;
		                                    ALUSrc <= 0;
		                                    ALUOp <= 37;
		                                    Branch <= 0;
		                                    MemWrite <= 0;
		                                    MemRead <= 0;
		                                    WAddy <= 0;
		                                    WriteALU <= 1;
		                                    LOen <= 0;
		                                    HIen <= 0;
			            		    //New signals
			                            writeCache <= 0;
			                            sum <= 0;
		                            	end
                        
		                                default: begin
		                                    RegWrite <= 0;
		                                    CondWrite <= 0;	
		                                    SignedConst <= 0;
		                                    RegDst	<= 0;
		                                    Link <= 0;
		                                    ALUSrc <= 0;
		                                    ALUOp <= 0;
		                                    JumpSRC <= 0;
		                                    Jump <= 0;
		                                    Branch <= 0;
		                                    MemWrite <= 0;
		                                    MemRead <= 0;
		                                    HLop <= 0;
		                                    HLSel <= 0;
		                                    WAddy	<= 0;
		                                    WriteLo	<= 0;
		                                    WriteMem <= 0;
		                                    WriteALU <= 0;
		                                    LOen <= 0;
		                                    HIen <= 0;
						    //New signals
			                            writeCache <= 0;
			                            sum <= 0;
		                        	end
                        
				             endcase
				        end
					default: begin
			                        RegWrite <= 0;
			                        CondWrite <= 0;	
			                        SignedConst <= 0;
			                        RegDst	<= 0;
			                        Link <= 0;
			                        ALUSrc <= 0;
			                        ALUOp <= 0;
			                        JumpSRC <= 0;
			                        Jump <= 0;
			                        Branch <= 0;
			                        MemWrite <= 0;
			                        MemRead <= 0;
			                        HLop <= 0;
			                        HLSel <= 0;
			                        WAddy	<= 0;
			                        WriteLo	<= 0;
			                        WriteMem <= 0;
			                        WriteALU <= 0;
			                        LOen <= 0;
			                        HIen <= 0;
			                    	//New signals
			                        writeCache <= 0;
			                        sum <= 0;
					    end

				endcase

			end

			//addi
			6'b001000: begin

				RegWrite <= 1;
				CondWrite <= 0;
				SignedConst <= 1;
				RegDst <= 0;
				Link <= 0;
				ALUSrc <= 1;
				ALUOp <= 3;
				Branch <= 0;
				MemWrite <= 0;
				MemRead <= 0;
				WAddy <= 0;
				WriteALU <= 1;
				LOen <= 0;
				HIen <= 0;
				
				//New signals
		                writeCache <= 0;
		                sum <= 0;

			end
			
			6'b011100: begin

				case(Instruction[5:0]) 


					//mul
					6'b000010: begin

						RegWrite <= 1;
						CondWrite <= 0;
						RegDst <= 1;
						Link <= 0;
						ALUSrc <= 0;
						ALUOp <= 5;
						Branch <= 0;
						MemWrite <= 0;
						MemRead <= 0;
						WAddy <= 0;
						WriteALU <= 1;
						LOen <= 0;
						HIen <= 0;
						//New signals
			                        writeCache <= 0;
			                        sum <= 0;
					end
					
					//div
					6'b000011: begin

						RegWrite <= 1;
						CondWrite <= 0;
						RegDst <= 1;
						Link <= 0;
						ALUSrc <= 0;
						ALUOp <= 51;
						Branch <= 0;
						MemWrite <= 0;
						MemRead <= 0;
						WAddy <= 0;
						WriteALU <= 1;
						LOen <= 0;
						HIen <= 0;
						//New signals
			                        writeCache <= 0;
			                        sum <= 0;
					end
					
					default: begin
                        RegWrite <= 0;
                        CondWrite <= 0;	
                        SignedConst <= 0;
                        RegDst	<= 0;
                        Link <= 0;
                        ALUSrc <= 0;
                        ALUOp <= 0;
                        JumpSRC <= 0;
                        Jump <= 0;
                        Branch <= 0;
                        MemWrite <= 0;
                        MemRead <= 0;
                        HLop <= 0;
                        HLSel <= 0;
                        WAddy	<= 0;
                        WriteLo	<= 0;
                        WriteMem <= 0;
                        WriteALU <= 0;
                        LOen <= 0;
                        HIen <= 0;
                        
                        //New signals
                        writeCache <= 0;
                        sum <= 0;
                    end
				endcase
			end
			
			//lw
			6'b100011: begin

				RegWrite <= 1;
				CondWrite <= 0;
				SignedConst <= 1;
				RegDst <= 0;
				Link <= 0;
				ALUSrc <= 1;
				ALUOp <= 10;
				Branch <= 0;
				MemWrite <= 0;
				MemRead <= 1;
				WAddy <= 0;
				WriteMem <= 1;
				WriteALU <= 0;
				LOen <= 0;
				HIen <= 0;
                
                //New signals
                writeCache <= 0;
                sum <= 0;
                
			end


			//sw
			6'b101011: begin

				RegWrite <= 0;
				CondWrite <= 0;
				SignedConst <= 1;
				ALUSrc <= 1;
				ALUOp <= 11;
				Branch <= 0;
				MemWrite <= 1;
				MemRead <= 0;
				LOen <= 0;
				HIen <= 0;
                
                
                //New signals
                writeCache <= 0;
                sum <= 0;
			end

			//beq
			6'b000100: begin

				RegWrite <= 0;
				CondWrite <= 0;
				SignedConst <= 1;
				ALUSrc <= 0;
				ALUOp <= 18;
				JumpSRC <= 0;
				Jump <= 0;
				Branch <= 1;
				MemWrite <= 0;
				MemRead <= 0;
				LOen <= 0;
				HIen <= 0;

                //New signals
                writeCache <= 0;
                sum <= 0;
			end

			//bne
			6'b000101: begin

				RegWrite <= 0;
				CondWrite <= 0;
				SignedConst <= 1;
				ALUSrc <= 0;
				ALUOp <= 19;
				JumpSRC <= 0;
				Jump <= 0;
				Branch <= 1;
				MemWrite <= 0;
				MemRead <= 0;
				LOen <= 0;
				HIen <= 0;


                //New signals
                writeCache <= 0;
                sum <= 0;
			end

			//j
			6'b000010: begin

				RegWrite <= 0;
				CondWrite <= 0;
				SignedConst <= 1;
				ALUOp <= 23;
				Jump <= 1;
				Branch <= 1;
				MemWrite <= 0;
				MemRead <= 0;
				LOen <= 0;
				HIen <= 0;
				
				//New signals
                writeCache <= 0;
                sum <= 0;
			end


			//jal
			6'b000011: begin

				RegWrite <= 1;
				CondWrite <= 0;
				SignedConst <= 1;
				Link <= 1;
				ALUSrc <= 0;
				ALUOp <= 25;
				JumpSRC <= 0;
				Jump <= 1;
				Branch <= 1;
				MemWrite <= 0;
				MemRead <= 0;
				WAddy <= 1;
				WriteALU <= 1;
				LOen <= 0;
				HIen <= 0;
				
				//New signals
                writeCache <= 0;
                sum <= 0;
			end
			
			//andi
			6'b001100: begin

				RegWrite <= 1;
				CondWrite <= 0;
				RegDst <= 0;
				Link <= 0;
				ALUSrc <= 1;
				ALUOp <= 27;
				Branch <= 0;
				MemWrite <= 0;
				MemRead <= 0;
				WAddy <= 0;
				WriteALU <= 1;
				LOen <= 0;
				HIen <= 0;
				
				//New signals
                writeCache <= 0;
                sum <= 0;
			end

			//ori
			6'b001101: begin

				RegWrite <= 1;
				CondWrite <= 0;
				SignedConst <= 0;
				RegDst <= 0;
				Link <= 0;
				ALUSrc <= 1;
				ALUOp <= 31;
				Branch <= 0;
				MemWrite <= 0;
				MemRead <= 0;
				WAddy <= 0;
				WriteALU <= 1;
				LOen <= 0;
				HIen <= 0;
				
				//New signals
                writeCache <= 0;
                sum <= 0;
			end

			//slti
			6'b001010: begin
				RegWrite <= 1;
				CondWrite <= 0;
				SignedConst <= 1;
				RegDst <= 0;
				Link <= 0;
				ALUSrc <= 1;
				ALUOp <= 39;
				Branch <= 0;
				MemWrite <= 0;
				MemRead <= 0;
				WAddy <= 0;
				WriteALU <= 1;
				LOen <= 0;
				HIen <= 0;
                
                //New signals
                writeCache <= 0;
                sum <= 0;
                
			end

			
        default: begin
            RegWrite <= 0;
			CondWrite <= 0;	
			SignedConst <= 0;
			RegDst	<= 0;
			Link <= 0;
			ALUSrc <= 0;
			ALUOp <= 0;
			JumpSRC <= 0;
			Jump <= 0;
			Branch <= 0;
			MemWrite <= 0;
			MemRead <= 0;
			HLop <= 0;
			HLSel <= 0;
			WAddy	<= 0;
			WriteLo	<= 0;
    		WriteMem <= 0;
			WriteALU <= 0;
			LOen <= 0;
			HIen <= 0;
			
			//New signals
            writeCache <= 0;
            sum <= 0;
        end
        
        
		endcase
        
        if (Instruction == 0) begin
                RegWrite <= 0;
                CondWrite <= 0;	
                SignedConst <= 0;
                RegDst	<= 0;
                Link <= 0;
                ALUSrc <= 0;
                ALUOp <= 0;
                JumpSRC <= 0;
                Jump <= 0;
                Branch <= 0;
                MemWrite <= 0;
                MemRead <= 0;
                HLop <= 0;
                HLSel <= 0;
                WAddy	<= 0;
                WriteLo	<= 0;
                WriteMem <= 0;
                WriteALU <= 0;
                LOen <= 0;
                HIen <= 0;
                
                //New signals
                writeCache <= 0;
                sum <= 0;
          end
	end

endmodule
