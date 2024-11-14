
module comparator (
    input wire [3:0] count,
    input wire [3:0] red_time,
    input wire [3:0] yellow_time,
    input wire [3:0] green_time,
    output wire eq_red_time, 
    output wire eq_yellow_time, 
    output wire eq_green_time
);


    assign eq_red_time = (count == red_time);
    assign eq_yellow_time = (count == yellow_time);
    assign eq_green_time = (count == green_time);
    
endmodule