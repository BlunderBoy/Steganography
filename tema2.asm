%include "include/io.inc"
;Macarie Razvan-Cristian, 322CB
extern atoi
extern printf
extern exit

; Functions to read/free/print the image.
; The image is passed in argv[1].
extern read_image
extern free_image
; void print_image(int* image, int width, int height);
extern print_image

; Get image's width and height.
; Store them in img_[width, height] variables.
extern get_image_width
extern get_image_height

section .data
	use_str db "Use with ./tema2 <task_num> [opt_arg1] [opt_arg2]", 10, 0
        proverb db "C'est un proverbe francais.", 0
        Amorse db ".- ", 0
        Bmorse db "-... ", 0
        Cmorse db "-.-. ", 0
        Dmorse db "-.. ", 0
        Emorse db ". ", 0
        Fmorse db "..-. ", 0
        Gmorse db "--. ", 0
        Hmorse db ".... ", 0
        Imorse db ".. ", 0
        Jmorse db ".--- ", 0
        Kmorse db ".-. ", 0
        Lmorse db ".-.. ", 0
        Mmorse db "-- ", 0
        Nmorse db "-. ", 0
        Omorse db "--- ", 0
        Pmorse db ".--. ", 0
        Qmorse db "--.- ", 0
        Rmorse db ".-. ", 0
        Smorse db "... ", 0
        Tmorse db "- ", 0
        Umorse db "..- ", 0
        Vmorse db "...- ", 0
        Wmorse db ".-- ", 0
        Xmorse db "-..- ", 0
        Ymorse db "-.-- ", 0
        Zmorse db "--.. ", 0
        morse0 db "----- ", 0
        morse1 db ".---- ", 0
        morse2 db "..--- ", 0
        morse3 db "...-- ", 0
        morse4 db "----. ", 0
        morse5 db "..... ", 0
        morse6 db "-.... ", 0
        morse7 db "--... ", 0
        morse8 db "---.. ", 0
        morse9 db "----. " , 0
        morse_virgula db "--..-- ", 0
        morse_spatiu db " ", 0

section .bss
    task:       resd 1
    img:        resd 1
    img_width:  resd 1
    img_height: resd 1

section .text
bruteforce_singlebyte_xor:
    push ebp
    mov ebp, esp
    
    xor eax, eax
    xor edx, edx
    xor ecx, ecx
    xor edx, edx
    xor edi, edi ; cheie
    xor esi, esi
    
for_cheie: 
    cmp edi, 255
    jae final
    
    
    mov ecx, 0
    for_linie: ;ebx matricea, ecx i, edx j, edi cheia
    cmp ecx, [img_height] ;conditia de iesire din forul mare (i < inaltime)
    jae end_linie
       ;PRINT_UDEC 4, ecx
       ;PRINT_STRING " - "
        mov edx, 0
        for_coloana:
           cmp edx, [img_width]
           jae end_coloana

           push ecx 
           push edx
           push eax
           mov eax, ecx
           mul dword [img_width] ; eax = ecx * lungime
           mov ecx, eax ; ecx = eax = ecx * lungime
           pop eax
           pop edx
        
           add ecx, edx ; ecx = ecx * lungime + edx

           mov ebx, [ebp+8] ;punem in ebx adresa lui img
           mov ebx, [ebx + ecx * 4] ; adresa matricii + ecx * lungime *4 + edx * 4
           ;PRINT_UDEC 4, ecx
           xor ebx, edi ; z = ebx de aici incolo
           ;PRINT_UDEC 4, edx
           ;PRINT_UDEC 4, ebx
          ; PRINT_STRING " "
            
           cmp ebx, 'r'
           jne nu_e_stringul
      
           add ecx, 1
           mov ebx, [ebp+8] 
           mov ebx, [ebx + ecx * 4] 
           xor ebx, edi ; z = ebx de aici incolo
           cmp ebx, 'e'
           jne nu_e_stringul
           
           add ecx, 1
           mov ebx, [ebp+8] 
           mov ebx, [ebx + ecx * 4] 
           xor ebx, edi ; z = ebx de aici incolo
           cmp ebx, 'v'
           jne nu_e_stringul
           
           add ecx, 1
           mov ebx, [ebp+8] 
           mov ebx, [ebx + ecx * 4] 
           xor ebx, edi ; z = ebx de aici incolo
           cmp ebx, 'i'
           jne nu_e_stringul
           
           add ecx, 1
           mov ebx, [ebp+8] 
           mov ebx, [ebx + ecx * 4] 
           xor ebx, edi ; z = ebx de aici incolo
           cmp ebx, 'e'
           jne nu_e_stringul
           
           add ecx, 1
           mov ebx, [ebp+8] 
           mov ebx, [ebx + ecx * 4] 
           xor ebx, edi ; z = ebx de aici incolo
           cmp ebx, 'n'
           jne nu_e_stringul    
           
           
           ;cand gasim stringul revient printam pana la \0
           pop ecx ; linia care contine mesajul
           mov esi, ecx
           push ecx 
           push edx
           push eax
           mov eax, ecx
           mul dword [img_width] ; eax = ecx * lungime
           mov ecx, eax ; ecx = eax = ecx * lungime
           pop eax
           pop edx
           ;in ecx * 4 am adresa de inceput a linie care contine mesajul
           
           mov eax, edi
           shl eax, 16
           xor eax, esi
          ; PRINT_UDEC 4, eax ; cheie/linie
           
           jmp final
                     
