# 2613_2021s
Instruction is provided at https://sites.google.com/a/temple.edu/ece2612/home/cloud9-setup

Server Address: `ece-000.eng.temple.edu`

Login to in your aws cloud 9
```
git clone -b fall2021 https://github.com/lbaitemple/ece2613
```

### step 1: check your path
```
which npm
echo $PATH
```
### step 2: add npm into your PATH
```
echo "PATH=$HOME/.c9/node/bin:\$PATH" >> ~/.bashrc
source ~/.bashrc
```
Now check if npm is in the path
```
which npm 
```

### step 3: install github fetcher
You may want to install fetcher by typing the following commands from a command terminal window
```
npm install -g github-files-fetcher
```

### step 4: download a github folder
After that, you can download the lab 2 folder by typing
```
rm -rf lab2
fetcher --url="https://github.com/lbaitemple/2613_2020f/tree/master/lab2"
```

### step 5: zip the file (for example in lab4)
```
cd lab4
zip lab4.zip run_hf.bat output_files/*.sof
```

### terminal commands
```
$ECE2612/backdoor/simulate svn_seg_decoder
$ECE2612/backdoor/synthesize lab3_top_io_wrapper
```
