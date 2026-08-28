`timescale 1ns / 1ps

module tb_Validacao_PIN_Piso3();

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



    task inserir_pin_correto;
        begin
            sw_pin = 2'b01; 
            #10; 
            btn_confirmar = 1; #10; btn_confirmar = 0; 
            #20; 


            sw_pin = 2'b01; 
            #10;
            btn_confirmar = 1; #10; btn_confirmar = 0;
            #20;

            sw_pin = 2'b10; 
            #10;
            btn_confirmar = 1; #10; btn_confirmar = 0;
            #20;
        end
    endtask

    initial begin

        reset = 1; Botao_Chamada = 0; Botao_Selecao = 0; 
        sw_pin = 0; btn_confirmar = 0; Sensor_Porta = 0;
        
        #50 reset = 0;

        #50;
        Botao_Selecao = 4'b1000; 
        #20 Botao_Selecao = 0;   

        #10;

        #50;

        inserir_pin_correto();

        wait(led_aviso_pin == 0);

        wait(Display == 1); 
        wait(Display == 2);
        
        wait(Display == 3);
        wait(Porta == 1);

        wait(Porta == 0);
        #100 $finish;
    end

endmodule