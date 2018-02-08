#!/bin/bash
email(){
clear
echo $NOME
echo "E-mail: "
read EMAIL
echo $EMAIL > /tt3projeto/email.txt
grep -q '[A-Z]' /tt3projeto/email.txt
if [ $? = "0" ]; then
	echo "E-mail inválido"
	sleep 3
	email
else
	grep -q '^[0-9]' /tt3projeto/email.txt
	case $? in
		0) echo "E-mail inválido"; sleep 3; email;;
		1) grep -q '@' /tt3projeto/email.txt; CONTEUDO=$?; f1;;
	esac
fi	
}
f1(){
if [ $CONTEUDO == "0" ]; then
	grep -q ' ' /tt3projeto/email.txt
	case $? in
		0) echo "E-mail inválido"; sleep 3; email;;
		1) final;;
	esac
else
	echo "E-mail inválido"
	sleep 3
	email
fi
}
final(){
grep -q '\.com$' /tt3projeto/email.txt
case $? in
	0) echo "."; sleep 1; echo "."; sleep 1; echo "."; sleep 1; echo "E-mail: $EMAIL" >> /tt3projeto/.dados/$NOME; bash /tt3projeto/telefone.sh;;
	1) final2;;
esac
}
final2(){
grep -q '\.com\.br$' /tt3projeto/email.txt
case $? in
	0) echo "."; sleep 1; echo "."; sleep 1; echo "."; sleep 1; echo "E-mail: $EMAIL" >> /tt3projeto/.dados/$NOME; bash /tt3projeto/telefone.sh;;
	1) final3;;
esac
}
final3(){
grep -q '\.br$' /tt3projeto/email.txt
case $? in
	0) echo "."; sleep 1; echo "."; sleep 1; echo "."; sleep 1; echo "E-mail: $EMAIL" >> /tt3projeto/.dados/$NOME; bash /tt3projeto/telefone.sh;;
	1) echo "E-mail inválido"; sleep 3; email;;
esac
}
email
