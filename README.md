Verilog RTL and RISC-V Practice Activities

Name: ANUSUYA A 

Assignment: Verilog RTL and RISC-V Practice Activities

Project Description:
This repository contains Verilog RTL designs, RISC-V processor development activities, testbenches, ModelSim simulations and waveform verification completed as part of the 4-day assignment.

Day 1 – RTL Building Blocks and Self-Checking Verification:
1.1 Parameterized ALU
1.2 Up/Down Counter
1.3 Barrel Shifter
1.4 Register File
1.5 Ripple-Carry Adder/Subtractor
1.6 Priority Encoder and Decoder
1.7 LFSR and Shift Register
1.8 Edge Detector and Debouncer

Day 2 – FSM Controllers and Memory Design:
2.1 Sequence Detector
2.2 Vending Machine Controller
2.3 Synchronous FIFO
2.4 Design Review
2.5 Traffic Light with Pedestrian Request
2.6 ATM Controller with PIN and Balance
2.7 Round-Robin Arbiter
2.8 RAM, ROM and Watchdog Timer

Day 3 – Extending the Single-Cycle RISC-V CPU:
3.1 Instruction Extensions
3.2 Assembly Programs
3.3 Self-Checking CPU Testbench
3.4 Waveform Analysis
3.5 Branch and Jump Extensions
3.6 More Assembly Programs
3.7 Instruction Coverage Matrix
3.8 Bug-Hunt Exercise

Day 4 – Pipeline Hazards, Analysis and Submission:
4.1 Data Hazard Handling
4.2 Control Hazard Handling
4.3 Performance Comparison
4.4 Git Submission
4.5 Hazard Waveform Report
4.6 Performance Counters
4.7 Extended Program Runs
4.8 Architecture Diagram and Demo

Daily Completion Checklist:

Day    Core Activities    Additional (At least 2)    Waveforms Saved    Git Commit Pushed

Day 1       [✓]                  [✓]                       [✓]                 [✓]
Day 2       [✓]                  [✓]                       [✓]                 [✓]
Day 3       [✓]                  [✓]                       [✓]                 [✓]
Day 4       [✓]                  [✓]                       [✓]                 [✓]

How to Run Simulations Using ModelSim:
Step 1: Open ModelSim
Open ModelSim and navigate to the project directory.
Step 2: Create Working Library
pwd
vlib work
vmap work work
Step 3: Compile Verilog Files
vlog alu.v alu_tb.v
Step 4: Start Simulation
vsim work.alu_tb
Step 5: Add Signals to Waveform
add wave -r *
Step 6: Run Simulation
run -all
Step 7: Zoom Waveform
wave zoomfull
Check the PASS/FAIL messages and verify the simulation waveforms.

Known Issues:
No known issues.

Conclusion:
This project demonstrates practical knowledge of Verilog RTL design, FSM implementation, RISC-V processor architecture, pipeline hazard handling, simulation and verification using ModelSim
