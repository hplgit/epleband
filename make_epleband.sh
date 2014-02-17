#!/bin/sh
if [ $# -gt 0 ]; then
  year=$1
else
  year=14
fi
cd 20$year

function system {
  "$@"
  if [ $? -ne 0 ]; then
    echo "make.sh: unsuccessful command $@"
    echo "abort!"
    exit 1
  fi
}

# Extended info HTML
system doconce format html epleband${year} -DLYRICS -DTAB -DMOVIES --html_style=bloodish --encoding=utf-8
mv epleband${year}.html epleband${year}_lyrics_tab_youtube.html
system doconce split_html epleband${year}_lyrics_tab_youtube.html

system doconce format html epleband${year} -DLYRICS -DTAB -DTAB_SOLO -DMOVIES --html_style=bloodish --encoding=utf-8
if [ $? -ne 0 ]; then exit 1; fi
mv epleband${year}.html epleband${year}_lyrics_tab_youtube_solo.html
system doconce split_html epleband${year}_lyrics_tab_youtube_solo.html
system doconce format html epleband${year} -DLYRICS -DTAB -DTAB_SOLO --html_style=bloodish --encoding=utf-8
mv epleband${year}.html epleband${year}_lyrics_tab_solo.html


# Extended info HTML, one big file, tab, but no movies
system doconce format html epleband${year} -DLYRICS -DTAB --html_style=bloodish --encoding=utf-8
mv epleband${year}.html epleband${year}_lyrics_tab.html

# Extended info HTML, one big file, no movies
system doconce format html epleband${year} -DLYRICS --html_style=bloodish --encoding=utf-8
mv epleband${year}.html epleband${year}_lyrics.html

# Compact info HTML
system doconce format html epleband${year} --html_style=bloodish --encoding=utf-8

# Extended info PDF
system doconce format pdflatex epleband${year} -DLYRICS --latex_papersize=a4 --latex_font=helvetica
doconce replace '\textbf{Chords' '\vspace{0.5cm}\par\noindent\textbf{Chords' epleband${year}.p.tex
doconce replace '\section{' '\clearpage\section{' epleband${year}.p.tex
system doconce ptex2tex epleband${year}
pdflatex epleband${year}
pdflatex epleband${year}
pdflatex epleband${year}
mv epleband${year}.pdf epleband${year}_lyrics.pdf

# Compact info PDF
system doconce format pdflatex epleband${year}  --latex_papersize=a6 --latex_font=helvetica
doconce replace '\textbf{Chords' '\vspace{0.5cm}\par\noindent\textbf{Chords' epleband${year}.p.tex
system doconce ptex2tex epleband${year}
pdflatex epleband${year}
mv epleband${year}.pdf epleband${year}_mobil.pdf

# Compact info A6 PDF for mobile phone
system doconce format pdflatex epleband${year} --latex_papersize=a6 --latex_font=helvetica
doconce replace '\tableofcontents' '' epleband${year}.p.tex
system doconce ptex2tex epleband${year}
pdflatex epleband${year}

# Compact HTML
system doconce format html index --html_style=bloodish
