`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module tb_main_async;
parameter N = 32;
parameter address_size = 12;
reg [address_size-1:0] cache_wa_1;
reg [address_size-1:0] cache_wa_2;
reg [address_size-1:0] cache_wa_3;
reg [address_size-1:0] cache_ra_1;
reg [address_size-1:0] cache_ra_2;
reg [address_size-1:0] cache_ra_3;
reg [N-1:0] data_1;
reg [N-1:0] data_2;
reg [N-1:0] data_3;
reg cache_we_1;
reg cache_we_2;
reg cache_we_3;
reg cache_re_1;
reg cache_re_2;
reg cache_re_3;
reg reg_we_1;
reg reg_we_2;
reg reg_we_3;
reg reg_we_4;
reg [3:0] reg_wa_1;
reg [3:0] reg_wa_2;
reg [3:0] reg_wa_3;
reg [3:0] reg_wa_4;
reg reg_re_1;
reg reg_re_2;
reg reg_re_3;
reg reg_re_4;
reg [3:0] reg_ra_1;
reg [3:0] reg_ra_2;
reg [3:0] reg_ra_3;
reg [3:0] reg_ra_4;
wire cache_ack;
wire cache_req;
wire reg_ack;
wire reg_req;					
main_async main(.cache_wa_1(cache_wa_1), .cache_wa_2(cache_wa_2), .cache_wa_3(cache_wa_3),
		.cache_ra_1(cache_ra_1), .cache_ra_2(cache_ra_2), .cache_ra_3(cache_ra_3),
		.data_1(data_1), .data_2(data_2), .data_3(data_3), 
		.cache_we_1(cache_we_1), .cache_we_2(cache_we_2), .cache_we_3(cache_we_3),
		.cache_re_1(cache_re_1), .cache_re_2(cache_re_2), .cache_re_3(cache_re_3),
		.reg_we_1(reg_we_1), .reg_we_2(reg_we_2), .reg_we_3(reg_we_3), .reg_we_4(reg_we_4),
		.reg_wa_1(reg_wa_1), .reg_wa_2(reg_wa_2), .reg_wa_3(reg_wa_3), .reg_wa_4(reg_wa_4),
		.reg_re_1(reg_re_1), .reg_re_2(reg_re_2), .reg_re_3(reg_re_3), .reg_re_4(reg_re_4),
		.reg_ra_1(reg_ra_1), .reg_ra_2(reg_ra_2), .reg_ra_3(reg_ra_3), .reg_ra_4(reg_ra_4),
		.cache_ack(cache_ack), .cache_req(cache_req), .reg_req(reg_req), .reg_ack(reg_ack));
initial begin
	// wait for cache's acknowledgment
	while (cache_ack == 0)
	begin #1; end
	cache_we_1 = 1;
	cache_wa_1 = 12'h000;
	data_1 = 32'h2;
	#2;
	// data on data lines of cache being written into cache
	while (cache_ack == 0)
	begin #1; end
	cache_we_1 = 0;
	// writing of data in cache done
	cache_we_2 = 1;
	cache_wa_2 = 12'h001;
	data_2 = 32'h2;
	#2
	while (cache_ack == 0) 
	begin #1; end
	cache_we_2 = 0;
	// writing of 2nd data in cache done
	cache_re_1 = 1;
	cache_ra_1 = cache_wa_1;
	#2
	// data is being placed on cache output data lines
	while (cache_ack == 0)
	begin #1; end
	cache_re_1 = 0;
	// cache data is on data lines; wait for register's acknowledgment
	while (reg_ack == 0)
	begin #1; end
	reg_we_1 = 1;
	reg_wa_1 = 4'b0000;
	#2
	// writing of 1st data in register starts
	while (reg_ack == 0)
	begin #1; end
	// writing of cache data in register done
	// cache to register for 2nd data starts
	while (cache_ack == 0) 
	begin #1; end
	cache_re_2 = 1;
	cache_ra_2 = cache_wa_2;
	#2
	while (reg_ack == 0)
	begin #1; end
	cache_re_2 = 0;

	while (reg_ack == 0)
	begin #1; end
	reg_we_2 = 1;
	reg_wa_2 = 4'b0001;
	#2
	// writing of 2nd cache data into register done
	while (reg_ack == 0)
	begin #1; end
	// reading of 1st register data starts
	reg_re_1 = 1;
	reg_ra_1 = reg_wa_1;
	#2
	while (reg_ack == 0)
	begin #1; end
	reg_re_1 = 0;
	// reading of 2nd register data starts
	reg_re_2 = 1;
	reg_ra_2 = reg_wa_2;
	#2
	while (reg_ack == 0)
	begin #1; end
	reg_re_2 = 0;
	repeat(29) begin
	#2
	while (reg_ack == 0)
	begin #1; end
	reg_we_3 = 1;
	reg_wa_3 = 4'b0010;
	#2
	while (reg_ack == 0)
	begin #1; end
	reg_we_3 = 0;
	reg_re_3 = 1;
	reg_ra_3 = reg_wa_3;
	#2
	while (reg_ack == 0)
	begin #1; end
	reg_re_3 = 0;
	end
	reg_we_4 = 1;
	reg_wa_4 = 4'b0011;
	#2
	while (reg_ack == 0)
	begin #1; end
	reg_we_4 = 0;
	
	while (cache_ack == 0)
	begin #1; end
	cache_we_3 = 1;
	cache_wa_3 = 12'h002;
	#2
	while (cache_ack == 0)
	begin #1; end
	cache_we_3 = 0;

end
endmodule
