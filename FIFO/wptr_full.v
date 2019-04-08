module wptr_full#(
    parameter ASIZE = 4,
    parameter DSIZE = 8
)(
    input [ASIZE:0] r2w_ptr,
    input           wr_clk,
    input           wr_rst,
    input           wr_inc,
    output     [ASIZE-1:0] wr_addr,
    output reg [ASIZE:0]   wr_ptr,
    output reg             wr_full
);
reg [ASIZE:0] wbin,wbnext,wgnext;

// pointer use grey code 
always@(posedge wr_clk or posedge wr_rst) begin
    if(wr_rst) begin
        wbin <= 0;
        wr_ptr <=0;
    end
    else begin
        wr_ptr <= wgnext;
        wbin <= wbnext; 
    end
end

always@(*) begin
    wbnext = (!wr_full)?(wbin + wr_inc) : wbin;
    wgnext = (wbnext>>1)^wbnext;
end

//memory address poninter
assign wr_addr = wbin[ASIZE-1:0];

//FIFO full generation
always@(posedge wr_clk or posedge wr_rst)begin
    if(wr_rst) wr_full <= 1;
    else begin
        wr_full <= ( wgnext == { ~r2w_ptr[ASIZE:ASIZE-1], r2w_ptr[ASIZE-2:0] } );
        //wr_full <= ((wgnext[ASIZE])   != r2w_ptr[ASIZE]) &&
        //            (wgnext[ASIZE-1]) != r2w_ptr[ASIZE-1] &&
        //            (wgnext[ASIZE-2:0] == r2w_ptr[ASIZE-2:0]);
    end
end

endmodule
