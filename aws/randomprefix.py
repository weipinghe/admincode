#!/usr/bin/env python
# Written by Weiping He  
# 2017/09/12 
#
# AWS recommend using a hexadecimal hash as the prefix for S3 better performance
# https://aws.amazon.com/blogs/aws/amazon-s3-performance-tips-tricks-seattle-hiring-event/
#
# A four character hex hash partition set in a bucket or sub-bucket namespace could theoretically 
# grow to support millions of operations per second and over a trillion unique keys.
# examplebucket/animations/232a-2013-26-05-15-00-00/cust1234234/animation1.obj 
# examplebucket/animations/7b54-2013-26-05-15-00-00/cust3857422/animation2.obj 
# examplebucket/videos/8761-2013-26-05-15-00-00/cust1248473/video3.mpg 
# examplebucket/videos/2e4f-2013-26-05-15-00-01/cust1248473/video4.mpg 
#
import random 

def randomPrefix(size=4):
	#import string
	#chars=string.ascii_lowercase + string.digits
	chars='abcdef0123456789'
	return ''.join(random.choice(chars) for _ in range(size))

print (randomPrefix())
print (randomPrefix(3))
print (randomPrefix(5))