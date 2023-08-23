# stratux-NPNA
Stratux Europe running on a NanoPi Neo Air. Probably the smallest Stratux System possible. The case including fan and GPS ist juts 79x48x33mm in size.
Based on the wonderful work of https://github.com/b3nn0/stratux and https://github.com/VirusPilot/stratux-pi4.

```diff
-!!WARNING!!- This is work in progress. It might not work! It might fail after a while! DO NOT RELY ON IT DURING FLIGHT!!
```

# Installation
- Install a fresh version or Armbian Bullseye (I used 23.02.0 with 5.15.91 kernel) on your NanoPi Neo Air. Since there is no official Armbian support for the NanoPi Neo Air, you need to compile it yourself. For compatibility reason, you need to add ```BOOTFS_TYPE="fat"``` to the NanoPi Neo Air config file before compiling Armbian.
For best performance, install Armbian to the internal eMMC of the NanoPi Neo Air.
- Boot up Armbian Bullseye and connect to your WiFi. The initial Armbian setup script will guide you through that process.
- Download and run the Stratux NPNA setup script:
```
wget https://raw.githubusercontent.com/sternflyer/stratux-NPNA/main/stratux-NPNA-setup.sh
chmod +x stratux-NPNA-setup.sh
sudo ./stratux-NPNA-setup.sh
```

- Reboot when promted 

# Hardware
Description of the hardware used. You can find a shopping list at the end.

## NanoPi Neo Air
The NanoPi Neo Air is a very minimalistic SBC. Measuring only 40x40mm, it is probably one of the smallest SBC around. With no external connectors aside a mini USB port and a SD-Card slot. 
However, two USB-Ports, UART and I2C are available via pinheader. For detailed description see https://wiki.friendlyelec.com/wiki/index.php/NanoPi_NEO_Air.

## SDR
I'm using two Nooelec NESDR Nano 2 to receive ADS-B (1090 MHz) and OGN (868 MHz). Without plastic housing the SDRs fit under the custom PCB. The Fan provides proficient cooling. With a MCX to SMA adaptor you can remove the antennas for transport.

## GPS
I was having some difficulties to find a GPS that is working. The SDRs have quite some interference into the GPS frequency range and compromise reception. After many trial and error I found that the Beitian BE-252i module works best. It has a u-blox UBX-M10050 chip with a 25*25mm ceramic antenna.

## AHRS
I'm sing the popular GY-91 board with BMP280 and a MPU9250 accelerometer, gyroscope and compass. Due to EOL of MPU9250 cips, there are many boards with a MPU6050. The MPU6050 is the same as the MPU9250, but without a compass. Since compass is not used in Stratux, MPU6050 should work just as well (not tested).

## PCB
For connecting the peripherlas (two SDRs, a GPS, fan, and GY-91 AHRS board) I designed a PCB to connect to the pinheader. The smallest SMD components are 0805, still solderable by hand. Make sure to cut the pins of the USB-plugs as short as possible (after soldering) to prevent them from touching the NanoPi Air. Use the PCB spacers for correct distance between NanoPi Air and PCB.

## Case
The case can be 3D-printed. With the fan it provides sifficient cooling for the NanoPi Air and the SDRs. With the suction cup you can fix it to a window. Make sure to print it with white ABS oder PETG filament since it might get hot in direct sunlight. PLA will get soft if you leave it in the sun behind the window (aks me how i know...).

# Shopping list
These are the components you need: TBA
- NanoPi Neo Air (https://amzn.to/3KQvrtV)
- SDRs (https://amzn.to/3qOO4Ye)
- GPS Module
- 30x30x7mm Fan (https://amzn.to/45lR8dI)
- GY-91 (https://amzn.to/3sjisum)
- PCB
- PCB components ([PCB/Partlist PCB.csv](https://github.com/sternflyer/stratux-NPNA/blob/main/PCB/Partlist%20PCB.csv))
- PETG or ABS for the case (https://amzn.to/3P5NSgH)
- Suction cup (https://amzn.to/3E7OOLq)

# NanoPi Neo Air vs. Raspberry Pi 3B+
Here is a small comparison of the NanoPi Neo Air and the Raspberry Pi 3B+ when running Stratux. Comparison was done with two Nooelec NESDR Nano 2, a GPS (USB BL1 GPS Module at rPi 3B+, Beitian BE-252i GPS on UART at NeoPi Nano Air) and a GY-91 Module as AHRS connected. TBA

|     | raspberry Pi 3B+ | NanoPi Neo Air |
|-----|---------|----------------|
Power Consumption | 1154 mA | 985 mA |
Avg. CPU load | 61 % | 64 % |
Avg. CPU Temp. | 42 °C | 45 °C |
