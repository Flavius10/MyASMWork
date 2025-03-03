bits 32

global _validare_secventa

; extern exit
; extern printf
; extern scanf              
; import exit msvcrt.dll  
; import printf msvcrt.dll  
; import scanf msvcrt.dll  

segment data use32 class=data
    
    litera db 0, 0

    cuvinte times 200 db 0, 0
    cuvant1 dd 0, 0      
    cuvant2 dd 0, 0  

    ascii_new_line db 0Ah   
    
    mesaj db "1 - Cuvantul este secventa/ 0 - Cuvantul nu este secventa: %d", 0
    
    format_citire db "%s"
    format_scriere db "%s", 0
    
    format_citire_caracter db "%c", 0
    format_scriere_caracter db "%c ", 0
    print_len db "%d ", 0
    
    len_cuvant_1 dd 0, 0
    len_cuvant_2 dd 0, 0

segment code use32 class=code
_validare_secventa:

    push ebp
    mov ebp, esp

    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    
    xor edi, edi
    xor esi, esi
    
    mov esi, [esp + 8]
    mov edi, [esp + 12]
    
    mov eax, edi
    
    verifica:
            mov al, [esi]  
            test al, al   
            je secventa_gasita

            mov bl, [edi]  
            test bl, bl    
            je secventa_negasita

            cmp al, bl
            jne urmatorul_caracter

            inc esi
            inc edi
            jmp verifica

        urmatorul_caracter:
            mov esi, [ebp + 8] 
            inc edi
    jmp verifica

    secventa_gasita:
        mov eax, 1
        jmp final

    secventa_negasita:
        mov eax, 0
    
    final:
   
    mov esp, ebp
    pop ebp
    
    ret
