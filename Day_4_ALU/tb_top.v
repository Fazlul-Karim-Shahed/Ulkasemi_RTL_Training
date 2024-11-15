
module tb_top;

    reg clk;
    reg reset;
    reg en;
    reg [2:0] data_a;
    reg [2:0] data_b;
    reg [1:0] compute;
    reg [1:0] addr;
    reg cs;
    reg write;
    wire [3:0] data_out;

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    top_module u_top_module (
        .clk(clk),
        .reset(reset),
        .en(en),
        .data_a(data_a),
        .data_b(data_b),
        .compute(compute),
        .addr(addr),
        .cs(cs),
        .write(write),
        .data_out(data_out)
    );

    initial begin
        reset = 1;
        en = 0;
        cs = 0;
        write = 0;

        @(negedge clk);
        reset = 0;
        en = 1;



        @(negedge clk);
        cs = 1;
        data_a = 3'd5;
        addr = 2'b00;
        @(negedge clk);
        write = 1;
        @(negedge clk);



        cs = 0;
        write = 0;
        @(negedge clk);
        cs = 1;
        data_b = 3'd7;
        addr = 2'b01;
        @(negedge clk);
        write = 1;
        @(negedge clk);





        cs = 0;
        write = 0;
        @(negedge clk);
        cs = 1;
        compute = 3'b00;
        addr = 2'b10;
        @(negedge clk);
        write = 1;
        @(negedge clk);


        cs = 0;
        write = 0;
        @(negedge clk);
        cs = 1;
        compute = 3'b01;
        addr = 2'b10;
        @(negedge clk);
        write = 1;
        @(negedge clk);


        cs = 0;
        write = 0;
        @(negedge clk);
        cs = 1;
        compute = 3'b10;
        addr = 2'b10;
        @(negedge clk);
        write = 1;
        @(negedge clk);



        cs = 0;
        write = 0;
        @(negedge clk);
        cs = 1;
        compute = 3'b11;
        addr = 2'b10;
        @(negedge clk);
        write = 1;
        @(negedge clk);

        repeat (50) @(negedge clk);

        #10;
        $finish;

    end
    
endmodule