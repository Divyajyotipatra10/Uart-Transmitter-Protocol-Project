module m10c_tb;
  reg clk,rst;
  wire [3:0]count;

  m10c dut(clk,count,rst);

  initial begin
    clk<=0;
    forever #10 clk<=~clk;
  end
  initial 
  begin
    rst<=1;
    #20
    rst<=0;
    #10
    rst<=1;
    #1000
    $stop;
  end

endmodule 
