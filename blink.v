module blink(
input           clk  , // clock 12 MHz
input           rstn , // reset, active low, from SW1 pushbutton
input  [4 -1:0] dipsw, // config inputs, from SW2 DIP switches
output [8 -1:0] led    // light outputs, to LEDs (D2-D9)
);

wire R, Y, G, R_P, G_P;

clock_div i_clock_div(
.clk   (clk) ,
.rst_n (rstn),
.sec   (sec)  
);

semafor  i_semafor(
.clk   (sec      ),
.rst_n (rstn     ),	
.sw    (~dipsw[0]),
.R     (R        ),
.Y     (Y        ),
.G     (G        ),
.R_P   (R_P      ),
.G_P   (G_P      )
);

assign led[0] = ~R;
assign led[1] = ~Y;
assign led[2] = ~G;
assign led[3] = 1;
assign led[4] = 1;
assign led[5] = 1;
assign led[6] = ~R_P;
assign led[7] = ~G_P;

endmodule // blink