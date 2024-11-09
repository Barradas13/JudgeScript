#!/bin/bash

# Variaveis para alterar
nome="burocracia"   # Nome do programa
max=6               # Quantidade de diretórios

num=1
diffnum=1

# Compilar o programa
g++ -std=c++17 -O2 "$nome".cpp -o "$nome" -Wall

rm -rf "saidasminhas"   # Pra nao aparecer o aviso na tela
mkdir "saidasminhas"
rm -rf "diffs"          # Reinicia a contagem de erros
mkdir "diffs"

# Prepara o dir de saidas pra cada task
for((i=1; i<=max; i++)) do
    mkdir "saidasminhas/${i}"
done

while [ $num -le $max ]; do
    echo "Checking task ${num}"

    # Entra no diretório e processa os arquivos de entrada (*.in)
    for entrada in ./${num}/*.in; do

        # Verifica se o arquivo existe
        if [ -f "$entrada" ]; then
            echo -e "\tChecking ${entrada}"

            # Extrai o número do arquivo de entrada (assumindo o formato N.in)
            arq=$(basename "$entrada" .in)
            saida="./${num}/${arq}.sol"                     # Arquivo de saída esperado
            minhasaida="./saidasminhas/${num}/${arq}.meu"   # Arquivo gerado pelo programa
            tempo="./saidasminhas/${num}/${arq}.tempo"      # Arquivo para armazenar o tempo de execução

            # Executa o programa e salva a saída
            { time ./"$nome" < "$entrada" > "$minhasaida" ; } 2> "$tempo"

            # Compara a saída esperada com a gerada, e só exibe diferenças
            if ! diff "$saida" "$minhasaida" > /dev/null; then
                echo -e "\t\tFound diff ${diffnum}"

                diffatt="./diffs/${diffnum}"
                touch "$diffatt"

                printf "Diferença encontrada entre ${saida} e ${minhasaida}.\n" >> "$diffatt"
                printf "Saída esperada:\n" >> "$diffatt"
                cat "$saida" >> "$diffatt"
                printf "Saída gerada:\n" >> "$diffatt"
                cat "$minhasaida" >> "$diffatt"

                # Incrementa o contador de erros
                diffnum=$((diffnum + 1))
            fi

            # Verifica e exibe o tempo de execução se passou de 1 segundo
            tempo_exec=$(grep -oP '(?<=real\s)\d+\.\d+' "$tempo")
            if [ -n "$tempo_exec" ] && (( $(echo "$tempo_exec > 1" | bc -l) )); then
                echo "Tempo de execução para $entrada: ${tempo_exec} segundos"
            fi
        fi
    done

    # Incrementa o contador de diretórios
    num=$((num + 1))
done