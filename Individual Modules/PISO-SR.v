module piso_sr(p_dout,clk,shift,load,dout);
    integer i;
    input load,clk,shift;
    input [7:0]p_dout;
    output reg dout;
    reg [7:0]in_dout;
    always @(posedge clk)
    begin
      if(load & shift)
        begin
            in_dout<={8{1'b1}}; //Ideal line 1 for rst.
            dout<=1;
        end
        else
        begin
          if(load && ~shift)
            begin
                in_dout<=p_dout; //Loading the values to their respective Flip-flops
                dout<=0;//start Bit
            end
          else if(~load && shift)
            begin
                in_dout[7]<=1'b1;
                for(i=0;i<7;i=i+1)
                begin
                    in_dout[i]<=in_dout[i+1]; //while shifting the data
                end
              dout<=in_dout[0];//shifting
            end
        end
    end
endmodule
