
module traffic_light_fsm (
  input wire clk, 
  input wire reset_b, 
  input reg start,
  input reg eq_yellow_time,
  input reg eq_red_time,
  input reg eq_green_time,
  output reg red, 
  output reg green, 
  output reg yellow,
  output reg clear
);
    
  reg [1:0] state, next_state;
  parameter IDLE = 2'b00, RED = 2'b01, GREEN = 2'b10, YELLOW = 2'b11;
  reg direction;

  always @(posedge clk, negedge reset_b) begin: PSR
    if(~reset_b) begin
      state <= IDLE;
    end
      
    else begin
      state <= next_state;
    end
      
  end


  always @(*) begin:NSOL

    begin:NSL
      case (state)
        IDLE: next_state = start ? RED : IDLE;
        RED: next_state = eq_red_time ? YELLOW  : RED;
        YELLOW: next_state = eq_yellow_time ? (direction ? GREEN : RED) : YELLOW;
        GREEN: next_state = eq_green_time ?  YELLOW : GREEN;
        default: next_state = 2'bx;
      endcase
    end

    begin:NOL
      case (state)
        IDLE: begin
          red = 0;
          green = 0;
          yellow = 0;
          clear = 1;
          direction = 1;
        end

        RED: begin
          red = 1;
          green = 0;
          yellow = 0;
          clear = eq_red_time;
          direction = 1;
        end

        YELLOW: begin
          red = 0;
          green = 0;
          yellow = 1;
          clear = eq_yellow_time;
        end

        GREEN: begin
          red = 0;
          green = 1;
          yellow = 0;
          clear = eq_green_time;
          direction = 0;
        end

        default: begin
          red = 1'bx;
          green = 1'bx;
          yellow = 1'bx;
          clear = 1'bx;
          direction = 1'bx;
        end
      endcase
    end
  end

endmodule