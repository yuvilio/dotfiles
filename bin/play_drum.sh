#!/usr/bin/env bash
ls -d -1 /home/yuvilio/.local/share/sounds/drums/*mp3 | shuf -n 1 | xargs player play