nu_e_stringul:       
           pop ecx
           inc edx
           jmp for_coloana
        end_coloana:
   ; NEWLINE
    inc ecx
    jmp for_linie   
    
    end_linie:
    inc edi
   ; NEWLINE        
    ;NEWLINE
    jmp for_cheie
final:   
    leave
    ret
    
xor_crypt:
    ;PRINT_UDEC 4, [ebp+8]
    ;NEWLINE
    push ebp
    mov ebp, esp
    ;in eax am cheie/linie
    mov esi, eax
    shl esi, 16
    shr esi, 16 ; am in esi linia cu la care punem mesajul
    inc esi
    
    mov edi, eax
    shr edi, 16 ; am in edi cheia cu care criptez si o modific
    add edi, edi ; key *= 2
    add edi, 3 ; key += 3
    
    xor edx, edx
    mov eax, edi
    mov ebx, 5
    div ebx 
    mov edi, eax ;key /= 5, restul in edx
    
    sub edi, 4 ;key -= 4
    
    
    mov ecx, 0
    for_linie_cript: ;ebx matricea, ecx i, edx j, edi cheia
    cmp ecx, [img_height] ;conditia de iesire din forul mare (i < inaltime)
    jae final_cript
        mov edx, 0
        for_coloana_cript:
           cmp edx, [img_width]
           jae end_coloana_cript
           
           cmp ecx, esi ; compar linia pe care trebuie sa pun mesajul cu linia curenta
           jne nu_printa_mesaj_ascuns
           xor ebx, ebx
           mov eax, 0
mesaj_ascuns:           
           mov bl, byte [proverb + eax]
           cmp bl, 0
           je gata_mesaj_ascuns
           ;xor ebx, [ebp+12] ; xor cu cheia veche
           xor ebx, edi ; xor cu cheia noua
           ;PRINT_UDEC 4, edx
           PRINT_UDEC 4, ebx
           PRINT_STRING " "
           inc eax
           jmp mesaj_ascuns
gata_mesaj_ascuns:
            mov edx, eax
            mov ebx, 0
            xor ebx, edi ; xor cu cheia noua
            PRINT_UDEC 4, ebx
            PRINT_STRING " "
            inc edx
            ;dec edx?   
