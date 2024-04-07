module clock_div(
input  clk  , // clock input
input  rst_n, // reset active low   
output sec    // a pulse every second
);

localparam TIME_TO_CNT = 5;
//localparam TIME_TO_CNT = 12000000;

reg [31:0] cnt;

always@(posedge clk or negedge rst_n)
  if (~rst_n || sec)
    cnt <= 'd0;
  else 
    cnt <= cnt + 1;

assign sec = (cnt == TIME_TO_CNT);

endmodule // clock_div
