#!/bin/ruby  -rubygems

require "net/ssh"
File.readlines('my20hosts.txt').each { |line|
#sshcmd = "uname -a"
#sshcmd = "sed -i 's/enforcing/disabled/g' /etc/selinux/config"
#sshcmd = "echo \"ClientAliveInterval 30\" >> /etc/ssh/sshd_config"
#sshcmd = "echo \"TCPKeepAlive yes\" >> /etc/ssh/sshd_config"
#sshcmd = "echo \"ClientAliveCountMax 99999\" >> /etc/ssh/sshd_config"
#sshcmd = "#shutdown -r now"
#sshcmd = "cd /etc/yum.repos.d; wget http://archive.cloudera.com/cm5/redhat/6/x86_64/cm/cloudera-manager.repo ; ls /etc/yum.repos.d/"
#sshcmd = "yum search cloudera-manager-daemons"
#sshcmd = "yum install -y cloudera-manager-agent cloudera-manager-daemons"
#sshcmd = "cd ; wget http://archive.cloudera.com/cm5/redhat/6/x86_64/cm/5/RPMS/x86_64/jdk-6u31-linux-amd64.rpm ; rpm -ivh jdk-6u31-linux-amd64.rpm"
#sshcmd = "cd ; wget http://archive.cloudera.com/cm5/redhat/6/x86_64/cm/5/RPMS/x86_64/oracle-j2sdk1.7-1.7.0+update55-1.x86_64.rpm ; rpm -ivh oracle-j2sdk1.7-1.7.0+update55-1.x86_64.rpm"

# change hostname
# 1. /etc/sysconfig/network
# "sed -i 's/companyprime/labs.company/g' /etc/sysconfig/network"
# 2. /etc/sysconfig/network-scripts/ifcfg-bond0
# sed -i 's/10.242.7.153/10.15.70.49/g' /etc/sysconfig/network-scripts/ifcfg-bond0
# 3. /etc/hosts
# echo "hostname" >> /tmp/myhosts.txt
#sshcmd = "echo \"#{onerow[1]}\t#{onerow[0]}.labs.company.com\">> /etc/hosts"
# 4. run hostname new
#sshcmd = "hostname #{onerow[0]}.labs.company.com"
# 5. /etc/resolv.conf
#sshcmd = "echo \"search labs.company.com corp.company.com company.com\" > /etc/resolv.conf; echo \"nameserver 10.15.70.49\">>/etc/resolv.conf; echo \"nameserver 10.15.70.56\">>/etc/resolv.conf"

# 6. /etc/sysconfig/network-scripts/ifcfg-eth*
#sshcmd = "sed -i 's/companyprime/labs.company/g' /etc/sysconfig/network-scripts/ifcfg-eth*"

begin
       line = line.chomp
       #line = machine
       #print "\n#{line}\n"
       print "\n"
       onerow=line.split("\t")
       print "Machine name: "
       # downcase
       onerow[0].downcase!
       print onerow[0]
       print " Machine IP: "
       print onerow[1]
       print "\n"
       sshcmd1 = "sed -i 's/companyprime/labs.company/g' /etc/sysconfig/network"
       sshcmd2 = "sed -i 's/10.242.7.153/10.15.70.49/g' /etc/sysconfig/network-scripts/ifcfg-bond0"
       #sshcmd3 = "echo \"#{onerow[1]}\t#{onerow[0]}.labs.company.com\">> /etc/hosts"
       sshcmd3 = "sed -i 's/companyprime/labs.company/g'  /etc/hosts"
       sshcmd4 = "hostname #{onerow[0]}.labs.company.com"
       sshcmd5 = "echo \"search labs.company.com corp.company.com company.com\" > /etc/resolv.conf; echo \"nameserver 10.15.70.49\">>/etc/resolv.conf; echo \"nameserver 10.15.70.56\">>/etc/resolv.conf"
       sshcmd6 = "sed -i 's/companyprime/labs.company/g' /etc/sysconfig/network-scripts/ifcfg-eth*"
       sshcmd7 = "uname -a"
       #print sshcmd
       print "\n"
       begin
            session = Net::SSH.start(onerow[1], 'root', :password => "password")
              getresult = session.exec!(sshcmd1)
              puts getresult
              getresult = session.exec!(sshcmd2)
              puts getresult
              getresult = session.exec!(sshcmd3)
              puts getresult
              getresult = session.exec!(sshcmd4)
              puts getresult
              getresult = session.exec!(sshcmd5)
              puts getresult
              getresult = session.exec!(sshcmd6)
              puts getresult
              getresult = session.exec!(sshcmd7)
              puts getresult
            rescue Errno::ECONNREFUSED => refused
              failed = 1
              puts "machine "+ onerow[1] + " ssh port is not open !"
	    rescue 
              puts "ERRORs!"
        end
  end
}

