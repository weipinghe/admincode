#!/bin/perl
# Weiping He
use ExtUtils::Installed;

my ($inst) = ExtUtils::Installed-> new();
my (@modules) = $inst-> modules();

# $] The first part of the string printed out when you say perl -v. 
# It can be used to determine at the beginning of a script whether the Perl 
# interpreter executing the script is in the right range of versions. 
# If used in a numeric context, $] returns version + patchlevel /1000.
# e.g. 5.10 is 5.010000
print "Perl Version: $]\n";

print "Perl Moduls:\n";
print "\nModuls:";
print "\t\tVersion\n";

for (my $i=0; $i<scalar(@modules); $i++) {
        my $version = $inst-> version($modules[$i]) || "???";
        print "$modules[$i]";
        if($modules[$i] =~/::/) { print "\t\t$version";}
        else       { print "\t\t$version";}
        print "\n";
}