module rptr_empty#(
    parameter DSIZE = 8,
    parameter ASIZE = 4
)(
    output  reg            rd_empty,
    output     [ASIZE-1:0] rd_addr,
    output reg [ASIZE:0] rd_ptr,
    input        [ASIZE:0] w2r_ptr,
    input        rd_inc,
    input        rd_clk,
    input        rd_rst
);
//
//for judgement of wire/reg

reg [ASIZE-1:0] rbin,rgnext,rbnext;

// pointer use grey code 
always@(posedge rd_clk or posedge rd_rst) begin
    if(rd_rst) begin
        rd_ptr <= 0;
        rbin <= 0;
    end
    else begin
        rd_ptr <= rgnext;
        rbin <= rbnext;
    end
end

//grey counter and bin code transfer to grey code 
always@(*)begin
    rbnext = (!rd_empty)?(rbin + rd_inc) : rbin;
    rgnext = (rbnext>>1)^rbnext;
end

//memory address pointer 
assign rd_addr = rbin[ASIZE-1:0];

//FIFO empty on reset or when the next rptr == synchronized wptr
always@(posedge rd_clk or posedge rd_rst) begin
    if(rd_rst) begin
        rd_empty <= 1;
    end
    else 
        rd_empty <= (rgnext == w2r_ptr);
end

endmodule


 