print_restul:
           cmp edx, [img_width]
           jae end_coloana_cript
           push ecx 
           push edx
           push eax
           mov eax, ecx
           mul dword [img_width] ; eax = ecx * lungime
           mov ecx, eax ; ecx = eax = ecx * lungime
           pop eax
           pop edx
           
           add ecx, edx ; ecx = ecx * lungime + edx
           mov ebx, [ebp+8] ;punem in ebx adresa lui img
           mov ebx, [ebx + ecx * 4] ; adresa matricii + ecx * lungime *4 + edx * 4
           ;PRINT_UDEC 4, ecx
           xor ebx, [ebp+12] ; xor cu cheia veche
           xor ebx, edi ; xor cu cheia noua
           ;PRINT_UDEC 4, edx
           PRINT_UDEC 4, ebx
           PRINT_STRING " "
           pop ecx
           inc edx
           
           jmp print_restul
           
nu_printa_mesaj_ascuns:
           push ecx 
           push edx
           push eax
           mov eax, ecx
           mul dword [img_width] ; eax = ecx * lungime
           mov ecx, eax ; ecx = eax = ecx * lungime
           pop eax
           pop edx
        
           add ecx, edx ; ecx = ecx * lungime + edx

           mov ebx, [ebp+8] ;punem in ebx adresa lui img
           mov ebx, [ebx + ecx * 4] ; adresa matricii + ecx * lungime *4 + edx * 4
           ;PRINT_UDEC 4, ecx
           xor ebx, [ebp+12]; xor cu cheia veche
           xor ebx, edi ; xor cu cheia noua
           ;PRINT_UDEC 4, edx
           PRINT_UDEC 4, ebx
           PRINT_STRING " "
           
           pop ecx
           inc edx
         jmp for_coloana_cript              
end_coloana_cript:
    NEWLINE
    inc ecx
    jmp for_linie_cript
       
final_cript:
    leave
    ret
    
blur:
    push ebp
    mov ebp, esp
    
    xor ecx, ecx
prima_linie:
    mov ebx, [ebp+8] ;punem in ebx adresa lui img
    mov ebx, [ebx + ecx * 4]
    PRINT_UDEC 4, ebx
    PRINT_STRING " "
    inc ecx
    cmp ecx, [img_width]
    jnz prima_linie
    NEWLINE
    
    mov edi, [img_height]
    dec edi
    
    mov ecx, 1
    for_linie_blur: ;ebx matricea, ecx i, edx j
    cmp ecx, edi ;conditia de iesire din forul mare (i < inaltime)
    jae final_blur
    mov edx, 0
        for_coloana_blur:
           cmp edx, [img_width]
           jae end_coloana_blur

           push ecx 
           push edx
           push eax
           mov eax, ecx
           mul dword [img_width] ; eax = ecx * lungime
           mov ecx, eax ; ecx = eax = ecx * lungime
           pop eax
           pop edx
        
           add ecx, edx ; ecx = ecx * lungime + edx
           mov ebx, [ebp+8] ;punem in ebx adresa lui img
           mov ebx, [ebx + ecx * 4]
           
           cmp edx, 0 ;daca e prima coloana
           je print_normal
           
           mov eax, [img_width] ; daca e ultima coloana
           dec eax
           cmp edx, eax
           je print_normal  
           
           xor eax, eax
           add eax, ebx; centru
           
           ;stanga
           push ecx
           sub ecx, 1
           mov ebx, [ebp+8] ;punem in ebx adresa lui img
           mov ebx, [ebx + ecx * 4] ; adresa matricii + ecx * lungime *4 + edx * 4
           add eax, ebx
           pop ecx
           
           ;dreapta
           push ecx
           add ecx, 1
           mov ebx, [ebp+8] ;punem in ebx adresa lui img
           mov ebx, [ebx + ecx * 4] ; adresa matricii + ecx * lungime *4 + edx * 4
           add eax, ebx
           pop ecx
           
           ;sus
           push ecx
           sub ecx, [img_width]
           mov ebx, [ebp+8] ;punem in ebx adresa lui img
           mov ebx, [ebx + ecx * 4] ; adresa matricii + ecx * lungime *4 + edx * 4
           add eax, ebx
           pop ecx
           
            ;jos
           push ecx
           add ecx, [img_width]
           mov ebx, [ebp+8] ;punem in ebx adresa lui img
           mov ebx, [ebx + ecx * 4] ; adresa matricii + ecx * lungime *4 + edx * 4
           add eax, ebx
           pop ecx
           
           ;impartim la 5 si afisam
           push edx
           xor edx, edx
           mov esi, 5
           div esi
           pop edx
           
           PRINT_UDEC 4, eax
           PRINT_STRING " "
           
           jmp gata_printul
