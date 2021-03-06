#if defined(WITH_SELF_VERIFICATION)
    /*
     * This handler encapsulates heap memory ops for selfVerification mode.
     *
     * The call to the handler is inserted prior to a heap memory operation.
     * This handler then calls a function to decode the memory op, and process
     * it accordingly. Afterwards, the handler changes the return address to
     * skip the memory op so it never gets executed.
     */
    vpush   {d0-d15}                    @ save out all fp registers
    push    {r0-r12,lr}                 @ save out all registers
    mov     r0, lr                      @ arg0 <- link register
    mov     r1, sp                      @ arg1 <- stack pointer
    ldr     r2, .LdvmSelfVerificationMemOpDecode @ defined in footer.S
    blx     r2                          @ decode and handle the mem op
    pop     {r0-r12,lr}                 @ restore all registers
    vpop    {d0-d15}                    @ restore all fp registers
    bx      lr                          @ return to compiled code
#endif
