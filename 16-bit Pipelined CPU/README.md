# 16-bit 5-Stage Pipelined CPU [Manuel Kelly]

### 16-bit 5-Stage Pipelined CPU written in SystemVerilog [INCOMPLETE TESTBENCH]
* TB does not show all operations.
* All ALU instructions are basic "common" CPU instrctions.
* The CPU reads instructions from memory, every clock cycle.
* Below is the following I/O you will need to know to use the CPU:
  * clk.
  * resetn.

* Below is the Register Map used for this 16-bit CPU.

### IR[15:0]
R-Type: 
|15-  OPCODE  -12|11-  Rd  -8|7-  Rs  -4|3-  Rt  -0|
| :----: | :----: | :----: | :----: |
        
I-Type: 
|15-  OPCODE  -12|11-  Rd  -8|7- IMM/ADDR  -0|
| :----: | :----: | :----: |

J-Type: 
|15-  OPCODE  -12|11-  ADDR  -0|
| :----: | :----: |


### Below are all 16 operations (instr[3:0] = IR[15:12])
<p align="center">
|instr[3:0]|Operation|
| :--------: | :----------: |
| 4'b0000 | NO OP |
| 4'b0001 | LOAD |
| 4'b0010 | LOAD IMMEDIATE |
| 4'b0011 | STORE |
| 4'b0100 | MOVE |
| 4'b0101 | AND |
| 4'b0110 | OR |
| 4'b0111 | XOR |
| 4'b1000 | ONE'S COMPLIMENT |
| 4'b1001 | TWO'S COMPLIMENT |
| 4'b1010 | SHIFT LEFT |
| 4'b1011 | SHIFT RIGHT |
| 4'b1100 | ADD |
| 4'b1101 | SUBTRACT |
| 4'b1110 | MULTIPLY |
| 4'b1111 | JUMP |
<p/>

[comment]: <> (UPDATE ALL OF THIS LATER)

[comment]: <> (|RTL Design| )
[comment]: <> (| :--------: | )
[comment]: <> (| | )

[comment]: <> (|Testbench1|)
[comment]: <> (| :--------: |)
[comment]: <> (| |)
