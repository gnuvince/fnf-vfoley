import random
import sys
import time

def last_login():
    now = int(time.time());
    one_year_ago = now - (3600 * 24 * 365)
    return random.randrange(one_year_ago, now)

uid = 0
lastnames = list(open("last-names.txt").readlines())
firstnames = list(open("first-names.txt").readlines())

for uid in range(1500000):
    name = random.choice(firstnames).strip() + "_" + random.choice(lastnames).strip()
    print("{}:{}:/home/{}:/bin/bash:{}".format(uid, name, name, last_login()))
