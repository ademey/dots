#!/bin/bash

if pgrep hyprsunset > /dev/null
then
  pkill hyprsunset
else
  setsid hyprsunset $@ & > /dev/null 
fi
# setsid redshift options & > /dev/null 