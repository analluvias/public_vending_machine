module comparator (
    input [7:0] credit,
    input [7:0] price,
    input [7:0] stock,
    
    output logic can_sell
);

    always_comb begin
        can_sell = (credit >= price) && (stock > 0);
    end
    
endmodule