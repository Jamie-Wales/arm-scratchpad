
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define HEAP_SIZE 1024 * 1024 // 1 MB heap

static uint8_t heap[HEAP_SIZE];
static uint8_t* heap_ptr = heap;

void* gc_alloc(size_t size)
{
    printf("Allocating memory of size %zu \n", size);
    if (heap_ptr + size > heap + HEAP_SIZE) {
        fprintf(stderr, "Heap overflow, out of memory!\n");
        exit(1);
    }

    void* ptr = heap_ptr;
    heap_ptr += size;
    return ptr;
}

void gc_free(void* ptr, size_t size)
{
    printf("Deallocating %p \n", ptr);
    (void)ptr;
    (void)size;
}

void print_string(const char* str)
{
    printf("%s\n", str);
}
