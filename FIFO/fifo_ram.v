module fifo_ram(
rclk,wclk,
wdata,rdata,waddr,raddr,write,read
    );


always@(posedge rclk)begin
    if(read)
        rdata <= mem[raddr] ; 
end

always@(posedge wclk) begin
    if(write)
        mem[waddr] <= wdata;
end


