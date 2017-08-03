import pprint
import re
import sys


def die(s):
    print(s)
    sys.exit(1)


class Token:
    def __init__(self, cat, lexeme=None):
        self.cat = cat
        self.lexeme = lexeme

    def __repr__(self):
        return "<%s: %s>" % (self.cat, self.lexeme)



def scan(chars):
    i = 0
    while i < len(chars):
        pass



def parse(tokens):
    i = 0
    def peek():
        return tokens[i].cat

    def eat(cat):
        nonlocal i
        if tokens[i].cat == cat:
            i += 1
            return tokens[i-1]
        else:
            die("expected %s, found %s" % (cat, tokens[i].cat))

    pass


def typecheck(symtable, ast):
    pass



def create_offsets(symtable):
    i = 0
    offsets = {}
    for var in symtable:
        offsets[var] = i
        i -= 4
    return offsets



def codegen(offsets, symtable, ast):
    pass


def main():
    src = sys.stdin.read()
    tokens = list(scan(src))
    pprint.pprint(tokens)
    # (symtable, ast) = parse(tokens)
    # for stmt in ast:
    #     typecheck(symtable, stmt)
    # offsets = create_offsets(symtable)
    # codegen(offsets, symtable, ast)


if __name__ == "__main__":
    main()
