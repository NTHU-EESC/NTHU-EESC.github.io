# Reference: https://www.geeksforgeeks.org/longest-common-subarray-in-the-given-two-arrays/
.data
.align 4

# =========testcase1===========
# A: .word 1, 2, 3, 2, 1
# i: .word 5
# B: .word 8, 7, 6, 4
# j: .word 4
# strOutput: .string "Max length of common subarray: "
# output: Max length of common subarray: 0
# ==============================

# =========testcase2===========
A: .word 1, 2, 8, 2, 1
i: .word 5
B: .word 8, 2, 1, 4, 7
j: .word 5
strOutput: .string "Max length of common subarray: "
# output: Max length of common subarray: 3
# ==============================

.text
.global _start

# Start your coding below, don't change anything upper except testing different testcase
_start:

    # set argument
    la a1, A
    lw a2, i
    la a3, B
    lw a4, j
    li a5, 0
    
    # call function
    jal _LCS

    # get the return value
    mv t0, a0

    # output string
    la a0, strOutput
    li a7, 4
    ecall

    # output value
    mv a0, t0
    li a7, 1
    ecall

    # exit main function
    jal _exit

_LCS:
    # save data
    addi sp, sp, -20
    sw ra, 16(sp) # save return address
    sw a2, 12(sp) # save i
    sw a4, 8(sp) # save j
    sw a5, 4(sp) # save count

    # (i == 0 || j == 0)
    beq a2, zero, _firstIf # check i, if i is 0 then skip checking j
    bne a4, zero, _secondIf # check j, if j isn't 0 then jump to _secondIf

_firstIf:
    # return count
    mv a0, a5
    addi sp, sp, 20
    jr ra


_secondIf:
    # count A[i-1] address
    mv t1, a2
    addi t1, t1, -1
    slli t1, t1, 2
    add t1, t1, a1

    # count B[i-1] address
    mv t2, a4
    addi t2, t2, -1
    slli t2, t2, 2
    add t2, t2, a3

    # load A[i-1] to t3
    lw t3, 0(t1)

    # load B[j-1] to t4
    lw t4, 0(t2)
    
    # (A[i-1] != B[j-1]) => _else
    bne t3, t4, _else

    # set the arguments
    addi a2, a2, -1
    addi a4, a4, -1
    addi a5, a5, 1

    # call itself recursively
    jal _LCS

    # count = return value
    mv a5, a0
    j _functionEnd

_else:
    # a(t5) = LCS(i - 1, j, A, B, 0)
    addi a2, a2, -1
    jal _LCS
    sw a0, 0(sp) # save a

    # restore the arguments
    lw a2, 12(sp)
    lw a4, 8(sp)
    lw a5, 4(sp)

    # b(t6) = LCS(i, j - 1, A, B, 0)
    addi a4, a4, -1
    jal _LCS
    mv t6, a0

    # restore a
    lw t5, 0(sp)

    # a < b
    bge t5, t6, _countLessThanA
    mv t5, t6

# count < a
_countLessThanA:
    lw a5, 4(sp)
    bge a5, t5, _functionEnd
    mv a5, t5

# return count
_functionEnd:
    mv a0, a5
    lw ra, 16(sp)
    addi sp, sp, 20
    jr ra

_exit:
    nop