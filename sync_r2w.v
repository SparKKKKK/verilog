module sync_r2w#(
    parameter ASIZE = 4,
    parameter DSIZE = 8
)(
    output reg [ASIZE:0] r2w_ptr,
    input  [ASIZE:0] rd_ptr,
    input            wr_clk,
    input            wr_rst
);

reg [ASIZE:0] med_ptr1;
always@(posedge wr_clk or posedge wr_rst) begin
  if(wr_rst) begin
    r2w_ptr <= 0;
    med_ptr1 <= 0;
    //{r2w_ptr,med_ptr1} <= 0;    
  end
  else begin
    r2w_ptr <= med_ptr1;
    med_ptr1 <= rd_ptr;
    //{r2w_ptr,med_ptr1} <= {med_ptr1,rd_ptr};
  end  
end
endmodule 