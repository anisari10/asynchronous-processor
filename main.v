`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module main_async(data_1, data_2, data_3, cache_we_1, cache_we_2, cache_we_3, 
		cache_re_1, cache_re_2, cache_re_3, cache_wa_1, cache_wa_2, cache_wa_3, 
		cache_ra_1, cache_ra_2, cache_ra_3, reg_we_1, reg_we_2, reg_we_3, reg_we_4,
		reg_re_1, reg_re_2, reg_re_3, reg_re_4, reg_ra_1, reg_ra_2, reg_ra_3, reg_ra_4, 
		reg_wa_1, reg_wa_2, reg_wa_3, reg_wa_4, reg_req, cache_req, reg_ack, cache_ack);							
parameter N = 32;
parameter address_size = 12;
input [address_size-1:0] cache_wa_1;
input [address_size-1:0] cache_wa_2;
input [address_size-1:0] cache_wa_3;
input [address_size-1:0] cache_ra_1;
input [address_size-1:0] cache_ra_2;
input [address_size-1:0] cache_ra_3;
input [N-1:0] data_1;
input [N-1:0] data_2;
input [N-1:0] data_3;
input cache_we_1;
input cache_we_2;
input cache_we_3;
input cache_re_1;
input cache_re_2;
input cache_re_3;
reg [N-1:0] cache_data_1;
reg [N-1:0] cache_data_2;
reg [N-1:0] cache_data_3;
reg [N-1:0] cache_data_4;
reg [N-1:0] final_result;
input reg_we_1;
input reg_we_2;
input reg_we_3;
input reg_we_4;
input reg_re_1;
input reg_re_2;
input reg_re_3;
input reg_re_4;
input [3:0] reg_wa_1;
input [3:0] reg_wa_2;
input [3:0] reg_wa_3;
input [3:0] reg_wa_4;
reg [N-1:0] reg_data_1;
reg [N-1:0] reg_data_2;
reg [N-1:0] reg_data_3;
reg [N-1:0] reg_data_4;
input [3:0] reg_ra_1;
input [3:0] reg_ra_2;
input [3:0] reg_ra_3;
input [3:0] reg_ra_4;
reg[N-1:0] reg_out_data_1;
reg[N-1:0] reg_out_data_2;
reg[N-1:0] reg_out_data_3;
reg[N-1:0] reg_out_data_4;
reg cache_REQ;
reg reg_REQ;
reg cache_ACK;
reg reg_ACK;
output reg cache_req;
output reg cache_ack;
reg cache_trig;
output reg reg_req;
output reg reg_ack;
reg reg_trig;


cache_async cache(.write_data_1(data_1), .write_data_2(data_2), .write_data_3(data_3),
		.wac_1(cache_wa_1), .wac_2(cache_wa_2), .wac_3(cache_wa_3), .rac_1(cache_ra_1),
		.rac_2(cache_ra_2), .rac_3(cache_ra_3), .out_data_1(cache_data_1), 
		.out_data_2(cache_data_2), .out_data_3(cache_data_3), .write_enable_1(cache_we_1),
		.write_enable_2(cache_we_2), .write_enable_3(cache_we_3), 
		.read_enable_1(cache_re_1), .read_enable_2(cache_re_2), .read_enable_3(cache_re_3),
		.req(cache_REQ), .ack(cache_ACK), .trig(cache_trig));
						
reg_async register(.write_address_1(reg_wa_1), .write_address_2(reg_wa_2),
		.write_address_3(reg_wa_3), .write_address_4(reg_wa_4),
		.write_data_1(cache_data_1), .write_data_2(cache_data_2), 
		.write_data_3(cache_data_3), .write_data_4(cache_data_4),
		.in_address_1(reg_ra_1), .in_address_2(reg_ra_2), 
		.in_address_3(reg_ra_3), .in_address_4(reg_ra_4),
		.write_enable_1(reg_we_1), .write_enable_2(reg_we_2), .write_enable_3(reg_we_3), 
		.write_enable_4(reg_we_4), .read_enable_1(reg_re_1), .read_enable_2(reg_re_2), 
		.read_enable_3(reg_re_3), .read_enable_4(reg_re_4),
		.out_data_1(reg_out_data_1), .out_data_2(reg_out_data_2),
		.out_data_3(reg_out_data_3), .out_data_4(reg_out_data_4), 
		.req(reg_REQ), .ack(reg_ACK), .trig(reg_trig));
							
multiplier mult(.Rm(reg_out_data_1), .Rs(reg_out_data_2), .result(reg_out_data_3));

initial begin
cache_REQ = 0;
reg_REQ = 0;
cache_ACK = 1;
reg_ACK = 1;
end

always@ (*) begin
cache_REQ = cache_req;
cache_ACK = cache_ack;
reg_REQ = reg_req;
reg_ACK = reg_ack; 
end

endmodule

