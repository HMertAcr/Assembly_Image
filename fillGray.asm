    .globl fillGray
fillGray:
    push %rbp            # setup stack frame
    mov %rsp, %rbp

    # save arguments to stack
    mov %edi, -4(%rbp)      # n
    mov %esi, -8(%rbp)      # filter_size
    mov %rdx, -16(%rbp)     # resim_org

    # allocate memory for temp array
    mov -4(%rbp), %edi      # n
    lea (,%rdi,2), %edi # n*sizeof(short)
    call malloc

    # store the return value of malloc to temp
    mov %rax, -24(%rbp)

    # copy resim_org to temp
    mov -16(%rbp), %rdx     # resim_org address
    mov -24(%rbp), %rcx     # temp address
    mov -4(%rbp), %rax      # n
    lea (,%rax,2), %rax  # n*sizeof(short)
    call memcpy
    
    # calculate the square root of n
    sqrt_loop:
    cmp %edx, 1
    jle sqrt_end
    sub $1, %edx
    jmp sqrt_loop
    sqrt_end:
    mov %edx, %ecx # side = edx

    # loop here to fill the gray image

    # copy temp to resim_org
    mov -24(%rbp), %rdx # temp
    mov -16(%rbp), %rcx # resim_org
    mov -4(%rbp), %rax  # n
    lea (,%rax,2), %rax  # n*sizeof(short)
    call memcpy

    #free temp
    mov -24(%rbp), %rdx # temp
    call free 

    # restore stack frame and return
    leave
    ret
