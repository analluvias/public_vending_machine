module control_unit(
    input clk,
    input reset,
    input [7:0] internal_credit,
    input logic [1:0] coin_in,
    input cancel,
    input confirm,
    input logic can_sell,


 	output vending_pkg::state_s state,
    output logic mem_read,
    output logic mem_write,
    output logic error,
    output logic internal_dispense,
    output logic credit_load
);

    import vending_pkg::*;
    state_s next_state;

	logic check_first_cycle;

    // state machine
	always_ff @(posedge clk) begin
		if (reset) begin
		    state <= IDLE;
		    check_first_cycle <= 0;
		end
		else begin
		    state <= next_state;

		    if (state != CHECK)
		        check_first_cycle <= 0;
		    else
		        check_first_cycle <= 1;
		end
	end

    // state machine logic
    always_comb begin : state_machine_logic
        next_state = state;
        case(state)

            IDLE: begin
                next_state = IDLE;

                if(coin_in != 2'b00)begin
                     next_state = COLLECT;
                end
            end

            COLLECT: begin
                next_state = COLLECT;

                if(cancel)
                    next_state = REFUND;
                else if(confirm)
                    next_state = CHECK;
            end

            CHECK: begin
                next_state = CHECK;

				if(cancel) next_state = REFUND;
				else if(!check_first_cycle) begin
					// stays at check on first cycle
					next_state = CHECK;

				end else begin

		            if (can_sell == 1) begin
		                next_state = DISPENSE;
		            end else begin
		                next_state = ERROR;
		            end

				end
                
            end

            DISPENSE: begin
                // signal dispense must be 1 by one clock cycle
                // mem_write must be 1 
                next_state = CHANGE;

                if(cancel == 1) begin
                    next_state = REFUND;
                end
            end

            CHANGE: begin
                // compute change_out
                // credit_load = 1 to zero out the credit
                next_state = IDLE;
            end

            ERROR: begin
                if(cancel) begin
                    next_state = REFUND;
                end
            end

            REFUND: begin
                next_state = IDLE;
            end

        endcase
    end

    // Saídas
    always_comb begin
        credit_load = 0;
        mem_read = 0;
        internal_dispense = 0;
        mem_write = 0;
        error = 0;

        case (state)

            IDLE: begin
            end

            COLLECT: begin
                credit_load = 1;
            end

            CHECK: begin
                mem_read = 1;
            end

            DISPENSE: begin
                internal_dispense = 1; // one cycle
                mem_write = 1; // decrement stock
            end

            CHANGE: begin
                credit_load = 1;
            end

            ERROR: begin
                error = 1;
            end

            REFUND: begin
                credit_load = 1;
            end
        endcase
    end


endmodule