print_normal:   
           PRINT_UDEC 4, ebx
           PRINT_STRING " "
           
           
gata_printul:          
          pop ecx
          inc edx
         jmp for_coloana_blur              
end_coloana_blur:
    NEWLINE
    inc ecx
    jmp for_linie_blur
    
final_blur:
    xor edx, edx
    mov eax, ecx
    mov ecx, [img_width]
    mul ecx
    mov ecx, eax
    xor edx, edx
ultima_linie:
    mov ebx, [ebp+8] ;punem in ebx adresa lui img
    mov ebx, [ebx + ecx * 4]
    PRINT_UDEC 4, ebx
    PRINT_STRING " "
    inc edx
    add ecx, 1
    cmp edx, [img_width]
    jnz ultima_linie
    
    leave
    ret
 
morse:
    push ebp
    mov ebp, esp
    
    mov eax, [ebp+16] ;offset
    mov ecx, eax ; pun in ecx offsetul
    
    mov eax, [ebp + 12] ;mesaj
    
    mov ebx, [ebp + 8] ; in ebp avem imaginea , in eax mesajul
    ;mov dword [ebx + ecx * 4], 66 ;asa suprascriem imaginea
    dec eax
loop_morse:
    inc eax
    xor esi, esi ; counter intern pentru fiecare string morse
    mov dl, byte[eax] ;verificam prima litera din mesaj
    
    cmp dl, 'A' ;daca e A
    je esteA
    cmp dl, 'B' ;daca e B
    je esteB
    cmp dl, 'C' ;daca e C
    je esteC
    cmp dl, 'D' ;daca e D
    je esteD
    cmp dl, 'E' ;daca e E
    je esteE
    cmp dl, 'F' ;daca e F
    je esteF
    cmp dl, 'G' ;daca e G
    je esteG
    cmp dl, 'H' ;daca e H
    je esteH
    cmp dl, 'I' ;daca e I
    je esteI
    cmp dl, 'J' ;daca e J
    je esteJ
    cmp dl, 'K' ;daca e K
    je esteK
    cmp dl, 'L' ;daca e L
    je esteL
    cmp dl, 'M' ;daca e M
    je esteM
    cmp dl, 'N' ;daca e N
    je esteN
    cmp dl, 'O' ;daca e O
    je esteO
    cmp dl, 'P' ;daca e P
    je esteP
    cmp dl, 'Q' ;daca e Q
    je esteQ
    cmp dl, 'R' ;daca e R
    je esteR
    cmp dl, 'S' ;daca e S
    je esteS
    cmp dl, 'T' ;daca e T
    je esteT
    cmp dl, 'U' ;daca e U
    je esteU
    cmp dl, 'V' ;daca e V
    je esteV
    cmp dl, 'W' ;daca e W
    je esteW
    cmp dl, 'X' ;daca e X
    je esteX
    cmp dl, 'Y' ;daca e Y
    je esteY
    cmp dl, 'Z' ;daca e Z
    je esteZ
    cmp dl, ',' ;daca e ,
    je esteVirgula
    cmp dl, 0 ;daca e \0
    je esteZero
    
    
    cmp dl, ' ' ;daca e spatiu
    je loop_morse
    
    
    jmp final_morse
esteZero:
    dec ecx
    mov ebx, [ebp + 8] ; in ebp avem imaginea , in eax mesajul
    mov dword [ebx + ecx * 4], 0 ;asa suprascriem imaginea
    jmp final_morse
