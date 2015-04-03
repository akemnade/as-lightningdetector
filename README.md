# as-lightningdetector
small pcb board with the as3935 lightning detector to fit into the GTA0X in the free space between the sim card holder and the back cover

Editing layout/schematics
-------------------------
The pcb layout is done with geda and pcb
The frontend xgsch2pcb is used.

on debian do as root:
apt-get install pcb geda geda-xgsch2pcb

Hardware installation
---------------------

Pins on the board are (from the outside to the middle)
GND
SDA
SCL
IRQ
Vdd

Connect Vdd to a regulator providing 2.5V to 3.6V
The board does not have I2C pull up resistors, 
so make sure, they are enabled on the other side.
The voltage these resistors are pulled to has can be a bit lower
than Vdd, so it can work e.g. with 1.8V I2c voltage and 2.5V
Vdd.
Important: The chip might block the I2C bus if power is not attached/enabled
so make sure any regulator is enabled before anything on the same bus is used.
The voltage divider at the IRQ pin has to be adapted to the
voltage required, default values are for adapting the 2.5V to 1.8V as required for GTA04 boards.

reader shell script
--------------------
read-as3935.sh reads out distance to the thunderstorm
and the last interrupt reason (8 = lighning)

The environment variables MYBUS and MODE are used to set the i2c bus number where the chip is on and whether the outdoor or indoor mode should be used.

calibration
-----------
if using 1% NPO capacitors, it should be well calibrated
but you can check if you use the calibration mode of the chip
the frequency on the irq pin should be 500/16=31.25 khz
