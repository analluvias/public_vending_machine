# ============================================================
# Script de Síntese
# ============================================================

# ------------------------------------------------------------
# Carregar configuração
# ------------------------------------------------------------

source synth/.synopsys_dc.setup

# ------------------------------------------------------------
# Inicialização e SVF
# ------------------------------------------------------------

# 1. Cria a pasta reports (TEM que ser antes do set_svf)
file mkdir reports

# Grava o histórico de otimizações do Design Compiler a partir daqui.
# Precisa vir ANTES de compile_ultra para capturar toda a compilação.
set_svf reports/default.svf

# ------------------------------------------------------------
# Ler RTL
# ------------------------------------------------------------

analyze -format sverilog rtl/vending_pkg.sv
analyze -format sverilog rtl/vending_top.sv
analyze -format sverilog rtl/control_unit.sv
analyze -format sverilog rtl/comparator.sv
analyze -format sverilog rtl/credit_reg.sv
analyze -format sverilog "rtl/memory.sv"
analyze -format sverilog rtl/subtractor.sv

# ------------------------------------------------------------
# Elaborar
# ------------------------------------------------------------

elaborate vending_top

link

# ------------------------------------------------------------
# Constraints
# ------------------------------------------------------------

source synth/constraints.sdc
# ------------------------------------------------------------
# Verificação do design
# ------------------------------------------------------------

puts "\n=================================================="
puts "CHECK DESIGN"
puts "=================================================="

# Cria a pasta reports caso ela não exista
file mkdir reports

# Executa o check_design e salva a saída no arquivo
redirect -file reports/check_design.rpt { check_design }

# ------------------------------------------------------------
# Relatórios pré-síntese
# ------------------------------------------------------------

redirect synth/area_pre.rpt {
report_area -hierarchy
}

redirect synth/timing_pre.rpt {
report_timing -max_paths 10
}

# ------------------------------------------------------------
# Síntese
# ------------------------------------------------------------


puts "\n=================================================="
puts "INICIANDO SÍNTESE"
puts "=================================================="

compile_ultra -no_autoungroup

# ------------------------------------------------------------
# Relatórios pós-síntese
# ------------------------------------------------------------

redirect synth/area_pos.rpt {
report_area -hierarchy
}

redirect synth/timing_relatorio.rpt {
report_timing -max_paths 10
}

redirect synth/power.rpt {
report_power
}

redirect synth/setup_violations.rpt {
report_constraint -all_violators
}

# ------------------------------------------------------------
# Exportar netlist
# ------------------------------------------------------------

write -format verilog -hierarchy -output synth/vending_syn.v

write -format ddc -hierarchy -output synth/vending_syn.ddc

write_sdc synth/vending_syn.sdc

# ------------------------------------------------------------
# Salvar sessão do DC
# ------------------------------------------------------------

write_file -format ddc -hierarchy -output synth/vending.ddc

puts "\n=================================================="
puts "SÍNTESE CONCLUÍDA"
puts "=================================================="
puts "Arquivos gerados:"
puts "  synth/area_pos.rpt"
puts "  synth/timing_relatorio.rpt"
puts "  synth/power.rpt"
puts "  synth/setup_violations.rpt"
puts "  synth/vending_syn.v"
puts "  synth/vending_syn.ddc"
puts "=================================================="

# Fecha o arquivo SVF e salva no disco de forma segura
set_svf -off
exit
