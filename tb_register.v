module register_test;

reg[3:0] read_address_1;
reg[3:0] write_address_1;

reg[3:0] read_address_2;
reg[3:0] write_address_2;

reg[3:0] in_address_1;
reg[3:0] in_address_2;

//reg[31:0] write_data;
//reg write_enable = 0;
reg[31:0] write_data;
reg[31:0] write_data_2;
reg write_enable = 0;
reg write_enable_2;


reg[31:0] pc_update;
reg pc_write;

reg clk;

wire[31:0] out_data_1;
wire[31:0] out_data_2;
wire[31:0] cspr;
wire[31:0] pc;

reg[31:0] Rm;
reg[31:0] Rs;
wire[31:0] result;


reg_sync RegisterFile(	//inputs
							.in_address_1(in_address_1),
							.in_address_2(in_address_2),
							.in_address_3(read_address_2),
							.in_address_4(write_address_2),

							
							.write_address(write_address_1),
							.write_address_2(write_address_2),
							.write_data(write_data),
							.write_data_2(write_data_2),
							.write_enable(write_enable),
							.write_enable_2(write_enable_2),
							
							.pc_update(pc_update), 
							.pc_write(pc_write), 
							.cspr_write(), 
							.cspr_update(),
							.clk(clk), 
							
							//outputs
							.out_data_1(out_data_1),
							.out_data_2(out_data_2),
							.out_data_3(),
							
							
							
							.pc(pc), 
							.cspr(cspr)			
							
							);


 multiplier mult(.Rs(Rs), .Rm(Rm), .result(result));

initial 
begin
clk = 0;
forever
#5 clk = ~clk;
end



initial begin
       	
	read_address_1 = 0;
	write_address_1 = 0;
	//$display("pc- %h" , pc);
	read_address_2 = 0;
	write_address_2 = 0;
	
	

	#2 
	write_address_1 = 4'b0000;
        write_enable = 1;
    	write_data = 32'h00000002;

	//#1 write_enable = 0;	

	
	write_address_2 = 4'b0001;
	write_enable_2 = 1;
	write_data_2 = 32'h00000002;
	//#1 write_enable = 0;

	//$display("pc %h", pc);
	#10
	
	in_address_1 = write_address_1;
	in_address_2 = write_address_2;
	#5
	Rs = out_data_1;
	Rm = out_data_2;
	#10
	repeat(10)
	begin
	#2
	Rs = result;
	end

	#3
	write_address_1 = 4'b0010;
	write_enable = 1;
	write_data = result;
	//$display("pc %h", pc);
end


endmodule
