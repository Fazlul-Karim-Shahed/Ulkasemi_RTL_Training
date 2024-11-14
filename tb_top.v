
module tb_top;
reg clk; 
reg reset_b; 
reg start;
reg [3:0] wr_data;
reg cs;
reg write;
reg [1:0] addr;
wire red;
wire green;
wire yellow;
wire [3:0] rd_data;


top_module u_top_module(
  .clk(clk), 
  .reset_b(reset_b), 
  .start(start),
  .cs(cs),
  .write(write),
  .wr_data(wr_data),
  .addr(addr),
  .red(red),
  .green(green),
  .yellow(yellow),
  .rd_data(rd_data)
);


initial begin
    clk = 0;
    forever #5 clk = ~clk;
end


initial begin
    reset_b = 0; 
    start = 0;
    cs = 0;
    write = 0;
    wr_data = 4'bxxxx;
    addr = 2'bxx;

    @(negedge clk);
    reset_b = 1;

    // Write 1
    @(negedge clk);
    cs = 1;
    wr_data = 4'd5;
    addr = 2'b01;

    @(negedge clk);
    write = 1;


    // Write 2
    @(negedge clk) ;
    cs = 0;
    write = 0;

    @(negedge clk) ;
    cs = 1;
    wr_data = 4'd10;
    addr = 2'b10;

    @(negedge clk);
    write = 1;


    // Write 3
    @(negedge clk) ;
    cs = 0;
    write = 0;


    @(negedge clk) ;
    cs = 1;
    wr_data = 4'd15;
    addr = 2'b11;

    @(negedge clk);
    write = 1;

    @(negedge clk) ;
    cs = 0;
    write = 0;

    @(negedge clk) ;
    start = 1;

    @(negedge clk);
    cs = 1;
    addr = 2'b01;

    @(negedge clk);


    @(negedge clk) ;
    cs = 0;

    @(negedge clk) ;
    cs = 1;
    addr = 2'b10;

    @(negedge clk);

    @(negedge clk) ;
    cs = 0;


    @(negedge clk) ;
    cs = 1;
    addr = 2'b11;

    @(negedge clk);

    @(negedge clk) ;
    cs = 0;

    repeat (50) @(negedge clk) ;
    #100;
    $finish;

  end

    
endmodule
