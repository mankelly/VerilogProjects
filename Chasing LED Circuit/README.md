# Chasing LED Circuit [Manuel Kelly]
### [YouTube Video Link](https://www.youtube.com/watch?v=7Cvl2endsew&ab_channel=Mvnkelly)

- This project implements a Chasing LED on the Nexys 4 FPGA.
- This circuit allows the user to change the speed of the LED and pause the LED.
- To change the speed of the LED, switches 7 to 0 will be used.
  - The 7-segment displays will display a number from 0 to 255.
  - 0 = 50 ms delay.
  - 255 = 500 ms delay.
- To change pause the LED, switch 15 will be used

| [RTL DESIGN] |
| :------------: |
| ![rtl](https://github.com/mankelly/VerilogProjects/blob/master/Chasing%20LED%20Circuit/images/diagram.PNG) |


| [Schematic] |
| :-----------: |
| ![schem](https://github.com/mankelly/VerilogProjects/blob/master/Chasing%20LED%20Circuit/images/schematic.jpg) |

| Pause Test |
| :------------: |
| ![pause](https://github.com/mankelly/VerilogProjects/blob/master/Chasing%20LED%20Circuit/images/sw%3D0%2Cstop%2Creset.PNG) |

| [Testbench 1: 50ms Delay](https://github.com/mankelly/VerilogProjects/blob/master/Chasing%20LED%20Circuit/Testbenches/midterm_tb.sv) |
| :-------------------------: |
| ![tb1](https://github.com/mankelly/VerilogProjects/blob/master/Chasing%20LED%20Circuit/images/sw%3D0.PNG) |

| [Testbench 2: 500ms Delay](https://github.com/mankelly/VerilogProjects/blob/master/Chasing%20LED%20Circuit/Testbenches/midterm_tb2.sv) |
| :-------------------------: |
| ![tb2](https://github.com/mankelly/VerilogProjects/blob/master/Chasing%20LED%20Circuit/images/sw%3D127.PNG) |

| [Testbench 3: 275ms Delay](https://github.com/mankelly/VerilogProjects/blob/master/Chasing%20LED%20Circuit/Testbenches/midterm_tb3.sv) |
| :-------------------------: |
| ![tb3](https://github.com/mankelly/VerilogProjects/blob/master/Chasing%20LED%20Circuit/images/sw%3D255.PNG) |
