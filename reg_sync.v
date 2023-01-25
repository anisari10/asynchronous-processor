`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module reg_sync(in_address_1,in_address_2,in_address_3,in_address_4, 
						out_data_1,out_data_2,out_data_3,out_data_4, 
						write_address_1, write_address_2, write_address_3, write_address_4,
						write_data_1, write_data_2, write_data_3, write_data_4,
						write_enable_1, write_enable_2, write_enable_3, write_enable_4,
						read_enable_1, read_enable_2, read_enable_3, read_enable_4,
						pc, pc_update, pc_write, 
						cspr, cspr_write, cspr_update, clk );

parameter N = 32;			 //register data size 

reg [N-1:0] R [15:0];	//16, 32 bit registers

//reading
input [3:0]in_address_1;
input [3:0]in_address_2;
input [3:0]in_address_3;
input [3:0]in_address_4;
output reg [N-1:0]out_data_1;
output reg [N-1:0]out_data_2;
output reg [N-1:0]out_data_3;
output reg [N-1:0]out_data_4;
//writing
input [3:0] write_address_1;
input[N-1:0] write_data_1;
input [3:0] write_address_2;
input[N-1:0] write_data_2;
input[3:0] write_address_3;
input[N-1:0] write_data_3;
input[3:0] write_address_4;
input[N-1:0] write_data_4;
input clk;
input write_enable_1;
input write_enable_2;
input write_enable_3;
input write_enable_4;
input read_enable_1;
input read_enable_2;
input read_enable_3;
input read_enable_4;
//pc
output reg [N-1:0]pc;
input pc_write;
input[N-1:0] pc_update;
//cspr
output reg [N-1:0]cspr;
input wire cspr_write;
input[N-1:0] cspr_update;
initial begin
	cspr = 0;
	R[0] = 0;
	R[1] = 0;
	R[2] = 0;
	R[3] = 0;
	R[4] = 0;
	R[5] = 0;
	R[6] = 0;
	R[7] = 0;
	R[8] = 0;
	R[9] = 0;
	R[10] = 0;
	R[11] = 0;
	R[12] = 0;
	R[13] = 0;
	R[14] = 0;
	R[15] = 0;	//pc = 0
end

//always@(*) begin
	//pc = R[2^3];
//end

always@(negedge clk) begin
	if(read_enable_1 == 1 || read_enable_2 == 1 || read_enable_3 == 1 || read_enable_4 == 1) begin
		#5
		if (read_enable_1 == 1) 
		out_data_1=R[in_address_1];
		if (read_enable_2 == 1)
		out_data_2=R[in_address_2];
		if (read_enable_3 == 1)
		out_data_3=R[in_address_3];
		if (read_enable_4 == 1)
		out_data_4=R[in_address_4];
	end 

	if(pc_write == 1) R[15] = pc_update;
	if(cspr_write == 1) cspr = cspr_update;
	if(write_enable_1 == 1 || write_enable_2 == 1 || write_enable_3 == 1 || write_enable_4 == 1) begin
		#5
		if (write_enable_1 == 1) R[write_address_1] = write_data_1;
		if (write_enable_2 == 1) R[write_address_2] = write_data_2;
		if (write_enable_3 == 1) R[write_address_3] = write_data_3;
		if (write_enable_4 == 1) R[write_address_4] = write_data_4;
	end
	
end
endmodule 
