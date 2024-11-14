

module register_bank(
  input wire clk,
  input wire reset_b,
  input wire [3:0] wr_data,
  input wire [1:0] addr,
  input wire wr_en,
  input wire rd_en,
  output reg [3:0] red_time,
  output reg [3:0] yellow_time,
  output reg [3:0] green_time,
  output reg [3:0] rd_data
);

  reg [3:0] red_time_reg;
  reg [3:0] yellow_time_reg;
  reg [3:0] green_time_reg;

  always @(posedge clk, negedge reset_b) begin
    if(~reset_b) begin
      red_time <= 0;
      yellow_time <= 0;
      green_time <= 0;
    end

    else begin
      red_time <= red_time_reg;
      yellow_time <= yellow_time_reg;
      green_time <= green_time_reg;
    end
  end

  assign red_time_reg = wr_en & addr == 2'b01 ? wr_data : red_time_reg;
  assign yellow_time_reg = wr_en & addr == 2'b10 ? wr_data : yellow_time_reg;
  assign green_time_reg = wr_en & addr == 2'b11 ? wr_data : green_time_reg;

  assign rd_data = rd_en & addr == 2'b01 ? red_time_reg : 0;
  assign rd_data = rd_en & addr == 2'b10 ? yellow_time_reg : 0;
  assign rd_data = rd_en & addr == 2'b11 ? green_time_reg : 0;


endmodule


