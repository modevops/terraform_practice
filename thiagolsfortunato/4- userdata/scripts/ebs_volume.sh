#!/bin/bash

#list paths and sizes them
df -h

#format volume to .ext4
mkfs.ext4 /dev/xvdh

#create folder to mount volume
mkdir /data

#mount volume to pah
mount /dev/xvdh /data

#list paths and sizes them
df -h