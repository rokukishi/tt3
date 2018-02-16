#!/bin/bash
nome(){
clear
echo "Formulário"
read -p "Nome completo: " NOME
echo $NOME > /tt3/.info.txt
grep -i -q -E '^([a-z]){3}[a-z ]+$' /tt3/.info.txt  
case $? in
	0) f1;;
	*) echo "Nome inválido 1"; sleep 3; nome;;
esac
}
f1(){
find /tt3/.dados/"$NOME"
CONTEUDO=$?
clear
case $CONTEUDO in
	0) echo "Nome ja exitente no banco de dados"; sleep 3; nome;;
	1) echo -n "."; sleep 1; echo -n "."; sleep 1; echo -n "."; sleep 1; email;;
	*) echo "Nome inválido 2"; sleep 3; nome;;
esac
} 
email(){
clear
echo $NOME
read -p "E-mail: " EMAIL
echo $EMAIL > /tt3/.info.txt
grep -q -E '^([a-z])+([a-z0-9\._])+@([a-z])+([a-z\.])+\.com|\.com\.br|\.br$' /tt3/.info.txt
case $? in
	0) final;;
	*) echo "E-mail inválido 1"; sleep 3; email;;
	
esac
}
final(){
grep -q $EMAIL /tt3/.dados/em.txt
case $? in
	0) echo "E-mail já cadastrado no banco de dados!"; sleep 3; email;;
	1) echo -n "."; sleep 1; echo -n "."; sleep 1; echo -n "."; sleep 1; fone;;
	*) echo "E-mail inválido 2"; sleep 3; email;;
esac
}
fone(){
clear
echo $NOME
read -n2 -p"Telefone: (" DDD; read -n4 -p") " PR; read -n5 -p- SU; echo
echo "$PR-$SU" > /tt3/.info.txt
grep -q $DDD /tt3/.ddd.txt
case $? in
        0) phon;;
        *) echo "DDD Não encontrado"; sleep 3; fone;;
esac
}
phon(){
grep -q -E '^([1-9){2}([0-9]){3}-([0-9]){3,4}$' /tt3/.info.txt
case $? in
        0) echo -n "."; sleep 1; echo -n "."; sleep 1; echo -n "."; sleep 1; rg;;
        *) echo "Número inválido"; sleep 3; fone;;
esac
}
rg(){
clear
echo $NOME
read -n2 -p "Indentificação (RG): " RG; read -n3 -p "." RG1; read -n3 -p "." RG2; read -n2 -p- DG; echo
echo "$RG.$RG1.$RG2-$DG" > /tt3/.info.txt
grep -q -i -E'^([0-9]){2}((\.[0-9]){3}){2}-[a-zA-Z0-9]{2}$' /tt3/.info.txt
case $? in
        0) echo -n "."; sleep 1; echo -n "."; sleep 1; echo -n "."; sleep 1; cpf;;
        *) echo "RG inválido"; sleep 3; rg;;
esac
}
cpf(){
clear
echo $NOME
read -n3 -p "CPF: " CPF; read -n3 -p "." CPF1; read -n3 -p "." CPF2; read -n2 -p- CPFDG; echo
echo $CPF > /tt3/.info.txt
grep -q -i '[a-z]' /tt3/.info.txt
case $? in
        1) echo $CPF1 > /tt3/.info.txt; prox;;
        *) echo "CPF inválido"; sleep 3; cpf;;
esac
}
prox(){
grep -q -i '[a-z]' /tt3/.info.txt
if (( $? == 0 )); then
	echo "CPF inválido"
	sleep 3
	cpf
else
	echo $CPF2 > /tt3/.info.txt
	grep -q -i '[a-z]' /tt3/.info.txt
	case $? in
		1) echo $CPFDG > /tt3/.info.txt; cpfdigito;;
		*) echo "CPF inválido"; sleep 3; cpf;;
	esac
fi
}
cpfdigito(){
grep -q -i '[a-z]' /tt3/.info.txt
if (( $? == 0 )); then
	echo "CPF inválido"
	sleep 3
	cpf
else
	grep $CPF\.$CPF1\.$CPF2\-$CPFDG /tt3/.dados/cpfs.txt
	case $? in
		0) echo "CPF já cadastrado"; sleep 3; cpf;;
		1) echo -n "."; sleep 1; echo -n "."; sleep 1; echo -n "."; sleep 1; nasc;;
		*) echo "CPF inválido"; sleep 3; cpf;;
	esac
