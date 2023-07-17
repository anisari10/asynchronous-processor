module async_clk(req, ack, clk);
input wire req, ack;
output reg clk;
always@(*)
begin
if(req==1)
    clk=1;
else if(ack==1)
    clk=0;
end
endmodule
