module fifo_ram#(
    parameter DSIZE=8,
    parameter ASIZE=4
    )(
    input wr_clk,
    input [DSIZE-1:0] wr_data,
    input rd_inc,wr_inc,
    input wr_full,
    input [ASIZE-1:0] rd_addr,wr_addr,

    output reg [DSIZE-1:0] rd_data
    );
reg [DSIZE-1:0] mem [ASIZE-1:0];
always@(*)begin
    if(rd_inc)
        rd_data = mem[rd_addr];
end
/*
always@(posedge rd_clk)begin
    if(rd_en)
        rd_data <= mem[rd_addr] ; 
end
*/
assign wr_en = wr_inc&(!wr_full);
always@(posedge wr_clk) begin
    if(wr_en)
        mem[wr_addr] <= wr_data;
end

endmodule 
