#!/bin/bash


# The NODE_PATH is a list of places Node looks in for loading modules.
# (I don't care weather this is bad practice or not, I'm doin' it, sucker!)
NEW_PATH=$(pwd)
NEW_PATH+="/app"
export NODE_PATH=$NEW_PATH

echo Starting Atomic Lacuna with NODE_PATH $NEW_PATH
~/atom-shell/atom .
