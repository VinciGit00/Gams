$ Title Es3 rifatto

set T /1*6/

Parameters
    D(t)
    /
    1 100
    2 250
    3 190
    4 140
    5 220
    6 110
    /
    
    cp(t)
    /
    1 50
    2 45
    3 55
    4 48
    5 52 
    6 50
    /
;

Scalars
    I0 giacenza iniziale /0/
    cs costo di giacenza /8/
    Imax giacenza massima del magazzino /100/
;

Variables
    x(t) produzione al tempo t
    I(t) magazzino al tempo t
    z    variabile obiettivo
;
 
*Le variabili devono essere positive
Positive Variables x, I;

Equations
    obiettivo
    bilancio(t)
;

obiettivo.. z =e= sum(t, cp(t)*x(t))+ cs*sum(t, I(t));
bilancio(t).. I(t-1)$(ord(t)>1) + I0$(ord(t)=1) + x(t) =e= I(t) + D(t);

Model production /all/;
solve production using LP minimizing z;

Scalars
    Xtot
    Itot
;

Xtot = sum(t, x.l(t));
Itot = sum(t, I.l(t));

display x.l, I.l, z.l, Xtot, Itot;

*PUNTO B

I0 = 50;
solve production using LP minimizing z;

display x.l, I.l;

*PUNTO C
I.fx('6') = I0;

solve production using LP minimizing z;

display x.l, I.l, z.l;

*PUNTO D

Equations
  
    sup(t)
;


sup(t).. I(t) =l= 100;

Model production2 /all/;
solve production2 using LP minimizing z;
display x.l, I.l, z.l;


Scalars
parziale 
;

parziale = z.l;
Equations
    sup2(t);
;
sup2(t).. I(t) =l= 200;


Model production3/obiettivo, bilancio, sup2/;
*Model production3/all - sup/;
solve production3 using LP minimizing z;
display x.l, I.l, z.l;

*Poi calcolo il delta