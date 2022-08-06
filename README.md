# Playdate SDK
## Copyright (C) Panic, Inc.

### Introduction

This archive contains the tools you need to build games for Playdate (http://play.date).

Please read the included document _Inside Playdate_ for more detailed information about the SDK and API.

### SDK Contents

INSTALL
=======

Please run ./setup.sh. It sets up a few critical features on Linux

* Sets up a udev rule to allow serial port access to non-root users
* Adds an application shortcut to /usr/local/share/applications so the Simulator is available in your desktop environment.
* Adds file icons and mimetype information to your system

bin/PlaydateSimulator
=======

The Simulator is how you run and test your Playdate application. It is also how you load your application on to the device.

bin/pdc
=======

The Playdate Compiler (pdc) compiles your Lua source files and bundles the compiled code with your art and sound assets into a bundle file called a pdx.

    ./pdc -sdkpath <path to the SDK> <input folder> <output folder>

bin/pdutil
========

pdutil can be used to send text commands to the device firmware. For example, to reboot the device into datadisk mode run

    ./pdutil <path to device serial port> datadisk

### Installation of command line tools

If you are developing from the command line, you can run directly from the SDK folder.

Building with Lua
=======

Building Lua applications requires the `pdc` compiler. Full documentation on working with Lua is in "Inside Playdate" which can be found from the Help menu in the Simulator.

Building with C
=======

Building C applications requires various developer tools including `GCC`, and `ARM GCC`.  Full documentation on working with C is in "Inside Playdate with C" which can be found the from the Help menu in the Simulator.

Examples/
=========

In the "Examples" folder you'll find source code for several sample games that illustrate Playdate best practices.

### Questions and feedback

Please contact us if you have questions or feedback about the Playdate SDK via the Playdate Developer forum at http://devforum.play.date.

Or, write to us at info@panic.com.

### Legal information

Playdate fonts are licensed to you under the https://creativecommons.org/licenses/by/4.0/[Creative Commons Attribution 4.0 International (CC BY 4.0) license.]
