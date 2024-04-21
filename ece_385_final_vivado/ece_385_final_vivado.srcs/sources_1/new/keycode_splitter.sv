`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/21/2024 11:56:37 AM
// Design Name: 
// Module Name: keycode_splitter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module keycode_splitter(
    input logic Clk,
    input logic [31:0] full_keycode, 
    
    output logic [7:0] keycode_1, keycode_2, keycode_3, keycode_4
    );
    
    logic [7:0] key_1_next, key_2_next, key_3_next, key_4_next;
    always_comb
    begin
        key_1_next = full_keycode[7:0];
        key_2_next = full_keycode[15:8];
        key_3_next = full_keycode[23:16];
        key_4_next = full_keycode[31:24];
    end
    
    always_ff @ (posedge Clk)
    begin
        keycode_1 <= key_1_next;
        keycode_2 <= key_2_next;
        keycode_3 <= key_3_next;
        keycode_4 <= key_4_next;
    end
endmodule
