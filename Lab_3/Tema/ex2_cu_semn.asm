; a - byte, b - word, c - double word, d - qword
; (a+c)-b+a + (d-c) = -5

bits 32 
global start        


extern exit, printf           
import exit msvcrt.dll   
import printf msvcrt.dll   
segment data use32 class=data
   
   a db 1
   b dw 7
   c dd 1
   d dq 0
   
   print_frm db 'Rezultatul este %d', 0
   
   
segment code use32 class=code
start:

    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    
    mov al, [a]
    cbw
    cwde
    add eax, [c] ; eax = a + c
    mov ebx, eax  ; ebx = eax = a + c
    
    xor eax, eax
    
    mov ax, [b]
    cwde
    sub ebx, eax  ; ebx = a + c - b
    
    xor eax, eax
    
    mov al, [a]
    cbw
    cwde
    add ebx, eax  ; ebx = (a+c)- b + a
    
    xor eax, eax
    mov eax, [c]
    sub ebx, eax  ; ebx = (a+c)- b + a - c
    
    xor eax, eax
    mov eax, ebx
    cdq
    
    add eax, [d]
    
    push eax
    push print_frm
    call [printf]
    add esp, 2 * 4
    
   
    push    dword 0      ; push the parameter for exit onto the stack
    call    [exit]       ; call exit to terminate the program
