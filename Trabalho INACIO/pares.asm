# Inácio Radin Rigatti

.data
mensagem_par:   .asciz " Valor par encontrado: "
mensagem_total: .asciz "  Total de valores pares: "

.text
main:

    li s0, 10     
    li s1, 7      
    li s2, 8      
    li s3, 18     

    addi t0, zero, 0

    andi t1, s0, 1
    bne t1, zero, vereficar_s1
    
    addi t0, t0, 1
    addi a7, zero, 4
    la a0, mensagem_par
    ecall
    
    addi a7, zero, 1
    add a0, zero, s0
    ecall

vereficar_s1:
    andi t1, s1, 1
    bne t1, zero, vereficar_s2
    
    addi t0, t0, 1
    addi a7, zero, 4
    la a0, mensagem_par
    ecall
    
    addi a7, zero, 1
    add a0, zero, s1
    ecall

vereficar_s2:
    andi t1, s2, 1
    bne t1, zero, vereficar_s3
    
    addi t0, t0, 1
    addi a7, zero, 4
    la a0, mensagem_par
    ecall
    
    addi a7, zero, 1
    add a0, zero, s2
    ecall

vereficar_s3:
    andi t1, s3, 1
    bne t1, zero, imprimir_total
    
    addi t0, t0, 1
    addi a7, zero, 4
    la a0, mensagem_par
    ecall
    
    addi a7, zero, 1
    add a0, zero, s3
    ecall

imprimir_total:
    addi a7, zero, 4
    la a0, mensagem_total
    ecall
    
    addi a7, zero, 1
    add a0, zero, t0
    ecall

    addi a7, zero, 10
    ecall
