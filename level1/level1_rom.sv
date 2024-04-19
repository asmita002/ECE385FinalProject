module level1_rom (
	input logic clock,
	input logic [18:0] address,
	output logic [7:0] q
);

logic [7:0] memory [0:299690] /* synthesis ram_init_file = "./level1/level1.COE" */;

always_ff @ (posedge clock) begin
	q <= memory[address];
end

endmodule
