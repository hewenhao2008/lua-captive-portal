# Captive portal for WiFiDog written in LUA

## Overview
This is simple captive portal used by me in conjuction with my [AVR token generator](https://github.com/pamelus/avr-token-generator) and [WiFiDog](http://dev.wifidog.org) for [LEDE](https://lede-project.org). It provides user interface for token authentication, api for WiFiDog and controlling unit for avr-token-generator.

## Development requirements
All you need is text editor and latest docker compose. You can deploy application locally by simply:
````
docker-compose up
````

Docker container binds localhost port 80 to lua CGI application, so simply go to `http://localhost` to see portal working.

## Credits
This software internally uses:
* Latest nixio from [LuCI](https://github.com/openwrt/luci)
* [Bootstrap v4](https://v4-alpha.getbootstrap.com)
* [jQuery](https://jquery.com)
* [LUA Resty templates](https://github.com/bungle/lua-resty-template) by Aapo Talvensaari
