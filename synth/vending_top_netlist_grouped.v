/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : X-2025.06-SP2
// Date      : Fri Jul 17 14:16:53 2026
/////////////////////////////////////////////////////////////


module control_unit ( clk, reset, internal_credit, coin_in, cancel, confirm, 
        can_sell, state, mem_read, mem_write, error, internal_dispense, 
        credit_load );
  input [7:0] internal_credit;
  input [1:0] coin_in;
  output [2:0] state;
  input clk, reset, cancel, confirm, can_sell;
  output mem_read, mem_write, error, internal_dispense, credit_load;
  wire   n24, mem_write, check_first_cycle, N23, n19, n20, n21, n2, n3, n4, n5,
         n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n22;
  assign internal_dispense = mem_write;

  DFFX1_RVT \state_reg[0]  ( .D(n21), .CLK(clk), .Q(n24), .QN(n18) );
  DFFX1_RVT \state_reg[2]  ( .D(n19), .CLK(clk), .Q(state[2]), .QN(n17) );
  DFFX1_RVT check_first_cycle_reg ( .D(N23), .CLK(clk), .Q(check_first_cycle)
         );
  DFFX2_RVT \state_reg[1]  ( .D(n20), .CLK(clk), .Q(state[1]), .QN(n22) );
  NBUFFX2_RVT U3 ( .A(n24), .Y(state[0]) );
  AND2X1_RVT U4 ( .A1(n24), .A2(n10), .Y(mem_write) );
  AND3X1_RVT U5 ( .A1(state[2]), .A2(n24), .A3(n22), .Y(error) );
  NAND2X0_RVT U6 ( .A1(state[1]), .A2(n17), .Y(n11) );
  INVX0_RVT U7 ( .A(n11), .Y(n10) );
  AND2X1_RVT U8 ( .A1(n17), .A2(n22), .Y(n13) );
  AO22X1_RVT U9 ( .A1(n24), .A2(n13), .A3(n18), .A4(state[2]), .Y(credit_load)
         );
  AND3X1_RVT U10 ( .A1(state[1]), .A2(n18), .A3(n17), .Y(mem_read) );
  INVX0_RVT U11 ( .A(reset), .Y(n14) );
  AND2X1_RVT U12 ( .A1(mem_read), .A2(n14), .Y(N23) );
  AO222X1_RVT U13 ( .A1(n17), .A2(confirm), .A3(n17), .A4(state[1]), .A5(n22), 
        .A6(cancel), .Y(n3) );
  OAI21X1_RVT U14 ( .A1(coin_in[1]), .A2(coin_in[0]), .A3(n13), .Y(n2) );
  AO221X1_RVT U15 ( .A1(state[0]), .A2(n3), .A3(n18), .A4(n2), .A5(reset), .Y(
        n6) );
  INVX0_RVT U16 ( .A(cancel), .Y(n4) );
  NAND3X0_RVT U17 ( .A1(N23), .A2(check_first_cycle), .A3(n4), .Y(n5) );
  NAND2X0_RVT U18 ( .A1(n6), .A2(n5), .Y(n21) );
  INVX0_RVT U19 ( .A(can_sell), .Y(n7) );
  NAND2X0_RVT U20 ( .A1(n7), .A2(check_first_cycle), .Y(n12) );
  AO22X1_RVT U21 ( .A1(state[2]), .A2(state[1]), .A3(n13), .A4(confirm), .Y(n8) );
  AO222X1_RVT U22 ( .A1(n24), .A2(cancel), .A3(n24), .A4(n8), .A5(cancel), 
        .A6(n10), .Y(n9) );
  AO22X1_RVT U23 ( .A1(N23), .A2(n12), .A3(n14), .A4(n9), .Y(n20) );
  OA21X1_RVT U24 ( .A1(n24), .A2(n10), .A3(cancel), .Y(n16) );
  OAI22X1_RVT U25 ( .A1(n13), .A2(n18), .A3(n12), .A4(n11), .Y(n15) );
  OA21X1_RVT U26 ( .A1(n16), .A2(n15), .A3(n14), .Y(n19) );
endmodule


