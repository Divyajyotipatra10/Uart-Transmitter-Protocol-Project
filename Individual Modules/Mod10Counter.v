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
