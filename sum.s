.data
    arr1:  .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    arr2:  .word 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
    newline: .asciiz "\n"

.text
    .globl main
main:
    li x5, 10            # x5 be size and set it to 10
    li x6, 0             # sum1
    li x7, 0             # sum2
    li x8, 0             # i = 0

    la x9, arr1          # Load address of arr1 into x9 (index = 0)

loop1:
    bge x8, x5, exit1    # Exit loop if i == size

    slli x18, x8, 2      # x18 = i * 4
    add x19, x18, x9     # add i * 4 to the base address off arr1 amd put it to x19
    addi x20, x8, 1      # x20 = i + 1
    sw x20, 0(x19)       # arr1[i] = i +1

    addi x8, x8, 1       # i += 1
    j loop1              # Jump back to loop1

exit1:
    li x8, 0             # i = 0
    la x21, arr2         # Load address of arr2 into x21 (index = 0)
loop2:
    bge x8, x5, exit2    # Exit loop if i == size

    slli x18, x8, 2      # x18 = i * 4
    add x19, x18, x21     # add i * 4 to the base address off arr2 amd put it to x19
    add x20, x8, x8      # x20 = i + i = i * 2
    sw x20, 0(x19)       # arr2[i] = i * 2

    addi x8, x8, 1       # i += 1
    j loop2              # Jump back to loop1


exit2:
    li x8, 0             # i = 0
loop3:
    bge x8, x5, exit3    # Exit loop if i == size

    slli x18, x8, 2      # x18 = i * 4

    add x19, x18, x9     # add i * 4 to the base address off arr1 amd put it to x19
    lw x20, 0(x19)       # x22 = arr1[i]
    add x6, x6, x20      # sum1 += arr1[i]

    add x19, x18, x21    # add i * 4 to the base address off arr2 amd put it to x20
    lw x20, 0(x19)       # x23 = arr2[i]
    add x7, x7, x20      # sum2 += arr2[i]

    addi x8, x8, 1       # i += 1
    j loop3              # Jump back to loop3

exit3:
    li a0, 1
    mv a1, x6            # Print sum1
    ecall

    li a0, 4
    la a1, newline
    ecall

    li a0, 1
    mv a1, x7            # Print sum2
    ecall
    
    li a0, 10            # Prepare to exit
    ecall                # Exit
