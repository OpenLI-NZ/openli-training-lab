#!/bin/bash

kill -INT $(ps aux | grep '[/]usr/bin/openlimediator' | awk '{print $2}')
