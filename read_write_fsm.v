
module read_write_fsm(
  input wire clk,
  input wire reset_b,
  input wire cs,
  input wire write,
  output reg wr_en,
  output reg rd_en
);

  reg [1:0] pstate, nstate;
  parameter IDLE = 2'b00,
            SETUP = 2'b01,
            WRITE = 2'b10,
            READ = 2'b11;


  always @(posedge clk, negedge reset_b) begin
    if(~reset_b) begin
      pstate <= IDLE;
    end
    else begin
      pstate <= nstate;
    end
  end


  always @(*) begin
    case (pstate)
      IDLE: nstate = cs ? SETUP : IDLE;
      SETUP: nstate = cs ? (write ? WRITE : READ) : IDLE ;
      WRITE: nstate = IDLE;
      READ: nstate = IDLE;
      default: nstate = IDLE;
    endcase
  end

  always @(*) begin
    case (pstate)
      IDLE: begin
        wr_en = 0;
        rd_en = 0;
      end

      SETUP: begin
        wr_en = 0;
        rd_en = 0;
      end

      WRITE: begin
        wr_en = 1;
        rd_en = 0;
      end

      READ: begin
        wr_en = 0;
        rd_en = 1;
      end
      default: begin
        wr_en = 1'bx;
        rd_en = 1'bx;
      end
    endcase
  end

endmodule