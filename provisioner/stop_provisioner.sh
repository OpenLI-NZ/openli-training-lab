#!/bin/bash

kill -INT $(ps aux | grep '[/]usr/bin/openliprovisioner' | awk '{print $2}')
