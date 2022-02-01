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
R-Type: |15-  OPCODE  -12|11-  Rd  -8|7-  Rs  -4|3-  Rt  -0|
        | :----: | :----: | :----: | :----: |
        
I-Type: |15-  OPCODE  -12|11-  Rd  -8|7- IMM/ADDR  -0|
        | :----: | :----: | :----: |

J-Type: |15-  OPCODE  -12|11-  ADDR  -0|
        | :----: | :----: |

* To write an instruction to memory, **wr** must be enabled and **opcode** must be filled.
### Below are all 16 operations (opcode[3:0])

|opcode[3:0]|Operation|op / c_b|
| :--------: | :----------: | :---------: |
| 4'b0000 | add | N/A |
| 4'b0001 | add w/ carry | c_b == carry |
| 4'b0010 | subtract | N/A |
| 4'b0011 | subtract w/ borrow | c_b == borrow |
| 4'b0100 | twos compliment | op == 1 comp A, else B |
| 4'b0101 | increment | op == 1 inc A, else B |
| 4'b0110 | decrement | op == 1 dec A, else B |
| 4'b0111 | pass through | op == 1 pass A, else B |
| 4'b1000 | and | N/A |
| 4'b1001 | or | N/A |
| 4'b1010 | xor | N/A |
| 4'b1011 | ones compliment | op == 1 comp A, else B |
| 4'b1100 | arithmetic shift A | op == 1 shift left, else shift right |
| 4'b1101 | logical shift A | op == 1 shift left, else shift right |
| 4'b1110 | rotate A | op == 1 rotate left, else rotate right |
| 4'b1111 | rotate through carry A | op == 1 rotate left, else rotate right; c_b == carry |


|RTL Design|
| :--------: |
|![RTL Design](https://github.com/mankelly/VerilogProjects/blob/1040136a56196a6bf64ee55356eb4fdfa4786470/8-bit%20CPU/images/RTL_Design.PNG)|

|[Testbench1](https://github.com/mankelly/VerilogProjects/blob/master/8-bit%20CPU/cpu_tb.sv)|
| :--------: |
|![TB1](https://github.com/mankelly/VerilogProjects/blob/a88aa6bab3003fe54ee7b314b9484a62cb4bf4c4/8-bit%20CPU/images/tb1.PNG)|
