; Se dau un octet A si un cuvant B. Sa se obtina un octet C care are pe bitii 0-3 bitii 2-5 ai lui A, ; iar pe bitii 4-7 bitii 6-9 ai lui B. 

bits 32
global start        

extern exit, printf              
import exit msvcrt.dll    
import printf msvcrt.dll    

segment data use32 class=data
    
    A db 10001010b
    B dw 1010110101000101b 
    C db 0  ; 01010010
    
    print_frm db 'Rezultatul este: %d', 0
    
segment code use32 class=code
start:

    xor eax, eax
    xor edx, edx
    xor ebx, ebx  ; aici se va salva C
    xor ecx, ecx 
    
    mov al, [A]
    and al, 00111100b  ; al = 00001000
    shr al, 2
    or ebx, eax        ; 00000010 = ebx = 2
    
    xor eax, eax
    mov ax, [B]
    and ax, 0000001111000000b  ; 0101000000 - cei patru biti  
    shr ax, 2
    or ebx, eax  ; 01010010
    
    mov [C], ebx
  
    
    push    dword 0     
    call    [exit]