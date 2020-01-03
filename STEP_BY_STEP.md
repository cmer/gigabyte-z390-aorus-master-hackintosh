# Step by Step Instructions Hackintoshing

These are step by step instructions for a Vanilla install of MacOS Mojave/Catalina on a Gigabyte Aorus Master Z390 with an Intel i9 9900k CPU.

This guide assumes that you are installing Mojave 10.14.5 or over, or Catalina.


## Setup UEFI/BIOS

* Load Optimized Default Settings
* Peripherals → USB Configuration → XHCI Hand-off : Enabled
* Chipset → Internal Graphics : Enabled (important for Quicklook/Preview and hardware acceleration)
    - Please note that we will be using our internal GPU in **headless** mode only and this guide assumes that. This is how an iMac19,1 (what we're basing our build on) behaves.
    - I seriously recommend enabling the iGPU. However, if you can't boot and get the error message "Unable to allocate runtime area", you will need to disable the iGPU. Unfortunately, I had to disable it myself.
    - ~~If you opt to disable Internal Graphics with Mojave, you will need to use `NoVPAJpeg.kext` to have proper decoding. It is **not** needed under Catalina. If you have iGPU enabled in Mojave, it is not required and should not be used.~~
    - `NoVPAJpeg.kext` is now deprecated. Use the following boot args instead: `shikigva=32 shiki-id=Mac-7BA5B2D9E42DDD94`


You may want to take a look at my [BIOS Settings & Overclocking](BIOS_SETTINGS.md).

## Utilities You'll Need

These are all Mac utilities. Therefore, you need access to a real Mac.

* [Clover Installer](https://github.com/Dids/clover-builder/releases)
* [Clover Configurator](https://mackie100projects.altervista.org/download-clover-configurator/)


## Creating a Bootable USB Installation Drive

Follow the following instructions:

* [Building the USB Installer](https://hackintosh.gitbook.io/-r-hackintosh-vanilla-desktop-guide/building-the-usb-installer)
* [Clover Setup](https://hackintosh.gitbook.io/-r-hackintosh-vanilla-desktop-guide/clover-setup)

## Configuring Clover

You need to create your own `config.plist` file. Start with the sample file I included in `assets/coffeelake_sample_config.plist`. This file was taken from /r/hackintosh's Vanilla Guide. Its latest version can always be found [on GitHub](https://github.com/corpnewt/Hackintosh-Guide/blob/master/Configs/CoffeeLake/config.plist)

Here's a [great explanation of the Clover settings for Coffee Lake](https://hackintosh.gitbook.io/-r-hackintosh-vanilla-desktop-guide/config.plist-per-hardware/coffee-lake) if you want to better understand what's going on.

1. Open `coffeelake_sample_config.plist` with Clover Configurator (right click → Open With → Clover Configurator)


 In **SMBIOS**:
    - Click the button with an up/down arrow (middle right). Chose `iMac19,1`. This is important since we'll be connecting our monitor to the RX580. The HDMI port on our motherboard should NOT be used on your Hackintosh.
    - Make sure the serial number generated is an iMac (Retina 5k, 2019) by clicking `Model Lookup`.
    - Ensure that `Check Coverage` reports that the serial is **NOT** valid. You don't want to use somebody else's serial number.
    - While you're here, copy your Board Serial Number to your clipboard. You'll need it soon.
* In **Rt Variables**:
    - Paste your Board Serial Number in the `MLB` field.
    - <del>Set `CsrActiveConfig` to `0x0` which enables SIP for extra security. This should work just fine for a Vanilla Hackintosh install and is how genuine Macs ship.</del>
    - Set `CsrActiveConfig` to `0x3e7` to disable SIP. This is unfortunately required as of 10.14.5 in order to load unsigned KEXTs.
* In **Boot**:
    - Make sure you have the following Arguments:
        - `debug=0x100` -- show debug screen instead of standard kernel panic screen.
        - `keepsyms=1` -- works with debug=0x100, show symbols on debug screen.
        - `dart=0` -- disables Intel Virtual Technology.
        - `slide=0` -- kernel address management.
        - `darkwake=8` -- sleep management (IgnoreDiskIOAlways).
        - `shikigva=32` -- video decoding stuff.
        - `alcid=16` -- this enables your onboard audio. Use `-alcoff` to disable audio.
        - `-v` -- boot in verbose mode. I personally remove this after my system is stable.

* In **ACPI**:
    - Click `List of Patches` and enable the following:
        + `change SAT0 to SATA`
        + `change HECI to IMEI`
    - In the `Fixes` section, check only the following (careful, there are 2 screens). NOTE: my system works just fine without any fixes.
        + `FixRTC` -- try if your system hangs at boot time
        + `FixShutdown` -- only use if you are having shutdown issues (ie: restarts instead of shutdown)
    - In `Drop Tables`, make sure you have `DMAR` and `MATS`.

* In **Devices**:
    - In the `USB` section, check `Inject`, `FixOwnership` and `HighCurrent`.
    - In the `Audio` section, set `Inject` to `No` and uncheck `AFGLowPowerState` and `ResetHDA`.
    - If you have enabled your iGPU (otherwise not required), click `Properties`, select `PciRoot(0x0)/Pci(0x2,0x0)`. Then, click the + button to add a property.
      - Add (or update if already present):
          + Property Key: `AAPL,ig-platform-id`
          + Property Value: `0300923E` -- iGPU in compute mode
          + Value Type: `DATA`

* In **Kernel and Kext Patches**
    - Remove all patches except `AppleAHCIPort`

* Click the Export Configuration button (bottom left), then Save As `config.plist`.
* Copy your newly generated `config.plist` to `/EFI/CLOVER/` on your bootable USB key.

## Kexts

All Kexts should be copied to `/EFI/CLOVER/kexts/Other`. Whenever copying kexts from an online source, always make sure to copy the **Release** version (as opposed to Debug) if both are included in your download.

We need a few Kexts to get our installation working as it should:

* [IntelMausiEthernet.kext](https://bitbucket.org/RehabMan/os-x-intel-network/downloads/)
    -  This is for our onboard Ethernet/LAN adapter
* [Lilu.kext](https://github.com/acidanthera/Lilu/releases)
    -  Arbitrary kext and process patching on macOS
* [WhateverGreen.kext](https://github.com/acidanthera/WhateverGreen/releases)
    -  Various patches necessary for certain ATI/AMD/Intel/Nvidia GPUs
* [VirtualSMC.kext](https://github.com/acidanthera/VirtualSMC/releases)
    - Advanced Apple SMC emulator in the kernel
    - In addition to `VirtualSMC.kext`, I use `SMCProcessor.kext` (enables temperature monitoring) and `SMCSuperIO.kext` (enables fan speed reading).
* [AppleALC.kext](https://github.com/acidanthera/AppleALC/releases)
    - Enables onboard audio

## Other Potential Kexts

* [NoVPAJpeg.kext](https://github.com/vulgo/NoVPAJpeg/releases)
    - ~~Use this only if you haven't enabled your iGPU. I recommend enabling the iGPU instead of this.~~
    - ~~Note: this kext is **no longer required under Catalina**, but was required with Mojave. If you're on Catalina, do not install it.~~
    - This kext has been deprecated. Use `shikigva=32 shiki-id=Mac-7BA5B2D9E42DDD94` in your boot arguments instead.

* [USBInjectAll.kext](https://bitbucket.org/RehabMan/os-x-usb-inject-all/downloads/)
    - This is necessary to create your own USB SSDT (see below). Otherwise, do not use.


## How to fix all your USB issues.

[Here I made a quick video explaining how to generate your own USB SSDT/kext](https://youtu.be/j3V7szXZZTc). This will fix all your USB issues such as slow speed, drives getting ejected on wake, etc. You should **absolutely** either use my `USBMap.kext` file (from my EFI folder), or generate your own. My file will only work with **exactly** the same motherboard model and revision as mine. In doubt, just make your own.



## Credit where credit is due

* [/r/hackintosh's awesome Vanilla Install guide](https://hackintosh.gitbook.io/-r-hackintosh-vanilla-desktop-guide/)
* MacPeet at [hackintosh-forum.de](https://www.hackintosh-forum.de) for a modified `AppleALC.kext`. (Now released as version 1.3.4)
* See [RESOURCES.md](RESOURCES.md) for other threads, sites, posts I used to get this to work.

## Status

I consider this guide complete and finished. Many have used it successfully already. I will continously update these documents as needed.
