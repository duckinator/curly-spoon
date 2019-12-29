#!/bin/bash

PID=$(ps a | grep -i ruby | grep test.rb | cut -d ' ' -f 1)

./debug.rb $PID
