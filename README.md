# HOMEMADE SINGLE CYCLE RV32I

A modular, Verilog implementation of a RISC-V CPU core based on the RV32I Instruction Set Architecture. This project demonstrates the fundamental principles of computer architecture, including datapath orchestration, control unit logic, and memory-mapped interfacing.

## Architecture Overview
This processor is a Single-Cycle implementation, meaning every instruction (Fetch, Decode, Execute, Memory, Writeback) completes in exactly one clock cycle. The design prioritizes modularity to allow for future expansion into a 5-stage pipeline.
### Core Specs:
- ISA: RISC-V (RV32I)
- Datapath: Single-Cycle
- Word Size: 32-bit
- Supported Instructions:
  - R-Type: ```add```, ```sub```, ```and```, ```or```, ```slt```
  - I-Type: ```addi```, ```andi```, ```ori```, ```lw```
  - S-Type: ```sw```
  - B-Type: ```beq```
  - J-Type: ```jal```

## Project Structure
```/Components```: Contains the Verilog source files for all modules.

```/Testbenches```: Contain Testbenches for "most" of the modules and datapaths.

## Hardware Logic & Data Flow
The processor follows the standard RISC-V functional stages:
1. Instruction Fetch (IF): The PC provides the address to Instruction Memory, fetching the 32-bit machine code.
2. Decode (ID): The Control Unit decodes the opcode while the Register File reads the source registers (rs1, rs2).
3. Execute (EX): The ALU performs arithmetic or address calculation (Base + Offset).
4. Memory (MEM): Data Memory is accessed for Load/Store operations using the ALU result as the effective address.
5. Writeback (WB): A 3-way Multiplexer selects between the ALU result, Memory data, or Return Address (PC+4) to write back to the destination register (rd).

## Verification & Testing
Backdoor Initialization: Register file and memory arrays are initialized with known values to isolate instruction logic.

Direct Stimulus Injection: The ```force``` and ```release``` Verilog commands are used to inject specific machine code sequences to verify corner cases in the datapath.

Trace Analysis: Signal timing and data transitions were verified via VCD waveform analysis.

(All the writing, running, and verifying were done using [siliconspace.org](https://siliconspace.org) (not sponsored), an online RTL-to-GDSII editor)

## Future Roadmap
- Implement a 5-stage Pipeline (IF, ID, EX, MEM, WB).
- Add a Forwarding Unit to handle Data Hazards.
- Add Hazard Detection for Control Hazards (Branch Flushing).
- Memory-Mapped I/O for FPGA peripheral support.


