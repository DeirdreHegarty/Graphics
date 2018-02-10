#!/bin/bash

if [[ $# -lt 1 ]]; then
  echo "usage: ${0##*/} [--hd] <file>.ini"
  exit 1
fi

PS4="$(tput setaf 2)+ $(tput sgr0)"
set -eux

if [[ "$1" == '--hd' ]]; then
  Height=1080
  Width=1920
  shift
else
  Height=240
  Width=320
fi

filename=${1%%.ini}

povray "${filename}.ini" Width=${Width} Height=${Height} Antialias=On Antialias_Threshold=0.0 2> povray.out
if avconv -i "${filename}%03d.png" "${filename}.avi"; then
  rm ${filename}*.png
fi

povray "${filename}.pov" Width=1024 Height=768 Antialias=On Antialias_Threshold=0.0 2>> povray.out
