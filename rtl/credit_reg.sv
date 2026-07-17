module credit_reg (
    input clk,
    input enable_credit_logic,
    input enable_zero_out_credit,
    input logic [1:0] coin_in,
    input reset,
    
    output logic [7:0] credit
    );

    // package
    import vending_pkg::from_bin_to_int;

    logic [7:0] coin_value;

    always_ff @(posedge clk) begin
        if (reset)
            coin_value <= 8'd0;

        else if (coin_in != 2'b00)
            coin_value <= from_bin_to_int(coin_in);
    end

    always_ff @(posedge clk) begin

        if (reset)
            credit <= 0;

        else if (enable_zero_out_credit)
            credit <= 0;

        else if (enable_credit_logic)
            credit <= credit + coin_value;

    end


endmodule
