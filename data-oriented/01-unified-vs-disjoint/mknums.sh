N=2000000
( yes 1 | head -n $N ; yes 2.0 | head -n $N ) | shuf > nums.txt
