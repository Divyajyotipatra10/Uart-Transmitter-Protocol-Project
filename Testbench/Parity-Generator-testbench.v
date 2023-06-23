module partiy_tb;
reg [6:0]din;
reg p_s;
wire p_b;
  wire [9:0]in_sr;
  parity_bit_generator dut(din,p_b,p_s,in_sr);
initial begin
#10 p_s=1'b0; din<=7'b0000000;
#10 p_s=1'b0; din<=7'b0000001;
#10 p_s=1'b0; din<=7'b0000010;
#10 p_s=1'b0; din<=7'b1011101;
#10 p_s=1'b0; din<=7'b1010101;
  #10 p_s=1'b0; din<=7'b0000011;
  #10 p_s=1'b0; din<=7'b0001010;
  #10 p_s=1'b1; din<=7'b0001100;
  #10 p_s=1'b1; din<=7'b0000111;
  #10 p_s=1'b1; din<=7'b0001111;
  #10 p_s=1'b1; din<=7'b0010011;
  #10 p_s=1'b1; din<=7'b0101101;
  #10 p_s=1'b1; din<=7'b1100111;
  #10 p_s=1'b1; din<=7'b1110111;
  #10 p_s=1'b1; din<=7'b1011110;
  #40$finish;
end
  initial $monitor($stime,,,"p_b= %b   in_sr=%b",p_b,in_sr);
endmodule 
