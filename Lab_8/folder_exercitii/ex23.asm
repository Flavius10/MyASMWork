; Se da numele unui fisier si un numar pe cuvant scris in memorie. Sa se scrie cifrele hexazecimale ale acestui numar ca text in fisier, fiecare cifra pe o linie separata. 

bits 32 
global start        


extern exit, printf, scanf, fopen, fclose, fprintf, fread  
             
import exit msvcrt.dll   
import printf msvcrt.dll   
import scanf msvcrt.dll   
import fopen msvcrt.dll   
import fclose msvcrt.dll   
import fprintf msvcrt.dll   
import fread msvcrt.dll   

segment data use32 class=data

    mod_acces db "w", 0
    descriptor dd -1
    file_name db "ex23.txt", 0
    
    format_string db "%s", 0
    format_int db "%d", 0
    format_caracter db "%c", 0
    format_hexa db "%X", 10, 0
    
    numar dd 0xABCDEF
    
    cat dd 0
    
    cifre times 30 db 0
    
segment code use32 class=code
start:
   
    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    
    push mod_acces
    push file_name
    call [fopen]
    add esp, 2 * 4
    
    mov [descriptor], eax
    
    cmp eax, 0
    je final
    
    xor edx, edx
    mov eax, [numar]
    
    cmp eax, 0
    je close_file
    
    mov ecx, 16
    
    mov edi, cifre
    
    citeste_cifra_cu_cifra:
        push ecx
    
        cmp eax, 0
        je literele
    
        div ecx
        mov [cat], eax
        
        mov [edi + ebx], edx
        inc ebx
        
        xor edx, edx
        mov eax, dword [cat]
        
        pop ecx
    
    jmp citeste_cifra_cu_cifra
    
    literele:
    
    mov esi, cifre
    dec ebx
    
    scrie_litere:
        
        mov al, [esi + ebx]
        
        cmp al, 0
        je close_file
        
        push eax
        push format_hexa
        push dword [descriptor]
        call [fprintf]
        add esp, 3 * 4
        
        dec ebx
        
    loop scrie_litere
        
   
    close_file:
    push dword [descriptor]
    call [fclose]
    add esp, 1 * 4
   
    final:
    push    dword 0      ; push the parameter for exit onto the stack
    call    [exit]       ; call exit to terminate the program
