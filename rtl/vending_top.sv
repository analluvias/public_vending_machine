module vending_top (
    input clk,
    input rst, // active at high, synchronous
    input cancel, // return credit and goes back to IDLE
    input confirm, // user confirms purchase -> synchronous pulse
    input [1:0] sell_item, // signal identifies item to be purchased, also identifies memory address
    input [1:0] coin_in, // monetary value entered -> sampled every clock cycle

    output dispense, // 1 cycle signal: means item must be released
    output error, // active when out of stock or out of credit
    output logic [7:0] change_out, // change value in cents, only valid at CHANGE state
    output logic [7:0] display, // current accumulated credit, for display
    output logic [2:0] state_out
);

    import vending_pkg::*;

    //==========================================================
    // State
    //==========================================================

    state_s state;

    //==========================================================
    // Control unit signals
    //==========================================================

    logic internal_sell_item;
    logic can_sell;
    logic mem_read;
    logic mem_write;
    logic internal_error;
    logic internal_dispense;
    logic credit_load;

    //==========================================================
    // Memory signals
    //==========================================================

    logic [7:0] price;
    logic [7:0] stock;

    //==========================================================
    // Change logic
    //==========================================================

    logic [7:0] internal_change;

    //==========================================================
    // Credit register
    //==========================================================

    logic [7:0] internal_credit;
    logic enable_credit_logic;
    logic enable_zero_out_credit;

    //==========================================================
    // Continuous assignments
    //==========================================================

    assign state_out = state;
    assign error     = internal_error;

    // Allow collecting inserted coins
    assign enable_credit_logic =
        (state == COLLECT) && credit_load;

    // Allow clearing the accumulated credit
    assign enable_zero_out_credit =
        ((state == CHANGE) && credit_load) ||
        ((state == REFUND) && credit_load);

	// shows credit
	assign display = internal_credit;

    //control unit module instance
    control_unit control (
        .clk(clk),
		.reset(rst),
        .state(state),
        .can_sell(can_sell),
        .coin_in(coin_in),
        .cancel(cancel),
        .confirm(confirm),

        .mem_read(mem_read),
        .mem_write(mem_write),
        .error(internal_error),
        .internal_credit(internal_credit),
        .internal_dispense(internal_dispense),
        .credit_load(credit_load)
    );
    assign dispense = internal_dispense;

    //credit_reg module instance
    credit_reg credit_module (
        .clk(clk),
        .enable_credit_logic(enable_credit_logic),
        .enable_zero_out_credit(enable_zero_out_credit),
        .credit(internal_credit),
        .coin_in(coin_in),
        .reset(rst)
    );

    // comparator module instance
    comparator comparator_module (
        .credit(internal_credit),
        .price(price),
        .stock(stock),
        .can_sell(can_sell)
    );

    // memory module instance
    memory memory_module (
        .price(price), 
        .stock(stock),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .address(sell_item),   //sell_item identifies memory address
        .rst(rst),          // reset signal
        .clk(clk)
    );

    //subtractor module instance
    subtractor subtractor_module(
        .credit(internal_credit),
        .price(price),
        .change(internal_change)
    );

    // that always ff controls change_out logic
    assign change_out =
        (state == CHANGE) ? internal_change :
        (state == REFUND) ? internal_credit :
                            8'd0;

endmodule
