# FIFO Buffer Core (Manuel Kelly)
**YouTube Link: https://www.youtube.com/watch?v=y1SHkFZnxXk&ab_channel=Mvnkelly**
* **I used rd_data[31:30] for the empty and full flags**
* This system allows the user to read and write decimal values to a FIFO buffer via a MMIO core.
* Up to 4 decimal values can be written to the FIFO and when read, all are added and output to the left four 7seg displays.
* Values are selected using the write function (btnU) and by adjusting the knob on a potentiometer.
* The read function is enabled using btnD.
* System will flash if the user tries to write when the buffer is full.
* System will flash if the user tries to read when the buffer is empty.
* LED1 and LED0 are used for the FIFO Full and Empty flags, respectively.
* System can be reset using the CPU reset button.
