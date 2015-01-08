#!/bin/bash
IP=192.168.100.106
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

customVolume(){
	echo 
	echo  "-80.0 dB                                -50.0 dB                                +12.0 dB"
	echo  "----------------------------------------------------------------------------------------"
	echo  "000                                       061                                        185"
	echo  
	echo -n "Hodnota volume: "
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

echo -n "Press any key to continue: "
read -n1 CMD

case $CMD in
	[lL]) volumeUp ;;
	[kK]) volumeDown ;;
	[oO]) powerOff ;;
	[iI]) powerOn ;;
	[mM]) mute ;;
	[qQ]) clear; exit;;
	[vV]) customVolume ;;
esac
mainFunction
}

mainFunction
