---
title: "Google Glass Lifestream"
date: "2013-06-17"
---

I'm happy to announce the launch of our open source Google Glass Lifestream & Backup Tool for Mac OS X. **In order for it to work, you must first turn on debug on your Glass: Settings > Device info > Turn on debug (see notes below as to why we do this)**.

After backing up your Glass to the chosen directory, it can optionally generate a lifestream from the images taken with your Glass. Here's my latest lifestream:

![Stephen Balaban's Lifestream - Created by the Lambda Labs Glass Backup Tool for Mac OS X](./images/out.gif)

You can download the backup tool here:

[Download the Google Glass Backup Tool](https://github.com/lambdal/LambdaBackup/archive/master.zip "Google Glass Backup Tool for Mac OS X")

Simply download and run the LambdaBackup.app file.

The source is available on Github: [https://github.com/lambdal/LambdaBackup](https://github.com/lambdal/LambdaBackup "https://github.com/lambdal/LambdaBackup"). The dirty secret is that the entire app is just a shell script wrapped into a `.app` file! It's the future of Cocoa development.

Tools used:

- `Platypus` - for wrapping the shell script up as an app.
- `CocoaDialog` - bash bindings for Cocoa.
- `adb` - for moving files back and forth between the Glass without having to implement a PTP client, this is why we need the Glass to be in debug mode.
- `ImageMagick` - for creating the optional GIF lifestream at the end.
- `GNU parallel` - for downsizing the images in parallel using ImageMagick.

Enjoy!
