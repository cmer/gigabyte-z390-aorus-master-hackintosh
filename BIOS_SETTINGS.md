# BIOS Settings & Overclocking

Here are the settings I used in my BIOS to overclock my i9 9900k to 5.1GHz. These work perfectly fine on macOS Mojave.

I set these after loading optimized defaults. I am currently using BIOS version F7.

![Geekbench](images/geekbench.png)

## M.I.T

### Advanced Frequency Settings

* CPU Clock Ratio: 51
* Extreme Memory Profile (XMP): Profile1

#### Advanced CPU Core Settings
* Uncore Ratio: 47
* Package Power Limit1 - TDP (Watts): 4090
* Package Power Limit2 (Watts): 4090
* Platform Power Limit1 (Watts): 4090
* Platform Power Limit2 (Watts): 4090
* CPU Enhanced Halt (C1E): Disabled
* C3 State Support: Disabled
* C6/C7 State Support: Disabled
* C8 State Support: Disabled
* C10 State Support: Disabled

### Advanced Memory Settings
  * Extreme Memory Profile (XMP): Profile1

### Advanced Voltage Settings

#### Advanced Power Settings
* CPU Internal AC/DC Load Line: Turbo
* CPU Vcore Loadline Calibration: Turbo
* VAXG Loadline Calibration: Turbo
* CPU Vcore Current Protection: Turbo
* VAXG Current Protection: Turbo

#### CPU Core Voltage Control
* CPU Vcore: 1.350V


## Peripherals

### Super IO Configuration

* Serial Port: Disabled

### USB Configuration

* XHCI Hand-off: Enabled

## Chipset

* Internal Graphics: Disabled

## Power

* AC BACK: Memory
