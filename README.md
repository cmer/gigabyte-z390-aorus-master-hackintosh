# Hackintosh Installation Guide for Gigabyte Z390 Aorus Master

## My Hardware
- Gigabyte Z390 Aorus Master
- Intel Core i3-8100 (will upgrade to i9-9900k)
- 1 x Samsung 970 EVO NVMe M.2 250GB
- 1 x Sapphire Nitro+ RX580 8GB (primary)
- 1 x Sapphire Nitro+ RX570 4GB (secondary)
- 1 x Broadcom BCM94360CS2 PCIe card

## What's Working/What's Not

#### Working
- Ethernet
- Audio
- APFS
- Sleep/Wake (a bit slow though, can take up to 15 seconds to wake up)

#### Not Working (yet!)
- Bluetooth (built-in) -- Wasn't able to pair devices although I can see them listed.

#### Not Yet Tested
- iMessage
- App Store
- Wake with Apple Watch
- Wi-Fi (waiting for BCM94360CS2 card delivery)
- FileVault
- USB headers
- Digital Audio out
- iGFX output post-install
- USB speed (ports are working, not sure if they're at full speed)

#### What I Fixed
- Occasional Kernel Panic on shutdown/reboot → Faking NVRAM with EmuVariableUefi-64.efi solved it. It can be removed when native NVRAM support is added for Z390 boards.


## BIOS Settings

### Before you begin...

Make sure to update your BIOS to the latest version. As of November 25, 2018, F6 is the latest version.

#### Save & Exit
-  *Load Optimized Defaults*

#### BIOS
-  Fast Boot: *Disabled*
-  Windows 8/10 Features: *Other OS*
-  CSM Support: *Disabled*
-  LAN PXE Boot Option ROM: *Disabled*
-  Storage Boot Option Control: *UEFI*

#### Peripherals
- Trusted Computing → Security Device Support: *Disabled*
- USB Configuration → Legacy USB Support *Enabled*
- USB Configuration → XHCI Hand-off: *Enabled*
- Network Stack Configuration → Network Stack: *Disabled*
- 
#### Chipset
- Vt-d: *Disabled*
- Above 4G Decoding: *Disabled*
- Wake on LAN: *Disabled*
- IOAPIC 24-119 Entries: *Enabled*

#### Power
- AC BACK: *Memory* (optional)

## Using my config.plist, Kexts and EFI folders

You are welcome to use my config.plist and kexts. However, make sure you set the following:

- SerialNumber
- BoardSerialNumber
- SmUUID

## Notes

- I had originally tried installing MacOS with iGFX but ran into some issues that can easily be resolved. Because of the CPU I used for installation (i3-8100), I would have needed to make some changes in in Clover. I decided to save myself the hassle and just plug in an RX5xx card instead.
- To get the onboard Realtek ALC1220-VB audio working, you MUST use the patched kext included in this repo. It is different from what you'd find widely available on the Internet. You must also inject layout id 16.
