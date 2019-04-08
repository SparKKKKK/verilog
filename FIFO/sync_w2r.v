module sync_w2r#(
    parameter DSIZE = 8,
    parameter ASIZE = 4
)(
    input  [ASIZE:0] wr_ptr,
    input            rd_clk,
    input            rd_rst,
    output reg [ASIZE:0] w2r_ptr
);

reg [ASIZE:0] med_ptr2;
always@(posedge rd_clk or posedge rd_rst) begin
  if(rd_rst) begin
    w2r_ptr <= 0;
    med_ptr2 <= 0;
    //{w2r_ptr,med_ptr2} <= 0;
  end
  else begin
    w2r_ptr <= med_ptr2;
    med_ptr2 <= wr_ptr;
    //{w2r_ptr,med_ptr2} <= {med_ptr2,wr_ptr};
  end
end
endmodule