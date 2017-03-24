#!/usr/bin/perl
# Weiping He
# This is a demo to show how to access webhdfs via KNOX
# refer 
# https://svn.apache.org/repos/asf/knox/site/books/knox-0-7-0/user-guide.html#WebHDFS+Examples

print "Please enter your username:";
chop($usrename=<STDIN>);

print "Please enter your password:";
#hide the type in
system("stty -echo");
chop($password=<STDIN>);
print "\n";
system("stty echo");

$hdfsdir="/user/weiping/2017"
print "Upload to hdfs directory: $hdfsdir";

#check the hdfs directory exist?
$mycmd1 = "curl -i -k -u $usrename:$password 'https://myknoxhost:8443/gateway/default/webhdfs/v1/$hdfsdir?op=LISTSTATUS | grep HTTP";

@lines1 = qx($mycmd1);
chomp($line1 = $lines1[0]);
if ($line1 =~ m/200 OK/){
	print "HDFS directory $hdfsdir exists.\n"
}
else{
	print "HDFS directory $hdfsdir does NOT exists.\n"
	exit(1);
}

#check the hdfs file exists?
$mycmd2 = "curl -i -k -u $usrename:$password 'https://myknoxhost:8443/gateway/default/webhdfs/v1/$hdfsdir/csv-test.zip?op=LISTSTATUS | grep HTTP";
@lines2 = qx($mycmd2);
chomp($line2 = $lines2[0]);
if ($line2 =~ m/200 OK/){
	print "HDFS file csv-test.zip already exists.\n"
	exit(1);
}

print "Uploading file...\n";
# step 1, get location head.
$mycmd3 = "curl -i -k -u $usrename:$password 'https://myknoxhost:8443/gateway/default/webhdfs/v1/$hdfsdir/csv-test.zip?op=CREATE\&user.name=$usrename' | grep Location";
@lines3 = qx($mycmd3);
chomp($line3 = $lines3[0]);
@fields = split /\s/,$line3;
$locationhead = $fields[1];
# print "$locationhead";

#step 2 "upload file with location head"
$mycmd4 = "curl -i -k -u $usrename:$password -T csv-test.zip -X PUT '$locationhead'";
@lines4 = qx($mycmd4);
print "\n";
foreach $line4(@lines4){
	if ( $line4 =~ m/^Location/ ) {print "File uploaded.\n".$line4."\n"; }
}

#step 3 list the file uploaded
$mycmd5 = "curl -i -k -u $usrename:$password 'https://myknoxhost:8443/gateway/default/webhdfs/v1/$hdfsdir/csv-test.zip?op=GETFUKESTATUS'";
@lines5 = qx($mycmd5);
foreach $line5(@lines5){
	chop($line5);
	if ( $line5 =~ m/^FileStatus/ ) {print "$line5\n"; }
}
