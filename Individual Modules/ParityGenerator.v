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
