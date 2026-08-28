`timescale 1ns / 1ps

module tb_Verificacao_Final();

    reg clk = 0;
    reg reset;
    
    reg [3:0] Botao_Chamada; 
    reg [3:0] Botao_Selecao; 
    reg [1:0] sw_pin;     
    reg btn_confirmar;    
    reg Sensor_Porta;

    wire [1:0] Display;      
    wire Porta;            
    wire led_aviso_pin;


    SistemaElevador uut (
        .clk(clk),
        .reset(reset),
        .Botao_Chamada(Botao_Chamada), 
        .Botao_Selecao(Botao_Selecao), 
        .sw_pin(sw_pin),
        .btn_confirmar(btn_confirmar),
        .Sensor_Porta(Sensor_Porta),
        
        .Display(Display), 
        .Porta(Porta),
        .led_aviso_pin(led_aviso_pin)
    );

    always #5 clk = ~clk;

    initial begin
        reset = 1; 
        Botao_Chamada = 0; Botao_Selecao = 0; 
        sw_pin = 0; btn_confirmar = 0; Sensor_Porta = 0;
        
        #50 reset = 0;

        #50;
        Botao_Chamada = 4'b0010;

        #100; 
        Botao_Chamada = 0; 

        wait(Porta == 1);
        

        wait(Porta == 0);
        #100 $finish;
    end
endmodule