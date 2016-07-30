#!/bin/perl
# 2016/7/29
# 
# This script is to look for small size region to merge.
# http://archive.cloudera.com/cdh5/cdh/5/hbase-0.98.1-cdh5.1.5/book/regions.arch.html#too_many_regions
# Why cannot I have too many regions?
#
# Typically you want to keep your region count low on HBase.
# Usually right around 100 regions per RegionServer has yielded the best results.
# 1. MemStore-Local Allocation Buffer (MSLAB) requires 2mb per memstore (that's 2mb per family per region). 
# 1000 regions that have 2 families each is 3.9GB of heap used, and it's not even storing data yet.
# 2. If you fill all the regions at somewhat the same rate, the global memory usage makes it that it 
# forces tiny flushes when you have too many regions which in turn generates compactions. 
# Rewriting the same data tens of times is the last thing you want. 
# An example is filling 1000 regions (with one family) equally and let's consider a 
# lower bound for global memstore usage of 5GB (the region server would have a big heap). 
# Once it reaches 5GB it will force flush the biggest region, 
# at that point they should almost all have about 5MB of data so it would flush that amount. 
# 5MB inserted later, it would flush another region that will now have a bit over 5MB of data, and so on. 
# This is currently the main limiting factor for the number of regions
# 3. The master as is is allergic to tons of regions, and will take a lot of time assigning 
# them and moving them around in batches. 
# The reason is that it's heavy on ZK usage, and it's not very async at the moment.
# 4. It is typical to have one mapper per HBase region. Thus, hosting only 5 regions per RS may 
# not be enough to get sufficient number of tasks for a mapreduce job, 
# while 1000 regions will generate far too many tasks.
# 
# Note: major compactions do NOT do region merges.
#