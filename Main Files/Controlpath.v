module statemachine(send,busy,load,shift,increment,rstcounter,count,clk,rst);
input send,count,clk,rst;
output reg busy,load,shift,increment,rstcounter;
/*-----------------------------------------------------------------------------
//states of the machine machine 
-----------------------------------------------------------------------------*/
parameter S0=3'b000, S1=3'b001, S2=3'b010, S3=3'b011, S4=3'b100;
reg [2:0]state;
always @(posedge clk)
	begin
		if(rst)
			state<=S0;
		else
			case(state)
				S0:					//Idle state
				begin
					if(send)
					begin 
						state<=S1;
					end
					else
						state<=S0;
				
				end
				
				S1:	state<=S2;			//Load State for Shift register
				
  				S2:	state<=S3;			//counter state
												
				S3:                                     //Data shifting State
				begin
					if(count)
						state<=S4;
					else
						state<=S2;
				end
				
				S4:                                    //Wait State(waiting for send command). 
				begin	
					if(send)
						state<=S1;
					else
						state<=S0;
					
				end
				
				default : state<=S0;
			endcase
					
	end
always @(state)
	begin
		case(state)
			S0:
			begin
				load<=1'b1; increment<=1'b0; shift<=1'b1; rstcounter<=1'b0; busy<=1'b0;
			end
			S1:
			begin
				load<=1'b1; increment<=1'b0; shift<=1'b0; rstcounter<=1'b1; busy<=1'b1;
			end
			S2:
			begin
				load<=1'b0; increment<=1'b0; shift<=1'b0; rstcounter<=1'b0; busy<=1'b1;
			end
			S3:
			begin
				load<=1'b0; increment<=1'b1; shift<=1'b1; rstcounter<=1'b0; busy<=1'b1;	
			end
			S4:
			begin
				load<=1'b0; increment<=1'b0; shift<=1'b0; rstcounter<=1'b0; busy<=1'b0;
			end
			
			default : begin load<=1'b0; increment<=1'b0; shift<=1'b0; rstcounter<=1'b0; busy<=1'b0; end
		endcase
	end

endmodule
