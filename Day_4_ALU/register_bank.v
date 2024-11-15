
module register_bank (
    input wire clk,
    input wire reset,
    input wire [2:0] data_a,
    input wire [2:0] data_b,
    input wire [1:0] compute,
    input wire [1:0] addr,
    input wire wr_en,
    input wire rd_en,
    output reg [2:0] data_a_out,
    output reg [2:0] data_b_out,
    output reg [1:0] compute_out
);
    reg [2:0] data_a_reg;
    reg [2:0] data_b_reg;
    reg [2:0] compute_reg;

    always @(posedge clk, posedge reset) begin
        if(reset) begin
          data_a_out <= 0;
          data_b_out <= 0;
          compute_out <= 0;
        end
        else begin
          data_a_out <= data_a_reg;
          data_b_out <= data_b_reg;
          compute_out <= compute_reg;
        end
    end

    assign data_a_reg = wr_en & addr == 2'b00 ? data_a : data_a_reg;
    assign data_b_reg = wr_en & addr == 2'b01 ? data_b : data_b_reg;
    assign compute_reg = wr_en & addr == 2'b10 ? compute : compute_reg;

    
endmodule