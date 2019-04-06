module grey_counter(
clk,rst,dout
    );
input clk,rst;
output [cnt_wide-1:0]dout;

reg [3:0]dout;
reg [3:0]current_dout;
reg [3:0]next_dout;

localparam cnt0 = 4'b0000;
localparam cnt1 = 4'b0001;
localparam cnt2 = 4'b0010;
localparam cnt3 = 4'b0011;
localparam cnt4 = 4'b0

