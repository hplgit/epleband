#!/bin/sh
doconce format html howto --no-preprocess

dest=../pub
cd example
python make.py
cp *.html *.pdf $dest
cp Johnny* $dest

