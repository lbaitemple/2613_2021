# 2613_2021s
Instruction is provided at https://sites.google.com/a/temple.edu/ece2612/home/cloud9-setup

Server Address: `ece-000.eng.temple.edu`

Login to in your aws cloud 9
```
git clone -b fall2021 https://github.com/lbaitemple/ece2613
```

### GTK setup
```
sudo apt update && sudo apt upgrade -y
rm -rf var/lib/dpkg/lock*
sudo dpkg --configure -a
sudo apt update && sudo apt upgrade -y
sudo apt install sshfs gtkwave -y
sudo modprobe fuse
```

Now, connect the drive
```
ssh-keygen -t rsa -b 4096 -C "lbai_student@ece-000.eng.temple.edu"
ssh-copy-id lbai_student@ece-000.eng.temple.edu
```

```
mkdir ece2613
echo "alias conn2613='sshfs lbai_student@ece-000.eng.temple.edu:/home/lbai_student/ece2613 /home/ubuntu/environment/ece2613'" >> ~/.bashrc
#sudo sh -c "lbai_student@ece-000.eng.temple.edu:/home/lbai_student/ece2613 /home/ubuntu/environment/ece2613  fuse.sshfs  defaults  0  0 >> #/etc/fstab"
#source ~/.bashrc
#cp -r ece2613/.c9/runners ~/.c9/
```

