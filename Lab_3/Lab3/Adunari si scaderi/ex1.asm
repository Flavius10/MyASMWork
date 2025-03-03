; a - byte, b - word, c - double word, d - qword - Interpretare fara semn
; c-(a+d)+(b+d) 
bits 32 

global start        


extern exit, printf               
import exit msvcrt.dll    
import printf msvcrt.dll  
  
segment data use32 class=data
    
    a db 10
    b dw 5
    c dd 6
    d dq 100

    print_frm db 'Rezulatul este: %d'
    
segment code use32 class=code
start:
   
    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    
    mov al, [a]
    cbw
    cwd
    cdq  ; edx:eax = a
    
    add eax, [d] 
    mov ecx, eax  ; ecx = a + d
    
    xor eax, eax
    
    mov eax, [c]
    sub eax, ecx  ; eax = c - (a + d)
    
    xor ecx, ecx  ; ecx = 0
    mov ecx, eax  ; ecx = c - (a + d)
    
    
    mov eax, ecx
    
    add eax, [d]  ; eax = c - (a + d) + d
    
    xor ecx, ecx
    mov ecx, eax
    xor eax, eax
    
    mov ax, [b]
    
    cwde
    
    add eax, ecx
    
    push eax
    push print_frm
    call [printf]
    add esp, 8
    
   
    push    dword 0      ; push the parameter for exit onto the stack
    call    [exit]       ; call exit to terminate the program
