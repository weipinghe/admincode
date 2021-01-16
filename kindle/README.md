# How to read a book on Kindle.

## For Scanned PDF
Use Kindle DX. (change direction to read)

Step 0, Crop the blank area using Briss GUI

step 1, Rotate PDF with pdfsam GUI (anti-clockwise 90)

step 2. split one page into two pages with briss command line

Refer this link, https://www.gargan.org/en/Java/BRISS/ 
the command line to split a a4page that contains two a5 pages next to each other into one file where each page is a5.
https://sourceforge.net/p/briss/patches/2/

https://www.gargan.org/en/Java/BRISS/

Normally one pdf includes to 2 clusters (need to choose for odd and even pages)
```
java -cp "C:\Kindle\briss-0.14\*.jar" -jar "C:\Kindle\briss-0.14\briss-0.14.jar" ^
-c 0/0/0.5/0,0.5/0/0/0:0/0/0.5/0,0.5/0/0/0  ^
-s D:\tempbooks\pthon-AI-v1.pdf -d D:\tempbooks\pthon-AI-v3.pdf
```

For pdf with cover page, it will be 4 clusters.
```
java -cp "C:\Kindle\briss-0.14\*.jar" -jar "C:\Kindle\briss-0.14\briss-0.14.jar" ^
-c 0/0/0.5/0,0.5/0/0/0:0/0/0.5/0,0.5/0/0/0:0/0/0.5/0,0.5/0/0/0:0/0/0.5/0,0.5/0/0/0 ^
-s D:\tempbooks\pthon-AI-v1.pdf -d D:\tempbooks\pthon-AI-v3.pdf
```

Usage:
        briss [-s SOURCE] [-d DESTINATION] [-c CROPARGS]
CROPARGS are in the format: part1_page1,part2_page1,...!part1_page2,part2_page2
where each part consists of 4 numbers: top/left/bottom/right
You can use the GUI to get these (use File/Show Crop Command)
split an a4 page into 2 a5:
-c 0/0/0.5/0,0.5/0/0/0:0/0/0.5/0,0.5/0/0/0 


setp 3, split to small files with pdfsam if the file is larger than 10MB.

Step 4. Copy to Kindle DX and start to read!

## For txt or epub

https://mirrors.dotsrc.org/pub/mirrors/exherbo/kindlegen_linux_2.6_i386_v2_9.tar.gz

https://ia801700.us.archive.org/14/items/kindlegen/kindlegen
English
kindlegen  test1.epub  -unicode -o test1.mobi

Chinese
kindlegen  test2.epub  -unicode -o test2.mobi
