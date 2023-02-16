# stratux-NPNA
Stratux Europe running on a NanoPi Neo Air. Probably the smallest Stratux System possible. 
Based on the wonderful work of https://github.com/b3nn0/stratux and https://github.com/VirusPilot/stratux-pi4.

# Installation
- Install a fresh version or Armbian Bullseye (I used 23.02.0 with 5.15.91 kernel) on your NanoPi Neo Air. Since there is no official Armbian support for the NanoPi Neo Air, you need to compile it yourself. For compatibility reason, you need to add ```BOOTFS_TYPE="fat"``` to the NanoPi Neo Air config file before compiling Armbian.
For best performance, install Armbian to the internal eMMC of the NanoPi Neo Air.
- Boot up Armbian Bullseye and connect to your WiFi. The initial Armbian setuo script will guide you through that process.
- Download and run the Stratux NPNA setup script:
```
wget https://raw.githubusercontent.com/sternflyer/stratux-NPNA/main/stratux-NPNA-setup.sh
chmod +x stratux-NPNA-setup.sh
sudo ./stratux-NPNA-setup.sh
```

- Reboot when promted 

# Hardware
The NanoPi Neo Air is a very minimalistic SBC. Measuring only 40x40mm, it is probably one of the smallest SBC around. With no external connectors aside a mini USB port and a SD-Card slot. 
However, two USB-Ports, UART and I2C are available via pinheader. For detailed description see https://wiki.friendlyelec.com/wiki/index.php/NanoPi_NEO_Air.

## PCB
For connecting the peripherlas (two SDRs, a GPS and GY-91 AHRS board) I designed a PCB to connect to the pinheader.

## NanoPi Neo Air vs. Raspberry Pi 3B+
Here is a small comparison of the NanoPi Neo Air and the Raspberry Pi 3B+ when running Stratux. Comparison was done with two Nooelec NESDR Nano 2, a GPS (USB BL1 GPS Module at rPi 3B+, Ublox Neo-7 GPS on UART at NeoPi Nano Air) and a GY-91 Module as AHRS connected.

|     | raspberry Pi 3B+ | NanoPi Neo Air |
|-----|---------|----------------|
Power Consumption | 1154 mA | xxxxmA|
Boot up time | 42 s | xx s |
Avg. CPU load | 61 % | xxx |
Avg. CPU Temp. | 42 °C | xx °C |
