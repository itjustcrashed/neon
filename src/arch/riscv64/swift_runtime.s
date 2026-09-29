# Copyright 2026 It Just Crashed
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

.section .text

# MARK: memset

.globl memset
.type memset, @function
memset:
    mv      t1, a0                          # Save the pointer for returning later

    andi    t0, a1, 255                     # Convert value to u8

    beqz    a2, .Lmemset_return             # If the count is 0, return
.Lclear_loop:
    sb      t0, 0(a0)                       # *ptr = byte
    addi    a0, a0, 1                       # ptr++
    addi    a2, a2, -1                      # count--

    bnez    a2, .Lclear_loop                # while (count != 0)
.Lmemset_return:
    mv      a0, t1                          # Return the original pointer
    ret
.size memset, .-memset

# MARK: memmove

.globl memmove
.type memmove, @function
memmove:
    mv      t1, a0                          # Save the destination for returning later
    beqz    a2, .Lmemmove_return            # If the count is 0, return

    bltu    a0, a1, .Lforward               # If dst < src, copy forwards

    # Copy backwards to safely handle overlapping regions
    add     a0, a0, a2                      # Point dst just past the destination
    add     a1, a1, a2                      # Point src just past the source
.Lbackward:
    addi    a0, a0, -1                      # dst--
    addi    a1, a1, -1                      # src--

    lbu     t0, 0(a1)                       # Load one byte from src
    sb      t0, 0(a0)                       # Store one byte to dst

    addi    a2, a2, -1                      # count--
    bnez    a2, .Lbackward                  # while (count != 0)
    j       .Lmemmove_return
.Lforward:
    lbu     t0, 0(a1)                       # Load one byte from src
    sb      t0, 0(a0)                       # Store one byte to dst

    addi    a0, a0, 1                       # dst++
    addi    a1, a1, 1                       # src++
    addi    a2, a2, -1                      # count--
    bnez    a2, .Lforward                   # while (count != 0)
.Lmemmove_return:
    mv      a0, t1                          # Return the original destination pointer
    ret
.size memmove, .-memmove

# MARK: putchar

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
