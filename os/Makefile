all: launcher.asm
	dd bs=512 count=2880 if=/dev/zero of=os.img
	nasm -f bin -o launcher.bin launcher.asm
	dd status=noxfer conv=notrunc if=launcher.bin of=os.img
run: os.img
	qemu-system-i386 os.img
edit: launcher.asm
	vim launcher.asm
clean:
	rm launcher.bin
	rm os.img
help:
	cat Makefile
