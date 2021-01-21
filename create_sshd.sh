#!/bin/sh

if [ $# -lt 1 ]; 
   then 
   printf "\nNot enough arguments - You should use the following command \n\n"
   printf "./create_sshd.sh tuaccessnet@ece-000.eng.temple.edu \n\n"
   exit 0 
fi 

mkdir -p ./ssh
ssh-keygen -t rsa -b 4096 -C $1 -f ./ssh/id_rsa
cat ./ssh/id_rsa.pub | ssh $1 "mkdir -p ~/.ssh && chmod 700 ~/.ssh && cat >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys"
