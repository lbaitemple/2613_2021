# 2613_2020f
# step 1: check your path
```
which npm
echo $PATH
```
# step 2: add npm into your PATH
```
echo "PATH=$HOME/.c9/node/bin:\$PATH" >> ~/.bashrc
source ~/.bashrc_profile
```
Now check if npm is in the path
```
which npm 
```

# step 3: install github fetcher
You may want to install fetcher by typing the following commands from a command terminal window
```
npm install -g github-files-fetcher
```

# step 4: download a github folder
After that, you can download the lab 2 folder by typing
```
rm -rf lab2
fetcher --url="https://github.com/lbaitemple/2613_2020f/tree/master/lab2"
```
