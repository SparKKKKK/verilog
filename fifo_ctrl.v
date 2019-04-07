module fifo_ctrl#(
    parameter DSIZE = 8,
    parameter ASIZE = 4
    )(
    output [DSIZE-1:0]rd_data,
    output rd_full,
    output wr_full,
    output rd_empty,

    input rd_clk,
    input wr_clk,
    input [DSIZE-1:0] wr_data,
    input wr_rst,
    input rd_rst,
    input rd_inc,
    input wr_inc
    );
wire [ASIZE-1:0] wr_addr,rd_addr;
wire [ASIZE-1:0] wr_ptr,rd_ptr,r2w_ptr,w2r_ptr;
//
//for judgement of wire/reg
//
rptr_empty  #(ASIZE,DSIZE) u1(
    .rd_clk   (rd_clk),
    .w2r_ptr   (w2r_ptr),
    .rd_inc   (rd_inc),
    .rd_rst   (rd_rst),
    .rd_addr  (rd_addr),
    .rd_empty (rd_empty),
    .rd_ptr   (rd_ptr)
);

sync_w2r  #(ASIZE,DSIZE) u2(
    .rd_clk   (rd_clk),
    .rd_rst   (rd_rst),
    .wr_ptr   (wr_ptr),
    .w2r_ptr   (w2r_ptr)
);

wptr_full  #(ASIZE,DSIZE) u3(
    .wr_clk   (wr_clk),
    .wr_rst   (wr_rst),
    .r2w_ptr   (r2w_ptr),
    .wr_inc   (wr_inc),
    .wr_addr  (wr_addr),
    .wr_full  (wr_full),
    .wr_ptr   (wr_ptr)
);

sync_r2w  #(ASIZE,DSIZE) u4(
    .wr_clk   (wr_clk),
    .wr_rst   (wr_rst),
    .rd_ptr   (rd_ptr),
    .r2w_ptr   (r2w_ptr)
);

fifo_ram  #(ASIZE,DSIZE) u5(
    .wr_clk   (wr_clk),
    .wr_addr  (wr_addr),
    .wr_inc   (wr_inc),
    .wr_full  (wr_full),
    .wr_data  (wr_data),
    .rd_addr  (rd_addr),
    .rd_inc   (rd_inc),
    .rd_data  (rd_data)
);

endmodule 