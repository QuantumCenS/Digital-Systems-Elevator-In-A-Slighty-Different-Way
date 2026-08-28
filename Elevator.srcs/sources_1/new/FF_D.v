module MEU_FF_D(
    input clk,      
    input reset,    
    input en,       
    input D,        
    output reg Q,  
    output nQ       
);

    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            Q <= 1'b0;      
        end else if (en) begin
            Q <= D;         
        end
        
    end

    assign nQ = ~Q;

endmodule