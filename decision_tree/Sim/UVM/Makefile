#Makefile for Scoreboard and Reference Model - Lab09


# SIMULATOR = Questa for Mentor's Questasim
# SIMULATOR = VCS for Synopsys's VCS

SIMULATOR = VCS

FSDB_PATH=/home/cad/eda/SYNOPSYS/VERDI_2022/verdi/T-2022.06-SP1/share/PLI/VCS/LINUX64

RTL= rtl.v
work= work #library name
SVTB2= interface.sv top.sv
# INC = +incdir+../env +incdir+../env_lib +incdir+../test
# SVTB1 = uvm_pkg::*
COVOP = -coveropt 3 +cover=bcft
VSIMOPT= -vopt -voptargs=+acc
VSIMCOV= -coverage -sva
VSIMBATCH1= -c -do  " log -r /* ;coverage save -onexit iris_cov1;run -all; exit"
VSIMBATCH2= -c -do  " log -r /* ;coverage save -onexit iris_cov2;run -all; exit"
VSIMBATCH3= -c -do  " log -r /* ;coverage save -onexit iris_cov3;run -all; exit"

help:
	@echo =====================================================================================================
	@echo " USAGE           --  make target                                                                       "
	@echo " clean           =>  clean the earlier log and intermediate files.                                     "
	@echo " sv_cmp          =>  Create library and compile the code.                                              "
	@echo " TC1             =>  To compile and run the testcase1 in batch mode.                                   "
	@echo " TC2             =>  To compile and run the testcase2 in batch mode.                                   "
	@echo " TC3             =>  To compile and run the testcase3 in batch mode.                                   "
	@echo " regress_12      =>  clean, compile and run testcases TC1 and TC2 in batch mode.                       "
	@echo " report_12       =>  To merge coverage reports for testcases TC1, TC2 and  convert to html format.     "
	@echo " regress_123     =>  clean, compile and run testcases TC1,TC2,TC3 in batch mode.                       "
	@echo " report_123      =>  To merge coverage reports for testcases TC1,TC2,TC3 and convert to html format.   "
	@echo " view_wave       =>  To view the waveform.                                                             "
	@echo " covhtml         =>  To view the coverage report in firefox.                                           "
	@echo " covtxt          =>  To view the coverage report in text editor [only for VCS]                         "
	@echo " cov_verdi       =>  To view coverage report in verdi[only for VCS]                                    "
	@echo ======================================================================================================

clean : clean_$(SIMULATOR)
sv_cmp : sv_cmp_$(SIMULATOR)
TC1 : TC1_$(SIMULATOR)
TC2 : TC2_$(SIMULATOR)
TC3 : TC3_$(SIMULATOR)
regress_12 : regress_12_$(SIMULATOR)
report_12 : report_12_$(SIMULATOR)
regress_123 : regress_123_$(SIMULATOR)
report_123 : report_123_$(SIMULATOR)
covhtml : covhtml_$(SIMULATOR)
covtxt: covtxt_$(SIMULATOR)
view_wave : view_wave_$(SIMULATOR)

# ---- Start of Definitions for Synopsys VCS Specific Targets -----#

sv_cmp_VCS:
	vcs -full64 -l comp.log -sverilog -debug_access+all -kdb -lca -ntb_opts uvm -P $(FSDB_PATH)/novas.tab $(FSDB_PATH)/pli.a $(RTL) $(SVTB2)

TC1_VCS:clean_VCS  sv_cmp_VCS
	./simv -a vcs.log +fsdbfile+wave_file1.fsdb -cm_dir ./cov1 +ntb_random_seed=3079295228 +UVM_TESTNAME=iris_test_c1
	urg -dir cov1.vdb -format both -report urgReport

TC2_VCS:
	./simv -a vcs.log +fsdbfile+wave_file2.fsdb -cm_dir ./cov2 +ntb_random_seed=1992898975 +UVM_TESTNAME=iris_test_c2
	urg -dir cov2.vdb -format both -report urgReport2

TC3_VCS:
	./simv -a vcs.log +fsdbfile+wave_file3.fsdb -cm_dir ./cov3 +ntb_random_seed_automatic +UVM_TESTNAME=iris_test_c3
	urg -dir cov3.vdb -format both -report urgReport3

clean_VCS:
	rm -rf simv* csrc* *.tmp *.vpd *.vdb *.key *.log *hdrs.h urgReport* *.fsdb verdi*
	clear

report_12_VCS:
	urg -dir cov1.vdb cov2.vdb -dbname merged_dir/merged_test -format both -report urgReport

regress_12_VCS: clean_VCS sv_cmp_VCS TC1_VCS TC2_VCS report_12_VCS

report_123_VCS:
	urg -dir cov1.vdb cov2.vdb cov3.vdb -dbname merged_dir/merged_test -format both -report urgReport

regress_123_VCS: clean_VCS sv_cmp_VCS TC1_VCS TC2_VCS TC3_VCS report_123_VCS

view_wave_VCS:
	verdi -ssf novas.fsdb

covhtml_VCS:
	firefox urgReport/grp*.html &

covtxt_VCS:
	vi urgReport/grp*.txt

cov_verdi:
	verdi -cov -covdir  iris_cov.vdb


# ---- End of Definitions for Synopsys VCS Specific Targets -----#

