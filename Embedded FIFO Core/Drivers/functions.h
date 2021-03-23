#include "chu_init.h"
#include "gpio_cores.h"
#include "xadc_core.h"
#include "sseg_core.h"
#include "spi_core.h"
#include "i2c_core.h"
#include "ps2_core.h"
#include "ddfs_core.h"
#include "adsr_core.h"
#include "fifo_core.h"

void calcRead(DebounceCore*, fifoCore*, GpoCore*, SsegCore*); // calculate the sum of everything in the FIFO and writes it to the upper 4 7segs
void writeVal(DebounceCore*, fifoCore*, int, GpoCore*); // used for the button to write to the FIFO
void sseg_disp3_0(SsegCore*, int); // for turning on lower 4 7seg displays
void sseg_disp7_4(SsegCore*, int); // for turning on upper 4 7seg displays
int calculate_value(double); // used to convert the voltage reading from 0->255
int voltageRead(XadcCore*, SsegCore*); // reads the voltage of the XADC and writes it to the lower 4 7segs
void ledCheck(GpoCore*, int, int); // checks to turn to on the empty/full flags
