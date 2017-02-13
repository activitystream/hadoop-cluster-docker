#!/bin/bash

service ssh start 
~/start-hadoop.sh 
tail -f /usr/local/*/logs/*.out 
bash -c 'while true; do sleep 10; done'