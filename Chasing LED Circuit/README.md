# Chasing LED Circuit [Manuel Kelly]
### [YouTube Video Link](https://www.youtube.com/watch?v=7Cvl2endsew&ab_channel=Mvnkelly)

- This project implements a Chasing LED on the Nexys 4 FPGA.
- This circuit allows the user to change the speed of the LED and pause the LED.
- To change the speed of the LED, switches 7 to 0 will be used.
  - The 7-segment displays will display a number from 0 to 255.
  - 0 = 50 ms delay.
  - 255 = 500 ms delay.
- To change pause the LED, switch 15 will be used

| [RTL DESIGN]() |
| :------------: |
| ![rtl]() |


| [Schematic]() |
| :-----------: |
| ![schem]() |

| [Pause Test]() |
| :------------: |
| ![stop]() |

| [Testbench 1: 50ms Delay]() |
| :-------------------------: |
| ![tb1]() |

| [Testbench 2: 500ms Delay]() |
| :-------------------------: |
| ![tb2]() |

| [Testbench 3: 275ms Delay]() |
| :-------------------------: |
| ![tb3]() |
