#!/bin/bash

apt list --upgradable 2>/dev/null | grep / | awk '{print $1}' | cut -d '.' -f 1 | cut -d '/' -f 1
