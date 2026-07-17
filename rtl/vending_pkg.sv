`timescale 1ns/1ps
package vending_pkg;
    
    // states
    typedef enum logic [2:0] { 
        IDLE = 3'b000,
        COLLECT = 3'b001,
        CHECK = 3'b010,
        DISPENSE = 3'b011,
        CHANGE = 3'b100,
        ERROR = 3'b101,
        REFUND = 3'b110
    } state_s;

    // that function translates values coin_in to int
    function automatic logic [7:0] from_bin_to_int (logic[1:0] coin_in);
        case(coin_in)
            2'b00: return 8'd0;
            2'b01: return 8'd25;
            2'b10: return 8'd50;
            2'b11: return 8'd100;
            default: return 8'd0;
        endcase
    endfunction

endpackage
