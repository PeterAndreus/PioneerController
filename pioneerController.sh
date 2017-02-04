#!/bin/bash
IP=192.168.1.106
PORT=23

sendCommand(){
	printf '%s\r\n' $1 | nc $IP $PORT
}

volumeDown(){
	sendCommand 'vd'
}

volumeUp(){
	sendCommand 'vu'	
}

powerOff(){
	sendCommand 'pf'
}

powerOn(){	
	sendCommand 'po'
}

mute(){
	sendCommand 'mz'
}

setBD(){
	sendCommand '25fn'
}

setPC(){
	sendCommand '23fn'
}

setSAT(){
	sendCommand '06fn'
}

sleepCmd(){
	sendCommand "$1sab"
}

manualCommand(){
	clear
	echo -n "Enter command: "
	read CMD
	sendCommand "$CMD"
}

sleepFunc(){
clear
echo "1: 30 Min			2: 60 Min"
echo "3: 90 Min			0: Off"

echo -n "Press any key to continue: "
read -n1 CMD

case $CMD in
	1) sleepCmd 030 ;;
	2) sleepCmd 060 ;;
	3) sleepCmd 090 ;;
	0) sleepCmd 000 ;;
esac
mainFunction
}

customVolume(){
	echo 
	echo  "-80.0 dB                                -50.0 dB                                +12.0 dB"
	echo  "----------------------------------------------------------------------------------------"
	echo  "000                                       061                                        185"
	echo  
	echo -n "Enter volume: "
	read VOL
	while [ $(echo -n $VOL | wc -m) -lt "3" ] 
	do
		VOL="0$VOL"
	done

	CMD=$VOL"VL"
	sendCommand "$CMD"
}

mainFunction(){
clear
echo "     ____  _                           "
echo "    / __ \\(_)___  ____  ___  ___  _____"
echo "   / /_/ / / __ \\/ __ \\/ _ \\/ _ \\/ ___/"
echo "  / ____/ / /_/ / / / /  __/  __/ /    "
echo " /_/   /_/\\____/_/ /_/\\___/\\___/_/     "

echo "L: Volume Up			K: Volume Down"
echo "V: Volume 			M: Mute"
echo "I: Power On			O: Power Down"
echo "S: Sleep"
echo ""
echo "1: PS4	2: PC	3: SAT"
echo ""
echo "W: Manual Command"

echo -n "Press any key to continue: "
read -n1 CMD

case $CMD in
	[lL]) volumeUp ;;
	[kK]) volumeDown ;;
	[oO]) powerOff ;;
	[iI]) powerOn ;;
	[mM]) mute ;;
	[sS]) sleepFunc ;;
	[qQ]) clear; exit;;
	[vV]) customVolume ;;
	[wW]) manualCommand ;;
	1) setBD ;;
	2) setPC ;;
	3) setSAT ;;
esac
mainFunction
}

mainFunction
