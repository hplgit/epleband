#!/bin/sh
if [ $# -gt 0 ]; then
  year=$1
else
  year=14
fi
cd 20$year

# Extended info HTML
doconce format html epleband${year} -DLYRICS -DTAB -DMOVIES --html_style=bloodish --encoding=utf-8
mv epleband${year}.html epleband${year}_lyrics_tab_youtube.html
doconce split_html epleband${year}_lyrics_tab_youtube.html

# Extended info HTML, one big file, tab, but no movies
doconce format html epleband${year} -DLYRICS -DTAB --html_style=bloodish --encoding=utf-8
mv epleband${year}.html epleband${year}_lyrics_tab.html

# Extended info HTML, one big file, no movies
doconce format html epleband${year} -DLYRICS --html_style=bloodish --encoding=utf-8
mv epleband${year}.html epleband${year}_lyrics.html

# Compact info HTML
doconce format html epleband${year} --html_style=bloodish --encoding=utf-8

# Extended info PDF
doconce format pdflatex epleband${year} -DLYRICS -DTAB  # drop movies in pdf
doconce ptex2tex epleband${year}  -DA4PAPER
pdflatex epleband${year}
mv epleband${year}.pdf epleband${year}_lyrics_tab.pdf

# Compact info PDF
doconce format pdflatex epleband${year}
doconce ptex2tex epleband${year}  -DA6PAPER
pdflatex epleband${year}
mv epleband${year}.pdf epleband${year}_mobil.pdf

# Compact info A6 PDF for mobile phone
doconce format pdflatex epleband${year}
doconce ptex2tex epleband${year}  -DA4PAPER
pdflatex epleband${year}

doconce format html index --html_style=bloodish
