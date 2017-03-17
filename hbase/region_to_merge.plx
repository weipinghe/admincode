#!/usr/bin/perl
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
# After merge, these regions will become other regions in HBase Master UI
# Only after the HBase cluster restart, these regions will go away.

use Cwd 'abs_path';

# If the module is not installed, download from http://www.cpan.org/

# Use Hortonworks Hadoop distribution
# Three inputs
# 1. $hdfs_meta will be the output of command: hadoop fs -lsr /apps/hbase/data/data 
# 2. $hbase_meta will be the output of hbase shell command: echo "scan 'hbase:meta'" | hbase shell
# 3. Size of the small regions you are looking for
# 
# To run the script
# ./region_to_merge.plx $hdfs_meta $hbase_meta 5000000000
#
# 5000000000 = 5GB
#10000000000 =10GB

# The output will be the actual commands to merge HBase region via HBase Shell.

$num_args=$#ARGV + 1;
if ($num_args !=3 ) {
  print "\nUsage: ".abs_path($0)." hdfs_meta  hbase_meta 5000000000\n";
  print "hdfs_meta will be the output of command: hadoop fs -lsr /apps/hbase/data/data\n"; 
  print "hbase_meta will be the output of hbase shell command: echo \"scan 'hbase:meta'\" | hbase shell\n";
  print "5000000000 = 5GB\n";
  exit;
}

$hdfs_meta = $ARGV[0];
$hbase_meta = $ARGV[1];
$merge_size = $ARGV[2];
$outputfile1 = "region_size_sortby_key";
$outputfile2 = "region_to_merge";
$mydate=`date +%Y%m%d`;
chomp($mydate);

# Step 1, Calculate region size.
my %hashtable1;
open(FILE1,"$hdfs_meta")||die "Cannot open $hdfs_meta ";
chomp(@List1 = <FILE1>);
foreach $line1 (@List1) {
  chomp ($line1);
  if ( ( $line1 =~ /\.regioninfo/ ) || ($line1 =~ /recovered\.edits/) )
   {}
  else {
   if ( $line1 =~ m/(\/[\w]*){7,}/ )  {
     @myarray1 = split (/\s+/, $line1);
     @curr_keys = split ('/', $myarray1[7]);
     $hashtable1{$curr_keys[7]} += $myarray1[4];
     }
  }
}  
close(FILE1); 

# Step 2, find adjacent regions for each region based on hbase_meta
# grep -C4 region hbase_meta | grep STARTKEY

my %mymergedregion;
 
foreach my $key ( sort keys(%hashtable1) )
{
   $leftregion="";
   $rightregion="";
   if ( ($key =~ /^\./) || ($hashtable1{$key} > $merge_size) ) {}
   else {
	   @rawoutputs = qx(grep -C4 $key $hbase_meta | grep STARTKEY | grep -v $key);
	   foreach $rawstring (@rawoutputs) {
	   	@items = split / /,$rawstring;
	   	@regionstring = split /\./, $items[1];
	   	if($leftregion){
	   		$rightregion = $regionstring[1];
	   	}
	   	else {
	   		$leftregion = $regionstring[1];
	   	}
	   }
	   if ($leftregion) {
	   	$mergeregion = $leftregion;
	   	# Merge with smaller region
	   	if ($hashtable1{$leftregion} > $hashtable1{$rightregion} ) {
	   		$mergeregion = $rightregion;
	   	}
	   	if ($mymergedregion{$key}) {
	   		print "\# Region $key is already merged.\n";
	   	}
	   	else {
	   		printf "\# $key : %.2fMB\n", $hashtable1{$key}/1000000;
	   		print "\# is merging with\n";
	   		printf "\# $mergeregion : %.2fMB\n", $hashtable1{$mergeregion}/1000000;
	   		print "echo \"merge_region \'$key\', \'$mergeregion\'\" |hbase shell>>/var/tmp/hbasemerge-$mydate.out\n";
	   		print "echo -e \"\\n\">>/var/tmp/hbasemerge-$mydate.out\n";
	   		$mymergedregion{$key} = 1;
	   		$mymergedregion{$mergeregion} = 1;
	   	}
	   }
	   print  "\n\n";     
   }
} 
print "\# Written by Weiping He\n";
 



