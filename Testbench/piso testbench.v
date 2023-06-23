module piso_sr_9bit_tb();
  reg load,clk,rst;
  reg[7:0]in_sr;
  wire dout;
  piso_sr_9bit xx(load,in_sr,dout,clk,rst);
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    clk<=1;
    forever #10 clk<=~clk;
  end
  initial begin
     rst<=1'b1; 
     load<=1'b1;
     in_sr<=8'b10001011;
    #13 rst<=1'b0;
    #16 load<=1'b0;
    #200 rst<=1'b1; load<=1'b1; in_sr<=8'b01110010;
    #10 rst<=1'b0;
    #13 load<=1'b0;
    #400 $stop;
   end
  initial $monitor($stime,,,"dout=%b",dout);
endmodule 
