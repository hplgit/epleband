import os, shutil

output = []
file = 'songs'
formats = ['html', 'latex']
latex_formats = ['-DA4PAPER', '-DA6PAPER']
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
        cmd = 'doconce format %s %s %s' % (format, filename, prepro)
        print cmd
        os.system(cmd)  # Run command

        if format == 'latex':
            for latex_format in latex_formats:
                filename2 = filename + '_' + latex_format[2:4]
                shutil.copy(filename + '.p.tex', filename2 + '.p.tex')
                cmd = 'doconce ptex2tex %s %s' % (filename2, latex_format)
                print cmd
                os.system(cmd)
                cmd = 'latex %s; latex %s; dvipdf %s' % \
                      (filename2, filename2, filename2)
                os.system(cmd)
                output.append(' * URL: "%s.pdf"' % filename2)
        elif format == 'html':
            output.append(' * URL: "%s.html"' % filename)
print '\n'.join(output)
