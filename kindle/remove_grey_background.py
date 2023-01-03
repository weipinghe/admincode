'''
C:\Anaconda3\python remove_grey_background.py 009.jpg test009.jpg

(base) C:\WINDOWS\system32> pip install opencv-python
Successfully installed opencv-python-4.7.0.68

(base) C:\WINDOWS\system32> pip install opencv-contrib-python
Successfully installed opencv-contrib-python-4.7.0.68
'''

import cv2
import numpy as np
import argparse

parser = argparse.ArgumentParser()
parser.add_argument("inputfile", help="The input scanned image file to be processed")
parser.add_argument("outputfile", help="The output image file after removing grey background and resizing")
args = parser.parse_args()

img = cv2.imread(args.inputfile, cv2.IMREAD_GRAYSCALE)

rgb_planes = cv2.split(img)
result_planes = []

for plane in rgb_planes:
    dilated_img = cv2.dilate(plane, np.ones((7,7), np.uint8))
    bg_img = cv2.medianBlur(dilated_img, 21)
    diff_img = 255 - cv2.absdiff(plane, bg_img)
    result_planes.append(diff_img)
    
result = cv2.merge(result_planes)

# resize image
scale_percent = 20 # percent of original size
width = int(img.shape[1] * scale_percent / 100)
height = int(img.shape[0] * scale_percent / 100)
dim = (width, height)

resized = cv2.resize(result, dim)
cv2.imwrite(args.outputfile, resized)
