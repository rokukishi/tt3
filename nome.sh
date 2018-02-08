#!/bin/bash
nome(){
clear
echo "Formulário"
echo "Nome: " 
read NOME
echo $NOME > /tt3projeto/nome.txt
grep -i -q '^[a-z]' /tt3projeto/nome.txt
case $? in
	0) grep -i -q '[a-z]$' /tt3projeto/nome.txt; CONTEUDO=$?; f1;;
	1) echo "Nome inválido"; sleep 3; nome;;
esac
}
f1(){
if [ $CONTEUDO == "0" ]; then
	grep -q '[0-9]' /tt3projeto/nome.txt
	case $? in
		0) echo "Nome inválido"; sleep 3; nome;;
		1) echo "."; sleep 1; echo "."; sleep 1; echo "."; sleep 1; echo "Nome: $NOME" > /tt3projeto/.dados/$NOME | email;;
	esac
else
	echo "Nome inválido"
	sleep 3
	nome
fi
}
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
        0) echo "."; sleep 1; echo "."; sleep 1; echo "."; sleep 1; echo "E-mail: $EMAIL" >> /tt3projeto/.dados/$NOME; fone;;
        1) final2;;
esac
}
final2(){
grep -q '\.com\.br$' /tt3projeto/email.txt
case $? in
        0) echo "."; sleep 1; echo "."; sleep 1; echo "."; sleep 1; echo "E-mail: $EMAIL" >> /tt3projeto/.dados/$NOME; fone;;
        1) final3;;
esac
}
final3(){
grep -q '\.br$' /tt3projeto/email.txt
case $? in
        0) echo "."; sleep 1; echo "."; sleep 1; echo "."; sleep 1; echo "E-mail: $EMAIL" >> /tt3projeto/.dados/$NOME; fone;;
        1) echo "E-mail inválido"; sleep 3; email;;
esac
}
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
                1) echo "."; sleep 1; echo "."; sleep 1; echo "."; sleep 1; echo "Telefone: ($DDD) $PR-$SU" >> /tt3projeto/.dados/$NOME; rg;;
        esac
fi
}
rg(){
echo "Deu"
#clear
#read -n2 -p "Indentificação (RG): " RG; read -n3 -p "." RG1; read -n3 -p "." RG2; read -n2 -p- DG; echo
#echo $RG > /tt3projeto/rg.txt
#grep -q -i '[a-z]' /tt3projeto/rg.txt
#case $? in
#        0) echo "RG inválido"; sleep 3; rg;;
#        1) echo $RG1 > /tt3projeto/rg.txt; ind;;
#esac
}

nome
