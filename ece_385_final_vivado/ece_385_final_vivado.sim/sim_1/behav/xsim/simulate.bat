@echo off
REM ****************************************************************************
REM Vivado (TM) v2022.2 (64-bit)
REM
REM Filename    : simulate.bat
REM Simulator   : Xilinx Vivado Simulator
REM Description : Script for simulating the design by launching the simulator
REM
REM Generated by Vivado on Thu Apr 18 22:47:01 -0500 2024
REM SW Build 3671981 on Fri Oct 14 05:00:03 MDT 2022
REM
REM IP Build 3669848 on Fri Oct 14 08:30:02 MDT 2022
REM
REM usage: simulate.bat
REM
REM ****************************************************************************
REM simulate design
echo "xsim testbench_1_behav -key {Behavioral:sim_1:Functional:testbench_1} -tclbatch testbench_1.tcl -protoinst "protoinst_files/mb_block.protoinst" -view C:/Users/dasan/Desktop/ECE385FinalProject/ece_385_final_vivado/testbench_1_behav.wcfg -log simulate.log"
call xsim  testbench_1_behav -key {Behavioral:sim_1:Functional:testbench_1} -tclbatch testbench_1.tcl -protoinst "protoinst_files/mb_block.protoinst" -view C:/Users/dasan/Desktop/ECE385FinalProject/ece_385_final_vivado/testbench_1_behav.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