module credit_reg ( clk, enable_credit_logic, enable_zero_out_credit, coin_in, 
        reset, credit );
  input [1:0] coin_in;
  output [7:0] credit;
  input clk, enable_credit_logic, enable_zero_out_credit, reset;
  wire   n8, n9, n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n1, n2,
         n3, n4, n5, n6, n7, n21, n22, n23, n24, n25, n26, n27, n28, n29, n30,
         n31, n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44,
         n45, n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58,
         n59, n60, n61, n62;
  wire   [7:0] coin_value;

  DFFX1_RVT \coin_value_reg[5]  ( .D(n20), .CLK(clk), .Q(coin_value[5]), .QN(
        n60) );
  DFFX1_RVT \coin_value_reg[4]  ( .D(n19), .CLK(clk), .Q(coin_value[4]), .QN(
        n59) );
  DFFX1_RVT \coin_value_reg[2]  ( .D(n18), .CLK(clk), .Q(coin_value[2]), .QN(
        n58) );
  DFFX1_RVT \coin_value_reg[1]  ( .D(n17), .CLK(clk), .Q(coin_value[1]) );
  DFFX1_RVT \coin_value_reg[0]  ( .D(n16), .CLK(clk), .Q(coin_value[0]), .QN(
        n57) );
  DFFX1_RVT \credit_reg[7]  ( .D(n8), .CLK(clk), .Q(credit[7]) );
  DFFX1_RVT \credit_reg[6]  ( .D(n9), .CLK(clk), .Q(credit[6]), .QN(n62) );
  DFFX1_RVT \credit_reg[5]  ( .D(n10), .CLK(clk), .Q(credit[5]) );
  DFFX1_RVT \credit_reg[4]  ( .D(n11), .CLK(clk), .Q(credit[4]) );
  DFFX1_RVT \credit_reg[3]  ( .D(n12), .CLK(clk), .Q(credit[3]) );
  DFFX1_RVT \credit_reg[2]  ( .D(n13), .CLK(clk), .Q(credit[2]) );
  DFFX1_RVT \credit_reg[1]  ( .D(n14), .CLK(clk), .Q(credit[1]) );
  DFFX1_RVT \credit_reg[0]  ( .D(n15), .CLK(clk), .Q(credit[0]), .QN(n61) );
  XOR2X1_RVT U3 ( .A1(credit[2]), .A2(n34), .Y(n35) );
  XOR2X1_RVT U4 ( .A1(credit[3]), .A2(n38), .Y(n39) );
  XOR2X1_RVT U5 ( .A1(credit[4]), .A2(n42), .Y(n43) );
  XOR2X1_RVT U6 ( .A1(credit[5]), .A2(n46), .Y(n47) );
  XOR2X1_RVT U7 ( .A1(credit[1]), .A2(n30), .Y(n31) );
  AND2X1_RVT U8 ( .A1(n1), .A2(n2), .Y(n54) );
  AND2X1_RVT U9 ( .A1(enable_credit_logic), .A2(n53), .Y(n1) );
  NAND2X0_RVT U10 ( .A1(n52), .A2(n62), .Y(n2) );
  INVX0_RVT U11 ( .A(coin_in[1]), .Y(n21) );
  INVX0_RVT U12 ( .A(reset), .Y(n22) );
  AND2X1_RVT U13 ( .A1(n21), .A2(n22), .Y(n4) );
  OR2X1_RVT U14 ( .A1(coin_in[0]), .A2(coin_value[0]), .Y(n3) );
  AND2X1_RVT U15 ( .A1(n4), .A2(n3), .Y(n16) );
  INVX0_RVT U16 ( .A(coin_in[0]), .Y(n23) );
  AND2X1_RVT U17 ( .A1(n23), .A2(n22), .Y(n6) );
  OR2X1_RVT U18 ( .A1(coin_in[1]), .A2(coin_value[1]), .Y(n5) );
  AND2X1_RVT U19 ( .A1(n6), .A2(n5), .Y(n17) );
  OA221X1_RVT U20 ( .A1(coin_in[1]), .A2(coin_value[5]), .A3(coin_in[1]), .A4(
        n23), .A5(n22), .Y(n20) );
  NAND2X0_RVT U21 ( .A1(n23), .A2(n21), .Y(n7) );
  OA221X1_RVT U22 ( .A1(n7), .A2(coin_value[4]), .A3(n23), .A4(n21), .A5(n22), 
        .Y(n19) );
  AND2X1_RVT U23 ( .A1(coin_value[2]), .A2(n21), .Y(n24) );
  OA221X1_RVT U24 ( .A1(coin_in[0]), .A2(n24), .A3(n23), .A4(coin_in[1]), .A5(
        n22), .Y(n18) );
  NAND2X0_RVT U25 ( .A1(coin_value[0]), .A2(enable_credit_logic), .Y(n25) );
  INVX0_RVT U26 ( .A(n25), .Y(n26) );
  NOR2X0_RVT U27 ( .A1(enable_zero_out_credit), .A2(reset), .Y(n56) );
  OA221X1_RVT U28 ( .A1(credit[0]), .A2(n26), .A3(n61), .A4(n25), .A5(n56), 
        .Y(n15) );
  NAND3X0_RVT U29 ( .A1(coin_value[0]), .A2(credit[0]), .A3(coin_value[1]), 
        .Y(n27) );
  AND2X1_RVT U30 ( .A1(n27), .A2(enable_credit_logic), .Y(n29) );
  AND2X1_RVT U31 ( .A1(coin_value[0]), .A2(credit[0]), .Y(n32) );
  OR2X1_RVT U32 ( .A1(coin_value[1]), .A2(n32), .Y(n28) );
  AND2X1_RVT U33 ( .A1(n29), .A2(n28), .Y(n30) );
  AND2X1_RVT U34 ( .A1(n56), .A2(n31), .Y(n14) );
  AO222X1_RVT U35 ( .A1(n32), .A2(coin_value[1]), .A3(n32), .A4(credit[1]), 
        .A5(coin_value[1]), .A6(credit[1]), .Y(n36) );
  INVX0_RVT U36 ( .A(n36), .Y(n33) );
  OA221X1_RVT U37 ( .A1(coin_value[2]), .A2(n36), .A3(n58), .A4(n33), .A5(
        enable_credit_logic), .Y(n34) );
  AND2X1_RVT U38 ( .A1(n56), .A2(n35), .Y(n13) );
  AO222X1_RVT U39 ( .A1(coin_value[2]), .A2(credit[2]), .A3(coin_value[2]), 
        .A4(n36), .A5(credit[2]), .A6(n36), .Y(n40) );
  INVX0_RVT U40 ( .A(n40), .Y(n37) );
  OA221X1_RVT U41 ( .A1(coin_value[0]), .A2(n40), .A3(n57), .A4(n37), .A5(
        enable_credit_logic), .Y(n38) );
  AND2X1_RVT U42 ( .A1(n56), .A2(n39), .Y(n12) );
  AO222X1_RVT U43 ( .A1(coin_value[0]), .A2(credit[3]), .A3(coin_value[0]), 
        .A4(n40), .A5(credit[3]), .A6(n40), .Y(n44) );
  INVX0_RVT U44 ( .A(n44), .Y(n41) );
  OA221X1_RVT U45 ( .A1(n41), .A2(n59), .A3(n44), .A4(coin_value[4]), .A5(
        enable_credit_logic), .Y(n42) );
  AND2X1_RVT U46 ( .A1(n56), .A2(n43), .Y(n11) );
  AO222X1_RVT U47 ( .A1(coin_value[4]), .A2(credit[4]), .A3(coin_value[4]), 
        .A4(n44), .A5(credit[4]), .A6(n44), .Y(n48) );
  INVX0_RVT U48 ( .A(n48), .Y(n45) );
  OA221X1_RVT U49 ( .A1(n45), .A2(n60), .A3(n48), .A4(coin_value[5]), .A5(
        enable_credit_logic), .Y(n46) );
  AND2X1_RVT U50 ( .A1(n56), .A2(n47), .Y(n10) );
  AO222X1_RVT U51 ( .A1(coin_value[5]), .A2(credit[5]), .A3(coin_value[5]), 
        .A4(n48), .A5(credit[5]), .A6(n48), .Y(n49) );
  OR2X1_RVT U52 ( .A1(coin_value[2]), .A2(n49), .Y(n53) );
  NAND2X0_RVT U53 ( .A1(coin_value[2]), .A2(n49), .Y(n52) );
  NAND3X0_RVT U54 ( .A1(enable_credit_logic), .A2(n53), .A3(n52), .Y(n50) );
  INVX0_RVT U55 ( .A(n50), .Y(n51) );
  OA221X1_RVT U56 ( .A1(credit[6]), .A2(n51), .A3(n62), .A4(n50), .A5(n56), 
        .Y(n9) );
  HADDX1_RVT U57 ( .A0(credit[7]), .B0(n54), .SO(n55) );
  AND2X1_RVT U58 ( .A1(n56), .A2(n55), .Y(n8) );
