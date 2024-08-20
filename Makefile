###  -*-Makefile-*-

# Copyright (c) 2019 Bluespec, Inc. All Rights Reserved

# ================================================================

.PHONY: all
all: sim

.PHONY: help
help:
	@echo '    make  verilog      Recompile the IP to Verilog (in dir _verilog)'
	@echo '                           NOTE: needs Bluespec bsc compiler'
	@echo ''
	@echo '    make  clean        Remove intermediate build-files'
	@echo '    make  full_clean   Restore to pristine state (pre-building anything)'

# ================================================================
# Simulation settings
# ----------------
# Top-level file and module
TOPFILE := tb/$(TB)TB.bsv

# ================================================================
# Search path for bsc for .bsv files

BSC_PATH = alu:branch:cache:decode:issue:lsu:regfile:rename:retire:tb:top:+

# ================================================================
# bsc compilation flags

BSC_COMPILATION_FLAGS += \
	-keep-fires -aggressive-conditions -no-warn-action-shadowing -no-show-timestamps -check-assert \
	-suppress-warnings G0020    \
	-show-range-conflict

# ================================================================
# Generate Verilog RTL from BSV sources (needs Bluespec 'bsc' compiler)

RTL_GEN_DIRS = -vdir build/_verilog -bdir build/_build -info-dir build/_build -simdir build/_sim

build/_build:
	mkdir -p $@

build/_verilog:
	mkdir -p $@

build/_sim:
	mkdir -p $@

.PHONY: verilog sim run_sim
verilog: build/_build build/_verilog
	@echo  "INFO: Verilog RTL generation ..."
	bsc -u -elab -verilog  $(RTL_GEN_DIRS) $(BSC_COMPILATION_FLAGS)  -p $(BSC_PATH) $(TOPFILE)
	@echo  "INFO: Verilog RTL generation finished"

sim: build/_build build/_verilog build/_sim
	@echo  "INFO: Simulation binary generation ..."
	bsc -u -sim $(RTL_GEN_DIRS) -g mkTB $(BSC_COMPILATION_FLAGS) -p $(BSC_PATH) $(TOPFILE)
	bsc -u -sim $(RTL_GEN_DIRS) -e mkTB $(BSC_COMPILATION_FLAGS) -p $(BSC_PATH) -o $@
	@echo  "INFO: Simulation binary finished"

run_sim: sim
	./sim

# ================================================================

.PHONY: clean
clean:
	rm -r -f   build

.PHONY: full_clean
full_clean: clean
	rm  -r -f  build

# ================================================================
