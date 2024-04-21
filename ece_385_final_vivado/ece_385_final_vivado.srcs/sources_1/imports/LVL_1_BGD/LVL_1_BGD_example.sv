module LVL_1_BGD_example (
    input logic [9:0] BallX, BallY, Ball_size,
	input logic vga_clk,
	
	input logic [9:0] DrawX, DrawY,
	input logic blank,
	output logic [3:0] red, green, blue
);

logic [14:0] rom_address;
logic [2:0] rom_q;

logic [3:0] palette_red, palette_green, palette_blue;
logic [3:0] palette_red, palette_green, palette_blue;

logic negedge_vga_clk;

// ball added
    logic ball_on;
    
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


// read from ROM on negedge, set pixel on posedge
assign negedge_vga_clk = ~vga_clk;

// address into the rom = (x*xDim)/640 + ((y*yDim)/480) * xDim
// this will stretch out the sprite across the entire screen
assign rom_address = ((DrawX * 160) / 640) + (((DrawY * 160) / 480) * 160);

always_ff @ (posedge vga_clk) begin
	red <= 4'h0;
	green <= 4'h0;
	blue <= 4'h0;

	if (blank) begin
        if ((ball_on == 1'b1)) begin 
            red <= 4'hf;
            green <= 4'h7;
            blue <= 4'h0;
        end       

        else
        begin 
            red <= palette_red;
            green <= palette_green;
            blue <= palette_blue;
        end      
	end
end

LVL_1_BGD_rom LVL_1_BGD_rom (
	.clka   (negedge_vga_clk),
	.addra (rom_address),
	.douta       (rom_q)
);

LVL_1_BGD_palette LVL_1_BGD_palette (
	.index (rom_q),
	.red   (palette_red),
	.green (palette_green),
	.blue  (palette_blue)
);

endmodule

//module LVL_1_BGD_example (
//    input logic [9:0] BallX, BallY, Ball_size,
//	input logic vga_clk,
	
//	input logic [9:0] DrawX, DrawY,
//	input logic blank,
//	output logic [3:0] red, green, blue
//);

//logic [14:0] bg_rom_address;
//logic [2:0] bg_rom_q;

//logic [14:0] char_rom_address;
//logic [2:0] char_rom_q;

//logic [3:0] bg_palette_red, bg_palette_green, bg_palette_blue;
//logic [3:0] char_palette_red, char_palette_green, char_palette_blue;

//logic negedge_vga_clk;

//// ball added
//    logic ball_on;
    
//    int DistX, DistY, Size;
//    assign DistX = DrawX - BallX;
//    assign DistY = DrawY - BallY;
//    assign Size = Ball_size;
  
//    always_comb
//    begin:Ball_on_proc
//        if ( (DistX) <= (Size) )
//            ball_on = 1'b1;
//        else 
//            ball_on = 1'b0;
//     end


//// read from ROM on negedge, set pixel on posedge
//assign negedge_vga_clk = ~vga_clk;

//// address into the rom = (x*xDim)/640 + ((y*yDim)/480) * xDim
//// this will stretch out the sprite across the entire screen
//assign bg_rom_address = ((DrawX * 160) / 640) + (((DrawY * 160) / 480) * 160);
//assign char_rom_address = ((DrawX*32) / 640) + (((DrawY * 32) / 480) * 32);


//always_ff @ (posedge vga_clk) begin
//	red <= 4'h0;
//	green <= 4'h0;
//	blue <= 4'h0;

//	if (blank) begin
//        if ((ball_on == 1'b1)) begin 
//            red <= 4'hf;
//            green <= 4'h7;
//            blue <= 4'h0;
//        end       

//        else
//        begin 
//            red <= bg_palette_red;
//            green <= bg_palette_green;
//            blue <= bg_palette_blue;
//        end      
//	end
//end

//LVL_1_BGD_rom LVL_1_BGD_rom (
//	.clka   (negedge_vga_clk),
//	.addra (bg_rom_address),
//	.douta       (bg_rom_q)
//);

//LVL_1_BGD_palette LVL_1_BGD_palette (
//	.index (bg_rom_q),
//	.red   (bg_palette_red),
//	.green (bg_palette_green),
//	.blue  (bg_palette_blue)
//);

//celeste_rom celeste_rom (
//	.clka   (negedge_vga_clk),
//	.addra (char_rom_address),
//	.douta       (char_rom_q)
//);

//celeste_palette celeste_palette (
//	.index (char_rom_q),
//	.red   (char_palette_red),
//	.green (char_palette_green),
//	.blue  (char_palette_blue)
//);

//endmodule



//endmodule
