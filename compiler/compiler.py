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
        if chars[i].isspace():
            i += 1
        elif chars[i] in ':;+-*/=()':
            yield Token(chars[i])
            i += 1
        elif chars[i].isalpha() or chars[i] == '_':
            r = re.compile(r'([_a-zA-Z][_a-zA-Z0-9]*)')
            m = re.match(r, chars[i:])
            ident = m.group(1)
            if ident in ["var", "int", "float", "while", "do", "done", "print", "read" ]:
                yield Token(ident)
            else:
                yield Token("id", ident)
            i += len(ident)
        elif chars[i].isdigit():
            r = re.compile(r'(\d+(.\d+)?)')
            m = re.match(r, chars[i:])
            digits = m.group(1)
            if '.' in digits:
                yield Token("float_lit", float(digits))
            else:
                yield Token("int_lit", int(digits))
            i += len(digits)
        else:
            die("unknown char: %c" % chars[i])


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

    def program():
        return (decls(), list(stmts()))

    def decls():
        symtab = {}
        while i < len(tokens) and peek() == "var":
            symtab.update(decl())
        return symtab

    def decl():
        eat("var")
        ident = eat("id")
        eat(":")
        if peek() == "int":
            ty = eat("int")
        elif peek() == "float":
            ty = eat("float")
        else:
            die("expected type, found %r" % tokens[i])
        eat(";")
        return { ident.lexeme: ty.cat }

    def stmts():
        stmts = []
        while i < len(tokens) and (peek() in ["while", "id", "print", "read"]):
            stmts.append(stmt())
        return stmts

    def stmt():
        if peek() == "read":
            eat("read")
            ident = eat("id")
            eat(";")
            return { "node": "read", "id": ident.lexeme }
        elif peek() == "print":
            eat("print")
            e = expr()
            eat(";")
            return { "node": "print", "expr": e }
        elif peek() == "id":
            ident = eat("id")
            eat("=")
            e = expr()
            eat(";")
            return { "node": "assign", "id": ident.lexeme, "expr": e }
        elif peek() == "while":
            eat("while")
            e = expr()
            eat("do")
            body = stmts()
            eat("done")
            return { "node": "while", "expr": e, "body": body }
        else:
            die("unexpected token %s" % peek())

    def expr():
        e1 = expr1()
        while peek() in "+-":
            op = eat(peek())
            e2 = expr1()
            e1 = { "node": op.cat, "e1": e1, "e2": e2 }
        return e1

    def expr1():
        e1 = expr2()
        while peek() in "*/":
            op = eat(peek())
            e2 = expr2()
            e1 = { "node": op.cat, "e1": e1, "e2": e2 }
        return e1

    def expr2():
        if peek() == "id":
            ident = eat("id")
            return { "node": "id", "id": ident.lexeme }
        elif peek() == "int_lit":
            x = eat("int_lit")
            return { "node": "int_lit", "value": x.lexeme }
        elif peek() == "float_lit":
            x = eat("float_lit")
            return { "node": "float_lit", "value": x.lexeme }
        elif peek() == "(":
            eat("(")
            e = expr()
            eat(")")
            return e
        else:
            die("unexpected token: %s" % peek())

    return program()

def typecheck(symtable, ast):
    if ast["node"] == "int_lit":
        ast["type"] = "int"
    elif ast["node"] == "float_lit":
        ast["type"] = "float"
    elif ast["node"] == "id":
        ast["type"] = symtable[ast["id"]]
    elif ast["node"] in "+-*/":
        typecheck(symtable, ast["e1"])
        typecheck(symtable, ast["e2"])
        if ast["e1"]["type"] == ast["e2"]["type"]:
            ast["type"] = ast["e1"]["type"]
        else:
            die("type error in %s" % ast["node"])
    elif ast["node"] == "read":
        if ast["id"] not in symtable:
            die("undeclared variable %s" % ast["id"])
    elif ast["node"] == "print":
        typecheck(symtable, ast["expr"])
    elif ast["node"] == "assign":
        typecheck(symtable, ast["expr"])
        if ast["id"] not in symtable:
            die("undeclared variable %s" % ast["id"])
        if ast["expr"]["type"] != symtable[ast["id"]]:
            die("type error in assign")
    elif ast["node"] == "while":
        typecheck(symtable, ast["expr"])
        if ast["expr"]["type"] != "int":
            die("type error in while")
        for stmt in ast["body"]:
            typecheck(symtable, stmt)
    else:
        die("Unknown type of node: %s" % ast["node"])


def create_offsets(symtable):
    i = 0
    offsets = {}
    for var in symtable:
        offsets[var] = i
        i -= 4
    return offsets


