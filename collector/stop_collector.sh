#!/bin/bash

kill -INT $(ps aux | grep '[/]usr/bin/openlicollector' | awk '{print $2}')
