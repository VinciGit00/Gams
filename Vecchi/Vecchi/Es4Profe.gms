Sets
    I inseme delle fonti /1*3/
    J insieme dei mercati da /1*5/
;

Parameters
    S(i) disponibilitù offerta di i
    
/
1
2
3
/

D(j) domanda di j
/
1
2
3
4
5
/
;

* Non si può fare tables
Table cfer(i,j) costo unitario per il trasport ferroviario
    1 2 3 4 5 
1
2
3
;


Table Cnav_Var(i,j) costo navale unitario
   1   2  3 4  5 
1  31 38 24 0 35
2 
3  0
;


Table CnavInv(i,j) costo di inserimento 
   1   2  3  4  5 
1  ...       0
2 
3  0
;

* è il frutto di una rielaborazione di altre matrici, non da console,
*quindi per questo motivo uso l'attributo parameter
Parameter C(i,j) costo unitario in funzione obiettivo;

Variables
    x(i,j)
    z
    ;
    
Equations
    obiettivo
    offerta(i)
    domanda(j)
    imp(i,j)
;

obiettivo.. z =e= ...;
offerta(i)..
domanda(j)..
imp(i,j).. $(C(i,j)=0)..

Model Transport /all/;

***Punto a
c(i,j) = cFer(i,j);
Solve Transport using LP minimizing z;

***Punto b
c(i,j) = cnav_var(i,j)+0.1*cnav_inv(i,j);
Solve Transport using LP minimizing z;

***Punto c
c(i,j) $(cnav_var(i,j)=0) = cfer(i,j);
c(i,j) $(cnav_var(i,j)>0) = min(cFer(i,j), ),  cnav_var(i,j)+0.1*cnav_inv(i,j));

Solve Transport using LP minimizing z;


