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
    # save a0, a1 and ra on to the stack
    addi sp sp -8
    sw a0 4(sp) # Store a
    sw ra 0(sp) # Store ra

    addi a1 a1 -1  # b -= 1
    beq a1 t0 exit # if b == 1 then exit

    jal mult # mult(a, b-1)

    lw t1 4(sp) # Load a form mult(a, b-1)
    lw ra 0(sp) # Load ra
    add a0 a0 t1 # a0 += mult(a, b-1)

    addi sp sp 8
    jr ra

exit:
    jr ra
