
module alu(
  input wire [2:0] data_a,
  input wire [2:0] data_b,
  input wire [1:0] compute,
  input wire en,
  output reg [3:0] data_out
);


  always @(*) begin
    case (compute)
      2'b00: data_out = en ? data_a & data_b : 0;
      2'b01: data_out = en ? data_a | data_b : 0;
      2'b10: data_out = en ? data_a + data_b : 0;
      2'b11: data_out = en ? ~data_a : 0;
      default: data_out = 0;
    endcase
  end

endmodule