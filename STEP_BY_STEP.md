# Step by Step Instructions Hackintoshing

These are step by step instructions for a Vanilla install of MacOS Mojave on a Gigabyte Aorus Master Z390 with an Intel i9 9900k CPU.


## Setup UEFI/BIOS

* Load Optimized Default Settings

That's it! I literally didn't change anything else and it just worked. However, these are settings that are generally recommended. Your mileage may vary:

* BIOS → Fast Boot : Disabled
* BIOS → LAN PXE Boot Option ROM : Disabled
* BIOS → Storage Boot Option Control : UEFI
* Peripherals → Trusted Computing → Security Device Support : Disable
* Peripherals → Network Stack Configuration → Network Stack : Disabled
* Peripherals → USB Configuration → Legacy USB Support : Auto
* Peripherals → USB Configuration → XHCI Hand-off : Enabled (Extremely important)
* Chipset → Vt-d : Disabled
* Chipset → Wake on LAN Enable : Disabled
* Chipset → IOAPIC 24-119 Entries : Enabled

## Utilities You'll Need

These are all Mac utilities. Therefore, you need access to a real Mac.

* [Clover Installer](https://github.com/Dids/clover-builder/releases)
* [Clover Configurator](https://mackie100projects.altervista.org/download-clover-configurator/)
* [IOJones](https://sourceforge.net/projects/iojones/)
* [FB-Patcher](https://www.insanelymac.com/forum/topic/335018-intel-fb-patcher-v166/)

## Creating a Bootable USB Installation Drive

Follow the following instructions:

* [Building the USB Installer](https://hackintosh.gitbook.io/-r-hackintosh-vanilla-desktop-guide/building-the-usb-installer)
* [Clover Setup](https://hackintosh.gitbook.io/-r-hackintosh-vanilla-desktop-guide/clover-setup)

## Configuring Clover

You need to create your own `config.plist` file. Start with the sample file I included in `assets/coffeelake_sample_config.plist`. This file was taken from /r/hackintosh's Vanilla Guide. Its latest version can always be found [on GitHub](https://github.com/corpnewt/Hackintosh-Guide/blob/master/Configs/CoffeeLake/config.plist)

Here's a [great explanation of the Clover settings for Coffee Lake](https://hackintosh.gitbook.io/-r-hackintosh-vanilla-desktop-guide/config.plist-per-hardware/coffee-lake) if you want to better understand what's going on.

* Open `coffeelake_sample_config.plist` with Clover Configurator (right click → Open With → Clover Configurator)
* In **SMBIOS**:
    - Click the button with an up/down arrow (middle right). Chose `iMac18,3`. This is important since we'll be connecting our monitor to the RX580. The HDMI port on our motherboard is NOT yet working for Hackintoshes.
    - Make sure the serial number generated is an iMac (mid-2017) by clicking `Model Lookup`. 
    - Ensure that `Check Coverage` reports that the serial is **NOT** valid. You don't want to use somebody else's serial number.
    - While you're here, copy your Board Serial Number to your clipboard. You'll need it soon.
* In **Rt Variables**:
    - Paste your Board Serial Number in the `MLB` field.
    - Set `CsrActiveConfig` to `0x0` which enables SIP for extra security. This should work just fine for a Vanilla Hackintosh install and is how genuine Macs ship.
* In **Boot**:
    - Change the `Custom Flags` to: `shikigva=40 uia_exclude=HS14` (this disables onboard Bluetooth since we'll be using an external Broadcom Wi-Fi/Bluetooth adapter)
* In **ACPI**:
    - Click `List of Patches` and enable the following:
        + `Change GFX0 to IGPU` -- this enables iGPU as headless for Quicklooks/Preview to work. More on this later. 
* In **Devices**:
    - Set `Inject` to `16`. This is a special id for our patched, unreleased `AppleALC.kext` file (discussed below). This makes your audio work.

* Click the Export Configuration button (bottom left), then Save As `config.plist`.
* Copy your newly generated `config.plist` to `/EFI/CLOVER/` on your bootable USB key.

## Kexts

All Kexts should be copied to `/EFI/CLOVER/kexts/Other`. Whenever copying kexts from an online source, always make sure to copy the **Release** version (as opposed to Debug) if both are included in your download.

We need a few Kexts to get our installation working as it should:

* AppleALC.kext
    - As of this writing, we need a special, unreleased, patched `AppleALC.kext` file to get onboard audio working. I recommend you simply grab the one I include in this guide. Find it at `/MY EFI/CLOVER/kexts/Other`
* [USBInjectAll.kext](https://bitbucket.org/RehabMan/os-x-usb-inject-all/downloads/)
    - This is necessary to exclude our onboard Bluetooth adapter (HS14).
* [IntelMausiEthernet.kext](https://bitbucket.org/RehabMan/os-x-intel-network/downloads/)
    -  This is for our onboard LAN adapter
* [Lilu.kext](https://github.com/acidanthera/Lilu/releases)
    -  Arbitrary kext and process patching on macOS
* [WhateverGreen.kext](https://github.com/acidanthera/WhateverGreen/releases)
    -  Various patches necessary for certain ATI/AMD/Intel/Nvidia GPUs
* [VirtualSMC.kext](https://github.com/acidanthera/VirtualSMC/releases)
    - Advanced Apple SMC emulator in the kernel
* [NoVPAJpeg.kext](https://github.com/vulgo/NoVPAJpeg/releases)
    - This is a kext we're using TEMPORARILY to get Quicklook/Preview working. iGPU is known to now work properly on Z390 boards yet. Hopefully we can remove this in the future.







## Patching Things Up (not yet working -- skip this section)

**NOTE**: I still can't get my iGPU to work in headless mode. Do not follow the instructions below.

Here we are going to enable our iGPU for good.

* Open FB-Patcher
* In the menu bar (top of the screen), File → Open → `/EFI/CLOVER/config.plist` (from your USB bootable drive)
* Click `Framebuffer` in the menu bar (at the top) and select `macOS 10.14`.

#### Enable headless iGPU

* Select `Platformid`: `0x3E920003`
* Go to `Patch` →
*  `Advanced`, click `Device ID`, then select `0x3E9B Intel UHD Graphics 630`.
*  Click `Generate Patch` # TODO: figure out why this does nothing
* File → Export → FrameBuffer Binary → /EFI/CLOVER/ACPI/patched/z390_aorus_master_igpu.aml







## Credit where credit is due

* [/r/hackintosh's awesome Vanilla Install guide](https://hackintosh.gitbook.io/-r-hackintosh-vanilla-desktop-guide/)
* See [RESOURCES.md](RESOURCES.md) for other threads, sites, posts I used to get this to work.

### THIS IS WORK IN PROGRESS. I will continously update these documents as I go along.