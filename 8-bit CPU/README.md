# 8-bit CPU [Manuel Kelly]
### 8-bit RISC CPU written in SystemVerilog [INCOMPLETE TESTBENCH]
* All ALU instructions were followed by this [Wikipedia page](https://en.wikipedia.org/wiki/Arithmetic_logic_unit).
* For simplicity of testbenching, this CPU can write instructions to be written to memory.
* The CPU reads instructions from memory, every clock cycle.
* Once memory empty flag rises, CPU stops and waits for more instructions to be executed.
* Below is the following I/O you will need to know to use the CPU:
  * clk, reset.
  * wr (write enable to write instructions to memory).
  * A, B (data that will be used for operations in the ALU [EX: add A, B]).
  * opcode (tells the ALU what operation to perform).
  * Y (output of the ALU).

* The ALU observes the **opcode[7:0]**, but not all 8-bit values. Few bits are ignored. 
  * The **lower 4 bits [3:0]** are used for the operations. 
  * **Bit [4]** is used for shift left/right or doing a single operation on A/B (bit is labeled *op* in ALU).
  * **Bit [5]** is used for determining if there is a carry or borrow (bit is labeled *c_b* in ALU).
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
| 4'b1100 | arithmetic shift | op == 1 shift left, else shift right |
| 4'b1101 | logical shift | op == 1 shift left, else shift right |
| 4'b1110 | rotate | op == 1 rotate left, else rotate right |
| 4'b1111 | rotate through carry | op == 1 rotate left, else rotate right; c_b == carry |

|RTL Design|
| :--------: |
|![RTL Design](https://github.com/mankelly/VerilogProjects/blob/1040136a56196a6bf64ee55356eb4fdfa4786470/8-bit%20CPU/images/RTL_Design.PNG)|
