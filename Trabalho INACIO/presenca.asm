# Inácio Radin Rigatti

.data

frequencia: .word 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF
            .word 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF
            .word 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF
            .word 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF

mensagem_aula: .asciz "Numero da aula (de 0 a 15): "
mensagem_aluno: .asciz "Numero do aluno (de 0 a 31): "
mensagem_registro: .asciz "Tipo do registro (presenca (1) ausencia (0): "

.text
main:
 
loop:
   
    addi a7, zero, 4
    la a0, mensagem_aula
    ecall
  
    addi a7, zero, 5
    ecall
    add s0, zero, a0  
    
    addi a7, zero, 4
    la a0, mensagem_aluno
    ecall
  
    addi a7, zero, 5
    ecall
    add s1, zero, a0      

    addi a7, zero, 4
    la a0, mensagem_registro
    ecall
    
    addi a7, zero, 5
    ecall
    add s2, zero, a0  
    
    la t0, frequencia      
    slli t1, s0, 2         
    add t0, t0, t1         
    lw t2, 0(t0)           
    
    # Cria máscara 
    addi t3, zero, 1       
    sll t3, t3, s1         
  
    beq s2, zero, ausencia
    
presenca:
   
    or t2, t2, t3
    jal zero, atualiza
    
ausencia:
  
    not t3, t3         
    and t2, t2, t3
    
atualiza:
 
    sw t2, 0(t0)
    # Volta para o loop
    jal zero, loop