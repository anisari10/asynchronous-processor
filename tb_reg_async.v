module reg_mult_tb;

reg[3:0] write_address_1;
reg[3:0] write_address_2;
reg[3:0] write_address_3;

reg[3:0] in_address_1;
reg[3:0] in_address_2;
reg[3:0] in_address_3;


//reg[31:0] write_data_1;
//reg write_enable_1 = 0;
reg[31:0] write_data_1;
reg[31:0] write_data_2;
reg[31:0] write_data_3;
reg write_enable_1;
reg write_enable_2;
reg write_enable_3;
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


register_file RegisterFile(	//inputs
							.in_address_1(in_address_1),
							.in_address_2(in_address_2),
							.in_address_3(in_address_3),
							.in_address_4(),

							
							.write_address_1(write_address_1),
							.write_address_2(write_address_2),
							.write_data_1(write_data_1),
							.write_data_2(write_data_2),
							.write_enable_1(write_enable_1),
							.write_enable_2(write_enable_2),
							.write_data_3(write_data_3).
							.write_enable_3(write_enable_3)
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
							//outputs
							.out_data_1(out_data_1),
							.out_data_2(out_data_2),
							.out_data_3(out_data_3),
							
							
							
							.pc(pc), 
							.cspr(cspr)			
							
							);

async_clk async_clk(.clk(clk), .req(req), .ack(ack));
multiplier mult(.Rs(Rs), .Rm(Rm), .result(result));

always @(*)
if(ack == 1)
begin
write_enable_1 = 0;
write_enable_2 = 0;
write_enable_3 = 0;
read_enable_1 = 0;
read_enable_2 = 0;
read_enable_3 = 0;
end

initial begin
	#2 
	// place address of reg 0 on address lines
	write_address_1 = 4'b0000;
	// enable register to ask for req
    write_enable_1 = 1;
	// by the time reg's req gets served, data is placed on the data lines 
    write_data_1 = 32'h00000002;

	// it takes 6ns for data to get into register

	#8
	// place address of reg 1 on address lines
	write_address_2 = 4'b0001;
	// enable reg to ask for req
	write_enable_2 = 1;
	// by the time reg's req gets served, data is placed on the data lines
	write_data_2 = 32'h00000002;
	
	// it takes 6ns for data to get into register

	#8
	// read_enable_1 is set to allow reading of data in reg_0
	read_enable_1 = 1;
	in_address_1 = write_address_1;
	#8
	// 1st operand is on data lines
	Rs = out_data_1;
	// read_enable_2 is set to allow reading of data in reg_1
	read_enable_2 = 1;
	in_address_2 = write_address_2;
	#8
	// 2nd operand is on data lines
	Rm = out_data_2;

	// Rs = out_data_1;
	// Rm = out_data_2;

	// repeat multiplication 10 times
	repeat(10)
	begin
	#2
	write_address_3 = 4'b0010;
	write_enable_3 = 1;
	write_data_3 = result;
	#8
	// temp_result is stored in reg_2
	// now temp_result has to be retrieved back to multiplier
	read_enable_3 = 1;
	in_address_3 = write_address_3;
	#8
	// temp_result is on data lines
	Rs = out_data_3;
	end

	#5
	write_address_1 = 4'b0011;
	write_enable_1 = 1;
	write_data_1 = result;
end


endmodule
