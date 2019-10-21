# Mode of operation #1: Run one command on inputs specified on the command-line

```
$ sha1sum *.txt
3f786850e387550fdab836ed7e6dc881de23001b  a.txt
89e6c98d92887913cadf06b2adb97f26cde4849b  b.txt
f8808683f017a90f977b8f1a2bd8c806b0038bc6  cmd-list.txt
2b66fd261ee5c6cfc8de7fa466bab600bcfe4f69  c.txt
06c8fefb6515229c4c1364f60907a5edcf83671c  file-list.txt

$ parallel sha1sum {} ::: *.txt
3f786850e387550fdab836ed7e6dc881de23001b  a.txt
89e6c98d92887913cadf06b2adb97f26cde4849b  b.txt
f8808683f017a90f977b8f1a2bd8c806b0038bc6  cmd-list.txt
2b66fd261ee5c6cfc8de7fa466bab600bcfe4f69  c.txt
06c8fefb6515229c4c1364f60907a5edcf83671c  file-list.txt
```

# Mode of operation #2: Run one command on inputs specified in a file (or stdin)

```
$ cat file-list.txt
a.txt
b.txt
c.txt

$ parallel sha1sum {} :::: file-list.txt
3f786850e387550fdab836ed7e6dc881de23001b  a.txt
89e6c98d92887913cadf06b2adb97f26cde4849b  b.txt
2b66fd261ee5c6cfc8de7fa466bab600bcfe4f69  c.txt

$ cat file-list.txt | parallel sha1sum {}
parallel: reading inputs from standard input
3f786850e387550fdab836ed7e6dc881de23001b  a.txt
89e6c98d92887913cadf06b2adb97f26cde4849b  b.txt
2b66fd261ee5c6cfc8de7fa466bab600bcfe4f69  c.txt
```

# Mode of operation #3: Run multiple commands specified in a file (or stdin)

```
$ cat cmd-list.txt
cat a.txt
rot13 <b.txt
sha1sum c.txt

$ parallel {} :::: cmd-list.txt
a
o
2b66fd261ee5c6cfc8de7fa466bab600bcfe4f69  c.txt

$ cat cmd-list.txt | parallel {}
parallel: reading inputs from standard input
a
o
2b66fd261ee5c6cfc8de7fa466bab600bcfe4f69  c.txt
```
