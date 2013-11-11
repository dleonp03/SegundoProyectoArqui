interprete: interprete.o
	ld -m elf_i386 -o interprete interprete.o

interprete.o: interprete.asm
	nasm -f elf -g -F stabs interprete.asm -l interprete.lst
