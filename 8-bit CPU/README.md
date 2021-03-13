# 8-bit CPU [Manuel Kelly]
### RISC 8-bit CPU written in SystemVerilog
* All alu instructions were followed by this [Wikipedia page](https://en.wikipedia.org/wiki/Arithmetic_logic_unit).
* For simplicity of testbenching, this CPU can write instructions to be written to memory.
* The CPU reads instructions from memory, every clock cycle.
* Once memory empty flag rises, CPU stops and waits for more instructions to be executed.
* Below is the following I/O you will need to know to use the CPU:
  * clk, reset.
  * wr (write enable to write instructions to memory).
  * A, B (data that will be used for operations in the ALU [EX: add A, B]).
  * opcode (tells the ALU what operation to perform).
  * Y (output of the ALU).

* **opcode[7:0]** takes many 8-bit values. 
  * The **lower 4 bits [3:0]** are used for the operations. 
  * **Bit [4]** is used for shift left/right or doing a single operation on A/B (bit is labeled *op* in ALU).
  * **Bit [5]** is used for determining if there is a carry or borrow (bit is labeled *c_b* in ALU).
### Below are all 16 operations (opcode[3:0])

|opcode[3:0]|Operation|op/c_b|
| :------- | ----: | :---: |
| 4'b0000 | | add | | N/A |
  
