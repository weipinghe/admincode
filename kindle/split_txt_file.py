# Some txt format ebooks have large size in 20--30MB.
# This program is to split a txt file into a few small files.
# Then you can read the small txt file on Kindle or open the files using Windows Notepad.
# Coding:utf-8   
# Support unicode filename and file content
# 20222-12

import io
import sys
n = len(sys.argv)
   
if n==3:
    myfilename = sys.argv[1]
    result = myfilename.rsplit('.', 1)[0]    
    lines_per_file = int(sys.argv[2])
else:
    print("python split_txt_file.py filename lines_per_file\n E.g. python split_txt_file.py aa.txt 30000")
    sys.exit()

smallfile = None
i=1

with io.open(myfilename, 'r', encoding='utf8') as largefile:
    for lineno, line in enumerate(largefile):
        if lineno % lines_per_file == 0:
            if smallfile:
                smallfile.close()
            small_filename = result +  '{num:02d}.txt'.format(num=i)
            i = i + 1
            smallfile = io.open(small_filename, "w", encoding='utf8')
        smallfile.write(line)
    if smallfile:
        smallfile.close()

print("Done")
# C:\python\python split_txt_file.py  filename lines_per_file      