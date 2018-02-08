#!/bin/bash
fone(){
clear
echo $NOME
echo "Telefone"
read -n2 -p"(" DDD; read -n4 -p") " PR; read -n5 -p- SU; echo
echo $PR > /tt3projeto/ddd.txt
grep -q $DDD /tt3projeto/dddbrasil.txt
case $? in
	0) phon;;
	1) echo "DDD Não encontrado"; sleep 3; fone;;
esac	
}
phon(){
grep -q -i '[a-z]' /tt3projeto/ddd.txt
case $? in
	0) echo "Número inválido"; sleep 3; fone;;
	1) grep -q '^0' /tt3projeto/ddd.txt; CONTEUDO=$?; ph;;
esac
}
ph(){
if [ $CONTEUDO == "0" ]; then
	echo "Número inválido"
	sleep 3
	fone
else	
	echo $SU > /tt3projeto/ddd.txt 
	grep -q -i '[a-z]' /tt3projeto/ddd.txt
	case $? in
		0) echo "Número inválido"; sleep 3; fone;;
		1) echo "."; sleep 1; echo "."; sleep 1; echo "."; sleep 1; echo "Telefone: ($DDD) $PR-$SU" >> /tt3projeto/.dados/$NOME; $ bash /tt3projeto/rg.sh;;
	esac
fi
}
fone