esteA:
    mov dl, byte [Amorse + esi] ;punem in partea low din edi un octet din codificarea lui a
    cmp dl, 0
    je loop_morse
    mov ebx, [ebp + 8] ; in ebp avem imaginea , in eax mesajul
    mov dword [ebx + ecx * 4], edx ;asa suprascriem imaginea
    inc ecx
    inc esi
    jmp esteA
    
esteB:
    mov dl, byte [Bmorse + esi] 
    cmp dl, 0
    je loop_morse
    mov ebx, [ebp + 8] ; in ebp avem imaginea , in eax mesajul
    mov dword [ebx + ecx * 4], edx ;asa suprascriem imaginea
    inc ecx
    inc esi
    jmp esteB
    
esteC:
    mov dl, byte [Cmorse + esi] 
    cmp dl, 0
    je loop_morse
    mov ebx, [ebp + 8] ; in ebp avem imaginea , in eax mesajul
    mov dword [ebx + ecx * 4], edx ;asa suprascriem imaginea
    inc ecx
    inc esi
    jmp esteC  
    
esteD:
    mov dl, byte [Dmorse + esi] 
    cmp dl, 0
    je loop_morse
    mov ebx, [ebp + 8] ; in ebp avem imaginea , in eax mesajul
    mov dword [ebx + ecx * 4], edx ;asa suprascriem imaginea
    inc ecx
    inc esi
    jmp esteD  

esteE:
    mov dl, byte [Emorse + esi] 
    cmp dl, 0
    je loop_morse
    mov ebx, [ebp + 8] ; in ebp avem imaginea , in eax mesajul
    mov dword [ebx + ecx * 4], edx ;asa suprascriem imaginea
    inc ecx
    inc esi
    jmp esteE 

esteF:
    mov dl, byte [Fmorse + esi] 
    cmp dl, 0
    je loop_morse
    mov ebx, [ebp + 8] ; in ebp avem imaginea , in eax mesajul
    mov dword [ebx + ecx * 4], edx ;asa suprascriem imaginea
    inc ecx
    inc esi
    jmp esteF

esteG:
    mov dl, byte [Gmorse + esi] 
    cmp dl, 0
    je loop_morse
    mov ebx, [ebp + 8] ; in ebp avem imaginea , in eax mesajul
    mov dword [ebx + ecx * 4], edx ;asa suprascriem imaginea
    inc ecx
    inc esi
    jmp esteG

esteH:
    mov dl, byte [Hmorse + esi] 
    cmp dl, 0
    je loop_morse
    mov ebx, [ebp + 8] ; in ebp avem imaginea , in eax mesajul
    mov dword [ebx + ecx * 4], edx ;asa suprascriem imaginea
    inc ecx
    inc esi
    jmp esteH

esteI:
    mov dl, byte [Imorse + esi] 
    cmp dl, 0
    je loop_morse
    mov ebx, [ebp + 8] ; in ebp avem imaginea , in eax mesajul
    mov dword [ebx + ecx * 4], edx ;asa suprascriem imaginea
    inc ecx
    inc esi
    jmp esteI

esteJ:
    mov dl, byte [Jmorse + esi] 
    cmp dl, 0
    je loop_morse
    mov ebx, [ebp + 8] ; in ebp avem imaginea , in eax mesajul
    mov dword [ebx + ecx * 4], edx ;asa suprascriem imaginea
    inc ecx
    inc esi
    jmp esteJ

esteK:
    mov dl, byte [Kmorse + esi] 
    cmp dl, 0
    je loop_morse
    mov ebx, [ebp + 8] ; in ebp avem imaginea , in eax mesajul
    mov dword [ebx + ecx * 4], edx ;asa suprascriem imaginea
    inc ecx
    inc esi
    jmp esteK

esteL:
    mov dl, byte [Lmorse + esi] 
    cmp dl, 0
    je loop_morse
    mov ebx, [ebp + 8] ; in ebp avem imaginea , in eax mesajul
    mov dword [ebx + ecx * 4], edx ;asa suprascriem imaginea
    inc ecx
    inc esi
    jmp esteL

