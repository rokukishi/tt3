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
echo "$PR$SU" > /tt3/.info.txt
grep -q $DDD /tt3/.ddd.txt
case $? in
        0) phon;;
        *) echo "DDD Não encontrado"; sleep 3; fone;;
esac
}
phon(){
grep -q -E '^([1-9]){2}([0-9]){6,7}$' /tt3/.info.txt
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
grep -q -i -E '^([0-9]){2}((\.[0-9]){3}){2}-[xX0-9]{2}$' /tt3/.info.txt
case $? in
        0) echo -n "."; sleep 1; echo -n "."; sleep 1; echo -n "."; sleep 1; cpf;;
        *) echo "RG inválido"; sleep 3; rg;;
esac
}
cpf(){
clear
echo $NOME
read -n3 -p "CPF: " CPF; read -n3 -p "." CPF1; read -n3 -p "." CPF2; read -n2 -p- CPFDG; echo
echo "$CPF.$CPF1.$CPF2-$CPFDG" > /tt3/.info.txt
grep -E -q -i '^([0-9]){3}((\.[0-9]){3}){2}-[0-9]{2}$' /tt3/.info.txt
case $? in
        0) echo -n "."; sleep 1; echo -n "."; sleep 1; echo -n "."; sleep 1; cpfdigio;;
        *) echo "CPF inválido"; sleep 3; cpf;;
esac
}
cpfdigito(){
grep $CPF\.$CPF1\.$CPF2\-$CPFDG /tt3/.dados/cpfs.txt
case $? in
	0) echo "CPF já cadastrado"; sleep 3; cpf;;
	1) echo -n "."; sleep 1; echo -n "."; sleep 1; echo -n "."; sleep 1; nasc;;
	*) echo "CPF inválido"; sleep 3; cpf;;
esac
}
nasc(){
clear
echo $NOME
read -n2 -p "Data de nascimento (DD/MM/AAAA): " DIA; read -n2 -p / MES; read -n4 -p / ANO; echo
echo "$DIA/$MES/$ANO" > /tt3/.info.txt
grep -E -q -i '^(0[1-9]|1[0-9]|2[0-9]|3[0-1])/(0[1-9]|1[0-2])/(19[0-9]{2}|200[0-9]|201[0-8])$' /tt3/.info.txt
if (( $? == 0 )); then
case $MES in
		01) diia=31; data;;
		02) diia=28; data1;;
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
else
echo "Data de nascimento inválida"
sleep 3
nasc
fi
}
data(){
if (( $DIA < $diia )); then
	echo -n "."; sleep 1; echo -n "."; sleep 1; echo -n "."; sleep 1 
	ip	
else
	echo "Data de nascimento inválida"
	sleep 3
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
}
ip(){
clear
echo $NOME
read -p "IP: " -d'.' IP; read -p "" -d'.' IP1; read -p "" -d'.' IP2; read -p "" IP3
echo "$IP.$IP1.$IP2.$IP3" > /tt3/.info.txt
grep -q -i -E '^([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])(\.[0-9]|1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5]){3}$' /tt3/.info.txt
if (( $? == 0 )); then
	mask
else
	echo
	echo "IP inválido!"
	sleep 3
	ip
fi
}
mask(){
clear
echo $NOME
read -p "Máscara: " -d'.' MASK; read -p "" -d'.' MASK1; read -p "" -d'.' MASK2; read -p "" MASK3
echo "$MASK.$MASK1.$MASK2.$MASK3" > /tt3/.info.txt
grep -q -i -E '^((0(\.0){3})|(128(\.0){3})|(192(\.0){3})|(224(\.0){3})|(240(\.0){3})|(248(\.0){3})|(252(\.0){3})|(254(\.0){3})|(255\.(0|128|192|224|240|248|252|254)(\.0){2})|(255\.(0|128|192|224|240|248|252|254)\.0(255\.(0|128|192|224|240|248|252|254|255))))' /tt3/.info.txt
if (( $? == 0 )); then
	echo "ok"
else
	echo "erro"
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
