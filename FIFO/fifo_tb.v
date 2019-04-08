`timescale 1ns/100ps

module fifo_tb;

parameter DSIZE = 8;
parameter ASIZE = 4;

wire [DSIZE-1:0] rd_data, beh_rd_data;
wire             wr_full, beh_wr_full;
wire             rd_empty, beh_rd_empty;
reg  [DSIZE-1:0] wr_data;
reg              wr_inc, wr_clk, wr_rst;
reg              rd_inc, rd_clk, rd_rst;

fifo_ctrl #(DSIZE, ASIZE) U1(
    .rd_data(rd_data),
    .wr_full(wr_full),
    .rd_empty(rd_empty),
    .wr_data(wr_data),
    .wr_inc(wr_inc),
    .wr_clk(wr_clk),
    .wr_rst(wr_rst),
    .rd_inc(rd_inc),
    .rd_clk(rd_clk),
    .rd_rst(rd_rst)
    );

beh_fifo #(DSIZE, ASIZE) U2(
    .rd_data(beh_rd_data),
    .wr_full(beh_wr_full),
    .rd_empty(beh_rd_empty),
    .wr_data(wr_data),
    .wr_inc(wr_inc),
    .wr_clk(wr_clk),
    .wr_rst(wr_rst),
    .rd_inc(rd_inc),
    .rd_clk(rd_clk),
    .rd_rst(rd_rst)
    );

always #30 wr_clk = ~wr_clk;
always #20 rd_clk = ~rd_clk;
always #30 wr_data = {$random}%256;

initial begin
    wr_rst = 0;
    rd_rst = 0;
    rd_clk = 0;
    wr_clk = 0;
    wr_inc = 0;
    rd_inc = 0;
    #50 wr_rst = 1;
        rd_rst = 1;
    #50 wr_rst = 0;
        rd_rst = 0;
    #10 rd_inc = 1;
    #100 rd_inc = 0;
    #100 wr_inc = 1;
    #1000 wr_inc = 0;
    #100 rd_inc = 1;
    #2000 $finish;
end

always @((rd_data  != beh_rd_data ) && 
         (wr_full  != beh_wr_full ) &&
         (rd_empty != beh_rd_empty)) begin
    $display($time, "rd_data is %h, beh_rd_data is %h", rd_data, beh_rd_data);
end

endmodule
