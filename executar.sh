#!/bin/bash
nome(){
clear
echo "Formulário"
read -p "Nome completo: " NOME
echo $NOME > /tt3/.info.txt
grep -i -q '^[a-z]' /tt3/.info.txt
case $? in
	0) grep -i -q '[a-z]$' /tt3/.info.txt; CONTEUDO=$?; f1;;
	*) echo "Nome inválido"; sleep 3; nome;;
esac
}
f1(){
if (( $CONTEUDO == 0 )); then
	grep -q '[0-9]' /tt3/.info.txt
	if (( $? == 0 )); then
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
			*) echo "Nome inválido"; sleep 3; nome;;
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
echo $EMAIL > /tt3/.info.txt
grep -q '[A-Z]' /tt3/.info.txt
if (( $? == 0 )); then
        echo "E-mail inválido"
        sleep 3
        email
else
        grep -q '^[0-9]' /tt3/.info.txt
        case $? in
                0) echo "E-mail inválido"; sleep 3; email;;
                1) grep -q '@' /tt3/.info.txt; CONTEUDO=$?; f2;;
		*) echo "E-mail inválido"; sleep 3; email;;
        esac
fi
}
f2(){
if (( $CONTEUDO == 0 )); then
        grep -q ' ' /tt3/.info.txt
        case $? in
                1) final;;
                *) echo "E-mail inválido"; sleep 3; email;;
        esac
else
        echo "E-mail inválido"
        sleep 3
        email
fi
}
final(){
grep -q '\.com$' /tt3/.info.txt
if (( $? == 0 )); then
	grep -q $EMAIL /tt3/.dados/em.txt
	case $? in
		0) echo "E-mail já cadastrado no banco de dados!"; sleep 3; email;;
		1) echo "."; sleep 1; echo "."; sleep 1; echo "."; sleep 1; fone;;
		*) echo "E-mail inválido"; sleep 3; email;;
	esac
else
	final2
fi
}
final2(){
grep -q '\.com\.br$' /tt3/.info.txt
if (( $? == 0 )); then
	grep -q $EMAIL /tt3/.dados/em.txt
	case $? in
		0) echo "E-mail já cadastrado no banco de dados!"; sleep 3; email;;
		1) echo "."; sleep 1; echo "."; sleep 1; echo "."; sleep 1; fone;;
		*) echo "E-mail inválido"; sleep 3; email;;
	esac
else
	final3
fi
}
final3(){
grep -q '\.br$' /tt3/.info.txt
if (( $? == 0 )); then
	grep -q $EMAIL /tt3/.dados/em.txt
	case $? in
		0) echo "E-mail já cadastrado no banco de dados!"; sleep 3; email;;
		1) echo "."; sleep 1; echo "."; sleep 1; echo "."; sleep 1; fone;;
		*) echo "E-mail inválido"; sleep 3; email;;
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
read -n2 -p"Telefone: (" DDD; read -n4 -p") " PR; read -n5 -p- SU; echo
echo $PR > /tt3/.info.txt
grep -q $DDD /tt3/.ddd.txt
case $? in
        0) phon;;
        *) echo "DDD Não encontrado"; sleep 3; fone;;
esac
}
phon(){
grep -q -i '[a-z]' /tt3/.info.txt
case $? in
        1) grep -q '^0' /tt3/.info.txt; CONTEUDO=$?; ph;;
        *) echo "Número inválido"; sleep 3; fone;;
esac
}
ph(){
if (( $CONTEUDO == 0 )); then
        echo "Número inválido"
        sleep 3
        fone
else
        echo $SU > /tt3/.info.txt
        grep -q -i '[a-z]' /tt3/.info.txt
        case $? in
                1) echo "."; sleep 1; echo "."; sleep 1; echo "."; sleep 1; rg;;
                *) echo "Número inválido"; sleep 3; fone;;
        esac
fi
}
rg(){
clear
echo $NOME
read -n2 -p "Indentificação (RG): " RG; read -n3 -p "." RG1; read -n3 -p "." RG2; read -n2 -p- DG; echo
echo $RG > /tt3/.info.txt
grep -q -i '[a-z]' /tt3/.info.txt
case $? in
        1) echo $RG1 > /tt3/.info.txt; ind;;
        *) echo "RG inválido"; sleep 3; rg;;
esac
}
ind(){
grep -q -i '[a-z]' /tt3/.info.txt
if (( $? == 0 )); then
	echo "RG inválido"
	sleep 3
	rg
else
	echo $RG2 > /tt3/.info.txt
	grep -q -i '[a-z]' /tt3/.info.txt
	case $? in
		1) echo $DG > /tt3/.info.txt; digito;;
		*) echo "RG inválido"; sleep 3; rg;;
	esac
