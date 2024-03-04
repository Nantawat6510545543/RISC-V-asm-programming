.text
main:
    li t0 1 # constant 1

    # passing the three arguments to a0 and a1
    li a0 110
    li a1 50

    jal mult

    mv a1 a0
    li a0 1
    ecall

    li a0 10
    ecall

mult:
    addi sp sp -12

    # save a0, a1 and ra on to the stack
    sw a0 8(sp) # Store a
    sw a1 4(sp) # Store b
    sw ra 0(sp) # Store ra

    bne a1 t0 return # if b != 1 then return a + mult(a, b-1)

    addi sp sp 12
    jr ra # return a

return:
    # a + mult(a, b-1)
    addi a1 a1 -1 # b -= 1

    jal mult # mult(a, b-1)

    lw t1 8(sp) # Load a0 | mult(a, b-1)
    lw ra 0(sp) # Load ra
    add a0 a0 t1 # a0 += mult(a, b-1)

    addi sp sp 12
    jr ra

