#!/bin/bash

g++ transportes.cpp -o transp  # Compilar o programa

num=1
max=5  # Quantidade de diretórios
mkdir "saidasminhas"
while [ $num -le $max ]; do
    # Entra no diretório e processa os arquivos de entrada (*.in)
    for entrada in ./${num}/*.in; do
        # Verifica se o arquivo existe
        if [ -f "$entrada" ]; then
            # Extrai o número do arquivo de entrada (assumindo o formato N.in)
            arq=$(basename "$entrada" .in)
            saida="./${num}/${arq}.sol"  # Arquivo de saída esperado
            minhasaida="./saidasminhas/${arq}.meu"     # Arquivo gerado pelo programa
            tempo="./saidasminhas/${arq}.tempo"       # Arquivo para armazenar o tempo de execução

            # Executa o programa e salva a saída
            { time ./transp < "$entrada" > "$minhasaida" ; } 2> "$tempo"

            # Compara a saída esperada com a gerada, e só exibe diferenças
            if ! diff "$saida" "$minhasaida" > /dev/null; then
                echo "Diferença encontrada entre ${saida} e ${minhasaida}."
                echo "Saída esperada:"
                cat "$saida"
                echo "Saída gerada:"
                cat "$minhasaida"
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