module SistemaElevador(
    input clk,
    input reset,
    input [3:0] Botao_Chamada, 
    input [3:0] Botao_Selecao, 
    input [1:0] sw_pin,
    input btn_confirmar,
    input Sensor_Porta,
    
    output [1:0] Display,
    output Porta,
    output led_aviso_pin
);

    wire fio_codigo_ok;
    wire fio_pede_pin;

    ControladorElevador controlador (
        .clk(clk),
        .reset(reset),
        .Botao_Chamada(Botao_Chamada), 
        .Botao_Selecao(Botao_Selecao), 
        .Sensor_Porta(Sensor_Porta),
        .codigo_ok(fio_codigo_ok),
        .Display(Display),
        .Porta(Porta),
        .pede_pin(fio_pede_pin)
    );

    ValidadorCodigo3_wrapper validador_bd (
        .clk(clk),
        .reset(reset),
        .sw_1(sw_pin[1]),
        .sw_0(sw_pin[0]),
        .btn_confirmar(btn_confirmar), 
        .codigo_ok(fio_codigo_ok) 
    );

    assign led_aviso_pin = fio_pede_pin;

endmodule