fi
}
digito(){
grep -q -i '[a-z]' /tt3/.info.txt
if [ $? == "0" ]; then
	echo "RG inválido"
	sleep 3
	rg
else
	echo "."
	sleep 1
	echo "."
	sleep 1
	echo "."
	sleep 1
	cpf
fi
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
		1) echo "."; sleep 1; echo ".";	sleep 1; echo "."; sleep 1; nasc;;
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
else
	if [ $DIA == "00" ]; then
		echo "Data de nascimento inválida"
		sleep 3
		nasc
	elif (( $DIA <= $diia )); then
		aninho
	fi
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
	echo "."
	sleep 1
	echo "."
	sleep 1
	echo "."
	sleep 1
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
#ip address | grep -i 'link/ether' -A2
read -p "IP: " -d'.' IP; read -p "" -d'.' IP1; read -p "" -d'.' IP2; read -n3 -p "" IP3; echo
echo $IP > /tt3/.info.txt
grep -q -i '[a-z]' /tt3/.info.txt
if (( $? == 0 )); then
	echo "IP inválido! "
	sleep 3
	ip
elif (( $IP <= 255 )); then
	case $IP in
	0) echo "IP inválido!"; sleep 3; ip;;
	*) wile;;
	esac
else
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
	echo "IP inválido!"
	sleep 3
	ip
elif (( $IP1 <= 255 )); then
	wile1
else
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
	echo "IP inválido!"
	sleep 3
	ip
elif (( $IP2 <= 255 )); then
	wile2

else
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
	echo "IP inválido!"
	sleep 3
	ip
elif (( $IP3 <= 255 )); then
wile3
else
	echo "IP inválido! 12"
	sleep 3
	ip
fi
}
wile3(){
JOC=255
while (( $IP3 != $JOC )); do
	let JOC=($JOC-1)
done
echo "."
sleep 1
echo "."
sleep 1
echo "."
sleep 1
mask
}
mask(){
clear
echo $NOME
read -p "Máscara: " -d'.' MASK; read -p "" -d'.' MASK1; read -p "" -d'.' MASK2; read -n3 -p "" MASK3; echo
echo $MASK > /tt3/.info.txt
grep -q -i '[a-z]' /tt3/.info.txt
if (( $? == 0 )); then
	echo "Máscara inválida 1"
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
		*) echo "Máscara inválida 2"; sleep 3; mask;;
	esac
fi
}
mask1(){
echo $MASK1 > /tt3/.info.txt
grep -q -i '[a-z]' /tt3/.info.txt
if (( $? == 0 )); then
	echo "Máscara inválida 3"
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
		*) echo "Máscara inválida 4"; sleep 3; mask;;
	esac
fi
}
mask2(){
echo $MASK2 > /tt3/.info.txt
grep -q -i '[a-z]' /tt3/.info.txt
if (( $? == 0 )); then
	echo "Máscara inválida 5"
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
		*) echo "Máscara inválida 6"; sleep 3; mask;;
	esac
fi
}
mask3(){
echo $MASK3 > /tt3/.info.txt
grep -q -i '[a-z]' /tt3/.info.txt
if (( $? == 0 )); then
	echo "Máscara inválida 7"
	sleep 3
	mask
else
	case $MASK3 in
		"255") echo "Máscara inválida 8"; sleep 1; echo "Máscara de loopback"; sleep 2; mask;;
		"254") game;;
		"252") game;;
		"248") game;;
		"240") game;;
		"224") game;;
		"192") game;;
		"128") game;;
		"0") game;;
		*) echo "Máscara inválida 9"; sleep 3; mask;;
	esac
fi
}
outros(){
if (( $MASK1 == 0 )); then
	if (( $MASK2 == 0 )); then
		if (( $MASK3 == 0 )); then
			game
		else
			echo "Máscara inválida 10"
			sleep 3
			mask
		fi
	else
		echo "Máscara inválida 11"
		sleep 3
		mask
	fi
else
	echo "Máscara inválida 12"
	sleep 3
	mask
fi
}
outros1(){
if (( $MASK2 == 0 )); then
	if (( $MASK3 == 0 )); then
		game
	else
		echo "Máscara inválida 13"
		sleep 3
		mask
	fi
else
	echo "Máscara inválida 14"
	sleep 3
	mask
fi
}
outros2(){
if (( $MASK3 == 0 )); then
	game
else
	echo "Máscara inválida 15"
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
echo "Programa finalizando em 3 ..."; sleep 1; echo "2 ..."; sleep 1; echo "1"; sleep 1
exit 0
}

nome
