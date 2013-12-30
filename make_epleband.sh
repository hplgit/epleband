#!/bin/sh
if [ $# -gt 0 ]; then
  year=$1
else
  year=14
fi
cd 20$year

doconce format html epleband${year} -DLYRICS -DTAB
mv epleband${year}.html epleband${year}_lyrics.html
doconce format html epleband${year}
exit

doconce format pdflatex epleband${year} -DLYRICS -DTAB
doconce ptex2tex epleband${year}  -DA4PAPER
pdflatex epleband${year}
mv epleband${year}.pdf epleband${year}_lyrics.pdf

doconce format pdflatex epleband${year}
doconce ptex2tex epleband${year}  -DA6PAPER
pdflatex epleband${year}
mv epleband${year}.pdf epleband${year}_mobil.pdf

doconce format pdflatex epleband${year}
doconce ptex2tex epleband${year}  -DA4PAPER
pdflatex epleband${year}