def codegen(offsets, symtable, ast):
    label = 0
    newline = [
        'la $a0, newline',
        'li $v0, 4',
        'syscall'
    ]
    sp_off = -4*len(offsets)
    program =[
        '.data',
        'newline: .asciiz "\\n"',
        '.text',
        'main:',
        'addi $fp, $sp, 0',
        'addi $sp, $sp, %d' % sp_off
    ]

    def codegen_expr(expr):
        nonlocal program
        if expr["node"] == "int_lit":
            program += [
                '# int literal',
                'li $s0, %d' % expr["value"],
            ]
        elif expr["node"] == "float_lit":
            program += [
                '# float literal',
                'li.s $f0, %f' % expr["value"],
                'mfc1 $s0, $f0',
            ]
        elif expr["node"] == "id":
            program += [
                '# identifier',
                'lw $s0, %d($fp)' % offsets[expr["id"]],
            ]
        elif expr["node"] in "+-*/" and expr["type"] == "int":
            op = {
                "+": "add", "-": "sub",
                "*": "mulo", "/": "div"
            }[expr["node"]]
            codegen_expr(expr["e1"])
            codegen_expr(expr["e2"])
            program += [
                '# int arithmetic',
                'lw $s2, 4($sp)',
                'lw $s1, 8($sp)',
                '%s $s0, $s1, $s2' % op,
                'addi $sp, $sp, 8'
            ]
        elif expr["node"] in "+-*/" and expr["type"] == "float":
            op = {
                "+": "add.s", "-": "sub.s",
                "*": "mul.s", "/": "div.s"
            }[expr["node"]]
            codegen_expr(expr["e1"])
            codegen_expr(expr["e2"])
            program += [
                '# float arithmetic',
                'lw $s2, 4($sp)',
                'lw $s1, 8($sp)',
                'mtc1 $s1, $f1',
                'mtc1 $s2, $f2',
                '%s $f0, $f1, $f2' % op,
                'mfc1 $s0, $f0',
                'addi $sp, $sp, 8'
            ]
        program += [
            'sw $s0, 0($sp)',
            'addi $sp, $sp, -4'
        ]

    def codegen_stmt(stmt):
        nonlocal program, label
        if stmt["node"] == "read" and symtable[stmt["id"]] == "int":
            program += [
                '# read int',
                'li $v0, 5',
                'syscall',
                'sw $v0, %d($fp)' % offsets[stmt["id"]]
            ]
        elif stmt["node"] == "print" and stmt["expr"]["type"] == "int":
            codegen_expr(stmt["expr"])
            program += [
                '# print int',
                'addi $sp, $sp, 4',
                'lw $a0, 0($sp)',
                'li $v0, 1',
                'syscall'
            ]
            program += newline
        elif stmt["node"] == "read" and symtable[stmt["id"]] == "float":
            program += [
                '# read float',
                'li $v0, 6',
                'syscall',
                'mfc1 $s0, $f0',
                'sw $s0, %d($fp)' % offsets[stmt["id"]]
            ]
        elif stmt["node"] == "print" and stmt["expr"]["type"] == "float":
            codegen_expr(stmt["expr"])
            program += [
                '# print float',
                'addi $sp, $sp, 4',
                'lw $a0, 0($sp)',
                'mtc1 $a0, $f12',
                'li $v0, 2',
                'syscall'
            ]
            program += newline
        elif stmt["node"] == "assign":
            codegen_expr(stmt["expr"])
            program += [
                '# assign',
                'addi $sp, $sp, 4',
                'lw $s0, 0($sp)',
                'sw $s0, %d($fp)' % offsets[stmt["id"]]
            ]
        elif stmt["node"] == "while":
            start_label = "L_" + str(label)
            label += 1
            end_label = "L_" + str(label)
            label += 1
            program += [
                '\n# while',
                start_label + ":"
            ]
            codegen_expr(stmt["expr"])
            program += [
                'addi $sp, $sp, 4',
                'lw $s0, 0($sp)',
                'beqz $s0, %s' % end_label
            ]
            for substmt in stmt["body"]:
                codegen_stmt(substmt)
            program += [
                'j %s' % start_label,
                end_label + ":"
            ]

    for stmt in ast:
        codegen_stmt(stmt)

    program += [
        '# exit',
        'li $v0, 10',
        'syscall'
    ]

    print('\n'.join(program))




def main():
    src = sys.stdin.read()
    tokens = list(scan(src))
    (symtable, ast) = parse(tokens)
    for stmt in ast:
        typecheck(symtable, stmt)
    offsets = create_offsets(symtable)
    codegen(offsets, symtable, ast)


if __name__ == "__main__":
    main()
