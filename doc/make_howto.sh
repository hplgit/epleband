#!/bin/sh
doconce format html howto --no-preprocess

python make.py
cp *.html *.pdf pub
cp Johnny* pub
