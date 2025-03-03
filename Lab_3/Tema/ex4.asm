; a - byte, b - word, c - double word, d - qword - Interpretare cu semn
; (a + b - c) + (a + b + d) - (a + b) = -39

bits 32 
global start        


extern exit, printf           
import exit msvcrt.dll   
import printf msvcrt.dll   
segment data use32 class=data
   
   a db 4
   b dw -50
   c dd 3
   d dq 10
   
   print_frm db 'Rezultatul este %d', 0
   
   
segment code use32 class=code
start:

    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    
    mov al, [a]
    cbw
    add ax, [b]
    cwde
    sub eax, [c]
    mov ecx, eax ; ecx = (a + b - c)
    
    xor eax, eax
    
    mov al, [a]
    cbw
    add ax, [b]
    cwde
    
    sub ecx, eax  ; ecx = (a + b - c) - (a + b) 
    
    xor eax, eax
    mov al, [a]
    cbw
    add ax, [b]
    cwde
    
    add ecx, eax ; ecx = (a + b - c) - (a + b) + a + b
    
    xor eax, eax
    mov eax, ecx
    
    cdq
    
    add eax, [d]
    
    push eax
    push print_frm
    call [printf]
    add esp, 2 * 4
    
   
    push    dword 0      ; push the parameter for exit onto the stack
    call    [exit]       ; call exit to terminate the program
