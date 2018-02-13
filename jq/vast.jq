def isVast1: any(. == 1 or . == 4) ;
def isVast2: any(. == 2 or . == 5) ;
def isVast3: any(. == 3 or . == 6) ;
def isVast4: any(. == 7 or . == 8) ;

def classify:
  [if isVast1 then " VAST 1.0" else null end,
   if isVast2 then " VAST 2.0" else null end,
   if isVast3 then " VAST 3.0" else null end,
   if isVast4 then " VAST 4.0" else null end] | add
;

map(classify) | sort | .[]
