#!/usr/bin/perl
# Weiping He
# 2017/7/19
#
# Sometimes the HDFS files are not closed correctly.
# We meet "Cannot obtain block length for LocatedBlock" when reading the files.
# One example is the flume log rotation.
# This script is to correct this error.

use Date::Calc qw(Today Add_DeltaDays);
use Time::Piece;

#1. Require username is flume.
$imyusername = getpwuid($<);
if($imyusername ne "flume"){
   print "User to run this script must be flume!\n";
   exit;
}

#2. (Optional) Get Kerberos ticket.
$myhostname = `hostname -f`;
$myreturncode = system("kinit -kt /etc/security/keytabs/flume.keytab flume/$myhostname\@DOMAIN.COM");

if ($myreturncode){
   print "Unable to get Kerberos Ticket, exiting...\n";
   exit;
}

$num_args = $#ARGV + 1;

#3. Get the date
if ($num_args >1) {
   print "Usage:\n";
   print "e.g. -1 means yesterday, 0 means today.";
   print "The default is -1 if no argument.";
   exit;
}

if ($num_args == 0) {
   print "Usage:\n";
   print "e.g. -1 means yesterday, 0 means today.";
   print "The default is -1 if no argument.";
   $Dd = -1;
}
else {
   $Dd = $ARGV[0];
}

$today = [Today()];
($thisyear, $thismonth, $thisday) = @today;
($year, $month, $day) = Add_Delta_Days($thisyear, $thismonth, $thisday, $Dd);
$month = sprintf "%02d", $month;
$day = sprintf "%02d", $day;

#/user/flume/20170718
$mydata = $year.$month.$day;

#4. Fine the file
#hadoop fs -ls '/user/flume/20170718/*/*.log.tmp'
@lines = qx(hadoop fs -ls '/user/flume/20170718/*/*.log.tmp' 2> /dev/null );
$loopi = 0;
foreach $line1 (@lines){
   $loopi++;
   if ($loopi % 2 == 0) {
      print "processed 10 files.\n";
      confirm();
   }
}


sub confirm(){
   print "Continue? y/n: ";
   while ( ($reply = <STDIN>) !~ /^[yn]/i ){
      print "Please answer yser or no: ";
   }
   if ( $reply =~/^y/i) {
      print "Continue! Yes!\n";
   }
   else {
      die "Exit!\n";
   }
}




