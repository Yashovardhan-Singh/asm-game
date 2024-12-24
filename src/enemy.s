BITS 64

extern DrawRectangle
extern GetRandomValue

global initEnemies
global drawEnemies
global updateEnemies
global initEnemyDirections

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

    mov rdi, 0
    mov rsi, 1
    call GetRandomValue

    lea r12, [enemies_dirs + (rbx*4)]
    mov dword [r12], eax

    inc rbx
    cmp rbx, MAX_ENEMIES
    jle .loop
    
    ret

drawEnemies:
    xor rbx, rbx
.loop:
    lea r12, [enemies + (rbx*8)]

    mov rdi, [r12]
    mov rsi, [r12 + 4]
    mov rdx, 32
    mov rcx, 32
    mov r8, 0xFFFFFFFF
    call DrawRectangle
    
    inc rbx    
    cmp rbx, MAX_ENEMIES
    jl .loop
    ret

; TODO: Fix whatever is happening
updateEnemies:
    xor rbx, rbx
.loop:
    cmp dword [enemies + (rbx*8)], 0
    jz .negative
    jg .positive
.post_set:
    inc rbx
    cmp rbx, MAX_ENEMIES
    jl .loop
    jp .exit
.negative:
    sub dword [enemies + (rbx*8)], 12
    jp .post_set
.positive:
    add dword [enemies + (rbx*8)], 12
    jp .post_set
.exit:
    ret