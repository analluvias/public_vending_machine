/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Ultra(TM) in wire load mode
// Version   : X-2025.06-SP2
// Date      : Fri Jul 17 14:27:46 2026
/////////////////////////////////////////////////////////////


module vending_top ( clk, rst, cancel, confirm, sell_item, coin_in, dispense, 
        error, change_out, display, state_out );
  input [1:0] sell_item;
  input [1:0] coin_in;
  output [7:0] change_out;
  output [7:0] display;
  output [2:0] state_out;
  input clk, rst, cancel, confirm;
  output dispense, error;
  wire   n199, mem_write, \control/N23 , \control/check_first_cycle ,
         \memory_module/mem[0][0] , \memory_module/mem[0][1] ,
         \memory_module/mem[0][2] , \memory_module/mem[0][3] ,
         \memory_module/mem[0][4] , \memory_module/mem[0][5] ,
         \memory_module/mem[0][6] , \memory_module/mem[0][7] ,
         \memory_module/mem[1][0] , \memory_module/mem[1][1] ,
         \memory_module/mem[1][2] , \memory_module/mem[1][3] ,
         \memory_module/mem[1][4] , \memory_module/mem[1][5] ,
         \memory_module/mem[1][6] , \memory_module/mem[1][7] ,
         \memory_module/mem[2][0] , \memory_module/mem[2][1] ,
         \memory_module/mem[2][2] , \memory_module/mem[2][3] ,
         \memory_module/mem[2][4] , \memory_module/mem[2][5] ,
         \memory_module/mem[2][6] , \memory_module/mem[2][7] ,
         \memory_module/mem[3][0] , \memory_module/mem[3][1] ,
         \memory_module/mem[3][2] , \memory_module/mem[3][3] ,
         \memory_module/mem[3][4] , \memory_module/mem[3][5] ,
         \memory_module/mem[3][6] , \memory_module/mem[3][7] , n55, n56, n57,
         n58, n59, n60, n61, n62, n63, n64, n66, n67, n68, n69, n70, n71, n72,
         n73, n74, n75, n76, n77, n78, n79, n80, n81, n82, n83, n84, n85, n86,
         n87, n88, n89, n90, n91, n92, n93, n94, n95, n96, n97, n98, n99, n100,
         n101, n102, n103, n104, n105, n106, n107, n108, n109, n110,
         \intadd_0/CI , \intadd_0/SUM[4] , \intadd_0/SUM[3] ,
         \intadd_0/SUM[2] , \intadd_0/SUM[1] , \intadd_0/SUM[0] ,
         \intadd_0/n5 , \intadd_0/n4 , \intadd_0/n3 , \intadd_0/n2 ,
         \intadd_0/n1 , n119, n120, n121, n122, n123, n124, n125, n126, n127,
         n128, n129, n130, n131, n132, n133, n134, n135, n136, n137, n138,
         n139, n140, n141, n142, n143, n144, n145, n146, n147, n148, n149,
         n150, n151, n152, n153, n154, n155, n156, n157, n158, n159, n160,
         n161, n162, n163, n164, n165, n166, n167, n168, n169, n170, n171,
         n172, n173, n174, n175, n176, n177, n178, n179, n180, n181, n182,
         n183, n184, n185, n186, n187, n188, n189, n190, n191, n192, n193,
         n194, n195, n197, n198;
  wire   [7:0] stock;
  wire   [7:0] internal_change;
  wire   [7:0] \credit_module/coin_value ;
  assign dispense = mem_write;
  assign display[7] = internal_change[7];
  assign display[6] = internal_change[6];
  assign display[5] = internal_change[5];
  assign display[4] = internal_change[4];
  assign display[3] = internal_change[3];
  assign display[2] = internal_change[2];
  assign display[1] = internal_change[1];
  assign display[0] = internal_change[0];

  DFFX1_RVT \control/check_first_cycle_reg  ( .D(\control/N23 ), .CLK(clk), 
        .Q(\control/check_first_cycle ) );
  DFFX1_RVT \control/state_reg[0]  ( .D(n64), .CLK(clk), .Q(n199), .QN(n191)
         );
  DFFX1_RVT \credit_module/credit_reg[0]  ( .D(n62), .CLK(clk), .Q(
        internal_change[0]) );
  DFFX1_RVT \credit_module/credit_reg[7]  ( .D(n55), .CLK(clk), .Q(
        internal_change[7]) );
  DFFX1_RVT \credit_module/coin_value_reg[0]  ( .D(n110), .CLK(clk), .Q(
        \credit_module/coin_value [0]) );
  DFFX1_RVT \credit_module/coin_value_reg[1]  ( .D(n109), .CLK(clk), .Q(
        \credit_module/coin_value [1]) );
  DFFX1_RVT \credit_module/coin_value_reg[2]  ( .D(n108), .CLK(clk), .Q(
        \credit_module/coin_value [2]) );
  DFFX1_RVT \credit_module/coin_value_reg[4]  ( .D(n107), .CLK(clk), .Q(
        \credit_module/coin_value [4]) );
  DFFX1_RVT \credit_module/coin_value_reg[5]  ( .D(n106), .CLK(clk), .Q(
        \credit_module/coin_value [5]) );
  DFFX1_RVT \memory_module/mem_reg[0][0]  ( .D(n103), .CLK(clk), .Q(
        \memory_module/mem[0][0] ) );
  DFFX1_RVT \memory_module/mem_reg[0][1]  ( .D(n99), .CLK(clk), .Q(
        \memory_module/mem[0][1] ) );
  DFFX1_RVT \memory_module/mem_reg[0][2]  ( .D(n95), .CLK(clk), .Q(
        \memory_module/mem[0][2] ) );
  DFFX1_RVT \memory_module/mem_reg[0][3]  ( .D(n91), .CLK(clk), .Q(
        \memory_module/mem[0][3] ) );
  DFFX1_RVT \memory_module/mem_reg[0][4]  ( .D(n87), .CLK(clk), .Q(
        \memory_module/mem[0][4] ) );
  DFFX1_RVT \memory_module/mem_reg[0][5]  ( .D(n83), .CLK(clk), .Q(
        \memory_module/mem[0][5] ) );
  DFFX1_RVT \memory_module/mem_reg[0][6]  ( .D(n79), .CLK(clk), .Q(
        \memory_module/mem[0][6] ) );
  DFFX1_RVT \memory_module/mem_reg[0][7]  ( .D(n76), .CLK(clk), .Q(
        \memory_module/mem[0][7] ) );
  DFFX1_RVT \memory_module/mem_reg[1][0]  ( .D(n102), .CLK(clk), .Q(
        \memory_module/mem[1][0] ) );
  DFFX1_RVT \memory_module/mem_reg[1][1]  ( .D(n98), .CLK(clk), .Q(
        \memory_module/mem[1][1] ) );
  DFFX1_RVT \memory_module/mem_reg[1][2]  ( .D(n94), .CLK(clk), .Q(
        \memory_module/mem[1][2] ) );
  DFFX1_RVT \memory_module/mem_reg[1][3]  ( .D(n90), .CLK(clk), .Q(
        \memory_module/mem[1][3] ) );
  DFFX1_RVT \memory_module/mem_reg[1][4]  ( .D(n86), .CLK(clk), .Q(
        \memory_module/mem[1][4] ) );
  DFFX1_RVT \memory_module/mem_reg[1][5]  ( .D(n82), .CLK(clk), .Q(
        \memory_module/mem[1][5] ) );
  DFFX1_RVT \memory_module/mem_reg[1][6]  ( .D(n78), .CLK(clk), .Q(
        \memory_module/mem[1][6] ) );
  DFFX1_RVT \memory_module/mem_reg[1][7]  ( .D(n75), .CLK(clk), .Q(
        \memory_module/mem[1][7] ) );
  DFFX1_RVT \memory_module/mem_reg[2][0]  ( .D(n101), .CLK(clk), .Q(
        \memory_module/mem[2][0] ) );
  DFFX1_RVT \memory_module/mem_reg[2][1]  ( .D(n97), .CLK(clk), .Q(
        \memory_module/mem[2][1] ) );
  DFFX1_RVT \memory_module/mem_reg[2][2]  ( .D(n93), .CLK(clk), .Q(
        \memory_module/mem[2][2] ) );
  DFFX1_RVT \memory_module/mem_reg[2][3]  ( .D(n89), .CLK(clk), .Q(
        \memory_module/mem[2][3] ) );
  DFFX1_RVT \memory_module/mem_reg[2][4]  ( .D(n85), .CLK(clk), .Q(
        \memory_module/mem[2][4] ) );
  DFFX1_RVT \memory_module/mem_reg[2][5]  ( .D(n81), .CLK(clk), .Q(
        \memory_module/mem[2][5] ) );
  DFFX1_RVT \memory_module/mem_reg[2][6]  ( .D(n77), .CLK(clk), .Q(
        \memory_module/mem[2][6] ) );
  DFFX1_RVT \memory_module/mem_reg[2][7]  ( .D(n74), .CLK(clk), .Q(
        \memory_module/mem[2][7] ) );
  DFFX1_RVT \memory_module/mem_reg[3][0]  ( .D(n100), .CLK(clk), .Q(
        \memory_module/mem[3][0] ) );
  DFFX1_RVT \memory_module/stock_reg[0]  ( .D(n73), .CLK(clk), .Q(stock[0]) );
  DFFX1_RVT \memory_module/mem_reg[3][1]  ( .D(n96), .CLK(clk), .Q(
        \memory_module/mem[3][1] ) );
  DFFX1_RVT \memory_module/stock_reg[1]  ( .D(n72), .CLK(clk), .Q(stock[1]) );
  DFFX1_RVT \memory_module/mem_reg[3][2]  ( .D(n92), .CLK(clk), .Q(
        \memory_module/mem[3][2] ) );
  DFFX1_RVT \memory_module/stock_reg[2]  ( .D(n71), .CLK(clk), .Q(stock[2]) );
  DFFX1_RVT \memory_module/mem_reg[3][3]  ( .D(n88), .CLK(clk), .Q(
        \memory_module/mem[3][3] ) );
  DFFX1_RVT \memory_module/stock_reg[3]  ( .D(n70), .CLK(clk), .Q(stock[3]) );
  DFFX1_RVT \memory_module/mem_reg[3][4]  ( .D(n84), .CLK(clk), .Q(
        \memory_module/mem[3][4] ) );
  DFFX1_RVT \memory_module/stock_reg[4]  ( .D(n69), .CLK(clk), .Q(stock[4]) );
  DFFX1_RVT \memory_module/mem_reg[3][5]  ( .D(n80), .CLK(clk), .Q(
        \memory_module/mem[3][5] ) );
  DFFX1_RVT \memory_module/stock_reg[5]  ( .D(n68), .CLK(clk), .Q(stock[5]), 
        .QN(n195) );
  DFFX1_RVT \memory_module/mem_reg[3][6]  ( .D(n104), .CLK(clk), .Q(
        \memory_module/mem[3][6] ) );
  DFFX1_RVT \memory_module/stock_reg[6]  ( .D(n67), .CLK(clk), .Q(stock[6]) );
  DFFX1_RVT \memory_module/mem_reg[3][7]  ( .D(n105), .CLK(clk), .Q(
        \memory_module/mem[3][7] ) );
  DFFX1_RVT \memory_module/stock_reg[7]  ( .D(n66), .CLK(clk), .Q(stock[7]), 
        .QN(n194) );
  FADDX1_RVT \intadd_0/U6  ( .A(\credit_module/coin_value [2]), .B(
        internal_change[2]), .CI(\intadd_0/CI ), .CO(\intadd_0/n5 ), .S(
        \intadd_0/SUM[0] ) );
  FADDX1_RVT \intadd_0/U5  ( .A(\credit_module/coin_value [0]), .B(
        internal_change[3]), .CI(\intadd_0/n5 ), .CO(\intadd_0/n4 ), .S(
        \intadd_0/SUM[1] ) );
  FADDX1_RVT \intadd_0/U4  ( .A(\credit_module/coin_value [4]), .B(
        internal_change[4]), .CI(\intadd_0/n4 ), .CO(\intadd_0/n3 ), .S(
        \intadd_0/SUM[2] ) );
  FADDX1_RVT \intadd_0/U3  ( .A(\credit_module/coin_value [5]), .B(
        internal_change[5]), .CI(\intadd_0/n3 ), .CO(\intadd_0/n2 ), .S(
        \intadd_0/SUM[3] ) );
  FADDX1_RVT \intadd_0/U2  ( .A(\credit_module/coin_value [2]), .B(
        internal_change[6]), .CI(\intadd_0/n2 ), .CO(\intadd_0/n1 ), .S(
        \intadd_0/SUM[4] ) );
  DFFSSRX1_RVT \control/state_reg[2]  ( .D(n197), .SETB(n119), .RSTB(n198), 
        .CLK(clk), .Q(state_out[2]), .QN(n192) );
  DFFX2_RVT \credit_module/credit_reg[1]  ( .D(n61), .CLK(clk), .Q(
        internal_change[1]) );
  DFFX2_RVT \control/state_reg[1]  ( .D(n63), .CLK(clk), .Q(state_out[1]), 
        .QN(n193) );
  DFFX2_RVT \credit_module/credit_reg[6]  ( .D(n56), .CLK(clk), .Q(
        internal_change[6]) );
  DFFX2_RVT \credit_module/credit_reg[5]  ( .D(n57), .CLK(clk), .Q(
        internal_change[5]) );
  DFFX2_RVT \credit_module/credit_reg[4]  ( .D(n58), .CLK(clk), .Q(
        internal_change[4]) );
  DFFX2_RVT \credit_module/credit_reg[3]  ( .D(n59), .CLK(clk), .Q(
        internal_change[3]) );
  DFFX2_RVT \credit_module/credit_reg[2]  ( .D(n60), .CLK(clk), .Q(
        internal_change[2]) );
  XOR2X1_RVT U124 ( .A1(internal_change[0]), .A2(\credit_module/coin_value [0]), .Y(n185) );
  INVX2_RVT U125 ( .A(sell_item[0]), .Y(n137) );
  AO222X1_RVT U126 ( .A1(n191), .A2(n182), .A3(n191), .A4(state_out[2]), .A5(
        n192), .A6(n193), .Y(n119) );
  INVX0_RVT U127 ( .A(rst), .Y(n198) );
  NBUFFX2_RVT U128 ( .A(n199), .Y(state_out[0]) );
  NOR4X1_RVT U129 ( .A1(stock[3]), .A2(stock[2]), .A3(stock[1]), .A4(stock[0]), 
        .Y(n120) );
  NAND4X0_RVT U130 ( .A1(\control/check_first_cycle ), .A2(n120), .A3(n195), 
        .A4(n194), .Y(n121) );
  OR3X1_RVT U131 ( .A1(stock[6]), .A2(stock[4]), .A3(n121), .Y(n182) );
  AND3X1_RVT U132 ( .A1(state_out[2]), .A2(state_out[0]), .A3(n193), .Y(error)
         );
  NAND2X0_RVT U133 ( .A1(state_out[2]), .A2(n191), .Y(n183) );
  INVX0_RVT U134 ( .A(n183), .Y(n122) );
  AND2X1_RVT U135 ( .A1(n122), .A2(internal_change[7]), .Y(change_out[7]) );
  AND2X1_RVT U136 ( .A1(n122), .A2(internal_change[5]), .Y(change_out[5]) );
  AND2X1_RVT U137 ( .A1(n122), .A2(internal_change[6]), .Y(change_out[6]) );
  AND2X1_RVT U138 ( .A1(n122), .A2(internal_change[4]), .Y(change_out[4]) );
  AND2X1_RVT U139 ( .A1(n122), .A2(internal_change[2]), .Y(change_out[2]) );
  AND2X1_RVT U140 ( .A1(n122), .A2(internal_change[3]), .Y(change_out[3]) );
  AND2X1_RVT U141 ( .A1(n122), .A2(internal_change[1]), .Y(change_out[1]) );
  AND2X1_RVT U142 ( .A1(internal_change[0]), .A2(n122), .Y(change_out[0]) );
  AND3X1_RVT U143 ( .A1(state_out[0]), .A2(state_out[1]), .A3(n192), .Y(
        mem_write) );
  AND4X1_RVT U144 ( .A1(state_out[1]), .A2(n198), .A3(n191), .A4(n192), .Y(
        \control/N23 ) );
  INVX0_RVT U145 ( .A(coin_in[0]), .Y(n128) );
  AND2X1_RVT U146 ( .A1(n128), .A2(n198), .Y(n124) );
  OR2X1_RVT U147 ( .A1(coin_in[1]), .A2(\credit_module/coin_value [1]), .Y(
        n123) );
  AND2X1_RVT U148 ( .A1(n124), .A2(n123), .Y(n109) );
  INVX0_RVT U149 ( .A(coin_in[1]), .Y(n127) );
  AND2X1_RVT U150 ( .A1(n127), .A2(n198), .Y(n126) );
  OR2X1_RVT U151 ( .A1(coin_in[0]), .A2(\credit_module/coin_value [0]), .Y(
        n125) );
  AND2X1_RVT U152 ( .A1(n126), .A2(n125), .Y(n110) );
  AND2X1_RVT U153 ( .A1(coin_in[1]), .A2(n198), .Y(n130) );
  AND3X1_RVT U154 ( .A1(n198), .A2(n127), .A3(n128), .Y(n131) );
  AO22X1_RVT U155 ( .A1(coin_in[0]), .A2(n130), .A3(n131), .A4(
        \credit_module/coin_value [2]), .Y(n108) );
  NAND2X0_RVT U156 ( .A1(n128), .A2(n127), .Y(n129) );
  OA221X1_RVT U157 ( .A1(n129), .A2(\credit_module/coin_value [4]), .A3(n128), 
        .A4(n127), .A5(n198), .Y(n107) );
  AO21X1_RVT U158 ( .A1(n131), .A2(\credit_module/coin_value [5]), .A3(n130), 
        .Y(n106) );
  AND2X1_RVT U159 ( .A1(sell_item[0]), .A2(sell_item[1]), .Y(n132) );
  NAND3X0_RVT U160 ( .A1(n132), .A2(mem_write), .A3(n198), .Y(n154) );
  INVX0_RVT U161 ( .A(n154), .Y(n156) );
  MUX41X1_RVT U162 ( .A1(\memory_module/mem[1][6] ), .A3(
        \memory_module/mem[0][6] ), .A2(\memory_module/mem[3][6] ), .A4(
        \memory_module/mem[2][6] ), .S0(n137), .S1(sell_item[1]), .Y(n172) );
  MUX41X1_RVT U163 ( .A1(\memory_module/mem[1][5] ), .A3(
        \memory_module/mem[0][5] ), .A2(\memory_module/mem[3][5] ), .A4(
        \memory_module/mem[2][5] ), .S0(n137), .S1(sell_item[1]), .Y(n171) );
  MUX41X1_RVT U164 ( .A1(\memory_module/mem[1][4] ), .A3(
        \memory_module/mem[0][4] ), .A2(\memory_module/mem[3][4] ), .A4(
        \memory_module/mem[2][4] ), .S0(n137), .S1(sell_item[1]), .Y(n170) );
  MUX41X1_RVT U165 ( .A1(\memory_module/mem[1][3] ), .A3(
        \memory_module/mem[0][3] ), .A2(\memory_module/mem[3][3] ), .A4(
        \memory_module/mem[2][3] ), .S0(n137), .S1(sell_item[1]), .Y(n169) );
  MUX41X1_RVT U166 ( .A1(\memory_module/mem[1][2] ), .A3(
        \memory_module/mem[0][2] ), .A2(\memory_module/mem[3][2] ), .A4(
        \memory_module/mem[2][2] ), .S0(n137), .S1(sell_item[1]), .Y(n168) );
  MUX41X1_RVT U167 ( .A1(\memory_module/mem[1][1] ), .A3(
        \memory_module/mem[0][1] ), .A2(\memory_module/mem[3][1] ), .A4(
        \memory_module/mem[2][1] ), .S0(n137), .S1(sell_item[1]), .Y(n167) );
  INVX0_RVT U168 ( .A(sell_item[1]), .Y(n135) );
  MUX41X1_RVT U169 ( .A1(\memory_module/mem[3][0] ), .A3(
        \memory_module/mem[2][0] ), .A2(\memory_module/mem[1][0] ), .A4(
        \memory_module/mem[0][0] ), .S0(n137), .S1(n135), .Y(n166) );
  OR2X1_RVT U170 ( .A1(n167), .A2(n166), .Y(n143) );
  OR2X1_RVT U171 ( .A1(n168), .A2(n143), .Y(n146) );
  OR2X1_RVT U172 ( .A1(n169), .A2(n146), .Y(n149) );
  OR2X1_RVT U173 ( .A1(n170), .A2(n149), .Y(n153) );
  OR2X1_RVT U174 ( .A1(n171), .A2(n153), .Y(n151) );
  NOR2X0_RVT U175 ( .A1(n172), .A2(n151), .Y(n133) );
  MUX41X1_RVT U176 ( .A1(\memory_module/mem[1][7] ), .A3(
        \memory_module/mem[0][7] ), .A2(\memory_module/mem[3][7] ), .A4(
        \memory_module/mem[2][7] ), .S0(n137), .S1(sell_item[1]), .Y(n173) );
  HADDX1_RVT U177 ( .A0(n133), .B0(n173), .SO(n163) );
  AO22X1_RVT U178 ( .A1(n156), .A2(n163), .A3(n154), .A4(
        \memory_module/mem[3][7] ), .Y(n105) );
  AO21X1_RVT U179 ( .A1(n172), .A2(n151), .A3(n133), .Y(n157) );
  AO22X1_RVT U180 ( .A1(n156), .A2(n157), .A3(n154), .A4(
        \memory_module/mem[3][6] ), .Y(n104) );
  AND2X1_RVT U181 ( .A1(n137), .A2(n135), .Y(n134) );
  NAND3X0_RVT U182 ( .A1(mem_write), .A2(n134), .A3(n198), .Y(n158) );
  INVX0_RVT U183 ( .A(n158), .Y(n159) );
  INVX0_RVT U184 ( .A(n166), .Y(n139) );
  AO22X1_RVT U185 ( .A1(n159), .A2(n139), .A3(n158), .A4(
        \memory_module/mem[0][0] ), .Y(n103) );
  AND2X1_RVT U186 ( .A1(sell_item[0]), .A2(n135), .Y(n136) );
  NAND3X0_RVT U187 ( .A1(mem_write), .A2(n136), .A3(n198), .Y(n160) );
  INVX0_RVT U188 ( .A(n160), .Y(n161) );
  AO22X1_RVT U189 ( .A1(n161), .A2(n139), .A3(n160), .A4(
        \memory_module/mem[1][0] ), .Y(n102) );
  AND2X1_RVT U190 ( .A1(sell_item[1]), .A2(n137), .Y(n138) );
  NAND3X0_RVT U191 ( .A1(mem_write), .A2(n138), .A3(n198), .Y(n162) );
  INVX0_RVT U192 ( .A(n162), .Y(n164) );
  AO22X1_RVT U193 ( .A1(n164), .A2(n139), .A3(n162), .A4(
        \memory_module/mem[2][0] ), .Y(n101) );
  AO22X1_RVT U194 ( .A1(n156), .A2(n139), .A3(n154), .A4(
        \memory_module/mem[3][0] ), .Y(n100) );
  INVX0_RVT U195 ( .A(n143), .Y(n140) );
  AO21X1_RVT U196 ( .A1(n167), .A2(n166), .A3(n140), .Y(n141) );
  AO22X1_RVT U197 ( .A1(n159), .A2(n141), .A3(n158), .A4(
        \memory_module/mem[0][1] ), .Y(n99) );
  AO22X1_RVT U198 ( .A1(n161), .A2(n141), .A3(n160), .A4(
        \memory_module/mem[1][1] ), .Y(n98) );
  AO22X1_RVT U199 ( .A1(n164), .A2(n141), .A3(n162), .A4(
        \memory_module/mem[2][1] ), .Y(n97) );
  AO22X1_RVT U200 ( .A1(n156), .A2(n141), .A3(n154), .A4(
        \memory_module/mem[3][1] ), .Y(n96) );
  INVX0_RVT U201 ( .A(n146), .Y(n142) );
  AO21X1_RVT U202 ( .A1(n168), .A2(n143), .A3(n142), .Y(n144) );
  AO22X1_RVT U203 ( .A1(n159), .A2(n144), .A3(n158), .A4(
        \memory_module/mem[0][2] ), .Y(n95) );
  AO22X1_RVT U204 ( .A1(n161), .A2(n144), .A3(n160), .A4(
        \memory_module/mem[1][2] ), .Y(n94) );
  AO22X1_RVT U205 ( .A1(n164), .A2(n144), .A3(n162), .A4(
        \memory_module/mem[2][2] ), .Y(n93) );
  AO22X1_RVT U206 ( .A1(n156), .A2(n144), .A3(n154), .A4(
        \memory_module/mem[3][2] ), .Y(n92) );
  INVX0_RVT U207 ( .A(n149), .Y(n145) );
  AO21X1_RVT U208 ( .A1(n169), .A2(n146), .A3(n145), .Y(n147) );
  AO22X1_RVT U209 ( .A1(n159), .A2(n147), .A3(n158), .A4(
        \memory_module/mem[0][3] ), .Y(n91) );
  AO22X1_RVT U210 ( .A1(n161), .A2(n147), .A3(n160), .A4(
        \memory_module/mem[1][3] ), .Y(n90) );
  AO22X1_RVT U211 ( .A1(n164), .A2(n147), .A3(n162), .A4(
        \memory_module/mem[2][3] ), .Y(n89) );
  AO22X1_RVT U212 ( .A1(n156), .A2(n147), .A3(n154), .A4(
        \memory_module/mem[3][3] ), .Y(n88) );
  INVX0_RVT U213 ( .A(n153), .Y(n148) );
  AO21X1_RVT U214 ( .A1(n170), .A2(n149), .A3(n148), .Y(n150) );
  AO22X1_RVT U215 ( .A1(n159), .A2(n150), .A3(n158), .A4(
        \memory_module/mem[0][4] ), .Y(n87) );
  AO22X1_RVT U216 ( .A1(n161), .A2(n150), .A3(n160), .A4(
        \memory_module/mem[1][4] ), .Y(n86) );
  AO22X1_RVT U217 ( .A1(n164), .A2(n150), .A3(n162), .A4(
        \memory_module/mem[2][4] ), .Y(n85) );
  AO22X1_RVT U218 ( .A1(n156), .A2(n150), .A3(n154), .A4(
        \memory_module/mem[3][4] ), .Y(n84) );
  INVX0_RVT U219 ( .A(n151), .Y(n152) );
  AO21X1_RVT U220 ( .A1(n171), .A2(n153), .A3(n152), .Y(n155) );
  AO22X1_RVT U221 ( .A1(n159), .A2(n155), .A3(n158), .A4(
        \memory_module/mem[0][5] ), .Y(n83) );
  AO22X1_RVT U222 ( .A1(n161), .A2(n155), .A3(n160), .A4(
        \memory_module/mem[1][5] ), .Y(n82) );
  AO22X1_RVT U223 ( .A1(n164), .A2(n155), .A3(n162), .A4(
        \memory_module/mem[2][5] ), .Y(n81) );
  AO22X1_RVT U224 ( .A1(n156), .A2(n155), .A3(n154), .A4(
        \memory_module/mem[3][5] ), .Y(n80) );
  AO22X1_RVT U225 ( .A1(n159), .A2(n157), .A3(n158), .A4(
        \memory_module/mem[0][6] ), .Y(n79) );
  AO22X1_RVT U226 ( .A1(n161), .A2(n157), .A3(n160), .A4(
        \memory_module/mem[1][6] ), .Y(n78) );
  AO22X1_RVT U227 ( .A1(n164), .A2(n157), .A3(n162), .A4(
        \memory_module/mem[2][6] ), .Y(n77) );
  AO22X1_RVT U228 ( .A1(n159), .A2(n163), .A3(n158), .A4(
        \memory_module/mem[0][7] ), .Y(n76) );
  AO22X1_RVT U229 ( .A1(n161), .A2(n163), .A3(n160), .A4(
        \memory_module/mem[1][7] ), .Y(n75) );
  AO22X1_RVT U230 ( .A1(n164), .A2(n163), .A3(n162), .A4(
        \memory_module/mem[2][7] ), .Y(n74) );
  NAND2X0_RVT U231 ( .A1(state_out[1]), .A2(n192), .Y(n165) );
  OA21X1_RVT U232 ( .A1(state_out[0]), .A2(n165), .A3(n198), .Y(n174) );
  AO22X1_RVT U233 ( .A1(n174), .A2(stock[0]), .A3(\control/N23 ), .A4(n166), 
        .Y(n73) );
  AO22X1_RVT U234 ( .A1(n174), .A2(stock[1]), .A3(\control/N23 ), .A4(n167), 
        .Y(n72) );
  AO22X1_RVT U235 ( .A1(n174), .A2(stock[2]), .A3(\control/N23 ), .A4(n168), 
        .Y(n71) );
  AO22X1_RVT U236 ( .A1(n174), .A2(stock[3]), .A3(\control/N23 ), .A4(n169), 
        .Y(n70) );
  AO22X1_RVT U237 ( .A1(n174), .A2(stock[4]), .A3(\control/N23 ), .A4(n170), 
        .Y(n69) );
  AO22X1_RVT U238 ( .A1(n174), .A2(stock[5]), .A3(\control/N23 ), .A4(n171), 
        .Y(n68) );
  AO22X1_RVT U239 ( .A1(n174), .A2(stock[6]), .A3(\control/N23 ), .A4(n172), 
        .Y(n67) );
  AO22X1_RVT U240 ( .A1(n174), .A2(stock[7]), .A3(\control/N23 ), .A4(n173), 
        .Y(n66) );
  OA221X1_RVT U241 ( .A1(state_out[0]), .A2(state_out[1]), .A3(state_out[0]), 
        .A4(n192), .A5(cancel), .Y(n197) );
  AO222X1_RVT U242 ( .A1(n192), .A2(confirm), .A3(n192), .A4(state_out[1]), 
        .A5(n193), .A6(cancel), .Y(n175) );
  OR3X1_RVT U243 ( .A1(rst), .A2(n191), .A3(n175), .Y(n180) );
  OA21X1_RVT U244 ( .A1(coin_in[1]), .A2(coin_in[0]), .A3(n198), .Y(n176) );
  NAND4X0_RVT U245 ( .A1(n191), .A2(n192), .A3(n193), .A4(n176), .Y(n179) );
  INVX0_RVT U246 ( .A(cancel), .Y(n177) );
  NAND3X0_RVT U247 ( .A1(\control/check_first_cycle ), .A2(\control/N23 ), 
        .A3(n177), .Y(n178) );
  NAND3X0_RVT U248 ( .A1(n180), .A2(n179), .A3(n178), .Y(n64) );
  OA222X1_RVT U249 ( .A1(n197), .A2(state_out[2]), .A3(n197), .A4(state_out[0]), .A5(n197), .A6(state_out[1]), .Y(n181) );
  AND4X1_RVT U250 ( .A1(state_out[0]), .A2(n198), .A3(n192), .A4(n193), .Y(
        n188) );
  AO222X1_RVT U251 ( .A1(n182), .A2(\control/N23 ), .A3(n198), .A4(n181), .A5(
        n188), .A6(confirm), .Y(n63) );
  NAND3X0_RVT U252 ( .A1(state_out[0]), .A2(n192), .A3(n193), .Y(n184) );
  AND3X1_RVT U253 ( .A1(n198), .A2(n184), .A3(n183), .Y(n190) );
  AO22X1_RVT U254 ( .A1(internal_change[0]), .A2(n190), .A3(n185), .A4(n188), 
        .Y(n62) );
  AND2X1_RVT U255 ( .A1(internal_change[0]), .A2(\credit_module/coin_value [0]), .Y(n187) );
  FADDX1_RVT U256 ( .A(n187), .B(internal_change[1]), .CI(
        \credit_module/coin_value [1]), .S(n186) );
  AO22X1_RVT U257 ( .A1(n188), .A2(n186), .A3(n190), .A4(internal_change[1]), 
        .Y(n61) );
  AO222X1_RVT U258 ( .A1(n187), .A2(internal_change[1]), .A3(n187), .A4(
        \credit_module/coin_value [1]), .A5(internal_change[1]), .A6(
        \credit_module/coin_value [1]), .Y(\intadd_0/CI ) );
  AO22X1_RVT U259 ( .A1(n188), .A2(\intadd_0/SUM[0] ), .A3(n190), .A4(
        internal_change[2]), .Y(n60) );
  AO22X1_RVT U260 ( .A1(n188), .A2(\intadd_0/SUM[1] ), .A3(n190), .A4(
        internal_change[3]), .Y(n59) );
  AO22X1_RVT U261 ( .A1(n188), .A2(\intadd_0/SUM[2] ), .A3(n190), .A4(
        internal_change[4]), .Y(n58) );
  AO22X1_RVT U262 ( .A1(n188), .A2(\intadd_0/SUM[3] ), .A3(n190), .A4(
        internal_change[5]), .Y(n57) );
  AO22X1_RVT U263 ( .A1(n188), .A2(\intadd_0/SUM[4] ), .A3(n190), .A4(
        internal_change[6]), .Y(n56) );
  XOR2X1_RVT U264 ( .A1(\intadd_0/n1 ), .A2(internal_change[7]), .Y(n189) );
  AO22X1_RVT U265 ( .A1(internal_change[7]), .A2(n190), .A3(n189), .A4(n188), 
        .Y(n55) );
endmodule

