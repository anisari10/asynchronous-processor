module async_clk_tb();
reg req, ack, sync;
wire clk;

async_clk async_clk(.req(req), .ack(ack), .clk(clk), .sync(sync));
initial
begin
req = 0;
ack = 0;
sync = 0;

#10 req = 1;
#2 req = 0;
#25 ack = 1;
#3 ack = 0;
#40 req = 1;
#1 req = 0;
#13 ack = 1;
#2 ack = 0;
#37 sync = 1;
#5 sync = 0;
end
endmodule
