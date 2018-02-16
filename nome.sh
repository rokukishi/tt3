#!/bin/bash
nome(){
clear
echo "Formulário"
read -p "Nome completo: " NOME
echo $NOME > /tt3/nome.txt
grep -i -q '^[a-z]' /tt3/nome.txt
case $? in
	0) grep -i -q '[a-z]$' /tt3/nome.txt; CONTEUDO=$?; f1;;
	1) echo "Nome inválido"; sleep 3; nome;;
esac
}
f1(){
if [ $CONTEUDO == "0" ]; then
	grep -q '[0-9]' /tt3/nome.txt
	if [ $? == "0" ]; then
		echo "Nome inválido"
		sleep 3
		nome
	else
		find /tt3/.dados/"$NOME"
		CONTEUDO=$?
		clear
		case $CONTEUDO in
			0) echo "Nome ja exitente no banco de dados"; sleep 3; nome;;
			1) echo "."; sleep 1; echo "."; sleep 1; echo "."; sleep 1; email;;
		esac
	fi
else
	echo "Nome inválido"
	sleep 3
	nome
fi
}
email(){
clear
echo $NOME
read -p "E-mail: " EMAIL
echo $EMAIL > /tt3/email.txt
grep -q '[A-Z]' /tt3/email.txt
if [ $? = "0" ]; then
        echo "E-mail inválido"
        sleep 3
        email
else
        grep -q '^[0-9]' /tt3/email.txt
        case $? in
                0) echo "E-mail inválido"; sleep 3; email;;
                1) grep -q '@' /tt3/email.txt; CONTEUDO=$?; f2;;
        esac
fi
}
f2(){
if [ $CONTEUDO == "0" ]; then
        grep -q ' ' /tt3/email.txt
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
grep -q '\.com$' /tt3/email.txt
if [ $? == "0" ]; then
	grep -q $EMAIL /tt3/em.txt
	case $? in
		0) echo "E-mail já cadastrado no banco de dados!"; sleep 3; email;;
		1) echo "."; sleep 1; echo "."; sleep 1; echo "."; sleep 1; fone;;
	esac
else
	final2
fi
}
final2(){
grep -q '\.com\.br$' /tt3/email.txt
if [ $? == "0" ]; then
	grep -q $EMAIL /tt3/em.txt
	case $? in
		0) echo "E-mail já cadastrado no banco de dados!"; sleep 3; email;;
		1) echo "."; sleep 1; echo "."; sleep 1; echo "."; sleep 1; fone;;
	esac
else
	final3
fi
}
final3(){
grep -q '\.br$' /tt3/email.txt
if [ $? == "0" ]; then
	grep -q $EMAIL /tt3/em.txt
	case $? in
		0) echo "E-mail já cadastrado no banco de dados!"; sleep 3; email;;
		1) echo "."; sleep 1; echo "."; sleep 1; echo "."; sleep 1; fone;;
	esac
else
	echo "E-mail inválido"
	sleep 3
	email
fi
}
fone(){
clear
echo $NOME
echo "Telefone"
read -n2 -p"(" DDD; read -n4 -p") " PR; read -n5 -p- SU; echo
echo $PR > /tt3/ddd.txt
grep -q $DDD /tt3/dddbrasil.txt
case $? in
        0) phon;;
        1) echo "DDD Não encontrado"; sleep 3; fone;;
esac
}
phon(){
grep -q -i '[a-z]' /tt3/ddd.txt
case $? in
        0) echo "Número inválido"; sleep 3; fone;;
        1) grep -q '^0' /tt3/ddd.txt; CONTEUDO=$?; ph;;
esac
}
ph(){
if [ $CONTEUDO == "0" ]; then
        echo "Número inválido"
        sleep 3
        fone
else
        echo $SU > /tt3/ddd.txt
        grep -q -i '[a-z]' /tt3/ddd.txt
        case $? in
                0) echo "Número inválido"; sleep 3; fone;;
                1) echo "."; sleep 1; echo "."; sleep 1; echo "."; sleep 1; rg;;
        esac
fi
}
rg(){
echo "Deu"
game
#clear
#read -n2 -p "Indentificação (RG): " RG; read -n3 -p "." RG1; read -n3 -p "." RG2; read -n2 -p- DG; echo
#echo $RG > /tt3projeto/rg.txt
#grep -q -i '[a-z]' /tt3projeto/rg.txt
#case $? in
#        0) echo "RG inválido"; sleep 3; rg;;
#        1) echo $RG1 > /tt3projeto/rg.txt; ind;;
#esac
}
game(){
echo "Nome: $NOME" > /tt3/.dados/"$NOME"
echo $EMAIL >> /tt3/em.txt
echo "E-mail: $EMAIL" >> /tt3/.dados/"$NOME"
echo "Telefone: ($DDD) $PR - $SU" >> /tt3/.dados/"$NOME"
}
nome
