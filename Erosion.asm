    .globl Erosion
Erosion:
    pushq %rbp
    movq %rsp, %rbp

    pushq %rdi
    pushq %rsi
    pushq %rbx

    movl 8(%rbp), %edi
    movl 12(%rbp), %esi
    movq 16(%rbp), %rbx

    pushq %rbx
    call malloc
    addq $8, %rsp
    movq %rax, -8(%rbp)

    pushq -8(%rbp)
    pushq %rbx
    pushq %rdi
    call memcpy
    addq $24, %rsp

    movl %edi, %eax
    shrl $2, %eax
    movl %eax, -4(%rbp)

    xorl %edx, %edx
    movl -4(%rbp), %esi
    .L1:
    movl -4(%rbp), %ebx
    .L2:
    movl %esi, %eax
    subl %esi, %eax
    movl %eax, %edx
    .L3:
    movl %ebx, %eax
    subl %ebx, %eax
    .L4:
    cmpl $0, %edx
    jl .L5
    cmpl -4(%rbp), %edx
    jge .L5
    cmpl $0, %eax
    jl .L5
    cmpl -4(%rbp), %eax
    jge .L5
    movq -8(%rbp), %rcx
    movq -8(%rbp), %rdx
    movl %ecx, %esi
    movl %edx, %ebx
    movl %edx, %ecx
    movl %ecx, %edx
    movl %esi, %ecx
    movl %ebx, %esi
    addl %eax, %esi
    addl %edx, %ecx
    movzwl (%ecx, %esi), %eax
    movq -8(%rbp), %rcx
    movq %rbx, %rdx
    movl %ecx, %esi
    movl %edx, %ebx
    movl %edx, %ecx
    movl %esi, %edx
    movl %ebx, %esi
    addl %edx, %esi
    addl %ecx, %ebx
    cmpl (%ebx, %esi), %eax
    jge .L6
    movzwl (%ebx, %esi), %eax
    .L6:
    movq -8(%rbp), %rcx
    movl %esi, %edx
    movl %ebx, %ecx
    movl %ecx, %edx
    movl %esi, %ecx
    addl %eax, %ecx
    movw %ax, (%rcx, %rdx)
    .L5:
    addl $1, %eax
    cmpl -4(%rbp), %eax
    jl .L4
    addl $1, %edx
    cmpl -4(%rbp), %edx
    jl .L3
    addl $1, %ebx
    cmpl -4(%rbp), %ebx
    jl .L2
    addl $1, %esi
    cmpl -4(%rbp), %esi
    jl .L1

    pushq %rbx
    pushq -8(%rbp)
    pushq %rdi
    call memcpy
    addq $24, %rsp

    pushq -8(%rbp)
    call free
    addq $8, %rsp

    movq %rbp, %rsp
    popq %rbp
    ret
