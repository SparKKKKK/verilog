module beh_fifo #(
    parameter DSIZE = 8,
    parameter ASIZE = 4
    )(
    output [DSIZE-1:0] rd_data,
    output             wr_full,
    output             rd_empty,
    input  [DSIZE-1:0] wr_data,
    input              wr_inc, wr_clk, wr_rst,
    input              rd_inc, rd_clk, rd_rst
    );

localparam MEMDEPTH = 1<<ASIZE;
reg [DSIZE-1:0] ex_mem [0:MEMDEPTH-1];

reg [ASIZE:0] wr_ptr, wrptr1, wrptr2, wrptr3;
reg [ASIZE:0] rptr, rwr_ptr1, rwr_ptr2, rwr_ptr3;

always @(posedge wr_clk or posedge wr_rst) begin
    if (wr_rst) begin
        wr_ptr <= 0;
    end
    else if (wr_inc && !wr_full) begin
        ex_mem[wr_ptr[ASIZE-1:0]] <= wr_data;
        wr_ptr <= wr_ptr+1;
    end
end

always @(posedge wr_clk or posedge wr_rst) begin
    if (wr_rst) begin
        {wrptr3, wrptr2, wrptr1} <= 0;
    end
    else begin
        {wrptr3, wrptr2, wrptr1} <= {wrptr2, wrptr1, rptr};
    end
end

always @(posedge rd_clk or posedge rd_rst) begin
    if (rd_rst) begin
        rptr <= 0;
    end
    else if (rd_inc && !rd_empty) begin
        rptr <= rptr+1;
    end
end

always @(posedge rd_clk or posedge rd_rst) begin
    if (rd_rst) begin
        {rwr_ptr3, rwr_ptr2, rwr_ptr1} <= 0;
    end
    else begin
        {rwr_ptr3, rwr_ptr2, rwr_ptr1} <= {rwr_ptr2, rwr_ptr1, wr_ptr};
    end
end

assign rd_data = ex_mem[rptr[ASIZE-1:0]];
assign rd_empty = (rptr == rwr_ptr3);
assign wr_full = ((wr_ptr[ASIZE-1:0] == wrptr3[ASIZE-1:0]) &&
                (wr_ptr[ASIZE]     != wrptr3[ASIZE]));

endmodule
