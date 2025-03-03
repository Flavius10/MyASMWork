bits 32

global start

extern exit, printf
import exit msvcrt.dll
import printf msvcrt.dll

segment data public use32 class=data

    a dd 0
    b dd 0


segment code public use32 class=code

start:

    xor eax, eax
    xor ebx, ebx
    
    mov ebx, b
    
    mov eax, [ebx - a]
    
    push eax
    push format
    call [printf]
    add esp, 2 * 4

    push dword 0
    call [exit]