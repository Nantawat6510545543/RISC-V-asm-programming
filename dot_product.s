.data
    a:  .word 1, 2, 3, 4, 5
    b:  .word 6, 7, 8, 9, 10
    text: .asciiz "The dot product is: "
    newline: .asciiz "\n"

.text
main:
    li x5, 5             # x5 be size and set it to 5
    li x6, 0             # i = 0
    li x7, 0             # sop = 0

    la x8, a             # loading the address of b to x8
    la x9, b             # loading the address of b to x9

loop:
    bge x6, x5, exit     # Exit loop if i >= size

    slli x18, x6, 2      # x18 = i * 4
    add x19, x8, x18     # add i * 4 to the base address off a amd put it to x19
    add x20, x9, x18     # add i * 4 to the base address off b amd put it to x20

    lw x22, 0(x19)       # x22 = a[i]
    lw x23, 0(x20)       # x23 = b[i]
    mul x24, x22, x23    # x24 = a[i] * b[i]
    add x7, x7, x24      # sop += a[i] * b[i];

    addi x6, x6, 1       # i += 1
    j loop               # Jump back to loop

exit:
    li a0, 4
    la a1, text          # Print text
    ecall

    li a0, 1
    mv a1, x7            # Print sop
    ecall

    li a0, 4
    la a1, newline       # Print newline
    ecall

    li a0, 10            # Exit
    ecall
