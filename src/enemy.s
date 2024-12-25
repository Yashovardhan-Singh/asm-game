BITS 64

extern DrawRectangle
extern GetRandomValue

global initEnemies
global drawEnemies
global updateEnemies
global initEnemyDirections
global enemies

MAX_ENEMIES equ 10

section .bss
    enemies: resd 3 * MAX_ENEMIES
    enemies_dirs: resd MAX_ENEMIES

section .text

initEnemies:
    xor rbx, rbx
.loop:
    mov rdi, 0
    mov rsi, 1248
    call GetRandomValue
    lea r12, [enemies + (rbx*8)]
    mov dword [r12], eax
    mov dword [r12 + 4], 50
    mov rdi, 1
    mov rsi, 2
    call GetRandomValue
    lea r12, [enemies_dirs + (rbx*4)]
    mov dword [r12], eax
    inc rbx
    cmp rbx, MAX_ENEMIES
    jle .loop
    ret

updateEnemies:
    xor rbx, rbx
.loop:
    call collideEnemy
    call moveEnemy
    call drawEnemies
    inc rbx
    cmp rbx, MAX_ENEMIES
    jl .loop
    ret

moveEnemy:
    cmp dword [enemies_dirs + (rbx*4)], 1
    je .negative
    cmp dword [enemies_dirs + (rbx*4)], 2
    je .positive
    jmp .exit
.negative:
    sub dword [enemies + (rbx*8)], 6
    jmp .exit
.positive:
    add dword [enemies + (rbx*8)], 6
    jmp .exit
.exit:
    ret

collideEnemy:
    cmp dword [enemies + (rbx*8)], 0
    jle .left
    cmp dword [enemies + (rbx*8)], 1248
    jge .right
    jmp .exit
.left:
    mov dword [enemies_dirs + (rbx*4)], 2
    add dword [enemies + (rbx*8) + 4], 25
    jmp .exit
.right:
    mov dword [enemies_dirs + (rbx*4)], 1
    add dword [enemies + (rbx*8) + 4], 25
.exit:
    ret

drawEnemies:
    mov rdi, [enemies + (rbx*8)]
    mov rsi, [enemies + (rbx*8) + 4]
    mov rdx, 32
    mov rcx, 32
    mov r8, 0xFFFFFFFF
    call DrawRectangle
    ret