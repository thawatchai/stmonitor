#! /usr/bin/env bash

# http://earlruby.org/2008/08/update-pidgin-status-using-cron/

/bin/bash /home/piyawat/stmonitor/export_x_info.sh
source ~/.Xdbus

DISPLAY=:0.0

source /home/piyawat/.rvm/environments/ruby-2.0.0-p247

ruby /home/piyawat/workspace/stmonitor/stmonitor.rb
