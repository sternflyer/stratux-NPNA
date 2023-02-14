# stratux-NPNA
Stratux Europe running on a NanoPi Neo Air. Probably the smallest Stratux System possible. 
Based on the wonderful work of https://github.com/b3nn0/stratux and https://github.com/VirusPilot/stratux-pi4

# Installation
- Install a fresh version or Armbian Bullseye (I used 23.02.0 with 5.15.91 kernel) on your NanoPi Neo Air. Since there is no official Armbian support for the NanoPi Neo Air, you need to compile it yourself. For compatibility reason, you need to add ```BOOTFS_TYPE="fat"``` to the NanoPi Neo Air config file before compiling Armbian.
For best performance, install Armbian to the internal eMMC of the NanoPi Neo Air.
- Boot up Armbian Bullseye and connect to your WiFi. The initial Armbian setuo script will guide you through that process.
- Download and run the Stratux NPNA setup script:
```wget https://raw.githubusercontent.com/sternflyer/stratux-NPNA/main/stratux-NPNA-setup.sh```
```chmod +x stratux-NPNA-setup.sh```
```sudo ./stratux-NPNA-setup.sh```
- Reboot when promted 
