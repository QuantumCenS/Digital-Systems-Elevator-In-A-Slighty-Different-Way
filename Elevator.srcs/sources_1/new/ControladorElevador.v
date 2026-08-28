module ControladorElevador(
    input clk,
    input reset,
    input [3:0] Botao_Chamada,
    input [3:0] Botao_Selecao,
    input Sensor_Porta,
    input codigo_ok,
    
    output reg [1:0] Display,
    output reg Porta,
    output reg pede_pin
);

    // Estados
    parameter PARADO        = 3'b000;
    parameter ESPERA_PIN    = 3'b001;
    parameter MOVER         = 3'b010;
    parameter ABRIR_PORTA   = 3'b011;
    parameter PORTA_ABERTA  = 3'b100;
    parameter FECHAR_PORTA  = 3'b101;

    reg [2:0] estado;
    reg [1:0] destino;
    reg [3:0] timer; 
    reg ocupado_interno; 

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            estado <= PARADO;
            Display <= 2'b00; 
            destino <= 2'b00;
            Porta <= 0;
            pede_pin <= 0;
            timer <= 0;
            ocupado_interno <= 0;
        end else begin
            case (estado)
                PARADO: begin
                    Porta <= 0;
                    timer <= 0;
                    pede_pin <= 0;
                    
                    
                    if (Botao_Selecao != 0) begin
                        ocupado_interno <= 1;
                        
                        if (Botao_Selecao[0]) destino <= 0;
                        if (Botao_Selecao[1]) destino <= 1;
                        if (Botao_Selecao[2]) destino <= 2;
                        if (Botao_Selecao[3]) destino <= 3;
                        
                        // PIN 
                        if ((Botao_Selecao[2] || Botao_Selecao[3]) && 
                           !((Botao_Selecao[2] && Display==2) || (Botao_Selecao[3] && Display==3))) 
                            estado <= ESPERA_PIN;
                        
                        // move ou não?
                        else if ((Botao_Selecao[0] && Display!=0) || (Botao_Selecao[1] && Display!=1) || 
                                 (Botao_Selecao[2] && Display!=2) || (Botao_Selecao[3] && Display!=3))
                            estado <= MOVER;
                        else
                            estado <= ABRIR_PORTA;
                    end
                    
                    // Botão exterior, ou seja, o de seleção é o interior e o de chamada é o exterior
                    else if (Botao_Chamada != 0 && !ocupado_interno) begin
                        if (Botao_Chamada[3]) begin
                            destino <= 3;
                            if (Display != 3) estado <= MOVER;
                            else estado <= ABRIR_PORTA;
                        end
                        else if (Botao_Chamada[2]) begin
                            destino <= 2;
                            if (Display != 2) estado <= MOVER;
                            else estado <= ABRIR_PORTA;
                        end
                        else if (Botao_Chamada[1]) begin
                            destino <= 1;
                            if (Display != 1) estado <= MOVER;
                            else estado <= ABRIR_PORTA;
                        end
                        else begin 
                            destino <= 0;
                            if (Display != 0) estado <= MOVER;
                            else estado <= ABRIR_PORTA;
                        end
                    end
                end

                ESPERA_PIN: begin
                    pede_pin <= 1;
                    if (codigo_ok) begin
                        pede_pin <= 0;
                        estado <= MOVER;
                    end
                end

                MOVER: begin
                    if (Display == destino) begin
                         estado <= ABRIR_PORTA;
                         timer <= 0;
                    end else begin
                        if (timer < 3) timer <= timer + 1; 
                        else begin
                            timer <= 0;
                            if (Display < destino) Display <= Display + 1;
                            else Display <= Display - 1;
                        end
                    end
                end

                ABRIR_PORTA: begin
                    if (timer < 2) timer <= timer + 1; 
                    else begin
                        timer <= 0;
                        Porta <= 1;
                        estado <= PORTA_ABERTA;
                    end
                end

                PORTA_ABERTA: begin
                    if (Sensor_Porta) timer <= 0; 
                    else if (timer < 3) timer <= timer + 1; 
                    else begin
                        timer <= 0;
                        estado <= FECHAR_PORTA;
                    end
                end

                FECHAR_PORTA: begin
                    if (Sensor_Porta) estado <= ABRIR_PORTA; 
                    else if (timer < 2) timer <= timer + 1; 
                    else begin
                        timer <= 0;
                        Porta <= 0;
                        ocupado_interno <= 0;
                        estado <= PARADO;
                    end
                end
                
                default: estado <= PARADO;
            endcase
        end
    end
endmodule