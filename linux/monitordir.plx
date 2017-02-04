#!/usr/bin/perl
# Weiping He
# Refer http://search.cpan.org/~andya/File-Monitor-1.00/lib/File/Monitor.pm
# Need to install this perl module: File::Monitor

use File::Monitor;
use File::Copy qw(move);
use Cwd 'abs_path';
use strict;
use warnings;

my $num_args=$#ARGV + 1;
if ($num_args !=2 ) {
  print "\nUsage: ".abs_path($0)." monitor_dir moved_dir\n";
  print "monitor_dir will be the directory watched for files coming in (files created)\n";
  print "moved_dir will be the directory for files moved to.\n";
  print "please make sure both directories exist.\n
  exit;
}

if (-d $ARGV[0] && -d $ARGV[1] ) {
	my $monitor = File::Monitor->new;

	$monitor->watch(
	{
	    name    => $ARGV[0],
	    recurse => 1
	}
	);

	# Yes! infinite loop.
	while ( 1 ) {
	    for my $change ( $monitor->scan ) {
		my @new_files = $change->files_created;
		    for my $file ( @new_files ) {
			print "$file coming in\n";
			system("ls -l $file");
			print "$file uploaded\n";
			move $file, "$ARGV[1]/";
			print "$file moved\n\n";
		    }
	    }
	    sleep 1;
	}
}
else{
	print "Directory $ARGV[0] or $ARGV[1] does not exist!\n";
}