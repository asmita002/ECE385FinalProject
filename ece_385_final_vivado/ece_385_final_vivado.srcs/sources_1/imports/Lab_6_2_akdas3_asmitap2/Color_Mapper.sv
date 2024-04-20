//-------------------------------------------------------------------------
//    Color_Mapper.sv                                                    --
//    Stephen Kempf                                                      --
//    3-1-06                                                             --
//                                                                       --
//    Modified by David Kesler  07-16-2008                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Modified by Zuofu Cheng   08-19-2023                               --
//                                                                       --
//    Fall 2023 Distribution                                             --
//                                                                       --
//    For use with ECE 385 USB + HDMI                                    --
//    University of Illinois ECE Department                              --
//-------------------------------------------------------------------------


module  color_mapper ( input logic vga_clk, //change
                        input  logic [9:0] BallX, BallY, DrawX, DrawY, Ball_size,
                       output logic [3:0]  Red, Green, Blue );
    
    logic ball_on;
    logic [18:0] rom_address; //added change
    logic [7:0] rom_q; //added change
    logic [3:0] palette_red, palette_green, palette_blue; //added change
	 
 /* Old Ball: Generated square box by checking if the current pixel is within a square of length
    2*BallS, centered at (BallX, BallY).  Note that this requires unsigned comparisons.
	 
    if ((DrawX >= BallX - Ball_size) &&
       (DrawX <= BallX + Ball_size) &&
       (DrawY >= BallY - Ball_size) &&
       (DrawY <= BallY + Ball_size))
       )

     New Ball: Generates (pixelated) circle by using the standard circle formula.  Note that while 
     this single line is quite powerful descriptively, it causes the synthesis tool to use up three
     of the 120 available multipliers on the chip!  Since the multiplicants are required to be signed,
	  we have to first cast them from logic to int (signed by default) before they are multiplied). */
	  
    int DistX, DistY, Size;
    assign DistX = DrawX - BallX;
    assign DistY = DrawY - BallY;
    assign Size = Ball_size;
  
    always_comb
    begin:Ball_on_proc
        if ( (DistX*DistX + DistY*DistY) <= (Size * Size) )
            ball_on = 1'b1;
        else 
            ball_on = 1'b0;
     end 
    

//////////////////////////// BACKGROUND SPRITE ////////////////////////////

// Background sprite address calculation
// Adjust dimensions as per your sprite or screen resolution
assign rom_address = ((DrawX * 639) / 640) + (((DrawY * 469) / 480) * 639);

// Instantiate the ROM and Palette modules
level1_rom background_rom (
    .clock  (~vga_clk),
    .address(rom_address),
    .q      (rom_q)
);

level1_palette sprite_palette (
    .index (rom_q),
    .red   (palette_red),
    .green (palette_green),
    .blue  (palette_blue)
);



// Display logic
    always_comb
    begin:RGB_Display
        if ((ball_on == 1'b1)) begin 
            Red = 4'hf;
            Green = 4'h7;
            Blue = 4'h0;
        end       
        else if (DrawY >= 470)
        begin
            Red = 4'h0;
            Green = 4'h0;
            Blue = 4'hf;
        end
        else
        begin 
            Red = palette_red;
            Green = palette_green;
            Blue = palette_blue;
        end      
    end 
    
endmodule
