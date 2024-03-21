from lief import Binary,parse
from argparse import ArgumentParser
from os import path

parser = ArgumentParser(description='BSS spare')
parser.add_argument("elf", help="ELF file")
parser.add_argument("bin", help="Binary file")
parser.add_argument("withbss", help="Binary file with bss")

def bss_size(elf_path):
	binary: Binary = parse(elf_path)
	try:
		return binary.get_section(".bss").size
	except(AttributeError):
		return 0

def appendbss(bin_path, elf_path, bin_with_bss_path):
	filesize = path.getsize(bin_path) + bss_size(elf_path)
	with open(bin_with_bss_path, "wb") as f, open(bin_path, "rb") as r:
		data = r.read()
		f.write(data)
		f.truncate(filesize)

if __name__ == "__main__":
	args = parser.parse_args()
	appendbss(args.bin, args.elf, args.withbss)

