; boot.asm

BITS 16
ORG 0x7C00

start:
    ; set up the stack and data segment
    mov ax, 0           ; intermediate register
    mov ds, ax          ; set DS to 0
    mov es, ax          ; set ES to 0
    mov ss, ax          ; set SS to 0
    mov sp, 0x7C00      ; set stack pointer ss:sp 0000:7C00

    ; execute the main function
    mov si, hello
    call print_string

print_string:
    mov     ah, 0x0E    ; BIOS teletype function
.loop:
    lodsb               ; Load byte at DS:SI into AL and increment SI
    cmp     al, 0       ; Check for null terminator
    je      .done       ; If null terminator, jump to done
    int     0x10        ; Call BIOS interrupt to print character in AL
    jmp    .loop        ; Repeat for next character
.done:
    ret                 ; Return from the function


;data
hello: db "Hello, welcome to my OS!", 0

times 510 - ($ - $$) db 0
dw 0xAA55
