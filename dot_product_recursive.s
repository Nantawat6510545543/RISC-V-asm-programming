.data
    a:  .word 1, 2, 3, 4, 5
    b:  .word 6, 7, 8, 9, 10
    text: .asciiz "The dot product is: "
    newline: .asciiz "\n"

.text
main:
    li t0 1 # constant 1

    # passing the three arguments to a0, a1 and a2
    la a0 a # &a[0]
    la a1 b # &b[0]
    li a2 5 # size

    jal dot_product_recursive

    mv x30, a0     # result = a0

    # printf("The dot product is: %d\n", result);
    li a0 4
    la a1 text
    ecall
    mv a1 x30
    li a0 1
    ecall
    li a0 4
    la a1 newline
    ecall

    li a0 10       # Exit
    ecall

dot_product_recursive:
    addi sp sp -12

    # save a0, a1 and ra on to the stack
    sw a0 8(sp) # Store &a[0]
    sw a1 4(sp)  # Store &b[0]
    sw ra 0(sp)  # Store ra

    bne a2 t0 return # if size != 1 then return a[0]*b[0] + dot_product_recursive(a+1, b+1, size-1);

    # a0 = a[0] * b[0]
    lw t1 0(a0)
    lw t2 0(a1)
    mul a0 t1 t2

    addi sp sp 12
    jr ra

return:
    # a[0]*b[0] + dot_product_recursive(a+1, b+1, size-1);
    addi a0 a0 4  # &a[0] + 4
    addi a1 a1 4  # &b[0] + 4
    addi a2 a2 -1 # size - 1

    jal dot_product_recursive # dot_product_recursive(a+1, b+1, size-1);

    # restore a0, a1 and ra on to the stack
    lw t1 8(sp) # Load &a[0] (a0)
    lw t2 4(sp)  # Load &b[0] (a1)
    lw ra 0(sp)  # Load ra

    # load a[0] and b[0]
    lw t1 0(t1)
    lw t2 0(t2)

    # a0 += a[0] * b[0] | a0 += dot_product_recursive(a+1, b+1, size-1);
    mul x20, t1, t2
    add a0 a0 x20

    addi sp sp 12
    jr ra