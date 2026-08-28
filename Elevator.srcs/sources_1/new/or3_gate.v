`timescale 1ns / 1ps


module or3_gate(
    input A,
    input B,
    input C,
    output Y
    );
    
    assign Y = A | B | C;
    
endmodule
