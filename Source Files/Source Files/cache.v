`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Wilson Liao & James Fulton
// Create Date: 12/04/2021 07:35:40 PM
//////////////////////////////////////////////////////////////////////////////////

module cache(writeData, writeCache, sum, sumOut);
    
    input [31:0] writeData;
    input sum, writeCache;
    
    output reg [31:0] sumOut;
    
    integer i, j;
    
    reg [31:0] UofACache [69:0];
    reg [5:0] position;
    
    //Initialize everything to zero
    initial begin
        position = 0;
        for (i = 0; i < 70; i = i + 1) begin
        
            UofACache[i] <= 0;
        end
        
    end
    
    reg [31:0] temp;
    
    always @(writeCache, sum) begin
       
       if (writeCache == 1) begin
            UofACache[position] = writeData;
            position = position + 1;
        
       end
       
       if (sum == 1) begin
            
            //Reset temp
            temp = 0;
            
            //Compute sumOut
            for (j = 0; j < 70; j = j + 1) begin
                
               temp = temp + UofACache[j]; 
               
               //CLear Cache
               //UofACache[j] = 0;
               
            end
            
            sumOut = temp;
            
            for (j = 0; j < 70; j = j + 1) begin
                
               //temp = temp + UofACache[j]; 
               
               //CLear Cache
               UofACache[j] = 0;
               
            end
            position = 0;
         end
    end
    
endmodule












