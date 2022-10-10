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

    vdp_addr = $BF
    vdp_status = $BF
    
    jr main

vbl:    
    .ORG $0038
    in a,(vdp_status)
    
    dec d
    jr nz,done
    dec b

    ld d,$80
    ld c,$07
    call set_reg
    
done:
    ei
    reti
    
main:
    di
    im 1
    
    ld bc,$00
    call set_reg

    ld d,$FF
    
    ld bc,$e001
    call set_reg

    ld b,$00
    ld d,$80

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
