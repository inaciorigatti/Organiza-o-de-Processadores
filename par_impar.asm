.text
jal zero, main

# Função para verificar se um número é par ou ímpar
# Argumento: a0 - número a ser verificado
# Retorno: a1 - 0 se par, 1 se ímpar
check_par_impar:
    andi a1, a0, 1       # Faz AND com 1 (bit menos significativo)
    ret                  # Retorna (a1 será 0 para par, 1 para ímpar)

main:
    # Exemplo de uso - vamos verificar o número 7
    li a0, 7             # Carrega o número a ser verificado (7)
    jal ra, check_par_impar # Chama a função

    # Agora a1 contém 0 (par) ou 1 (ímpar)
    # Podemos usar isso para tomar alguma ação
    # Por exemplo, encerrar o programa
    li a7, 10            # Código de syscall para exit
    ecall                # Encerra o programa