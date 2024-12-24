BITS 64

%include "include/hardware.inc"

extern DrawRectangle
extern colorWhite
extern IsKeyDown

global initPlayer
global drawPlayer
global moveLeft
global moveRight

section .bss
p_rect_pos: resd 1

section .text

initPlayer:
    mov rax, 20
    mov [p_rect_pos], rax
    ret

drawPlayer:
    mov rdi, [p_rect_pos]
    mov rsi, 600
    mov rdx, 32
    mov rcx, 32
    mov r8,  0xFFFFFFFF
    call     DrawRectangle
    ret

moveLeft:
    mov rdi, KEY_A
    call IsKeyDown
    cmp rax, 1
    jnz .exit
    sub dword [p_rect_pos], 12
    cmp dword [p_rect_pos], 0
    jge .exit                       ; Little endian?
    mov [p_rect_pos], rax
.exit:
    ret

moveRight:
    mov rdi, KEY_D
    call IsKeyDown
    cmp rax, 1
    jnz .exit
    add dword [p_rect_pos], 12
    cmp dword [p_rect_pos], 1248
    jle .exit                       ; Little endian?
    mov [p_rect_pos], rax
.exit:
    ret