esteM:
    mov dl, byte [Mmorse + esi] 
    cmp dl, 0
    je loop_morse
    mov ebx, [ebp + 8] ; in ebp avem imaginea , in eax mesajul
    mov dword [ebx + ecx * 4], edx ;asa suprascriem imaginea
    inc ecx
    inc esi
    jmp esteM

esteN:
    mov dl, byte [Nmorse + esi] 
    cmp dl, 0
    je loop_morse
    mov ebx, [ebp + 8] ; in ebp avem imaginea , in eax mesajul
    mov dword [ebx + ecx * 4], edx ;asa suprascriem imaginea
    inc ecx
    inc esi
    jmp esteN

esteO:
    mov dl, byte [Omorse + esi] 
    cmp dl, 0
    je loop_morse
    mov ebx, [ebp + 8] ; in ebp avem imaginea , in eax mesajul
    mov dword [ebx + ecx * 4], edx ;asa suprascriem imaginea
    inc ecx
    inc esi
    jmp esteO

esteP:
    mov dl, byte [Pmorse + esi] 
    cmp dl, 0
    je loop_morse
    mov ebx, [ebp + 8] ; in ebp avem imaginea , in eax mesajul
    mov dword [ebx + ecx * 4], edx ;asa suprascriem imaginea
    inc ecx
    inc esi
    jmp esteP

esteQ:
    mov dl, byte [Qmorse + esi] 
    cmp dl, 0
    je loop_morse
    mov ebx, [ebp + 8] ; in ebp avem imaginea , in eax mesajul
    mov dword [ebx + ecx * 4], edx ;asa suprascriem imaginea
    inc ecx
    inc esi
    jmp esteQ

esteR:
    mov dl, byte [Rmorse + esi] 
    cmp dl, 0
    je loop_morse
    mov ebx, [ebp + 8] ; in ebp avem imaginea , in eax mesajul
    mov dword [ebx + ecx * 4], edx ;asa suprascriem imaginea
    inc ecx
    inc esi
    jmp esteR

esteS:
    mov dl, byte [Smorse + esi] 
    cmp dl, 0
    je loop_morse
    mov ebx, [ebp + 8] ; in ebp avem imaginea , in eax mesajul
    mov dword [ebx + ecx * 4], edx ;asa suprascriem imaginea
    inc ecx
    inc esi
    jmp esteS

esteT:
    mov dl, byte [Tmorse + esi] 
    cmp dl, 0
    je loop_morse
    mov ebx, [ebp + 8] ; in ebp avem imaginea , in eax mesajul
    mov dword [ebx + ecx * 4], edx ;asa suprascriem imaginea
    inc ecx
    inc esi
    jmp esteT

esteU:
    mov dl, byte [Umorse + esi] 
    cmp dl, 0
    je loop_morse
    mov ebx, [ebp + 8] ; in ebp avem imaginea , in eax mesajul
    mov dword [ebx + ecx * 4], edx ;asa suprascriem imaginea
    inc ecx
    inc esi
    jmp esteU

esteV:
    mov dl, byte [Vmorse + esi] 
    cmp dl, 0
    je loop_morse
    mov ebx, [ebp + 8] ; in ebp avem imaginea , in eax mesajul
    mov dword [ebx + ecx * 4], edx ;asa suprascriem imaginea
    inc ecx
    inc esi
    jmp esteV

esteW:
    mov dl, byte [Wmorse + esi] 
    cmp dl, 0
    je loop_morse
    mov ebx, [ebp + 8] ; in ebp avem imaginea , in eax mesajul
    mov dword [ebx + ecx * 4], edx ;asa suprascriem imaginea
    inc ecx
    inc esi
    jmp esteW

esteX:
    mov dl, byte [Xmorse + esi] 
    cmp dl, 0
    je loop_morse
    mov ebx, [ebp + 8] ; in ebp avem imaginea , in eax mesajul
    mov dword [ebx + ecx * 4], edx ;asa suprascriem imaginea
    inc ecx
    inc esi
    jmp esteX

