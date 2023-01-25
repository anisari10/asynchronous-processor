module reg_async(in_address_1,in_address_2,in_address_3,in_address_4, 
		out_data_1,out_data_2,out_data_3,out_data_4, 
		write_address_1,write_data_1,write_enable_1,
		write_address_2, write_data_2, write_enable_2,
  		write_address_3, write_data_3, write_enable_3,
		pc, pc_update, pc_write, write_enable_4, write_data_4,
  		read_enable_1, read_enable_2, read_enable_3, read_enable_4, 
  		write_address_4, cspr, cspr_write, cspr_update, req, ack, clk);

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
output reg req;
output reg ack;
//writing
input [3:0]write_address_1;
input[N-1:0] write_data_1;
input [3:0]write_address_2;
input[N-1:0] write_data_2;
input [3:0]write_address_3;
input[N-1:0] write_data_3;
input [3:0]write_address_4;
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
	R[0] = 32'b0;
	R[1] = 32'b0;
	R[2] = 32'b0;
	R[3] = 32'b0;
	R[4] = 32'b0;
	R[5] = 32'b0;
	R[6] = 32'b0;
	R[7] = 32'b0;
	R[8] = 32'b0;
	R[9] = 32'b0;
	R[10] = 32'b0;
	R[11] = 32'b0;
	R[12] = 32'b0;
	R[13] = 32'b0;
	R[14] = 32'b0;
	R[15] = 32'b0;	
   pc = 0;
	req = 0;
	ack = 1; // initialising ack with 1
end

//always@(*) begin
	//pc = R[2^3];
//end
always@(*)
begin
	if(write_enable_1 == 1)
	begin
	#1 req = 1;
	ack = 0;
	end
end
always@(*)
begin
	if(write_enable_2 == 1)
	begin
	#1 req = 1;
	ack = 0;
	end
end
always@(*)
begin
	if(write_enable_3 == 1)
	begin
	#1 req = 1;
	ack = 0;
	end
end


always@(*)
begin
	if(read_enable_1 == 1)
	begin
	#1 req = 1;
	ack = 0;
	end
end
always@(*)
begin
	if(read_enable_2 == 1)
	begin
	#1 req = 1;
	ack = 0;
	end
end
always@(*)
begin
	if(read_enable_3 == 1)
	begin
	#1 req = 1; 
	ack = 0;
	end
end

always@(posedge clk) begin
   	if (read_enable_1==1)
	begin
	#11
	out_data_1=R[in_address_1];
	#1 
	ack = 1;
	req = 0;
	end	
  	 else if (read_enable_2==1)
	begin
	#11
	out_data_2=R[in_address_2];
	#1 
	ack = 1;
	req = 0; 
	end
  	else if (read_enable_3==1)
	begin
	#11
	out_data_3=R[in_address_3];
	#1 
	ack = 1;
	req = 0;
	end
   	else if (write_enable_1==1)
	begin
	#11
	R[write_address_1]=write_data_1;
	#1 
	ack = 1;
	req = 0;
	end
	else if (write_enable_2==1) 
	begin
	#11
	R[write_address_2]=write_data_2;
	#1
	ack = 1;
	req = 0;
	end
   	else if (write_enable_3==1) 
	begin
	#11
	R[write_address_3]=write_data_3;
	#1
	ack = 1;
	req = 0;
	end
end
endmodule
