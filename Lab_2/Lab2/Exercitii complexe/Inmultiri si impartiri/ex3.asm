bits 32
global start
extern exit, printf
import exit msvcrt.dll
import printf msvcrt.dll
 
segment data use32 class=data
    a  db 6
    b  db 4
    c  db 3
    d  dw 2
 
    print_frm db 'Rezultatul este: %hd', 0
    catul_frm db 'Catul este: %hd', 10, 13, 0
    rest_frm db 'Restul este: %hd' , 0
 
segment code use32 class=code
start:
    xor eax, eax
    xor edx, edx
    xor ebx, ebx
 
    mov al, [b]     ; al = b
    add al, 1       ; al = b + 1
 
    movsx ecx, al   ; ecx = b + 1
    mov eax, 2
    imul ecx        ; eax = 2 * (b + 1)
 
    movsx edx, word [d] ; edx = d
    sub edx, eax    ; edx = d - 2 * (b + 1)
    add edx, -1     ; edx = -1 + d - 2 * (b + 1)
 
    movsx ebx, byte [a] ; ebx = a
    mov eax, edx
    ;xor edx, edx    ; edx = 0
    cdq
 
    idiv ebx        ; eax = (-1 + d - 2 * (b + 1)) / a, edx = remainder
 
    push edx        ; salvam edx, se strica la printf 
    push eax
    push catul_frm
    call [printf]
    add esp, 8
 
    pop edx
    push edx
    push rest_frm
    call [printf]
    add esp, 8
 
    push    dword 0      ; push the parameter for exit onto the stack
    call    [exit]       ; call exit to terminate the program