#!/bin/bash
rg(){
clear
read -n2 -p "Indentificação (RG): " RG; read -n3 -p "." RG1; read -n3 -p "." RG2; read -n2 -p- DG; echo
echo $RG > /tt3projeto/rg.txt
grep -q -i '[a-z]' /tt3projeto/rg.txt
case $? in
	0) echo "RG inválido"; sleep 3; rg;;
	1) echo $RG1 > /tt3projeto/rg.txt; ind;;
esac
}
rg

