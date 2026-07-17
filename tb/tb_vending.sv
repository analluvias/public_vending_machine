`timescale 1ns/1ps

module tb_vending;

//////////////////////////////////////////////////////////////
// DUT Signals
//////////////////////////////////////////////////////////////

logic clk;
logic rst;
logic cancel;
logic confirm;
logic [1:0] sell_item;
logic [1:0] coin_in;

logic dispense;
logic error;
logic [7:0] change_out;
logic [7:0] display;
logic [2:0] state_out;

//////////////////////////////////////////////////////////////
// DUT
//////////////////////////////////////////////////////////////

vending_top dut(
    .clk(clk),
    .rst(rst),
    .cancel(cancel),
    .confirm(confirm),
    .sell_item(sell_item),
    .coin_in(coin_in),

    .dispense(dispense),
    .error(error),
    .change_out(change_out),
    .display(display),
    .state_out(state_out)
);

//////////////////////////////////////////////////////////////
// CLOCK
//////////////////////////////////////////////////////////////

always #5 clk = ~clk;

//////////////////////////////////////////////////////////////
// Waveform
//////////////////////////////////////////////////////////////

initial begin
    $fsdbDumpfile("vending.fsdb");
    $fsdbDumpvars(0, tb_vending, "+all");
end

//////////////////////////////////////////////////////////////
// PASS / FAIL
//////////////////////////////////////////////////////////////

integer errors = 0;

task automatic check;

input [31:0] expected;
input [31:0] actual;
input string label;

begin

    if(expected===actual)
        $display("[PASS] %-25s -> %0d",label,actual);

    else begin

        $display("[FAIL] %-25s Expected=%0d Actual=%0d",
                    label,expected,actual);

        errors++;

    end

end

endtask

//////////////////////////////////////////////////////////////
// RESET
//////////////////////////////////////////////////////////////

task automatic reset_machine;

begin

    rst       = 1;
    coin_in   = 0;
    sell_item = 0;
    confirm   = 0;
    cancel    = 0;

    repeat(2) @(posedge clk);

    rst = 0;

    @(posedge clk);

end

endtask

//////////////////////////////////////////////////////////////
// INSERT COIN
//////////////////////////////////////////////////////////////

task automatic apply_coin(input [1:0] coin);

begin

    coin_in = coin;

    @(posedge clk);

    coin_in = 2'b00;
end

endtask

//////////////////////////////////////////////////////////////
// BUY ITEM
//////////////////////////////////////////////////////////////

task automatic buy_item(input [1:0] item);

begin

    sell_item = item;

    confirm = 1;

    @(posedge clk);

    confirm = 0;

end

endtask

//////////////////////////////////////////////////////////////
// TEST 1
//////////////////////////////////////////////////////////////

task automatic test_success_change;

begin

    $display("");
    $display("========================================");
    $display("TESTE 1 - Compra com troco");
    $display("========================================");

    apply_coin(2'b11);          //100
    buy_item(2'b00);            //café =25

    // Aguarda a máquina ir para o estado de processamento (state 3)
    @(posedge clk);

    // DISPENSE
    @(posedge clk); 
    #1 check(1,dispense,"Dispense");

    // CHANGE
    @(posedge clk);
    #1 check(75,change_out,"Troco");

    // IDLE
    @(posedge clk);
    #1 check(0,display,"Credito zerado");

end

endtask

//////////////////////////////////////////////////////////////
// TEST 2
//////////////////////////////////////////////////////////////

task automatic test_insufficient_credit;

begin

    $display("");
    $display("========================================");
    $display("TESTE 2 - Credito insuficiente");
    $display("========================================");

    apply_coin(2'b01);          //25
    buy_item(2'b11);            //snack=100

    // CHECK
    @(posedge clk);
    @(posedge clk);

    // ERROR
    @(posedge clk);

    check(1,error,"Erro");

end

endtask

//////////////////////////////////////////////////////////////
// TEST 3
//////////////////////////////////////////////////////////////

task automatic test_cancel;

begin

    $display("");
    $display("========================================");
    $display("TESTE 3 - Cancelamento");
    $display("========================================");

    apply_coin(2'b11);

    apply_coin(2'b11);

    cancel = 1;

    @(posedge clk);

    cancel = 0;

    // REFUND

    @(posedge clk);

    check(200,change_out,"Refund");

    // IDLE

    @(posedge clk);

    check(0,display,"Credito zerado");

end

endtask

//////////////////////////////////////////////////////////////
// TEST 4
//////////////////////////////////////////////////////////////

task automatic test_stock;

integer i;

begin

    $display("");
    $display("========================================");
    $display("TESTE 4 - Estoque");
    $display("========================================");

    //------------------------------------------------------
    // Compra 5 cafés
    //------------------------------------------------------

    for(i=0;i<5;i++) begin

        apply_coin(2'b01);

        buy_item(2'b00);

        //CHECK
        @(posedge clk);
        @(posedge clk);

        //DISPENSE
        @(posedge clk);

        //CHANGE
        @(posedge clk);

        //IDLE
        @(posedge clk);

    end

    //------------------------------------------------------
    // Sexta compra
    //------------------------------------------------------

    apply_coin(2'b01);

    buy_item(2'b00);

    //CHECK
    @(posedge clk);
    @(posedge clk);

    //ERROR
    @(posedge clk);

    check(1,error,"Sem estoque");

end

endtask

//////////////////////////////////////////////////////////////
// TIMEOUT
//////////////////////////////////////////////////////////////

initial begin

    #5000;

    $display("TIMEOUT");

    $finish;

end

//////////////////////////////////////////////////////////////
// MAIN
//////////////////////////////////////////////////////////////

initial begin

    clk = 0;

    reset_machine();

    test_success_change();

    reset_machine();

    test_insufficient_credit();

    reset_machine();

    test_cancel();

    reset_machine();

    test_stock();

    $display("");

    if(errors==0) begin

        $display("========================================");
        $display("TODOS OS TESTES PASSARAM");
        $display("========================================");

    end

    else begin

        $display("========================================");
        $display("%0d TESTES FALHARAM",errors);
        $display("========================================");

    end

    #20;

    $finish;

end

endmodule
