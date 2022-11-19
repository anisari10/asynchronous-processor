module register_file(in_address_1,in_address_2,in_address_3,in_address_4, 
						out_data_1,out_data_2,out_data_3,out_data_4, 
						write_address_1,write_data_1,write_enable_1,
						write_address_2, write_data_2, write_enable_2,
                        write_address_3, write_data_3, write_enable_3,
						pc, pc_update, pc_write, 
                        read_enable_1, read_enable_2, read_enable_3,
						cspr, cspr_write, cspr_update, clk, req, ack);

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

input clk;
input write_enable_1;
input write_enable_2;
input write_enable_3;

input read_enable_1;
input read_enable_2;
input read_enable_3;

//pc
output reg [N-1:0]pc;
input pc_write;
input[N-1:0] pc_update;


//cspr
output reg [N-1:0]cspr;
input wire cspr_write;
input[N-1:0] cspr_update;


async_clk async_clk(.clk(clk), .req(req), .ack(ack));
 multiplier mult(.Rs(Rs), .Rm(Rm), .result(result));

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
	R[15] = 0;	
        pc = 0;
	req = 0;
	ack = 0;
end

//always@(*) begin
	//pc = R[2^3];
//end

always@(*)
if(write_enable_1 == 1)
begin
#1 req = 1;
end
always@(*)
if(write_enable_2 == 1)
begin
#1 req = 1;
end
always@(*)
if(write_enable_3 == 1)
begin
#1 req = 1;
end


always@(*)
if(read_enable_1 == 1)
begin
#1 req = 1;
end
always@(*)
if(read_enable_2 == 1)
begin
#1 req = 1;
end
always@(*)
if(read_enable_3 == 1)
begin
#1 req = 1;
end

//async_clk clk_1(.clk(clk), .req(req), .ack(ack));

always@(posedge clk) begin
    if (read_enable_1==1)
	begin
	#5
	out_data_1=R[in_address_1];
	#1 
	 ack = 1;
	 req = 0;
	end
    if (read_enable_2==1)
	begin
	#5
	out_data_2=R[in_address_2];
	#1 
	 ack = 1;
	 req = 0;
	end
    if (read_enable_3==1)
	begin
	#5
	out_data_3=R[in_address_3];
	#1 
	 ack = 1;
	 req = 0;
	end

	// if(pc_write == 1) R[15] = pc_update;
	// if(cspr_write == 1) cspr = cspr_update;

	// write data into reg when write_enable is set. After writing, acknowledge.
    // 6ns to acknowledge.
    if (write_enable_1==1)
	begin
	#5
	 R[write_address_1]=write_data_1;
	#1 
	 ack = 1;
	 req = 0;
	end
	if (write_enable_2==1) 
	begin
	#5
	R[write_address_2]=write_data_2;
	#1
	ack = 1;
	req = 0;
	end
    if (write_enable_3==1) 
	begin
	#5
	R[write_address_3]=write_data_3;
	#1
	ack = 1;
	req = 0;
	end

end


// when write_enable and read_enable are low, req, ack signals are also low. Hence clk is low
always @(*)
if(write_enable_1 == 0)
begin
ack = 0;
req = 0;
end
always @(*)
if(write_enable_2 == 0)
begin
ack = 0;
req = 0;
end
always @(*)
if(write_enable_3 == 0)
begin
ack = 0;
req = 0;
end

always @(*)
if(read_enable_1 == 0)
begin
ack = 0;
req = 0;
end
always @(*)
if(read_enable_2 == 0)
begin
ack = 0;
req = 0;
end
always @(*)
if(read_enable_3 == 0)
begin
ack = 0;
req = 0;
end


endmodule
