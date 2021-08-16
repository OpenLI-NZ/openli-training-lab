#!/bin/bash

kill -9 $(ps aux | grep '[r]syslog' | awk '{print $2}')