esteY:
    mov dl, byte [Ymorse + esi] 
    cmp dl, 0
    je loop_morse
    mov ebx, [ebp + 8] ; in ebp avem imaginea , in eax mesajul
    mov dword [ebx + ecx * 4], edx ;asa suprascriem imaginea
    inc ecx
    inc esi
    jmp esteY

esteZ:
    mov dl, byte [Zmorse + esi] 
    cmp dl, 0
    je loop_morse
    mov ebx, [ebp + 8] ; in ebp avem imaginea , in eax mesajul
    mov dword [ebx + ecx * 4], edx ;asa suprascriem imaginea
    inc ecx
    inc esi
    jmp esteZ



esteVirgula:
    mov dl, byte [morse_virgula + esi] ;punem in partea low din edi un octet din codificarea lui a
    cmp dl, 0
    je loop_morse
    mov ebx, [ebp + 8] ; in ebp avem imaginea , in eax mesajul
    mov dword [ebx + ecx * 4], edx ;asa suprascriem imaginea
    inc ecx
    inc esi
    jmp esteVirgula
    
final_morse:
    leave
    ret

lsb_encode:
    push ebp
    mov ebp, esp
    
    mov eax, [ebp+16] ;offset
    mov ecx, eax ; pun in ecx offsetul
    
    mov eax, [ebp + 12] ;mesaj
    
    dec ecx
    
    
    ;mov dword [ebx + ecx * 4], 66 ;asa suprascriem imaginea
    dec eax
loop_mesaj:
    inc eax ;dec urmat de inc ca sa pot sa ii dau inc la fiecare iteratie
    xor edx, edx
    mov dl, byte[eax]
    
    mov edi, 1 ;shifeteru
    shl edi, 7
    mov esi, 8 ;conteru care face sa se faca shiftare de 8 ori
loop_caracter:
    test edx, edi
    jz am_gasit_0
                   ;cand gasesc un 1
    mov ebx, [ebp + 8] ; in ebx avem imaginea
    push eax
    mov eax, [ebx + 4 * ecx] ; pun in eax valoarea
    or eax, 1; pun pe lsb 1
    mov dword [ebx + ecx * 4], eax ; suprascriu valoarea
    pop eax
    inc ecx ; cresc cu 1 offsetul 
    dec esi
    shr edi, 1
    cmp esi, 0
    jnz loop_caracter
    
    cmp dl, 0
    jnz loop_mesaj
    
am_gasit_0: ;pentru cand fac test si da 0

    mov ebx, [ebp + 8] ; in ebx avem imaginea
    push eax
    mov eax, [ebx + 4 * ecx] ; pun in eax valoarea
    and eax, 254; pun pe lsb 0, e 11111110 si imi face primu bit 0
    mov dword [ebx + ecx * 4], eax ; suprascriu valoarea
    pop eax
    inc ecx ; cresc cu 1 offsetul 

    dec esi
    shr edi, 1
    cmp esi, 0
    jnz loop_caracter
        
    
    cmp dl, 0
    jnz loop_mesaj
    
    leave
    ret
lsb_decode:
    push ebp
    mov ebp, esp
    
    mov eax, [ebp+12] ;offset
    mov ecx, eax ; pun in ecx offsetul
    
    dec ecx
    mov ebx, [ebp + 8] ; in ebx avem imaginea
    xor edx, edx

caracter:  
    mov esi, 8
    xor edx, edx
cifra_din_imagine: 
    mov eax, [ebx + 4 * ecx] ; pun in eax valoarea
    shl eax, 31
    shr eax, 31
    
    shl edx, 1
    add edx, eax
    
    dec esi
    inc ecx
    
    cmp esi, 0
    jnz cifra_din_imagine
    
    cmp edx, 0
    jz final_lsb_decode
    PRINT_CHAR edx
    
    jmp caracter
   
final_lsb_decode: 
    leave
    ret
    
global main
main:
    mov ebp, esp; for correct debugging
    ; Prologue
    ; Do not modify!
    push ebp
    mov ebp, esp

    mov eax, [ebp + 8]
    cmp eax, 1
    jne not_zero_param

    push use_str
    call printf
    add esp, 4

    push -1
    call exit

