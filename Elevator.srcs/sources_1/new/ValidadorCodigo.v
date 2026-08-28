module ValidadorCodigo2(
    input clk,
    input reset,
    input [1:0] sw_pin,      
    input btn_confirmar,     
    input ativar,            
    output reg pin_correto   
);

    parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;
    reg [1:0] estado;
    reg btn_prev;

    wire clique = (btn_confirmar && !btn_prev);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            estado <= S0;
            pin_correto <= 0;
            btn_prev <= 0;
        end else begin
            btn_prev <= btn_confirmar;
            
            if (!ativar) begin
                estado <= S0;
                pin_correto <= 0;
            end else begin
                case (estado)
                    S0: if (clique) begin
                            if (sw_pin == 2'b01) estado <= S1; // 1
                            else estado <= S0;
                        end
                    S1: if (clique) begin
                            if (sw_pin == 2'b01) estado <= S2; // 1
                            else estado <= S0;
                        end
                    S2: if (clique) begin
                            if (sw_pin == 2'b10) estado <= S3; // 2
                            else estado <= S0;
                        end
                    S3: pin_correto <= 1; 
                endcase
            end
        end
    end
endmodule