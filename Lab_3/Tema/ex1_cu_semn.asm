; a - byte, b - word, c - double word, d - qword cu semn
; (a+b)-(a+d)+(c-a) 
; (-1 + (-10)) - (-1 + 3) + 7 = -11 - 2 + 7 = -6

bits 32 
global start        


extern exit, printf           
import exit msvcrt.dll   
import printf msvcrt.dll   
segment data use32 class=data
   
   a db -1
   b dw -10
   c dd 6
   d dq 3
   
   print_frm db 'Rezultatul este %d', 0
   
   
segment code use32 class=code
start:

    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    
    mov al, [a]
    cbw
    add ax, [b] ; ax = a + b
    cwde ; eax = a + b
    
    mov ecx, eax  ; ecx = a + b
    xor eax, eax
    xor ebx, ebx
    
    mov ebx, [c]
    mov al, [a]
    cbw
    cwde
    sub ebx, eax  ; ebx = c - a
    
    xor eax, eax
    mov eax, ebx  ; eax = c - a
    add eax, ecx  ; eax = a + b + c - a
    
    mov ebx, eax
    xor eax, eax
    mov al, [a]
    cbw
    cwde
    sub ebx, eax
    
    xor eax, eax
    mov eax, ebx
    
    xor ebx, ebx
    
    cdq
    
    sub eax, [d]
    
    push eax
    push print_frm
    call [pr    intf]
    add esp, 2 * 4
    
   
    push    dword 0      ; push the parameter for exit onto the stack
    call    [exit]       ; call exit to terminate the program
