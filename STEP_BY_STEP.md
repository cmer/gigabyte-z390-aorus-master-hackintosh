# Step by Step Instructions Hackintoshing

These are step by step instructions for a Vanilla install of MacOS Mojave on a Gigabyte Aorus Master Z390 with an Intel i9 9900k CPU.


## Setup UEFI/BIOS

* Load Optimized Default Settings
* Peripherals → USB Configuration → XHCI Hand-off : Enabled
* Chipset → Internal Graphics : Enabled (important for Quicklook/Preview)
    - Please note that we will be using our internal GPU in **headless** mode only and this guide assumes that. This is how an iMac18,3 (what we're basing our build on) behaves.

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


## Creating a Bootable USB Installation Drive

Follow the following instructions:

* [Building the USB Installer](https://hackintosh.gitbook.io/-r-hackintosh-vanilla-desktop-guide/building-the-usb-installer)
* [Clover Setup](https://hackintosh.gitbook.io/-r-hackintosh-vanilla-desktop-guide/clover-setup)

## Configuring Clover

You need to create your own `config.plist` file. Start with the sample file I included in `assets/coffeelake_sample_config.plist`. This file was taken from /r/hackintosh's Vanilla Guide. Its latest version can always be found [on GitHub](https://github.com/corpnewt/Hackintosh-Guide/blob/master/Configs/CoffeeLake/config.plist)

Here's a [great explanation of the Clover settings for Coffee Lake](https://hackintosh.gitbook.io/-r-hackintosh-vanilla-desktop-guide/config.plist-per-hardware/coffee-lake) if you want to better understand what's going on.

1. Open `coffeelake_sample_config.plist` with Clover Configurator (right click → Open With → Clover Configurator)
2.


 In **SMBIOS**:
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
        + `Change GFX0 to IGPU`
* In **Devices**:
    - Set `Inject` to `16`.
    - Now to enable our headless iGPU, we need to fake the device id. To do so, Click `Properties`, select `PciRoot(0x0)/Pci(0x2,0x0)`. Then, click the + button to add a property. Add the following:
        + Property Key: `device-id`
        + Property Value: `923E0000`
        + Value Type: `DATA`
* Click the Export Configuration button (bottom left), then Save As `config.plist`.
* Copy your newly generated `config.plist` to `/EFI/CLOVER/` on your bootable USB key.

## Kexts

All Kexts should be copied to `/EFI/CLOVER/kexts/Other`. Whenever copying kexts from an online source, always make sure to copy the **Release** version (as opposed to Debug) if both are included in your download.

We need a few Kexts to get our installation working as it should:

* [USBInjectAll.kext](https://bitbucket.org/RehabMan/os-x-usb-inject-all/downloads/)
    - This is necessary to exclude our onboard Bluetooth adapter (HS14).
* [IntelMausiEthernet.kext](https://bitbucket.org/RehabMan/os-x-intel-network/downloads/)
    -  This is for our onboard Bluetooth/Wifi adapter
* [Lilu.kext](https://github.com/acidanthera/Lilu/releases)
    -  Arbitrary kext and process patching on macOS
* [WhateverGreen.kext](https://github.com/acidanthera/WhateverGreen/releases)
    -  Various patches necessary for certain ATI/AMD/Intel/Nvidia GPUs
* [VirtualSMC.kext](https://github.com/acidanthera/VirtualSMC/releases)
    - Advanced Apple SMC emulator in the kernel

## Other Kexts

These are Kexts that I am not using, but that could potentially be useful for you.

* [NoVPAJpeg.kext](https://github.com/vulgo/NoVPAJpeg/releases)
    - This is a Kext you can use if you are having issues with Quicklook/Preview. iGPU is known to now work properly on Z390 boards. I was able to get my iGPU (headless) to work properly so I don't need this.


## Fixing Kernel Panics at Reboot/Shutdown

Because NVRAM is not natively working on my motherboard, we have to use the UEFI driver `EmuVariableUefi-64.efi`. You can install `EmuVariableUefi-64.efi` using Clover Configurator (Install Drivers) or with the Clover installation package (Customize → UEFI Drivers).

When I added `EmuVariableUefi-64.efi` to `/EFI/CLOVER/drivers64UEFI` , I got a crash at bootup. 

The solution to that crash is to remove `AptioMemoryFix-64.efi` and to replace it with `OsxAptioFix2Drv-free2000.efi`. You can [download it from here](https://www.dropbox.com/s/d74tdymovdxmlly/OsxAptioFix2Drv-free2000.efi?dl=0).

I am told that there are downsides (that I don't fully understand yet) to using `OsxAptioFix2Drv-free2000`, so do this at your own risk.

I will update this guide when I learn more about all this. Hopefully we can run without these alternative UEFI drivers in the future.



## Credit where credit is due

* [/r/hackintosh's awesome Vanilla Install guide](https://hackintosh.gitbook.io/-r-hackintosh-vanilla-desktop-guide/)
* MacPeet at [hackintosh-forum.de](https://www.hackintosh-forum.de) for a modified `AppleALC.kext`. (Now released as version 1.3.4)
* See [RESOURCES.md](RESOURCES.md) for other threads, sites, posts I used to get this to work.

### THIS IS WORK IN PROGRESS. I will continously update these documents as I go along.