#!/usr/bin/env bash
# fix time confusion caused by v2ray
# requires sudo
# thanks https://www.v2rayssr.com/vpstime.html

service ntp stop
ntpdate us.pool.ntp.org
service ntp start
