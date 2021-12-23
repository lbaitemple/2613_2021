# 2613_2022s
Instruction is provided at https://sites.google.com/a/temple.edu/ece2612/home/cloud9-setup

Server Address: `ece-000.eng.temple.edu`

Login to in your aws cloud 9
```
git clone -b spring2022 https://github.com/lbaitemple/ece2613 spring202
cd spring2022
chmod +x udpateos.sh
./updateos.sh
```

### Download VScode  (https://code.visualstudio.com/Download)
#### find the following extensions
1. remote ssh
2. code runner
3. wavetrace
4. SystemVerilog - Language Support



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
