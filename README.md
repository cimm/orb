# Orb

A small DIY project to build an internet connected lamp that can change colors depending the received input. Some possible use cases: weather forecast, CI monitor, air quality, etc.

## Status

This project is still under construction. In it's current state it will:

* Read the weather forecast from Yahoo! Weather for a given city and trun green when the forecast looks fair. It will turn red if it looks bad.
* Read the delay for the next given Belgian train connection and turn red when the train is delayed. It will turn green if no delays are found.
* Read your Gmail inbox and turn green when you have unread messages. It will turn red if no unread messages are found.

## Install

1. Install Ruby 1.9.2 or 1.8.7
2. Install the [Nokogiri](http://rubygems.org/gems/nokogiri) and [serialport](http://rubygems.org/gems/serialport) gems
2. Clone the repo
3. Send the Orb.pde sketch to the Arduino board
4. Wire the breadboard according to the schema below
5. Keep the USB cable connected and run the orbifier script

## Wiring schema

![Arduing and breadboard wiring schema](https://github.com/cimm/orb/raw/master/schema.png)

## Orbifier script

You can find the USB port you need in the Arduino editor, it's the same one as the one you use to upload sketches.

### Weather

Weather forecast for Brussels, Belgium:

    ./orbifier weather -p /usb/tty.usbmodem441 -c 968019

The second parameter is the Yahoo! Weather WOEID for the city you want. You can find the WOEID in the Yahoo! Weather URL, eg. [Brussels](http://weather.yahoo.com/belgium/capital-region-of-brussels/brussels-968019/).

### Delays

Belgian train delay for the next train from Leuven to Wavre:

    ./orbifier delay -p /usb/tty.usbmodem441 -o Leuven -d Wavre

The last 2 parameters are the Belgian station of origin and destionation.

### Gmail

New mails in your Gmail inbox:

    ./orbifier gmail -p /usb/tty.usbmodem441 -a example@gmail.com -s 12345

Important: the password will be visible in your shell history, know what you are doing!
