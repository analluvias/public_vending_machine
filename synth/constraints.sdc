# ============================================================
# Environment Constraints (Load e Driving Cell para SAED32)
# ============================================================

# Define o nome interno da biblioteca, célula típica (Buffer) e o pino
set LIB_NAME "saed32rvt_tt1p05v25c"
set TYP_CELL "NBUFFX4_RVT"
set TYP_PIN  "A"

# ============================================================
# Clock principal
# ============================================================

# 20 ns -> 50 MHz
create_clock -name clk -period 6 [get_ports clk]

# Incerteza do clock
set_clock_uncertainty 0.5 [get_clocks clk]

# Tempo de subida/descida do clock
set_clock_transition 0.1 [get_clocks clk]

# ============================================================
# Input delay
# ============================================================
# Esse comando define o atraso de entrada para todos os sinais de entrada, exceto para o clock.
# O atraso é definido como 3.0 ns após a subida do clock, e o clock é removido da coleção
# de entradas usando o comando remove_from_collection.

# Aproveitamos para salvar as entradas sem o clock em uma variável
set inputs_no_clk [remove_from_collection [all_inputs] [get_ports clk]]

set_input_delay 3 -clock clk $inputs_no_clk

# ============================================================
# Output delay
# ============================================================
set_output_delay 3 -clock clk [all_outputs]

# ============================================================
# Fanout máximo
# ============================================================
# Informa à ferramenta que nenhuma porta lógica interna deve acionar mais de 8 outras portas
set_max_fanout 8 [current_design]

# ============================================================
# Environment / Condições de Contorno
# ============================================================

# Configurar o Driving Cell (simulando que os sinais chegam de um buffer NBUFFX4_RVT)
set_driving_cell -lib_cell $TYP_CELL -pin Y $inputs_no_clk

# Configurar o Load (simulando que as saídas estão ligadas a 8 buffers, de acordo com o max_fanout)
set cap_of_buffer [load_of $LIB_NAME/$TYP_CELL/$TYP_PIN]
set my_typical_load [expr 8.0 * $cap_of_buffer]

set_load $my_typical_load [all_outputs]

# Print para verificar durante a síntese se o cálculo funcionou
puts "INFO: Load de saida configurado para $my_typical_load (FO8)"
