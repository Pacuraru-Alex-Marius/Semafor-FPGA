module semafor(
input  clk  ,
input  rst_n,
input  sw   ,
output R    , 
output Y    , 
output G    ,
output R_P  ,
output G_P 
);

localparam RED    = 2'b00;
localparam YELLOW = 2'b01;
localparam GREEN  = 2'b11;

reg [1:0] current_state;
reg [1:0] next_state;
reg [3:0] cnt;
reg       rst_cnt;

always@(posedge clk or negedge rst_n)
  if (~rst_n || rst_cnt) 
    cnt <= 'd0;
  else if (cnt == 'd6 && current_state == GREEN)
    cnt <= 'd6;
  else 
    cnt <= cnt + 1;

always@(posedge clk or negedge rst_n)
  if (~rst_n)
    current_state <= RED;
  else 
    current_state <= next_state;

always@(*) begin
  case (current_state)
    GREEN: 	
      if (cnt == 'd6 && sw == 1) begin
        next_state <= YELLOW;
        rst_cnt <= 1;
      end 		
      else begin
        next_state <= GREEN;
        rst_cnt <= 0;
      end
    YELLOW: 	
      if (cnt == 'd1) begin
        next_state <= RED;
        rst_cnt <= 1;
      end 		
      else begin 
        next_state <= YELLOW;
        rst_cnt <= 0;
      end
    default: // RED
      if (cnt == 'd9) begin
        next_state <= GREEN;
        rst_cnt <= 1;
      end 		
      else begin
        next_state <= RED;
        rst_cnt <= 0;
      end
  endcase
end

assign R = (current_state == RED); 
assign Y = (current_state == YELLOW); 
assign G = (current_state == GREEN);

assign R_P = (current_state == GREEN || current_state == YELLOW);
assign G_P = (current_state == RED);

endmodule // semafor