# Hackintosh Mojave Installation Guide for Gigabyte Z390 Aorus Master

This build is "Vanilla". I used [this guide](https://hackintosh.gitbook.io/-r-hackintosh-vanilla-desktop-guide/) as a starting point.

### Hardware

See my [Hardware List](HARDWARE.md)


### What's Working/What's Not

##### Working
- Ethernet
- Audio (including digital audio)
- APFS
- Sleep/Wake (USB devices sometimes get ejected when waking from deep sleep)
- Headless iGPU with native support for Quicklook and Preview
- All USB ports
- iMessage
- App Store
- Facetime
- APFS
- Handoff (iOS to Mac)
- Bluetooth & Wi-Fi (via Broadcom adapter)
- Unlock with Apple Watch
- Airdrop (Mac to Mac and iOS to Mac)
- AirPlay
- Continuity
- Apple Music (iTunes)
- Power Nap


##### Not Working
- iGFX HDMI output. Common problem, nobody seems to have found a solution. But I don't need it.
- Built-in wifi. This will likely never work since it is the new Intel CNVi that MacOS doesn't support.
- Onboard Bluetooth is hit or miss. However, I disabled it (HS14) because I have a natively supported Broadcom BCM94360CS2 WIFI/BT adapter.
- Netflix DRM in Safari (works in Chrome)
- DRM-protected video in iTunes (ie: purchased TV shows)


##### Not Yet Tested
- FileVault
- All USB ports are working, but I haven't tested their speed.
- Thunderbolt Hot Swap


### Step By Step Instructions

See [STEP_BY_STEP.md](STEP_BY_STEP.md)


### The Lazy Way

You are welcome to use my config.plist and kexts. However, make sure you set the following:

- SerialNumber
- BoardSerialNumber
- SmUUID
