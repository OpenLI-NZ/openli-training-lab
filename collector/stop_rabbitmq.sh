#!/bin/bash

kill -9 $(ps aux | grep '^[r]abbitmq ' | awk '{print $2}')
