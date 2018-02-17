#!/bin/bash
nome(){
clear
echo "Formulário"
read -p "Nome completo: " NOME
echo $NOME > /tt3/.info.txt
grep -i -q -E '^([a-z]){3}[a-z ]+$' /tt3/.info.txt  
case $? in
	0) f1;;
	*) echo "Nome inválido"; sleep 2; nome;;
esac
}
f1(){
find /tt3/.dados/"$NOME"
CONTEUDO=$?
clear
case $CONTEUDO in
	0) echo "Nome ja exitente no banco de dados"; sleep 3; nome;;
	1) echo -n "."; sleep 0.25; echo -n "."; sleep 0.25; echo -n "."; sleep 0.25; email;;
	*) echo "Nome inválido"; sleep 2; nome;;
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
	*) echo "E-mail inválido"; sleep 2; email;;
	
esac
}
final(){
grep -q $EMAIL /tt3/.dados/em.txt
case $? in
	0) echo "E-mail já cadastrado no banco de dados!"; sleep 3; email;;
	1) echo -n "."; sleep 0.25; echo -n "."; sleep 0.25; echo -n "."; sleep 0.25; fone;;
	*) echo "E-mail inválido"; sleep 2; email;;
esac
}
fone(){
clear
echo $NOME
read -n2 -p "Telefone: (" DDD; read -n4 -p") " PR; read -n5 -p- SU; echo
echo "$PR$SU" > /tt3/.info.txt
grep -q $DDD /tt3/.ddd.txt
case $? in
        0) phon;;
        *) echo "DDD Não encontrado"; sleep 2; fone;;
esac
}
phon(){
grep -q -E '^([1-9]){2}([0-9]){6,7}$' /tt3/.info.txt
case $? in
	0) echo -n "."; sleep 0.25; echo -n "."; sleep 0.25; echo -n "."; sleep 0.25; rg;;
        *) echo "Número inválido"; sleep 2; fone;;
esac
}
rg(){
clear
echo $NOME
read -n2 -p "Indentificação (RG): " RG; read -n3 -p "." RG1; read -n3 -p "." RG2; read -n2 -p- DG; echo
echo "$RG$RG1$RG2$DG" > /tt3/.info.txt
grep -q -E '^([0-9]){2}(([0-9]){3}){2}[xX0-9]{1,2}$' /tt3/.info.txt
case $? in
	0) echo -n "."; sleep 0.25; echo -n "."; sleep 0.25; echo -n "."; sleep 0.25; cpf;;
        *) echo "RG inválido"; sleep 2; rg;;
esac
}
cpf(){
clear
echo $NOME
read -n3 -p "CPF: " CPF; read -n3 -p "." CPF1; read -n3 -p "." CPF2; read -n2 -p- CPFDG; echo
echo "$CPF$CPF1$CPF2$CPFDG" > /tt3/.info.txt
grep -E -q '^([0-9]){3}(([0-9]){3}){2}([0-9]){1,2}$' /tt3/.info.txt
case $? in
	0) echo -n "."; sleep 0.25; echo -n "."; sleep 0.25; echo -n "."; sleep 0.25; cpfdigito;;
        *) echo "CPF inválido"; sleep 2; cpf;;
esac
}
cpfdigito(){
grep $CPF\.$CPF1\.$CPF2\-$CPFDG /tt3/.dados/cpfs.txt
case $? in
	0) echo "CPF já cadastrado"; sleep 2; cpf;;
	1) echo -n "."; sleep 0.25; echo -n "."; sleep 0.25; echo -n "."; sleep 0.25; nasc;;
	*) echo "CPF inválido"; sleep 2; cpf;;
esac
}
nasc(){
clear
echo $NOME
read -n2 -p "Data de nascimento (DD/MM/AAAA): " DIA; read -n2 -p "/" MES; read -n4 -p "/" ANO; echo
echo "$DIA$MES$ANO" > /tt3/.info.txt
grep -E -q '^(0[1-9]|1[0-9]|2[0-9]|3[0-1])(0[1-9]|1[0-2])(19[0-9]{2}|200[0-9]|201[0-8])$' /tt3/.info.txt
if (( $? == 0 )); then
	case $DIA in
		01) DIA=1;;
		02) DIA=2;;
		03) DIA=3;;
		04) DIA=4;;
		05) DIA=5;;
		06) DIA=6;;
		07) DIA=7;;
		08) DIA=8;;
		09) DIA=9;;
	esac
	case $MES in
		"01") diia=31; data;;
		"02") diia=28; data1;;
		"03") diia=31; data;;
		"04") diia=30; data;;
		"05") diia=31; data;;
		"06") diia=30; data;;
		"07") diia=31; data;;
		"08") diia=31; data;;
		"09") diia=30; data;;
		"10") diia=31; data;;
		"11") diia=30; data;;
		"12") diia=31; data;;
	esac
else
	echo "Data de nascimento inválida"
	sleep 2
	nasc
fi
}
data1(){
BISEXTO=1900
ANAO=1904
while (( $ANO != $BISEXTO )); do
	if (( $ANO < $ANAO )); then
		data
	elif (( $ANO == $ANAO )); then
		let diia=($diia+1)
		data
	else
		let BISEXTO=($BISEXTO+4)
		let ANAO=($ANAO+4)		
	fi
done
let diia=($diia+1)
data
}
data(){
if (( $diia >= $DIA )); then			
	echo -n "."
	sleep 0.25
	echo -n "."
	sleep 0.25
	echo -n "."
	sleep 0.25
	ip	
else
	echo "Data de nascimento inválida"
	sleep 2
	nasc
fi
}
ip(){
clear
echo $NOME
read -p "IP: " -d'.' IP; read -p "" -d'.' IP1; read -p "" -d'.' IP2; read -p "" IP3
echo "$IP.$IP1.$IP2.$IP3" > /tt3/.info.txt
grep -q -E '^(0|[1-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])(\.(0|[1-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])){3}$' /tt3/.info.txt
if (( $? == 0 )); then
	echo -n "."; sleep 0.25; echo -n "."; sleep 0.25; echo -n "."; sleep 0.25
	mask
else
	echo
	echo "IP inválido!"
	sleep 2
	ip
fi
}
mask(){
clear
echo $NOME
read -p "Máscara: " -d'.' MASK; read -p "" -d'.' MASK1; read -p "" -d'.' MASK2; read -p "" MASK3
echo "$MASK$MASK1$MASK2$MASK3" > /tt3/.info.txt
grep -q -E '^0(0){3}|128(0){3}|192(0){3}|224(0){3}|240(0){3}|248(0){3}|252(0){3}|254(0){3}|255(0|128|192|224|240|248|252|254)(0){2}|255255(0|128|192|224|240|248|252|254)(0)|255255255(0|128|192|224|240|248|252|254|255)' /tt3/.info.txt
if (( $? == 0 )); then
	LOP="$MASK$MASK1$MASK2$MASK3"
	IPLOP="$IP$IP1$IP2$IP3"
	if [ $LOP == "255255255255" ] && [ $IPLOP != "127001" ]; then
		echo "Máscara inválida"
		sleep 1
		echo "Máscara de Loopback"
		sleep 2
		mask
	else
		echo -n "."; sleep 0.25; echo -n "."; sleep 0.25; echo -n "."; sleep 0.25
	game
	fi
else
	echo "Máscara inválida"
	sleep 2
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
