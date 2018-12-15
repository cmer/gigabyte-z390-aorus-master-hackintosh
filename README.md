# Hackintosh Mojave Installation Guide for Gigabyte Z390 Aorus Master

This build is "Vanilla". I used [this guide](https://hackintosh.gitbook.io/-r-hackintosh-vanilla-desktop-guide/) as a starting point.

### Hardware

See my [Hardware List](HARDWARE.md)


### What's Working/What's Not

##### Working
- Ethernet
- Audio (including digital audio)
- APFS
- Sleep/Wake (a bit slow though, can take up to 15 seconds to wake up)
- All USB ports
- 
##### Not Working (yet!)
- WI-FI. This will likely never work since it is the new Intel CNVi that MacOS doesn't support.
- Quicklook/Preview (need to fix iGPU)
- iGFX HDMI output. Common problem, nobody seems to have found a solution

##### Not Yet Tested
- iMessage
- App Store
- Wake with Apple Watch
- FileVault
- USB speed (ports are working, not sure if they're at full speed)

##### What I Fixed (and how)
- Onboard Bluetooth is hit or miss. However, I disabled it because I have a natively supported Broadcom BCM94360CS2 WIFI/BT adapter.


### Step By Step Instructions

See [STEP_BY_STEP.md](STEP_BY_STEP.md)


### The Lazy Way

You are welcome to use my config.plist and kexts. However, make sure you set the following:

- SerialNumber
- BoardSerialNumber
- SmUUID
