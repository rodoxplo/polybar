#!/bin/sh

#uptime -p

uptime | awk -F, '{sub(".*up ",x,$1);print $1}'
