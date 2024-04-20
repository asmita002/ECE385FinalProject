`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/20/2024 01:28:38 PM
// Design Name: 
// Module Name: control
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


module control(
    input  logic        Reset, 
    input  logic        frame_clk,
    input  logic [7:0]  keycode,
//    input  logic [7:0]  keycode_1,
//    input  logic [7:0]  keycode_2,

    output logic [9:0]  CharX, 
    output logic [9:0]  CharY, 
    output logic [9:0]  CharS, 
    output logic        show_menu

    );

    parameter [9:0] Char_X_Center=320;  // Center position on the X axis
    parameter [9:0] Char_Y_Center=240;  // Center position on the Y axis
    parameter [9:0] Char_X_Min=0;       // Leftmost point on the X axis
    parameter [9:0] Char_X_Max=639;     // Rightmost point on the X axis
    parameter [9:0] Char_Y_Min=0;       // Topmost point on the Y axis
    parameter [9:0] Char_Y_Max=470;     // Bottommost point on the Y axis // OG = 479
    parameter [9:0] Char_X_Step=1;      // Step size on the X axis
    parameter [9:0] Char_Y_Step=1;      // Step size on the Y axis
    
    
    parameter grav=1;      // Step size on the Y axis

    logic [9:0] Char_X_Motion;
    logic [9:0] Char_X_Motion_next;
    logic [9:0] Char_Y_Motion;
    logic [9:0] Char_Y_Motion_next;
//    logic gnd_flag;

    logic [9:0] Char_X_next;
    logic [9:0] Char_Y_next;
    
    enum logic [1:0] {MENU, START, GND, AIR} state, state_next;


	always_ff @ (posedge frame_clk)
	begin
		if (Reset) 
			state <= MENU;
		else 
		begin
			state <= state_next;
			Char_Y_Motion <= Char_Y_Motion_next; 
			Char_X_Motion <= Char_X_Motion_next; 
            CharY <= Char_Y_next;  // Update ball position
            CharX <= Char_X_next;
        end
	end
	
	// Set signals, movement, position depending on state
	always_comb
	begin
	   Char_X_next = Char_X_Center;
	   Char_Y_next = Char_Y_Center;
	   CharS = 10'd16;
	   show_menu = 0;
	   Char_Y_Motion_next = 0;
	   Char_X_Motion_next = 0;
	   
	   case (state)
	       MENU:
	       begin
	           show_menu = 1'b1;
	           CharS =1'b1;
           end
           
           START:
           begin
           // set everything to default
           end

	       AIR:
	       begin
	           // Gravity in effect
               Char_Y_Motion_next = Char_Y_Motion + grav;
               
               // keyboard input, only horizontal movement controllable
//               if (keycode_2 == 8'h04  || (keycode_1 == 8'h04 && keycode_2 != 8'h07) ) // A (Left)
               if (keycode == 8'h04)
               begin
                    Char_X_Motion_next = -10'd1;
               end
               
//               if (keycode_2 == 8'h07  || (keycode_1 == 8'h07 && keycode_2 != 8'h04) ) // D (Right)
               if (keycode == 8'h07)
               begin
                    Char_X_Motion_next = 10'd1;
               end               	           
	       end
           
	       GND:
	       begin
//               if (keycode_1 == 8'h1A || keycode_2 == 8'h1A) // W (Jump)
               if (keycode == 8'h1A)
               begin
                    Char_Y_Motion_next = -10'd10;
               end

//               if (keycode_2 == 8'h04  || (keycode_1 == 8'h04 && keycode_2 != 8'h07) ) // A (Left)
               if (keycode == 8'h04)
               begin
                    Char_X_Motion_next = -10'd1;
               end
               
//               if (keycode_2 == 8'h07  || (keycode_1 == 8'h07 && keycode_2 != 8'h04) ) // D (Right)
               if (keycode == 8'h07)
               begin
                    Char_X_Motion_next = 10'd1;
               end
               
	       end

           default: ;
	   endcase

       // next cycle's position
       Char_X_next = (CharX + Char_X_Motion_next);
       Char_Y_next = (CharY + Char_Y_Motion_next);

       // vertical collision detection
       if ( ((Char_Y_next + CharS) >= Char_Y_Max) ) // reached ground
       begin
           Char_Y_next = Char_Y_Max - CharS;
           Char_Y_Motion_next = 0;
       end
       
       if ( (Char_Y_next - CharS) <= Char_Y_Min ) // hit the top
       begin
           Char_Y_next = Char_Y_Min + CharS;
           Char_Y_Motion_next = 0;
       end
       
       // horizontal collision detection
       if ( ((Char_X_next + CharS) >= Char_X_Max) ) // reached right border
       begin
           Char_X_next = Char_X_Max - CharS;
           Char_X_Motion_next = 0;
       end
       
       if ( (Char_X_next - CharS) <= Char_X_Min ) // reached left border
       begin
           Char_X_next = Char_X_Min + CharS;
           Char_X_Motion_next = 0;
       end

	end
	
	// set next state
    always_comb
    begin
        // default: stay in the same state
        state_next = state;
        
	   case (state)
	       MENU:
	       begin
//	           if (keycode_1 || keycode_2)
	           if (keycode) // press any key to start
	           begin
	               state_next = START;
	           end
           end
           
           START:
           begin
                state_next = AIR;
           end

	       AIR:
	       begin
	           if ((Char_Y_next + CharS) >= Char_Y_Max) // reached the ground
	           begin
	               state_next = GND;
	           end
	       end
           
	       GND:
	       begin
//               if (keycode_1 == 8'h1A || keycode_2 == 8'h1A) // W (Jump)
               if (keycode == 8'h1A)
               begin
                    state_next = AIR;
               end               
	       end

           default: ;
	   endcase
    end

endmodule