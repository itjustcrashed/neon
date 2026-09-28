.section .text.preboot

# Assumes the environment provided by SBI.
# [[noreturn]] void start(unsigned long hartid, const void *dtb);
.globl start
.type start, @function
start:
    mv      s0, a0                          # Save hartid to s0
    mv      s1, a1                          # Save &dtb

    la      sp, __boot_hart_stack_end       # Set the stack pointer
.Lclear_bss:
    # memset(__bss_start, 0, __bss_end - __bss_start)
    la      a0, __bss_start                 # ptr: __bss_start
    la      t0, __bss_end
    sub     a2, t0, a0                      # count: __bss_end - __bss_start
    mv      a1, zero                        # value: 0

    call    memset
.Ljump:
    # start_kernel(hartid, &dtb)
    mv      a0, s0                          # hartID: hartid
    mv      a0, s1                          # dtb: &dtb
    call    start_kernel
