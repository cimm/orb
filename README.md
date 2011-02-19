# Orb

A small DIY project to build an internet connected lamp that can change colors depending the received input. Some possible use cases: weather forecast, CI monitor, air quality, etc.

## Status

This project is under construction. In it's current state it will:

* Read the weather forecast from Yahoo! Weather for a given location and light the on-board Arduino LED when the forecast looks fair. It will turn off the LED if it looks bad.
* Read the delays for a given Belgian train connection and turn the on-board Arduino LED on when the train is delayd. It will turn off the LED if no delays are found.

## Install

1. Clone the repo
2. Send the Orb.pde sketch to the Arduino board
3. Keep the USB cable connected and run the orbifier script

## Orbifier

You can find the USB port you need in the Arduino editor, it's the same one as the one you use to upload sketches.

### Weather

Weather forecast for Brussels, Belgium:

    ./orbifier weather -p /usb/tty.usbmodem441 -l 968019

The second parameter is the Yahoo! Weather WOEID for the location you want. You can find the WOEID in the Yahoo! Weather URL, eg. [Brussels](http://weather.yahoo.com/belgium/capital-region-of-brussels/brussels-968019/).

### Delays

Belgian train delays for the next train from Leuven to Tienen:

    ./orbifier delay -p /usb/tty.usbmodem441 -o Leuven -d Tienen

The last 2 parameters are the Belgian station of origin and destionation.
