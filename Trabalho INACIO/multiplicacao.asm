# Inácio Radin Rigatti

.data
mensagem_x: .asciz "Digite o valor de X: "
mensagem_y: .asciz "Digite o valor de Y: "
mensagem_resultado: .asciz "Resultado da multiplicacao: "
novalinha: .asciz "\n"

.text
main:
    # Solicita valor X
    addi a7, zero, 4
    la a0, mensagem_x
    ecall
    
    addi a7, zero, 5
    ecall
    add s0, zero, a0  # s0 = X
    
    # Solicita valor Y
    addi a7, zero, 4
    la a0, mensagem_y
    ecall
    # Lê Y
    addi a7, zero, 5
    ecall
    add s1, zero, a0  # s1 = Y
    
    # Inicializa resultado em s2
    add s2, zero, zero
    
    # Verifica se algum valor é zero
    beq s0, zero, imprimir_resultado
    beq s1, zero, imprimir_resultado
    
    # Inicializa contador em t0
    add t0, zero, zero
    
multiplicacao_loop:
    # Adiciona X ao resultado
    add s2, s2, s0
    # Incrementa contador
    addi t0, t0, 1
    # Verifica se já somou Y vezes
    blt t0, s1, multiplicacao_loop
    
imprimir_resultado:
    # Imprime mensagem do resultado
    addi a7, zero, 4
    la a0, mensagem_resultado
    ecall
    # Imprime resultado
    addi a7, zero, 1
    add a0, zero, s2
    ecall
    # Nova linha
    addi a7, zero, 4
    la a0, novalinha
    ecall
    
    # Termina o programa
    addi a7, zero, 10
    ecall