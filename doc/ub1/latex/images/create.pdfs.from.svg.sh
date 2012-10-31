#!/bin/bash

for f in *svg; do b=$(basename $f .svg); echo $b; inkscape -D -A "$b.pdf" "$b.svg"; done
