# 2613_2024s
Instruction is provided at https://sites.google.com/a/temple.edu/ece2612/home/cloud9-setup

# after you select the instance for cloud9, in the terminal
```
git clone -b spring24 https://github.com/lbaitemple/ece2613 
cd ece2613
cat ./setup.sh | sudo -E bash -
sudo reboot
```

Update new os file
```
cd ~/ece2613/
rm updateos.sh
wget https://raw.githubusercontent.com/lbaitemple/ece2613/spring2022/updateos.sh
chmod +x updateos.sh
./updateos.sh
```

Here are the command line equivalents for the Intel/Altera tools:

Simulation - Modelsim simulator (only the basename is used)
```
$ECE2612/backdoor/ms_simulate <Verilog file basename>
```
Example from lab3: 
```
$ECE2612/backdoor/ms_simulate svn_seg_decoder
```

Synthesis (use the top_io_wrapper basename)
```
$ECE2612/backdoor/q_synthesize <top wrapper basename>
```
Example from lab3: 
```
$ECE2612/backdoor/q_synthesize lab3_top_io_wrapper
```
