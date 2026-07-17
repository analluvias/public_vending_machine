# ==========================================
# Diretórios
# ==========================================
RTL_DIR   = rtl
TB_DIR    = tb
SYNTH_DIR = synth
SCRIPTS_DIR = scripts
REPORT_DIR = reports
FM_DIR = fm

# ==========================================
# Arquivos
# ==========================================
PKG_FILES = $(RTL_DIR)/vending_pkg.sv

RTL_FILES = \
    $(RTL_DIR)/vending_top.sv \
    $(RTL_DIR)/control_unit.sv \
    $(RTL_DIR)/credit_reg.sv \
    $(RTL_DIR)/memory.sv \
    $(RTL_DIR)/comparator.sv \
    $(RTL_DIR)/subtractor.sv

TB_FILES = \
	$(TB_DIR)/tb_vending.sv

# ==========================================
# Top do testbench
# ==========================================
TOP = tb_vending

# ==========================================
# Flags
# ==========================================
TIMESCALE = 1ns/1ps

VLOGAN_FLAGS = -full64 \
			   -sverilog \
			   -kdb \
			   +lint=all

VCS_FLAGS = -full64 \
			-timescale=$(TIMESCALE) \
			-debug_access+all \
			-kdb

# ==========================================
# Verificação de sintaxe
# ==========================================
syntax:
	vlogan $(VLOGAN_FLAGS) \
		$(PKG_FILES) \
		$(RTL_FILES) \
		$(TB_FILES)

# ==========================================
# Compilação / Elaboração
# ==========================================
compile: syntax
	vcs $(VCS_FLAGS) -top $(TOP)

# ==========================================
# Simulação
# ==========================================
run: compile
	./simv

# ==========================================
# Abrir waveform
# ==========================================
wave:
	verdi -ssf vending.fsdb &

# ==========================================
# Síntese
# ==========================================
synth:
	dc_shell -x "source $(SCRIPTS_DIR)/.synopsys_dc.setup" -f $(SYNTH_DIR)/synth.tcl

# ==========================================
# Verificacao formal
# ==========================================
fm:
	mkdir -p $(FM_DIR)/reports
	fm_shell -f $(FM_DIR)/formality_auto_using.tcl

# ==========================================
# Limpeza da síntese
# ==========================================
clean_synth:
	rm -rf \
		./vending.ddc \
		./alib-52 \
		./default.svf \
		./work* \
		$(SYNTH_DIR)/*.rpt \
		$(SYNTH_DIR)/*.ddc \
		$(SYNTH_DIR)/*.db \
		$(SYNTH_DIR)/*_syn.v \
		$(REPORT_DIR)

# ==========================================
# Limpeza da simulação
# ==========================================
clean_sim:
	rm -rf \
		csrc \
		simv* \
		*.daidir \
		novas* \
		AN.DB \
		ucli.key \
		verdi* \
		DVEfiles \
		.vlogan* \
		*.fsdb \
		*.log

# ==========================================
# Limpeza do Formality
# ==========================================
clean_fm:
	rm -rf \
		./FM_WORK \
		./formality.log \
		./fm_core* \
		./formality_svf/ \
		$(FM_DIR)/reports

# ==========================================
# Limpeza total
# ==========================================
clean: clean_sim clean_synth clean_fm

.PHONY: syntax compile run wave synth fm clean clean_sim clean_synth clean_fm
