echo 'umask 027'>> ~/.bash_profile
echo "export ECE2612=/data/courses/ece_2612">> ~/.bash_profile
echo 'PATH=$PATH:$ECE2612/bin'>> ~/.bash_profile

mkdir -p ~/.vscode-server/data/Machine
cp settings.json ~/.vscode-server/data/Machine
rm -rf ~/.git
rm -rf .git

for i in lab1 lab2 lab3 lab4 lab5 lab5a lab6 lab6a lab7a lab8 lab17 lab18 lab19
do
   cp ./intel_extra_files_2020f/$i/* $i/
done
