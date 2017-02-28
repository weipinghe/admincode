#!/usr/bin/env python
# Written by Weiping He  
# 2017/02/27 
#
# "boto" python module should be installed.
# refer http://boto.readthedocs.org/en/latest/ref/redshift.html
# This script is to save cost.
# Start a Redshift in the morning and stop it in the night.

#
import boto

#1. define the cluster name, backup file name and the elastic ip.
myidentifier='mydw'
mybackupname = 'testbackup'
myelastic_ip='192.168.149.234'

cluster_exist=0
snapshot_exist=0

#2. Connect to the cluster
conn = boto.connect_redshift()
mydict=conn.describe_clusters()

#3. Check the snapshot exist or not.
snapshotresponse = conn.describe_cluster_snapshots()
snapshots = snapshotresponse['DescribeClusterSnapshotsResponse']['DescribeClusterSnapshotsResult']['Snapshots']

for mysnapshot in snapshots:
     # print mysnapshot['SnapshotIdentifier']
     if mybackupname == mysnapshot['SnapshotIdentifier'] :
          snapshot_exist=1
          print 'Snapshot ' + mybackupname + ' exist.'


#4. start the redshift cluster from a snapshot
# restore_from_cluster_snapshot(cluster_identifier, snapshot_identifier, snapshot_cluster_identifier=None,
#  port=None, availability_zone=None, allow_version_upgrade=None, cluster_subnet_group_name=None, publicly_accessible=None,
#  owner_account=None, hsm_client_certificate_identifier=None, hsm_configuration_identifier=None, elastic_ip=None,
#  cluster_parameter_group_name=None, cluster_security_groups=None, vpc_security_group_ids=None,
#  preferred_maintenance_window=None, automated_snapshot_retention_period=None)

def start_cluster():
     global myidentifier, mybackupname, myelastic_ip, cluster_exist, snapshot_exist, conn, mydict
     try:
          # if there is no snapshot, we cannot start this redshift cluster, just exit the program.
          if snapshot_exist == 0 :
               print 'Warning! Snapshot ' + mybackupname + ' does NOT exist! Exit...'
               import sys
               sys.exit()

          myclusterresponse=mydict['DescribeClustersResponse']['DescribeClustersResult']['Clusters']
          for mycluster in myclusterresponse:
               #print mycluster['ClusterIdentifier']
               if myidentifier == mycluster['ClusterIdentifier'] :
                    cluster_exist = 1

          if cluster_exist == 1 :
               print 'The Cluster ' + myidentifier + ' is already up!'
          else:
               # comment it out for testing
               conn.restore_from_cluster_snapshot(myidentifier, mybackupname, availability_zone='us-east-1a', elastic_ip=myelastic_ip)
               print 'start Cluster ' + myidentifier
     except IndexError:
          # comment it out for testing
          conn.restore_from_cluster_snapshot(myidentifier, mybackupname, availability_zone='us-east-1a', elastic_ip=myelastic_ip)
          print 'start Cluster ' + myidentifier

#5. stop the redshift cluster. ie. delete the redshift cluster after creaing a final snapshot
# delete_cluster(cluster_identifier, skip_final_cluster_snapshot=None, final_cluster_snapshot_identifier=None)
def stop_cluster():
     global myidentifier, mybackupname, myelastic_ip, cluster_exist, snapshot_exist, conn, mydict
     try:
          # Note the case that the cluster is already stopped!
          # The lenth is zero if no redshift cluster is running.
          if len(mydict['DescribeClustersResponse']['DescribeClustersResult']['Clusters']) :
               print 'you can stop.'
               #5.1 delete the snapshot testbackup
               # What if the cluster is already in the stop state?
               # comment it out for testing
               # delete_cluster_snapshot(snapshot_identifier, snapshot_cluster_identifier=None)
               conn.delete_cluster_snapshot(mybackupname, myidentifier)
               #
               #5.2 delete cluster mydw
               # comment it out for testing
               # delete_cluster(cluster_identifier, skip_final_cluster_snapshot=None, final_cluster_snapshot_identifier=None)
               conn.delete_cluster(myidentifier, skip_final_cluster_snapshot=False, final_cluster_snapshot_identifier=mybackupname)
               print 'Please wait, take a snapshot of cluster ' + myidentifier + ' with name ' + mybackupname + ', stop/delete cluster '+ myidentifier 
          else :
               print 'The cluster is already stopped!'
     except:
          import traceback
          traceback.print_exc()
          print 'Error while deleting snapshot ' +  mybackupname + ' or the cluster ' + myidentifier


import argparse

parser = argparse.ArgumentParser(description="Start/stop the cluster")
parser.add_argument("action", choices=["start", "stop"])


# Send email
import smtplib
from email.mime.text import MIMEText

text ='cluster ' + myidentifier + ' with elastic_ip=' + myelastic_ip + ' and snapshot name ' + mybackupname
msg = MIMEText(text, 'plain')

me = 'whe@company.com'
you = 'whe@company.com'
msg['From'] = 'whe@company.com'
msg['To'] = 'whe@company.com'

# Send the message via our own SMTP server, but don't include the
# envelope header.
s = smtplib.SMTP('localhost')

args = parser.parse_args()
print args
if args.action == "start":
    start_cluster()
    msg['Subject'] = '!Start cluster ' + myidentifier + ' with elastic_ip=' + myelastic_ip
    s.sendmail(me, you, msg.as_string())
    s.quit()
if args.action == "stop":
    stop_cluster()
    msg['Subject'] = '!!Stop/delete ' + myidentifier + ' with elastic_ip=' + myelastic_ip
    s.sendmail(me, you, msg.as_string())
    s.quit()