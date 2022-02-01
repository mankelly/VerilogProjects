# uART Receive and Transmit Modules

### Basic Uart Rx and Tx modules used for serial communication with a host.
* Each Rx & Tx module are state machines that are implemented with the Baud_Gen.sv.
* To send and Recieve data, it is best to use a FIFO buffer during communication. 
* Each module has been verified and tested working via communication with a PC.
