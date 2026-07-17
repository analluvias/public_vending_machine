# ============================================================
# formality.tcl — Equivalência RTL (golden) x Netlist (revision)
# Controlador de Vending Machine — com guidance de SVF
# ============================================================

# 1. Biblioteca de células — a mesma target_library do synth.tcl
read_db libs/saed32rvt_tt105v25c.db



# 2. Carrega o SVF gerado pelo Design Compiler (Etapa 1) como guidance.
# Deve vir ANTES de qualquer read_verilog/set_top: o Formality lê
# o histórico de otimizações da síntese e passa a registrar também
# as próprias operações desta sessão no mesmo arquivo.
set_svf reports/default.svf

# 3. ESSENCIAL: habilita o modo de setup automático baseado no SVF.
# Sem esta variável, o Formality só aproveita o guidance
# parcialmente (limitado a poucas operações estruturais) — é ela
# que faz o Formality de fato consumir o histórico de otimizações
# do Design Compiler (constantes, retiming, merge/inversão de
# registrador, reencodificação de FSM) durante o match.
set synopsys_auto_setup true

