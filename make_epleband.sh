#!/bin/sh
year=13
doconce format html epleband${year} -DLYRICS
mv epleband${year}.html epleband${year}_lyrics.html
doconce format html epleband${year}

doconce format pdflatex epleband${year} -DLYRICS
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
