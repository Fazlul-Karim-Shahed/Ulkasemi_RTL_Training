
module counter (
    input wire clk, 
    input wire clear, 
    input wire reset_b,
    output reg [3:0] count
); 
    
    always @(posedge clk, negedge reset_b) begin
        if(~reset_b) begin
            count <= 3'b0;
        end
        else begin
            count <= clear ? 3'b0 : count + 1;
        end
    end
    
    
endmodule