fi
}
nasc(){
clear
echo $NOME
read -n2 -p "Data de nascimento (DD/MM/AAAA): " DIA; read -n2 -p / MES; read -n4 -p / ANO; echo
echo $MES > /tt3/.info.txt
grep -q -i '[a-z]' /tt3/.info.txt
if (( $? == 0 )); then
	echo "Data de nascimento inválida"
	sleep 3
	nasc
elif [ $MES == "00" ]; then
	echo "Data de nascimento inválida"
	sleep 3
	nasc
else
	case $MES in
		01) diia=31; data;;
		02) diia=28; data;;
		03) diia=31; data;;
		04) diia=30; data;;
		05) diia=31; data;;
		06) diia=30; data;;
		07) diia=31; data;;
		08) diia=31; data;;
		09) diia=30; data;;
		10) diia=31; data;;
		11) diia=30; data;;
		12) diia=31; data;;
		*) echo "Data de nascimento inválida"; sleep 3; nasc;;
	esac
fi
}
data(){
echo $DIA > /tt3/.info.txt
grep -q -i '[a-z]' /tt3/.info.txt
if (( $? == 0 )); then
	echo "Data de nascimento inválida"
	sleep 3
	nasc
elif [ $DIA == "00" ]; then
	echo "Data de nascimento inválida"
	sleep 3
	nasc
elif (( $DIA <= $diia )); then
		aninho
else
	echo "Data de nascimento inválida"
	sleep 3
	nasc
fi
}
aninho(){
echo $ANO > /tt3/.info.txt
grep '[a-z]' /tt3/.info.txt
if (( $? == 0 )); then
	echo "Data de nascimento inválida"
	sleep 3
	nasc
elif [ $ANO == "0000" ]; then
	echo "Data de nascimento inválida"
	sleep 3
	nasc
elif (( $ANO <= 2018)); then
	echo -n "."; sleep 1; echo -n "."; sleep 1; echo -n "."; sleep 1
	ip
else 
	echo "Data de nascimento inválida"
	sleep 3
	nasc
fi
}
ip(){
clear
echo $NOME
read -p "IP: " -d'.' IP; read -p "" -d'.' IP1; read -p "" -d'.' IP2; read -n3 -p "" IP3
echo $IP > /tt3/.info.txt
grep -q -i '[a-z]' /tt3/.info.txt
if (( $? == 0 )); then
	echo
	echo "IP inválido! "
	sleep 3
	ip
elif (( $IP <= 255 )); then
	case $IP in
	0) echo; echo "IP inválido!"; sleep 3; ip;;
	*) wile;;
	esac
else
	echo
	echo "IP inválido!"
	sleep 3
	ip
fi
}
wile(){
JOC=255
while (( $IP != $JOC )); do
	let JOC=($JOC-1)
done
ip1
}
ip1(){
echo $IP1 > /tt3/.info.txt
grep -q -i '[a-z]' /tt3/.info.txt
if (( $? == 0 )); then
	echo
	echo "IP inválido!"
	sleep 3
	ip
elif (( $IP1 <= 255 )); then
	wile1
else
	echo
	echo "IP inválido!"
	sleep 3
	ip
fi
}
wile1(){
JOC=255
while (( $IP2 != $JOC )); do
	let JOC=($JOC-1)
done
ip2
}
ip2(){
echo $IP2 > /tt3/.info.txt
grep -q -i '[a-z]' /tt3/.info.txt
if (( $? == 0 )); then
	echo
	echo "IP inválido!"
	sleep 3
	ip
elif (( $IP2 <= 255 )); then
	wile2

else
	echo
	echo "IP inválido!"
	sleep 3
	ip
fi
}
wile2(){
JOC=255
while (( $IP2 != $JOC )); do
	let JOC=($JOC-1)
done
ip3
}
ip3(){
echo $IP3 > /tt3/.info.txt
grep -q -i '[a-z]' /tt3/.info.txt
if (( $? == 0 )); then
	echo
	echo "IP inválido!"
	sleep 3
	ip
elif (( $IP3 <= 255 )); then
wile3
else
	echo
	echo "IP inválido!"
	sleep 3
	ip
fi
}
wile3(){
JOC=255
while (( $IP3 != $JOC )); do
	let JOC=($JOC-1)
done
echo -n "."; sleep 1; echo -n "."; sleep 1; echo -n "."; sleep 1
mask
}
mask(){
clear
echo $NOME
read -p "Máscara: " -d'.' MASK; read -p "" -d'.' MASK1; read -p "" -d'.' MASK2; read -n3 -p "" MASK3
echo $MASK > /tt3/.info.txt
grep -q -i '[a-z]' /tt3/.info.txt
if (( $? == 0 )); then
	echo
	echo "Máscara inválida"
	sleep 3
	mask
else
	case $MASK in
		"255") mask1;;
		"254") outros;;
		"252") outros;;
		"248") outros;;
		"240") outros;; 
		"224") outros;;
		"192") outros;;
		"128") outros;;
		*) echo; echo "Máscara inválida"; sleep 3; mask;;
	esac
