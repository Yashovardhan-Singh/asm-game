BITS 64

extern DrawRectangle

global initEnemy
global drawEnemy

MAX_ENEMIES equ 10

section .bss
    enemies: resd 2 * MAX_ENEMIES

section .text

initEnemy:
    lea rsi, [enemies]
    xor rbx, rbx
    mov rcx, MAX_ENEMIES
.loop:
    cmp rbx, rcx
    jge .exit
    mov dword [rsi + (rbx*2)], 200
    mov dword [rsi + (rbx*2) + 1], 200
    inc rbx
    jmp .loop
.exit:
    ret

drawEnemy:
    lea rsi ,[enemies]
    xor rbx, rbx
    mov rcx, MAX_ENEMIES
.loop:
    cmp rbx, rcx
    jge .exit
    mov rdi, [rsi + (rbx*2)]
    mov rsi, [rsi + (rbx*2) + 1]
    mov rdx, 32
    push rcx
    mov rcx, 32
    mov r8,  0xFFFFFFFF
    call     DrawRectangle
    pop rcx
    inc rbx
    jmp .loop
    ret
.exit:
    ret