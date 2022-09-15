mkdir -p ~/.vscode-server/data/Machine
cp settings.json ~/.vscode-server/data/Machine
rm -rf ~/.git
rm -rf .git

for i in lab1 lab2 lab3 lab4 lab5 lab5a lab6 lab6a lab7a
do
   cp ./intel_extra_files_2020f/$i/* $i/
done