endmodule


module comparator ( credit, price, stock, can_sell );
  input [7:0] credit;
  input [7:0] price;
  input [7:0] stock;
  output can_sell;
  wire   n1, n2;

  NOR4X1_RVT U2 ( .A1(stock[7]), .A2(stock[6]), .A3(stock[5]), .A4(stock[4]), 
        .Y(n2) );
  NOR4X1_RVT U3 ( .A1(stock[3]), .A2(stock[2]), .A3(stock[1]), .A4(stock[0]), 
        .Y(n1) );
  NAND2X0_RVT U4 ( .A1(n2), .A2(n1), .Y(can_sell) );
endmodule


module memory ( price, stock, mem_read, mem_write, address, rst, clk );
  output [7:0] price;
  output [7:0] stock;
  input [1:0] address;
  input mem_read, mem_write, rst, clk;
  wire   \mem[3][7] , \mem[3][6] , \mem[3][5] , \mem[3][4] , \mem[3][3] ,
         \mem[3][2] , \mem[3][1] , \mem[3][0] , \mem[2][7] , \mem[2][6] ,
         \mem[2][5] , \mem[2][4] , \mem[2][3] , \mem[2][2] , \mem[2][1] ,
         \mem[2][0] , \mem[1][7] , \mem[1][6] , \mem[1][5] , \mem[1][4] ,
         \mem[1][3] , \mem[1][2] , \mem[1][1] , \mem[1][0] , \mem[0][7] ,
         \mem[0][6] , \mem[0][5] , \mem[0][4] , \mem[0][3] , \mem[0][2] ,
         \mem[0][1] , \mem[0][0] , n18, n19, n20, n21, n22, n23, n24, n25, n26,
         n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40,
         n41, n42, n43, n44, n45, n46, n47, n48, n49, n50, n51, n52, n53, n54,
         n55, n56, n57, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13,
         n14, n15, n16, n17, n58, n59, n60, n61, n62, n63, n64, n65, n66, n67,
         n68, n69, n70, n71, n72, n73, n74, n75, n76, n77, n78, n79, n80, n81,
         n82, n83, n84, n85;

  DFFX1_RVT \mem_reg[3][7]  ( .D(n56), .CLK(clk), .Q(\mem[3][7] ) );
  DFFX1_RVT \mem_reg[3][6]  ( .D(n29), .CLK(clk), .Q(\mem[3][6] ) );
  DFFX1_RVT \mem_reg[3][5]  ( .D(n33), .CLK(clk), .Q(\mem[3][5] ) );
  DFFX1_RVT \mem_reg[3][4]  ( .D(n37), .CLK(clk), .Q(\mem[3][4] ) );
  DFFX1_RVT \mem_reg[3][3]  ( .D(n41), .CLK(clk), .Q(\mem[3][3] ) );
  DFFX1_RVT \mem_reg[3][2]  ( .D(n45), .CLK(clk), .Q(\mem[3][2] ) );
  DFFX1_RVT \mem_reg[3][1]  ( .D(n49), .CLK(clk), .Q(\mem[3][1] ) );
  DFFX1_RVT \mem_reg[3][0]  ( .D(n53), .CLK(clk), .Q(\mem[3][0] ) );
  DFFX1_RVT \mem_reg[2][7]  ( .D(n26), .CLK(clk), .Q(\mem[2][7] ) );
  DFFX1_RVT \mem_reg[2][6]  ( .D(n30), .CLK(clk), .Q(\mem[2][6] ) );
  DFFX1_RVT \mem_reg[2][5]  ( .D(n34), .CLK(clk), .Q(\mem[2][5] ) );
  DFFX1_RVT \mem_reg[2][4]  ( .D(n38), .CLK(clk), .Q(\mem[2][4] ) );
  DFFX1_RVT \mem_reg[2][3]  ( .D(n42), .CLK(clk), .Q(\mem[2][3] ) );
  DFFX1_RVT \mem_reg[2][2]  ( .D(n46), .CLK(clk), .Q(\mem[2][2] ) );
  DFFX1_RVT \mem_reg[2][1]  ( .D(n50), .CLK(clk), .Q(\mem[2][1] ) );
  DFFX1_RVT \mem_reg[2][0]  ( .D(n54), .CLK(clk), .Q(\mem[2][0] ) );
  DFFX1_RVT \mem_reg[1][7]  ( .D(n27), .CLK(clk), .Q(\mem[1][7] ) );
  DFFX1_RVT \mem_reg[1][6]  ( .D(n31), .CLK(clk), .Q(\mem[1][6] ) );
  DFFX1_RVT \mem_reg[1][5]  ( .D(n35), .CLK(clk), .Q(\mem[1][5] ) );
  DFFX1_RVT \mem_reg[1][4]  ( .D(n39), .CLK(clk), .Q(\mem[1][4] ) );
  DFFX1_RVT \mem_reg[1][3]  ( .D(n43), .CLK(clk), .Q(\mem[1][3] ) );
  DFFX1_RVT \mem_reg[1][2]  ( .D(n47), .CLK(clk), .Q(\mem[1][2] ) );
  DFFX1_RVT \mem_reg[1][1]  ( .D(n51), .CLK(clk), .Q(\mem[1][1] ) );
  DFFX1_RVT \mem_reg[1][0]  ( .D(n55), .CLK(clk), .Q(\mem[1][0] ) );
  DFFX1_RVT \mem_reg[0][7]  ( .D(n28), .CLK(clk), .Q(\mem[0][7] ) );
  DFFX1_RVT \mem_reg[0][6]  ( .D(n32), .CLK(clk), .Q(\mem[0][6] ) );
  DFFX1_RVT \mem_reg[0][5]  ( .D(n36), .CLK(clk), .Q(\mem[0][5] ) );
  DFFX1_RVT \mem_reg[0][4]  ( .D(n40), .CLK(clk), .Q(\mem[0][4] ) );
  DFFX1_RVT \mem_reg[0][3]  ( .D(n44), .CLK(clk), .Q(\mem[0][3] ) );
  DFFX1_RVT \mem_reg[0][2]  ( .D(n48), .CLK(clk), .Q(\mem[0][2] ) );
  DFFX1_RVT \mem_reg[0][1]  ( .D(n52), .CLK(clk), .Q(\mem[0][1] ) );
  DFFX1_RVT \mem_reg[0][0]  ( .D(n57), .CLK(clk), .Q(\mem[0][0] ) );
  DFFX1_RVT \stock_reg[7]  ( .D(n25), .CLK(clk), .Q(stock[7]) );
  DFFX1_RVT \stock_reg[6]  ( .D(n24), .CLK(clk), .Q(stock[6]) );
  DFFX1_RVT \stock_reg[5]  ( .D(n23), .CLK(clk), .Q(stock[5]) );
  DFFX1_RVT \stock_reg[4]  ( .D(n22), .CLK(clk), .Q(stock[4]) );
  DFFX1_RVT \stock_reg[3]  ( .D(n21), .CLK(clk), .Q(stock[3]) );
  DFFX1_RVT \stock_reg[2]  ( .D(n20), .CLK(clk), .Q(stock[2]) );
  DFFX1_RVT \stock_reg[1]  ( .D(n19), .CLK(clk), .Q(stock[1]) );
  DFFX1_RVT \stock_reg[0]  ( .D(n18), .CLK(clk), .Q(stock[0]) );
  INVX0_RVT U3 ( .A(address[0]), .Y(n5) );
  AND2X1_RVT U4 ( .A1(mem_write), .A2(n75), .Y(n7) );
  INVX0_RVT U5 ( .A(rst), .Y(n75) );
  INVX2_RVT U6 ( .A(address[1]), .Y(n3) );
  AND2X1_RVT U7 ( .A1(n3), .A2(n5), .Y(n1) );
  NAND2X0_RVT U8 ( .A1(n7), .A2(n1), .Y(n68) );
  INVX0_RVT U9 ( .A(n68), .Y(n69) );
  MUX41X1_RVT U10 ( .A1(\mem[3][0] ), .A3(\mem[1][0] ), .A2(\mem[2][0] ), .A4(
        \mem[0][0] ), .S0(n3), .S1(n5), .Y(n83) );
  INVX0_RVT U11 ( .A(n83), .Y(n8) );
  AO22X1_RVT U12 ( .A1(n69), .A2(n8), .A3(n68), .A4(\mem[0][0] ), .Y(n57) );
  AND2X1_RVT U13 ( .A1(address[1]), .A2(address[0]), .Y(n2) );
  NAND2X0_RVT U14 ( .A1(n2), .A2(n7), .Y(n65) );
  INVX0_RVT U15 ( .A(n65), .Y(n67) );
  MUX41X1_RVT U16 ( .A1(\mem[2][6] ), .A3(\mem[0][6] ), .A2(\mem[3][6] ), .A4(
        \mem[1][6] ), .S0(n3), .S1(address[0]), .Y(n77) );
  MUX41X1_RVT U17 ( .A1(\mem[2][5] ), .A3(\mem[0][5] ), .A2(\mem[3][5] ), .A4(
        \mem[1][5] ), .S0(n3), .S1(address[0]), .Y(n78) );
  MUX41X1_RVT U18 ( .A1(\mem[2][4] ), .A3(\mem[0][4] ), .A2(\mem[3][4] ), .A4(
        \mem[1][4] ), .S0(n3), .S1(address[0]), .Y(n79) );
  MUX41X1_RVT U19 ( .A1(\mem[2][3] ), .A3(\mem[0][3] ), .A2(\mem[3][3] ), .A4(
        \mem[1][3] ), .S0(n3), .S1(address[0]), .Y(n80) );
  MUX41X1_RVT U20 ( .A1(\mem[2][2] ), .A3(\mem[0][2] ), .A2(\mem[3][2] ), .A4(
        \mem[1][2] ), .S0(n3), .S1(address[0]), .Y(n81) );
  MUX41X1_RVT U21 ( .A1(\mem[2][1] ), .A3(\mem[0][1] ), .A2(\mem[3][1] ), .A4(
        \mem[1][1] ), .S0(n3), .S1(address[0]), .Y(n82) );
  OR2X1_RVT U22 ( .A1(n83), .A2(n82), .Y(n12) );
  OR2X1_RVT U23 ( .A1(n81), .A2(n12), .Y(n15) );
  OR2X1_RVT U24 ( .A1(n80), .A2(n15), .Y(n58) );
  OR2X1_RVT U25 ( .A1(n79), .A2(n58), .Y(n61) );
  OR2X1_RVT U26 ( .A1(n78), .A2(n61), .Y(n64) );
  NOR2X0_RVT U27 ( .A1(n77), .A2(n64), .Y(n63) );
  MUX41X1_RVT U28 ( .A1(\mem[2][7] ), .A3(\mem[0][7] ), .A2(\mem[3][7] ), .A4(
        \mem[1][7] ), .S0(n3), .S1(address[0]), .Y(n76) );
  HADDX1_RVT U29 ( .A0(n63), .B0(n76), .SO(n73) );
  AO22X1_RVT U30 ( .A1(n67), .A2(n73), .A3(n65), .A4(\mem[3][7] ), .Y(n56) );
  AND2X1_RVT U31 ( .A1(address[0]), .A2(n3), .Y(n4) );
  NAND2X0_RVT U32 ( .A1(n7), .A2(n4), .Y(n70) );
  INVX0_RVT U33 ( .A(n70), .Y(n71) );
  AO22X1_RVT U34 ( .A1(n71), .A2(n8), .A3(n70), .A4(\mem[1][0] ), .Y(n55) );
  AND2X1_RVT U35 ( .A1(address[1]), .A2(n5), .Y(n6) );
  NAND2X0_RVT U36 ( .A1(n7), .A2(n6), .Y(n72) );
  INVX0_RVT U37 ( .A(n72), .Y(n74) );
  AO22X1_RVT U38 ( .A1(n74), .A2(n8), .A3(n72), .A4(\mem[2][0] ), .Y(n54) );
  AO22X1_RVT U39 ( .A1(n67), .A2(n8), .A3(n65), .A4(\mem[3][0] ), .Y(n53) );
  INVX0_RVT U40 ( .A(n12), .Y(n9) );
  AO21X1_RVT U41 ( .A1(n83), .A2(n82), .A3(n9), .Y(n10) );
  AO22X1_RVT U42 ( .A1(n69), .A2(n10), .A3(n68), .A4(\mem[0][1] ), .Y(n52) );
  AO22X1_RVT U43 ( .A1(n71), .A2(n10), .A3(n70), .A4(\mem[1][1] ), .Y(n51) );
  AO22X1_RVT U44 ( .A1(n74), .A2(n10), .A3(n72), .A4(\mem[2][1] ), .Y(n50) );
  AO22X1_RVT U45 ( .A1(n67), .A2(n10), .A3(n65), .A4(\mem[3][1] ), .Y(n49) );
  INVX0_RVT U46 ( .A(n15), .Y(n11) );
  AO21X1_RVT U47 ( .A1(n81), .A2(n12), .A3(n11), .Y(n13) );
  AO22X1_RVT U48 ( .A1(n69), .A2(n13), .A3(n68), .A4(\mem[0][2] ), .Y(n48) );
  AO22X1_RVT U49 ( .A1(n71), .A2(n13), .A3(n70), .A4(\mem[1][2] ), .Y(n47) );
  AO22X1_RVT U50 ( .A1(n74), .A2(n13), .A3(n72), .A4(\mem[2][2] ), .Y(n46) );
  AO22X1_RVT U51 ( .A1(n67), .A2(n13), .A3(n65), .A4(\mem[3][2] ), .Y(n45) );
  INVX0_RVT U52 ( .A(n58), .Y(n14) );
  AO21X1_RVT U53 ( .A1(n80), .A2(n15), .A3(n14), .Y(n16) );
  AO22X1_RVT U54 ( .A1(n69), .A2(n16), .A3(n68), .A4(\mem[0][3] ), .Y(n44) );
  AO22X1_RVT U55 ( .A1(n71), .A2(n16), .A3(n70), .A4(\mem[1][3] ), .Y(n43) );
  AO22X1_RVT U56 ( .A1(n74), .A2(n16), .A3(n72), .A4(\mem[2][3] ), .Y(n42) );
  AO22X1_RVT U57 ( .A1(n67), .A2(n16), .A3(n65), .A4(\mem[3][3] ), .Y(n41) );
  INVX0_RVT U58 ( .A(n61), .Y(n17) );
  AO21X1_RVT U59 ( .A1(n79), .A2(n58), .A3(n17), .Y(n59) );
  AO22X1_RVT U60 ( .A1(n69), .A2(n59), .A3(n68), .A4(\mem[0][4] ), .Y(n40) );
  AO22X1_RVT U61 ( .A1(n71), .A2(n59), .A3(n70), .A4(\mem[1][4] ), .Y(n39) );
  AO22X1_RVT U62 ( .A1(n74), .A2(n59), .A3(n72), .A4(\mem[2][4] ), .Y(n38) );
  AO22X1_RVT U63 ( .A1(n67), .A2(n59), .A3(n65), .A4(\mem[3][4] ), .Y(n37) );
  INVX0_RVT U64 ( .A(n64), .Y(n60) );
  AO21X1_RVT U65 ( .A1(n78), .A2(n61), .A3(n60), .Y(n62) );
  AO22X1_RVT U66 ( .A1(n69), .A2(n62), .A3(n68), .A4(\mem[0][5] ), .Y(n36) );
  AO22X1_RVT U67 ( .A1(n71), .A2(n62), .A3(n70), .A4(\mem[1][5] ), .Y(n35) );
  AO22X1_RVT U68 ( .A1(n74), .A2(n62), .A3(n72), .A4(\mem[2][5] ), .Y(n34) );
  AO22X1_RVT U69 ( .A1(n67), .A2(n62), .A3(n65), .A4(\mem[3][5] ), .Y(n33) );
  AO21X1_RVT U70 ( .A1(n77), .A2(n64), .A3(n63), .Y(n66) );
  AO22X1_RVT U71 ( .A1(n69), .A2(n66), .A3(n68), .A4(\mem[0][6] ), .Y(n32) );
  AO22X1_RVT U72 ( .A1(n71), .A2(n66), .A3(n70), .A4(\mem[1][6] ), .Y(n31) );
  AO22X1_RVT U73 ( .A1(n74), .A2(n66), .A3(n72), .A4(\mem[2][6] ), .Y(n30) );
  AO22X1_RVT U74 ( .A1(n67), .A2(n66), .A3(n65), .A4(\mem[3][6] ), .Y(n29) );
  AO22X1_RVT U75 ( .A1(n69), .A2(n73), .A3(n68), .A4(\mem[0][7] ), .Y(n28) );
  AO22X1_RVT U76 ( .A1(n71), .A2(n73), .A3(n70), .A4(\mem[1][7] ), .Y(n27) );
  AO22X1_RVT U77 ( .A1(n74), .A2(n73), .A3(n72), .A4(\mem[2][7] ), .Y(n26) );
  NOR2X0_RVT U78 ( .A1(rst), .A2(mem_read), .Y(n85) );
  AND2X1_RVT U79 ( .A1(mem_read), .A2(n75), .Y(n84) );
  AO22X1_RVT U80 ( .A1(stock[7]), .A2(n85), .A3(n84), .A4(n76), .Y(n25) );
  AO22X1_RVT U81 ( .A1(stock[6]), .A2(n85), .A3(n84), .A4(n77), .Y(n24) );
  AO22X1_RVT U82 ( .A1(stock[5]), .A2(n85), .A3(n84), .A4(n78), .Y(n23) );
  AO22X1_RVT U83 ( .A1(stock[4]), .A2(n85), .A3(n84), .A4(n79), .Y(n22) );
  AO22X1_RVT U84 ( .A1(stock[3]), .A2(n85), .A3(n84), .A4(n80), .Y(n21) );
  AO22X1_RVT U85 ( .A1(stock[2]), .A2(n85), .A3(n84), .A4(n81), .Y(n20) );
  AO22X1_RVT U86 ( .A1(stock[1]), .A2(n85), .A3(n84), .A4(n82), .Y(n19) );
  AO22X1_RVT U87 ( .A1(stock[0]), .A2(n85), .A3(n84), .A4(n83), .Y(n18) );
