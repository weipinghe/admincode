#!/usr/bin/perl
 
use Net::LDAP;
 
$ldap = Net::LDAP->new("LDAP server");
 
# an anonymous bind
#$mesg = $ldap->bind ;
 
# An admin bind
$mesg = $ldap->bind("cn=directory manager", password=>"secret");
 
$mesg = $ldap->search(filter=>"(objectclass=posixAccount)", base=>"ou=people,dc=corp,dc=mycompany,dc=com");
 
@entries = $mesg->entries;
 
foreach $entry (@entries) {
        $username = $entry->get_value(uid);
        $_  = $entry->get_value(userPassword);
        s/{crypt}//i;
        $userPassword  = $_ ;
        $uidnumber = $entry->get_value(uidNumber);
        $gidnumber = $entry->get_value(gidNumber);
        $gecos = $entry->get_value(gecos);
        $homedir = $entry->get_value(homeDirectory);
        $shell = $entry->get_value(loginShell);
 
 print "$username:$userPassword:$uidnumber:$gidnumber:$gecos:$homedir:$shell\n";
}

#bind_dn: 'cn=proxyAgent,ou=proxies,dc=corp,dc=mycompany,dc=com'
#bind_dn: 'cn=tester,ou=people,dc=corp,dc=mycompany,dc=com'
