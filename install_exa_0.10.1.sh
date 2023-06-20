#!/bin/bash

### ########################### ###
###  INSTACAO DO PROGRAMA EXA   ###
###  A EVOLUCAO DO COMANDO LS   ###
### BY LUIZ PETERLI - 03/05/21  ###
### Exa 0.10.1 update 20/06/23  ###
### ########################### ###


DEPENDENCES(){
apt update; apt install curl cmake zip unzip -y
}


INSTALL(){
if [ -e "/usr/local/bin/exa" ];then
		rm -rf /usr/local/bin/exa; rm -rf /etc/bash_completion.d/exa.bash; 
	else
		echo "\nprosseguindo com instalação nova\n" > /dev/null
fi		

###> BAIXANDO E INSTALADO E DECLARANDO O PROGRAMA
curl https://sh.rustup.rs -sSf | sh; cd /tmp; wget https://github.com/ogham/exa/releases/download/v0.10.1/exa-linux-x86_64-musl-v0.10.1.zip; unzip exa-linux-x86_64-musl-v0.10.1.zip; cp bin/exa /usr/local/bin/
cp completions/exa.bash /etc/bash_completion.d/; cp man/* /usr/local/share/man/


cat ~/.bashrc|grep 'exa' >/dev/null
if [ $? -eq 0 ]; then
		echo "Alias já existe no bashrc desse usuário"; source ~/.bashrc
	else
		echo -e "\n#Carrega exa\nalias ld='exa -T --level=2 --long --icons'\n" >> ~/.bashrc; source ~/.bashrc
fi		
}


###> IDENTIFICANDO O SISTEMA OPERACIONAL PELO KERNEL
KRN=$(uname -a)

###> VERIFICANDO A COMPATIBILIDADE DO SISTEMA OPERACIONAL
case "$KRN" in
    *buntu*|*ebian*)
        ###> CASO O SISTEMA OPERACIONAL SEJA UBUNTU OU DEBIAN
        DEPENDENCES;INSTALL
        ;;
    *icrosoft*)
        ###> CASO O SISTEMA OPERACIONAL SEJA EMBARCADO MICROSOFT
        SEM=$(cat /etc/[A-Za-z]*[_-][rv]e[lr]* |grep 'NAME="')
        case "$SEM" in
            *buntu*|*ebian*)
                ###> CASO O SISTEMA OPERACIONAL SEJA UBUNTU OU DEBIAN
                DEPENDENCES;INSTALL
                ;;
            *)
                ###> CASO O SISTEMA OPERACIONAL NAO SUPORTE O SCRIPT
                clear;echo -e "\nInfelizmente o script ${BR}não ofecerece${NM} suporte ao sistema operacional ${BB}$KRN${NM}\n";exit 1
             ;;       
        esac
        ;;
    *)
        ###> CASO O SISTEMA OPERACIONAL NAO SUPORTE O SCRIPT
        clear;COLOR;echo -e "\nInfelizmente o script ${BR}não ofecerece suporte${NM} ao sistema operacional ${BB}$KRN${NM}\n";exit 1
        ;;
esac


###> INFORMANDO
echo -e "\nPronto, basta usar o alias *ld* ou o comando completo *exa -T --level=2 --long --icons* para utilizar o exa\n"

exit=0
