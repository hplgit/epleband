"""
Run doconce on songs.do.txt and produce
various versions in various formats.
"""
import os, shutil

output = []
file = 'songs'
formats = ['html', 'latex']
latex_formats = ['--latex_papersize=a4', '--latex_papersize=a6']
prepro_variables = ['', '-DLYRICS', '-DLYRICS -DTAB -DMOVIES']

for format in formats:
    for prepro in prepro_variables:
        if prepro == '':
            filename = file + '_compact'
        elif prepro == '-DLYRICS':
            filename = file + '_lyrics'
        else:
            filename = file
        if file != filename:
            shutil.copy(file + '.do.txt', filename + '.do.txt')
        for latex_format in latex_formats:
            cmd = 'doconce format %s %s %s %s' % \
                  (format, filename, prepro, latex_format)
            print cmd
            os.system(cmd)  # Run command

        if format == 'latex':
            filename2 = filename + '_' + latex_format[2:4]
            shutil.copy(filename + '.p.tex', filename2 + '.p.tex')
            cmd = 'doconce ptex2tex %s' % filename2
            print cmd
            os.system(cmd)
            cmd = 'pdflatex %s; pdflatex %s' % \
                  (filename2, filename2, filename2)
            os.system(cmd)
            output.append(' * URL: "%s.pdf"' % filename2)
        elif format == 'html':
            output.append(' * URL: "%s.html"' % filename)
print '\n'.join(output)
