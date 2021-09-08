#!/bin/bash
 
echo "Enter Your TUACCESSNET ID: "
read accessnetid
echo "Welcome ${accessnetid}!"



ssh-keygen -q -t rsa -b 4096 -C "${accessnetid}@ece-000.eng.temple.edu"
ssh-copy-id -f  ${accessnetid}@ece-000.eng.temple.edu


mkdir ~/environment/ece2613
echo "alias conn2613='sshfs ${accessnetid}@ece-000.eng.temple.edu:/home/${accessnetid}/ece2613 /home/ubuntu/environment/ece2613'" >> ~/.bashrc

sudo sh -c 'echo "${accessnetid}@ece-000.eng.temple.edu:/home/${accessnetid}/ece2613 /home/ubuntu/environment/ece2613  fuse.sshfs  defaults  0  0" >> /etc/fstab' 
