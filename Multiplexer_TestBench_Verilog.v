module mux_tb;
reg dIN1, dIN2, ch;
wire dOUT;

mux_2x1_gl uut(dIN1, dIN2, ch, dOUT);

    initial begin
        ch=0; dIN1=1; dIN2=0;
        #10
        dIN1=0; dIN2=1;
        #10
        ch=1; dIN1=1; dIN2=0;
        #10
        dIN1=0; dIN2=1;
        #10

        $finish();

    end 

endmodule
