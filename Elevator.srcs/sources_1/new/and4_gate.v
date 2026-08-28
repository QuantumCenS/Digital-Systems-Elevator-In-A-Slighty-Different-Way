`timescale 1ns / 1ps

module and4_gate(
    input A,
    input B,
    input C,
    input D,
    output Y
    );
    
    assign Y = A & B & C & D;
 
endmodule
