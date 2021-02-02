#!/bin/bash

wal=$(cat ~/.cache/wal/wal)
xss-lock -- i3lock -n -i $wal
