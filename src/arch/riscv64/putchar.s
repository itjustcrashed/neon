.section .text

.globl  putchar
.type   putchar, @function
putchar:
    andi    t0, a0, 0xff                    # Save the byte that will be written
    mv      t1, a0                          # Preserve the character for the return value

    li      a7, 0x4442434e                  # SBI_EXT_DBCN
    li      a6, 2                           # SBI_EXT_DBCN_CONSOLE_WRITE_BYTE
    mv      a0, t0                          # DBCN argument: uint8_t byte

    ecall

    bnez    a0, .Lputchar_error             # SBI_SUCCESS is defined as 0

    mv      a0, t1
    ret
.Lputchar_error:
    li      a0, -1                          # EOF
    ret
.size   putchar, .-putchar
