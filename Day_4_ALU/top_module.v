
module top_module (
    input wire clk,
    input wire reset,
    input wire en,
    input wire [2:0] data_a,
    input wire [2:0] data_b,
    input wire [1:0] compute,
    input wire [1:0] addr,
    input wire cs,
    input wire write,
    output wire [3:0] data_out
);

    wire wr_en;
    wire rd_en;
    wire [2:0] data_a_out;
    wire [2:0] data_b_out;
    wire [1:0] compute_out;


    register_bank u_register_bank (
        .clk(clk),
        .reset(reset),
        .data_a(data_a),
        .data_b(data_b),
        .compute(compute),
        .addr(addr),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .data_a_out(data_a_out),
        .data_b_out(data_b_out),
        .compute_out(compute_out)
    );

    read_write_fsm u_read_write_fsm (
        .clk(clk),
        .reset_b(reset),
        .cs(cs),
        .write(write),
        .wr_en(wr_en),
        .rd_en(rd_en)
    );

    alu u_alu (
        .data_a(data_a_out),
        .data_b(data_b_out),
        .compute(compute_out),
        .en(en),
        .data_out(data_out)
    );


    
    
endmodule