not_zero_param:
    ; We read the image. You can thank us later! :)
    ; You have it stored at img variable's address.
    mov eax, [ebp + 12]
    push DWORD[eax + 4]
    call read_image
    add esp, 4
    mov [img], eax

    ; We saved the image's dimensions in the variables below.
    call get_image_width
    mov [img_width], eax

    call get_image_height
    mov [img_height], eax

    ; Let's get the task number. It will be stored at task variable's address.
    mov eax, [ebp + 12]
    push DWORD[eax + 8]
    call atoi
    add esp, 4
    mov [task], eax

    ; There you go! Have fun! :D
    mov eax, [task]
    cmp eax, 1
    je solve_task1
    cmp eax, 2
    je solve_task2
    cmp eax, 3
    je solve_task3
    cmp eax, 4
    je solve_task4
    cmp eax, 5
    je solve_task5
    cmp eax, 6
    je solve_task6
    jmp done

solve_task1:
    push dword [img]
    call bruteforce_singlebyte_xor
    add esp, 4
    mov ecx, eax
    shl ecx, 16
    shr ecx, 16
    mov esi, ecx
    mov edi, eax
    shr edi, 16
    
    xor edx, edx
    mov eax, [img_width]
    mul ecx ; linia * lungimea = ecx
    mov ecx, eax
    
printare_mesaj:
    mov ebx, [img]
    mov ebx, [ebx + ecx * 4] 
    xor ebx, edi
    cmp ebx, 16
    jb final_print
    PRINT_CHAR ebx
    inc ecx
    jmp printare_mesaj

final_print:
    NEWLINE
    PRINT_UDEC 4, edi
    NEWLINE
    PRINT_UDEC 4, esi
    NEWLINE
    jmp done
solve_task2:
    push 0
    push 0
    push 0
    call print_image
    add esp, 12
    push dword [img]
    call bruteforce_singlebyte_xor
    add esp, 4
    mov edx, eax
    shr edx, 16
    push dword edx
    push dword [img]
    call xor_crypt
    add esp, 8
    jmp done
solve_task3:
    mov eax, [ebp + 12] ; pun in eax argv
    mov eax, [eax + 16] ; pun in eax indicele
    push eax
    call atoi
    add esp, 4
    push eax ;byte id
    
    mov eax, [ebp + 12] ; pun in eax argv
    mov eax, [eax + 12] ; pun in eax mesajul
    push eax ;msg
    
    
    push dword [img] ; image
    call morse
    add esp, 4
    push dword [img_height]
    push dword [img_width]
    push dword [img]
    call print_image
    add esp, 12
    jmp done
solve_task4:

    mov eax, [ebp + 12] ; pun in eax argv
    mov eax, [eax + 16] ; pun in eax indicele
    push eax
    call atoi
    add esp, 4
    push eax ;byte id
    
    mov eax, [ebp + 12] ; pun in eax argv
    mov eax, [eax + 12] ; pun in eax mesajul
    push eax ;msg
    
    push dword [img] ; image
    call lsb_encode
    add esp, 12
    
    push dword [img_height]
    push dword [img_width]
    push dword [img]
    call print_image
    add esp, 12
    
    jmp done
solve_task5:
    mov eax, [ebp + 12] ; pun in eax argv
    mov eax, [eax + 12] ; pun in eax indicele
    push eax
    call atoi
    add esp, 4
    push eax ;byte id
    
    push dword [img] ; image
    call lsb_decode
    add esp, 8
    jmp done
solve_task6:
   push 0
   push 0
   push 0
   call print_image
   add esp, 12
   push dword[img]
   call blur
   add esp, 4
   ;void print_image(int* image, int width, int height);
   jmp done

    ; Free the memory allocated for the image.
done:
    push DWORD[img]
    call free_image
    add esp, 4

    ; Epilogue
    ; Do not modify!
    xor eax, eax
    leave
    ret