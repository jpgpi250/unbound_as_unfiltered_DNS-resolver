#!/bin/bash

redis-cli EVAL "$(cat /etc/redis/redis-idle-clean.lua)" 2 "*" 129600
redis-cli SAVE
