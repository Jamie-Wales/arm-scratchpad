// File: call_c_functions.s

    .section __TEXT,__text
    .global _main

_main:
    mov     w0, #10                   // First argument (a)
    mov     w1, #20                   // Second argument (b)

    stp     x29, x30, [sp, #-16]!     // Push frame pointer and link register
    mov     x29, sp                   // Update frame pointer

    bl      _add_numbers              // Result will be in w0

    // Call print_result
    bl      _print_result

    ldp     x29, x30, [sp], #16       // Pop frame pointer and link register
    mov     w0, #0                    // Set return value to 0
    ret
