
module top_module (
  input wire clk, 
  input wire reset_b, 
  input wire start,
  input wire cs,
  input wire write,
  input wire [3:0] wr_data,
  input wire [1:0] addr,
  output wire red,
  output wire green,
  output wire yellow,
  output wire [3:0] rd_data
);


  wire eq_yellow_time;
  wire eq_red_time;
  wire eq_green_time;
  wire [3:0] green_time;
  wire [3:0] red_time;
  wire [3:0] yellow_time;
  wire clear;
  wire [3:0] count;
  wire wr_en;
  wire rd_en;

  traffic_light_fsm u_traffic_light_fsm(
    .clk(clk), 
    .reset_b(reset_b), 
    .start(start),
    .eq_yellow_time(eq_yellow_time),
    .eq_red_time(eq_red_time),
    .eq_green_time(eq_green_time),
    .red(red), 
    .green(green), 
    .yellow(yellow),
    .clear(clear)
  );

  read_write_fsm u_read_write_fsm(
    .clk(clk),
    .reset_b(reset_b),
    .cs(cs),
    .write(write),
    .wr_en(wr_en),
    .rd_en(rd_en)
  );

  register_bank u_register_bank(
    .clk(clk),
    .reset_b(reset_b),
    .wr_data(wr_data),
    .addr(addr),
    .wr_en(wr_en),
    .rd_en(rd_en),
    .red_time(red_time),
    .yellow_time(yellow_time),
    .green_time(green_time),
    .rd_data(rd_data)
  );

  counter u_counter(
    .clk(clk), 
    .clear(clear), 
    .reset_b(reset_b),
    .count(count)
  );

  comparator u_comparator(
    .count(count),
    .red_time(red_time),
    .yellow_time(yellow_time),
    .green_time(green_time),
    .eq_yellow_time(eq_yellow_time),
    .eq_red_time(eq_red_time),
    .eq_green_time(eq_green_time)
  );


    
endmodule