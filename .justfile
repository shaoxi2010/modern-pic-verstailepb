qemu target:
	qemu-system-arm -machine versatilepb -display none -semihosting -serial stdio -kernel {{target}}

qemu-debug target:
	@echo "Use gdb to connect :1234 remote"
	qemu-system-arm -S -s -machine versatilepb -display none -semihosting -serial stdio -kernel {{target}}

qemu-bin target address:
	@echo "Use Generic Loader"
	qemu-system-arm -machine versatilepb -display none -semihosting -serial stdio -device loader,file={{target}},addr={{address}} -device loader,addr={{address}},cpu-num=0

qemu-debug-bin target address:
	@echo "Use Generic Loader"
	@echo "Use gdb to connect :1234 remote"
	qemu-system-arm -S -s -machine versatilepb -display none -semihosting -serial stdio -device loader,file={{target}},addr={{address}} -device loader,addr={{address}},cpu-num=0