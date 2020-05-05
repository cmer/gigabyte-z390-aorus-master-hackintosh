Looking for my original Clover guide? [It's still available right here](https://github.com/cmer/gigabyte-z390-aorus-master-hackintosh/tree/96fe5217b6bfb59f9157848feac44443b87b890f).

# Hackintosh Catalina Guide for Gigabyte Z390 Aorus Master (OpenCore)

This build is "Vanilla". I used [this guide](https://dortania.github.io/OpenCore-Desktop-Guide/) as a starting point.

### Hardware

See my [Hardware List](HARDWARE.md)

![About My Mac](images/about.png)

### What's Working/What's Not

##### Working
- Ethernet
- Onboard Audio (including digital audio)
- APFS
- Sleep/Wake
- All USB ports at 3.x speed
- iMessage
- App Store
- Facetime
- APFS
- Handoff
- Bluetooth & Wi-Fi (via Broadcom adapter)
- Unlock with Apple Watch
- Airdrop
- AirPlay
- Continuity
- ALL DRMs:
  - iTunes Movies (FairPlay 1.x)
  - Netflix/Amazon Prime (FairPlay 2.x/3.x)
  - Apple TV+ (FairPlay 4.x)
- Power Nap
- NVRAM


##### Not Working (as expected)
- Built-in WIFI. This will very likely never work since it is the new Intel CNVi that macOS doesn't support.
- Onboard Bluetooth. I disabled it (HS14) because I have a natively supported Broadcom BCM94360CS2 WIFI/BT adapter anyways.


##### Not Yet Tested
- FileVault


### Step By Step Instructions

My old Clover guide used to have Step by Step instructions but I decided not to write such instructions here for two reasons: it's a pain to keep up to date, and I literally just followed the [OpenCore Desktop Guide](https://dortania.github.io/OpenCore-Desktop-Guide/). When in doubt, just look at my KEXTs, drivers and config.list for guidance.


### USB Port Map & SSDT

See [USB_MAP.md](USB_MAP.md) for a map of all the ports on the Aorus z390 Master.


### My EFI

You are welcome to use my EFI folder. However, make sure you set the following:

- SystemSerialNumber
- SystemUUID
- MLB
