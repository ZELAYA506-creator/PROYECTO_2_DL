TOP        = TopModule
SRC        = ../src/CodificadorHamming.sv ../src/DecodificadorHamming.sv ../src/LED_Display.sv ../src/SieteSeg_Display.sv ../src/$(TOP).sv
CONSTRAINT = ../constraints/hamming_constraints.cst
DEVICE     = GW1NR-LV9QN88C6/I5

all: bitstream

sim:
	ghdl -a ../src/*.sv ../sim/top_tb.sv
	ghdl -e TopModule_tb
	ghdl -r TopModule_tb --vcd=wave.vcd
	gtkwave wave.vcd &

synth:
	yosys -q -p 'read_verilog -sv $(SRC); hierarchy -top $(TOP); synth_gowin -json top.json'

pnr:
	nextpnr-gowin --json top.json --write top.asc --cst $(CONSTRAINT) --device $(DEVICE)

bitstream: synth pnr
	gowin_pack -d $(DEVICE) -o top.fs top.asc

clean:
	rm -f *.json *.asc *.fs *.vcd *.cf *.o work-obj08.cf

distclean: clean
	rm -f *.vvp *.vcd *.log
