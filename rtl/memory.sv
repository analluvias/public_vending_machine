module memory (
    output logic [7:0] price,
    output logic [7:0] stock,

    input logic mem_read,
    input logic mem_write,
    input logic [1:0] address,
    input logic rst,
    input logic clk
);

    // memory: [15:8] = price | [7:0] = stock
    logic [15:0] mem [3:0];

    // initializing memory
    initial begin
        mem[2'b00] = {8'h19, 8'h05}; // coffee  : price = 25, stock = 5
        mem[2'b01] = {8'h32, 8'h05}; // water  : price = 50, stock = 5
        mem[2'b10] = {8'h4B, 8'h03}; // juice  : price = 75, stock = 3
        mem[2'b11] = {8'h64, 8'h02}; // Snack : price = 100, stock = 2
    end

    always @(posedge clk) begin

        if (rst) begin
            // clean outputs
            price <= 8'h00;
            stock <= 8'h00;
        end
        else begin

            // synchronous reading
            if (mem_read) begin
                price <= mem[address][15:8];
                stock <= mem[address][7:0];
            end

            // synchronous writing
            if (mem_write) begin
                mem[address][7:0] <= mem[address][7:0] - 8'd1;
            end

        end
    end

endmodule
