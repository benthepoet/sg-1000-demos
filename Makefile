rom.bin: main.obj
	wlalink linkfile bin/rom.bin

main.obj:
	wla-z80 -o bin/main.obj src/sprites.s

