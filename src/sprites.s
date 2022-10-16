    .MEMORYMAP
    SLOTSIZE $8000
    DEFAULTSLOT 0
    SLOT 0 $0000
    .ENDME

    .ROMBANKMAP
    BANKSTOTAL 1
    BANKSIZE $8000
    BANKS 1
    .ENDRO
    
    .BANK 0 SLOT 0
    .ORGA $0000

    vdp_data = $BE
    vdp_addr = $BF
    vdp_status = $BF

    joy1 = $DC 
    
    jr main

vbl:    
    .org $0038
    in a,(vdp_status)

    in a,(joy1)
    bit 3,a

    jr nz,done

    inc d
    
    ld a,$01
    out (vdp_addr),a
    ld a,$7b
    out (vdp_addr),a
    ld a,d
    out (vdp_data),a
    
done:   
    ei
    reti
    
main:
    di
    im 1
    
    ld bc,$0200
    call set_reg

    ld bc,$e201
    call set_reg

    ld bc,$0e02
    call set_reg

    ld bc,$9f03
    call set_reg

    ld bc,$0004
    call set_reg

    ld bc,$7605
    call set_reg

    ld bc,$0306
    call set_reg
    
    ld bc,$0407
    call set_reg

    ; Setup sprite line
    ld a,$00
    out (vdp_addr),a
    ld a,$58
    out (vdp_addr),a
    ld a,$55
    out (vdp_data),a
    out (vdp_data),a
    out (vdp_data),a
    out (vdp_data),a

    ; Set sprite attributes
    ld a,$00
    out (vdp_addr),a
    ld a,$7b
    out (vdp_addr),a
    ld a,$ff
    out (vdp_data),a
    ld a,$00
    out (vdp_data),a
    out (vdp_data),a
    ld a,$06
    out (vdp_data),a

    ld d,$00
    
    ei
    
loop:   
    halt
    jr loop
    
set_reg:
    push af
    ld a,b
    out (vdp_addr),a
    ld a,$80
    or c
    out (vdp_addr),a
    pop af
    ret

set_addr:
    push af
    push hl
    ld hl,vdp_addr
    ld (hl),b
    ld a,$40
    or c
    ld (hl),a
    pop hl
    pop af
    ret

sprites:
    .db 00