endmodule


module vending_top ( clk, rst, cancel, confirm, sell_item, coin_in, dispense, 
        error, change_out, display, state_out );
  input [1:0] sell_item;
  input [1:0] coin_in;
  output [7:0] change_out;
  output [7:0] display;
  output [2:0] state_out;
  input clk, rst, cancel, confirm;
  output dispense, error;
  wire   credit_load, enable_credit_logic, enable_zero_out_credit, can_sell,
         mem_read, mem_write, n14, n15, n16, net1269, net1270, net1271,
         net1272, net1273, net1274, net1275, net1276, net1277, net1278,
         net1279, net1280, net1281, net1282, net1283, net1284;
  wire   [7:0] stock;

  control_unit control ( .clk(clk), .reset(rst), .internal_credit({net1277, 
        net1278, net1279, net1280, net1281, net1282, net1283, net1284}), 
        .coin_in(coin_in), .cancel(cancel), .confirm(confirm), .can_sell(
        can_sell), .state(state_out), .mem_read(mem_read), .mem_write(
        mem_write), .error(error), .internal_dispense(dispense), .credit_load(
        credit_load) );
  credit_reg credit_module ( .clk(clk), .enable_credit_logic(
        enable_credit_logic), .enable_zero_out_credit(enable_zero_out_credit), 
        .coin_in(coin_in), .reset(rst), .credit(display) );
  comparator comparator_module ( .credit(display), .price({net1269, net1270, 
        net1271, net1272, net1273, net1274, net1275, net1276}), .stock(stock), 
        .can_sell(can_sell) );
  memory memory_module ( .stock(stock), .mem_read(mem_read), .mem_write(
        mem_write), .address(sell_item), .rst(rst), .clk(clk) );
  INVX0_RVT U18 ( .A(state_out[2]), .Y(n14) );
  NOR2X0_RVT U19 ( .A1(n14), .A2(state_out[0]), .Y(n16) );
  AND2X1_RVT U20 ( .A1(n16), .A2(display[5]), .Y(change_out[5]) );
  AND2X1_RVT U21 ( .A1(n16), .A2(display[7]), .Y(change_out[7]) );
  AND2X1_RVT U22 ( .A1(n16), .A2(display[6]), .Y(change_out[6]) );
  AND2X1_RVT U23 ( .A1(n16), .A2(display[0]), .Y(change_out[0]) );
  AND2X1_RVT U24 ( .A1(n16), .A2(display[1]), .Y(change_out[1]) );
  AND2X1_RVT U25 ( .A1(n16), .A2(display[2]), .Y(change_out[2]) );
  AND2X1_RVT U26 ( .A1(n16), .A2(display[3]), .Y(change_out[3]) );
  AND2X1_RVT U27 ( .A1(n16), .A2(display[4]), .Y(change_out[4]) );
  INVX0_RVT U28 ( .A(state_out[1]), .Y(n15) );
  AND4X1_RVT U29 ( .A1(state_out[0]), .A2(credit_load), .A3(n15), .A4(n14), 
        .Y(enable_credit_logic) );
  AND2X1_RVT U30 ( .A1(credit_load), .A2(n16), .Y(enable_zero_out_credit) );
endmodule

