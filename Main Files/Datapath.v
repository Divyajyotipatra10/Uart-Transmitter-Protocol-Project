/*----------------------------------------------------
datapath- Main Module
----------------------------------------------------*/
module uart(load,shift,increment,rstcounter,p_s,din,dout,count,clk);
input load,shift,increment,rstcounter,p_s,clk;
input [6:0]din;
output count;
output dout;
wire [7:0]p_dout;
p_generator PB(p_s,din,p_dout); //parity bit generator and data sender

countermod10 CNTR(increment,rstcounter,count);//whole counter process

piso_sr SR(p_dout,clk,shift,load,dout); //shift Register processing

endmodule


/*----------------------------------------------------
datapath- Parity Generator
----------------------------------------------------*/
module p_generator(p_s,din,p_dout);
    input p_s;
    input [6:0]din;
    reg p_b;
    output [7:0]p_dout; //
    always @(*)
    begin
        if(~p_s)
        begin
            p_b<=(din[0]^din[1]^din[2]^din[3]^din[4]^din[5]^din[6]);//even parity generator
        end
        else
        begin
            p_b<=(~(din[0]^din[1]^din[2]^din[3]^din[4]^din[5]^din[6]));//odd parity generator
        end
    end
    assign p_dout={p_b,din};
endmodule


/*----------------------------------------------------
datapath- Counter
----------------------------------------------------*/
module countermod10(increment,rstcounter,count10);//Moore Based Counter
input increment,rstcounter;
output reg count10;
reg [3:0]state;
parameter S0=4'b0000,S1=4'b0001,S2=4'b0010,S3=4'b0011,S4=4'b0100,S5=4'b0101,S6=4'b0110,S7=4'b0111,S8=4'b1000,S9=4'b1001	;

always @(posedge increment)
begin
	if (rstcounter)
		state<=S0;
	else
		case(state)
			S0: state<=S1;
			S1: state<=S2;
			S2: state<=S3;
			S3: state<=S4;
			S4: state<=S5;
			S5: state<=S6;
			S6: state<=S7;
			S7: state<=S8;
			S8: state<=S9;
			S9: state<=S0;
			default : state<=S0;
		endcase
end

always @(state)
begin
	case(state)
			S0: count10<=0;
			S1: count10<=0;
			S2: count10<=0;
			S3: count10<=0;
			S4: count10<=0;
			S5: count10<=0;
			S6: count10<=0;
			S7: count10<=0;
			S8: count10<=0;
			S9: count10<=1;
			default : count10<=0;
	endcase
end
endmodule


/*----------------------------------------------------
datapath- Shift Register
----------------------------------------------------*/
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
/*----------------------------------------------------
datapath- Datapath Over
----------------------------------------------------*/
