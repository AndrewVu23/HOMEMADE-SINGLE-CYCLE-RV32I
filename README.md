# HOMEMADE SINGLE CYCLE RV32I

A modular, SystemVerilog implementation of a RISC-V CPU core based on the RV32I Instruction Set Architecture. This project demonstrates the fundamental principles of computer architecture, including datapath orchestration, control unit logic, and memory-mapped interfacing.

## Architecture Overview
This processor is a Single-Cycle implementation, meaning every instruction (Fetch, Decode, Execute, Memory, Writeback) completes in exactly one clock cycle. The design prioritizes modularity to allow for future expansion into a 5-stage pipeline.
