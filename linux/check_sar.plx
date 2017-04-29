#!/usr/bin/perl
# Weiping He
# check_sar.plx
use Cwd 'abs_path';
use List::Util qw(sum min max);

$datenow = `date +%s`;
chomp($datenow);
$mystarttime = $datenow - 7200;
$myendtime   = $datenow - 5400;

$num_args = $#ARGV + 1;
if ($num_args != 3) {
    print "\nUsage: ".abs_path($0)." hostname starttime endtime\n";
    print "\neg. ".abs_path($0)." myhost3.company.com  \"".my_e2d($mystarttime)."\" \"".my_e2d($myendtime)."\"   \n";
    # check_sar.plx myhost3.company.com  "2017-04-28 08:58:40" "2017-04-28 09:28:40"
    exit;
}

$myhostname = $ARGV[0];
$mystarttime = my_d2e ($ARGV[1]);
$myendtime   = my_d2e ($ARGV[2]);

($mystartdate, $mytime1) = split /\s/, $ARGV[1] ;
($myenddate,$mytime2) = split /\s/, $ARGV[2];
if ($mystartdate ne $myenddate)
{
  print "Stop! Only get data form the same day.\n";
  exit;
}
$sarfile = "/var/log/sa/". substr($mystartdate, 0, 4).substr($mystartdate, 5, 2) ."/sa".substr($mystartdate, -2);

#CPU info
my @mycpuarray;
$mycpucmd = "sar -u -s $mytime1 -e $mytime2 -f $sarfile 2> /dev/null| grep all | grep -v Average";

@cpulines = qx(/usr/bin/ssh -q  $myhostname $mycpucmd 2> /dev/null);
foreach $line1 (@cpulines)
{
       my @fields = split /\s/, $line1;
       push @mycpuarray, $fields[-1];
       #print "$line1";
}

print "CPU_Usage(Avg): ".array_avg(@mycpuarray)."%\n";
print "CPU_Usage (Max): ".max( @mycpuarray )."%\n";

#Memory
my @mymemarray;
$mymemcmd = "sar -r -s $mytime1 -e $mytime2 -f $sarfile 2> /dev/null |  grep -v Average | grep -v Linux | grep -v commit";

@memlines = qx(/usr/bin/ssh -q  $myhostname $mymemcmd 2> /dev/null);
foreach $line2 (@memlines)
{
     if ($line2 =~ /^ *$/ ) { }
     else {
       my @fields = split /\s+/, $line2;
       $memory_usage = ($fields[3] - $fields[6])/( $fields[2] + $fields[4]);
       $memory_usage = sprintf "%.2f", $memory_usage;
       push @mymemarray, $memory_usage;
      }
}

print "Memory_Usage(Avg): ".array_avg(@mymemarray)."% (not include the cached memory)\n";
print "Memory_Usage (Max): ".max( @mymemarray )."% (not include the cached memory)\n";


#3. Disks
#disk
my @mydiskreadc ;
my @mydiskreadd ;
my @mydiskreade ;
my @mydiskwritec ;
my @mydiskwrited ;
my @mydiskwritee ;

$mydiskcmd = "sar -p -d -s $mytime1 -e $mytime2 -f $sarfile 2> /dev/null | grep crypt | grep -v Average";

@disklines = qx(/usr/bin/ssh -q  $myhostname $mydiskcmd 2> /dev/null);
foreach $line2 (@disklines)
{
       my @fields = split /\s+/, $line2;
       if ($fields[2] =~ /xvdc1_crypt/) { push @mydiskreadc, $fields[4];  push @mydiskwritec, $fields[5]; }
       if ($fields[2] =~ /xvdd1_crypt/) { push @mydiskreadd, $fields[4];  push @mydiskwrited, $fields[5]; }
       if ($fields[2] =~ /xvde1_crypt/) { push @mydiskreade, $fields[4];  push @mydiskwritee, $fields[5]; }
}

print "Disk_C_read_Usage(Avg): ".array_avg(@mydiskreadc)." sectors per second.\n";
print "Disk_C_read_Usage(Max): ".max( @mydiskreadc )." sectors per second.\n";
print "Disk_C_write_Usage(Avg): ".array_avg(@mydiskwritec)." sectors per second.\n";
print "Disk_C_write_Usage(Max): ".max( @mydiskwritec )." sectors per second.\n";

print "Disk_D_read_Usage(Avg): ".array_avg(@mydiskreadd)." sectors per second.\n";
print "Disk_D_read_Usage(Max): ".max( @mydiskreadd )." sectors per second.\n";
print "Disk_D_write_Usage(Avg): ".array_avg(@mydiskwrited)." sectors per second.\n";
print "Disk_D_write_Usage(Max): ".max( @mydiskwrited )." sectors per second.\n";

print "Disk_E_read_Usage(Avg): ".array_avg(@mydiskreade)." sectors per second.\n";
print "Disk_E_read_Usage(Max): ".max( @mydiskreade )." sectors per second.\n";
print "Disk_E_write_Usage(Avg): ".array_avg(@mydiskwritee)." sectors per second.\n";
print "Disk_E_write_Usage(Max): ".max( @mydiskwritee )." sectors per second.\n";



sub array_avg {
    if (@_) {
    return sprintf "%.2f", sum(@_)/@_;
    }
    else {return 0;}
}

sub my_d2e{
        $datestring = shift;
        $myTS1=`date +%s -d"$datestring"`;
        chomp($myTS1);
        return($myTS1);
}

sub my_e2d{
        $datestring = shift;
        $myTS2=`date  -d '1970-01-01 UTC $datestring seconds'  +\"%Y-%m-%d %T\"`;
        chomp($myTS2);
        return($myTS2);
}