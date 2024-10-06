// program.s

    .section __TEXT,__text
    .global _main

_main:
    // Prologue: Set up the stack frame
    stp     x29, x30, [sp, #-32]!   // Adjust sp by -32, store x29 and x30 at [sp]
    stp     x19, x20, [sp, #16]     // Store x19 and x20 at [sp + 16]
    mov     x29, sp                 // Set x29 (frame pointer) to sp

    // Allocate memory for the message (16 bytes)
    mov     x0, #16                 // Argument: size = 16 bytes
    bl      _gc_alloc               // Call gc_alloc(size)
    mov     x19, x0                 // Save allocated pointer in x19

    // Store the message "Hello, World!" into the allocated memory
    mov     x0, x19                 // x0 = destination (allocated memory)
    adrp    x1, message@PAGE        // x1 = source (message)
    add     x1, x1, message@PAGEOFF
    mov     x2, #14                 // x2 = length of the message
    bl      _memcpy                 // Call memcpy(dest, src, size)

    // Call print_string(allocated_memory)
    mov     x0, x19                 // Argument: pointer to the message
    bl      _print_string           // Call print_string(str)

    // Deallocate the memory
    mov     x0, x19                 // Argument: pointer to the allocated memory
    mov     x1, #16                 // Argument: size of the allocated memory
    bl      _gc_free                // Call gc_free(ptr, size)

    // Epilogue: Restore the stack frame
    mov     w0, #0                  // Return value: 0
    ldp     x19, x20, [sp, #16]     // Restore x19 and x20 from [sp + 16]
    ldp     x29, x30, [sp], #32     // Restore x29 and x30, adjust sp by +32
    ret

    .section __TEXT,__cstring
message:
    .asciz "Hello, World!"
