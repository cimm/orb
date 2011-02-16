# Orb

A small DIY project to build an internet connected lamp that can change colors depending the received input. Some possible use cases: weather forecast, CI monitor, air quality, etc.

## Status

This project is under construction. In it's current state it will read the weather forecast from Yahoo! Weather for a given location and light the on-board Arduino LED when the forecast looks fair. It will turn off the LED if it looks bad.

## Install

1. Clone the repo
2. Send the Orb.pde sketch to the Arduino board
3. Keep the USB cable connected and run the listener script

## Listener

Weather forecast for Brussels, Belgium:

    ./listener -p /usb/tty.usbmodem441 -l 968019

You can find the USB port you need in the Arduino editor, it's the same one as the one you use to upload sketches. The second parameter is the Yahoo! Weather WOEID for the location you want. You can find the WOEID in the Yahoo! Weather URL, eg. [Brussels](http://weather.yahoo.com/belgium/capital-region-of-brussels/brussels-968019/).
