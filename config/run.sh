#!/bin/bash

service ssh start 
~/start-hadoop.sh 
bash -c 'while true; do sleep 10; done'