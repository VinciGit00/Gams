$Title Esercizio sulle tratte

Sets
    I /1*3/
    J/1*5/;
    
Parameters
    S(i) disponibilità di legname
    /
    1 10
    2 20
    3 15
    /
    
    D(j)
    /
    1 11
    2 12
    3 9
    4 10
    5 8
    /
;

Table Cfer(i,j) costo ferroviario
    1  2  3  4  5
1  61 72 45 55 66
2  69 78 60 49 56
3  59 66 63 62 47

;

Table Cnav(i,j) costo navale
    1  2  3  4  5
1  31 38 24  0 35
2  36 43 28 24 31
3   0 33 36 32 26
;

Table Cimb(i,j) costo delle imbarcazioni
    1    2   3   4   5
1  275 303 238   0 285
2  293 318 270 250 265 
3    0 283 275 268 240  
;

Variables

    x(i,j) Quantità di legname trasportata su un mercato
    z variabile obiettivo
;

positive variable x(i,j);

Equations
obiettivo
vincolo(i)
domanda(j)
inammissibili(i,j)
;

obiettivo.. z =e= sum(i, sum(j, Cfer(i,j) * x(i,j)));
*vincolo(i).. sum(j, x(i, j)) =e= S(i);
*domanda(j).. sum(i, x(i, j)) =e= D(j);


Model production /all/;

Solve production using LP minimizing z;
display z.l, x.l;