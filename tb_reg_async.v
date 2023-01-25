`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module tb_reg_async_2;
reg[3:0] write_address_1;
reg[3:0] write_address_2;
reg[3:0] write_address_3;
reg[3:0] write_address_4;
reg[3:0] in_address_1;
reg[3:0] in_address_2;
reg[3:0] in_address_3;
reg[31:0] write_data_1;
reg[31:0] write_data_2;
reg[31:0] write_data_3;
reg[31:0] write_data_4;
reg write_enable_1;
reg write_enable_2;
reg write_enable_3;
reg write_enable_4;
reg read_enable_1;
reg read_enable_2;
reg read_enable_3;
reg[31:0] pc_update;
reg pc_write;
wire clk;
wire req;
wire ack;
wire[31:0] out_data_1;
wire[31:0] out_data_2;
wire[31:0] out_data_3;
wire[31:0] cspr;
wire[31:0] pc;
reg[31:0] Rm;
reg[31:0] Rs;
wire[31:0] result;
reg_async RegisterFile(	//inputs
			.in_address_1(in_address_1),
			.in_address_2(in_address_2),
			.in_address_3(in_address_3),
			.in_address_4(),
			.write_address_1(write_address_1),
			.write_address_2(write_address_2),
			.write_address_3(write_address_3),
			.write_address_4(write_address_4),
			.write_data_1(write_data_1),
			.write_data_2(write_data_2),
			.write_enable_1(write_enable_1),
			.write_enable_2(write_enable_2),
			.write_data_3(write_data_3),
			.write_enable_3(write_enable_3),
			.write_enable_4(write_enable_4),
			.read_enable_1(read_enable_1),
			.read_enable_2(read_enable_2),
			.read_enable_3(read_enable_3),
			.pc_update(pc_update), 
			.pc_write(pc_write), 
			.cspr_write(), 
			.cspr_update(),
			.clk(clk), 
			.req(req),
			.ack(ack),
			.out_data_1(out_data_1),
			.out_data_2(out_data_2),
			.out_data_3(out_data_3),			
			.pc(pc), 
			.cspr(cspr)			
			
			);

async_clk clock(.clk(clk), .req(req), .ack(ack));
multiplier mult(.Rs(Rs), .Rm(Rm), .result(result));
initial begin
	// waiting for register to get ready for writing
	while (ack == 0)
	begin #1; end
	// writing of 1st data in register
	write_enable_1 = 1;
	write_address_1 = 4'b0000;
	write_data_1 = 32'h2;
	#2; // 1ns for request to go high and 1ns for level sensing
	while (ack == 0)
	begin #1; end
	// at this point, writing finished
	write_enable_1 = 0; // setting down write_enable_1 after acknowledgement
	// write_enable_2 sets high after acknowledgement
	// writing of 2nd data in register
	write_enable_2 = 1;
	write_address_2 = 4'b0001;
	write_data_2 = 32'h2;
	#2
	while (ack == 0) 
	begin #1; end
	write_enable_2 = 0;
	// reading of 1st data from register
	read_enable_1 = 1;
	in_address_1 = write_address_1;
	#2
	while (ack == 0)
	begin #1; end
	read_enable_1 = 0;
	// sending 1st data to multiplier
	Rm = out_data_1; 
	while (ack == 0)
	begin #1; end
	// reading of 2nd data from register
	read_enable_2 = 1;
	in_address_2 = write_address_2;
	#2
	while (ack == 0)
	begin #1; end
	read_enable_2 = 0;
	// sending 2nd data to multiplier
	Rs = out_data_2; 	
	repeat(29) begin
	#2
		while (ack == 0)
		begin #1; end
		// writing temp result into register
		write_enable_3 = 1;
		write_address_3 = 4'b0010;
		write_data_3 = result;
		#2
		while (ack == 0)
		begin #1; end
		write_enable_3 = 0;
		// reading temp result from register
		read_enable_3 = 1;
		in_address_3 = write_address_3;
		#2
		while (ack == 0)
		begin #1; end
		read_enable_3 = 0;
		// sending temp result to multiplier as 2nd operand
		Rs = out_data_3; 	
	end	
	// writing of final result into register
	write_enable_4 = 1;
	write_address_4 = 4'b0011;
	#2
	write_data_4 = result;
	while (ack == 0)
	begin #1; end
	write_enable_4 = 0;

end


endmodule