fi
}
mask1(){
echo $MASK1 > /tt3/.info.txt
grep -q -i '[a-z]' /tt3/.info.txt
if (( $? == 0 )); then
	echo
	echo "Máscara inválida"
	sleep 3
	mask
else
	case $MASK1 in
		"255") mask2;;
		"254") outros1;;
		"252") outros1;;
		"248") outros1;;
		"240") outros1;;
		"224") outros1;;
		"192") outros1;;
		"128") outros1;;
		"0") outros1;;
		*) echo; echo "Máscara inválida"; sleep 3; mask;;
	esac
fi
}
mask2(){
echo $MASK2 > /tt3/.info.txt
grep -q -i '[a-z]' /tt3/.info.txt
if (( $? == 0 )); then
	echo
	echo "Máscara inválida"
	sleep 3
	mask
else
	case $MASK2 in
		"255") mask3;;
		"254") outros2;;
		"252") outros2;;
		"248") outros2;;
		"240") outros2;;
		"224") outros2;;
		"192") outros2;;
		"128") outros2;;
		"0") outros2;;
		*) echo; echo "Máscara inválida"; sleep 3; mask;;
	esac
fi
}
mask3(){
echo $MASK3 > /tt3/.info.txt
grep -q -i '[a-z]' /tt3/.info.txt
if (( $? == 0 )); then
	echo
	echo "Máscara inválida"
	sleep 3
	mask
else
	case $MASK3 in
		"255") echo; echo "Máscara inválida"; sleep 1; echo "Máscara de loopback"; sleep 2; mask;;
		"254") game;;
		"252") game;;
		"248") game;;
		"240") game;;
		"224") game;;
		"192") game;;
		"128") game;;
		"0") game;;
		*) echo; echo "Máscara inválida"; sleep 3; mask;;
	esac
fi
}
outros(){
if (( $MASK1 == 0 )); then
	if (( $MASK2 == 0 )); then
		if (( $MASK3 == 0 )); then
			echo -n "."
			sleep 1
			echo -n "."
			sleep 1
			echo -n "."
			sleep 1
			game
		else
			echo
			echo "Máscara inválida"
			sleep 3
			mask
		fi
	else
		echo
		echo "Máscara inválida"
		sleep 3
		mask
	fi
else
	echo
	echo "Máscara inválida"
	sleep 3
	mask
fi
}
outros1(){
if (( $MASK2 == 0 )); then
	if (( $MASK3 == 0 )); then
		echo -n "."
		sleep 1
		echo -n "."
		sleep 1
		echo -n "."
		sleep 1
		game
	else
		echo
		echo "Máscara inválida"
		sleep 3
		mask
	fi
else
	echo
	echo "Máscara inválida"
	sleep 3
	mask
fi
}
outros2(){
if (( $MASK3 == 0 )); then
	echo -n "."
	sleep 1
	echo -n "."
	sleep 1
	echo -n "."
	sleep 1
	game
else
	echo
	echo "Máscara inválida"
	sleep 3
	mask
fi
}
game(){
echo "Nome: $NOME" > /tt3/.dados/"$NOME"
echo $EMAIL >> /tt3/.dados/em.txt
echo "E-mail: $EMAIL" >> /tt3/.dados/"$NOME"
echo "Telefone: ($DDD)$PR-$SU" >> /tt3/.dados/"$NOME"
echo "RG: $RG.$RG1.$RG2-$DG" >> /tt3/.dados/"$NOME"
echo "CPF: $CPF.$CPF1.$CPF2-$CPFDG" >> /tt3/.dados/"$NOME"
echo "$CPF.$CPF1.$CPF2-$CPFDG" >> /tt3/.dados/cpfs.txt
echo "Data de nascimento: $DIA/$MES/$ANO" >> /tt3/.dados/"$NOME"
echo "IP: $IP.$IP1.$IP2.$IP3" >> /tt3/.dados/"$NOME"
echo "Máscara: $MASK.$MASK1.$MASK2.$MASK3" >> /tt3/.dados/"$NOME"
echo "CADASTRA EFETUADO COM SUCESSO"
sleep 2
echo "Programa finalizando em 3 segundos"
echo -n "3 "; sleep 1; echo -n "2 "; sleep 1; echo -n "1"; sleep 1; echo
exit 0
}
nome
