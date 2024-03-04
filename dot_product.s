.data
    a:  .word 1, 2, 3, 4, 5
    b:  .word 6, 7, 8, 9, 10

.text
    .globl main
main:
    li x5, 5             # x5 be size and set it to 5
    li x6, 0             # i = 0
    li x7, 0             # sop = 0

    la x9, a
    la x21, b

loop:
    bge x6, x5, exit

    slli x18, x6, 2      # x18 = i * 4
    add x19, x9, x18     # add i * 4 to the base address off a amd put it to x19
    add x20, x21, x18    # add i * 4 to the base address off b amd put it to x20

    lw x22, 0(x19)       # x22 = a[i]
    lw x23, 0(x20)       # x23 = b[i]
    mul x24, x22, x23    # x24 = a[i] * b[i]
    add x7, x7, x24      # sop += a[i] * b[i];

    addi x6, x6, 1
    j loop

exit:
    li a0, 1
    mv a1, x7            # Print sop
    ecall

    li a0, 10            # Prepare to exit
    ecall                # Exit
