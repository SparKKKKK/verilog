//-----------------------------------------------
//  Data:2019/04/06
//  Author: Lynn
//  Describtion:一般的，普通二进制码与格雷码可以按以下方法互相转换：
//　　二进制码->格雷码（编码）：从最右边一位起，依次将每一位与左边一位异或（XOR），作为对应格雷码该位的值，最左边一位不变（相当于左边是0）；
//　　格雷码-〉二进制码（解码）：从左边第二位起，将每位与左边一位解码后的值异或，作为该位解码后的值（最左边一位依然不变）。
//
//------------------------------------------------

module grey_counter(clk,rst,dout);
parameter cnt_wide=4;
input clk,rst;
output [cnt_wide-1:0]dout;

reg [cnt_wide-1:0]dout;

reg [cnt_wide-1:0]q;

always@(posedge clk or negedge rst) begin
  if(rst) begin
    q<=0;
  end else if(q>=15)begin
    q<=0;
  end else 
    q <= q+1;
end

always@(*) begin
    dout = (q>>1)^q;
/*
    dout[3]=q[3];
    dout[0]=q[0]^q[1];
    dout[1]=q[1]^1[2];
    dout[2]=q[2]^q[3];
*/
end

endmodule

