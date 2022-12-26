$Title Trasporto

$Ontext
Soluzione dell'esercizio 4 (Modelli 1)
$Offtext

Sets
 I insieme delle fonti /1*3/
 J insieme dei mercati /1*5/
;

Parameters
 S(i) offerta [10^6 m3] di legname della fonte i
/
1 15
2 20
3 15
/

 D(j) domanda [10^6 m3] di legname del mercato j
/
1 11
2 12
3  9
4 10
5  8
/
;

Table cFer(i,j) costo di trasporto [k$\10^6 m3] ferroviario da i a j
    1   2   3   4   5
1  61  72  45  55  66
2  69  78  60  49  56
3  59  66  63  61  47
;

Table cNav_var(i,j) costo di trasporto variabile [k$\10^6 m3] da i a j
    1   2   3   4   5
1  31  38  24   0  35
2  36  43  28  24  31
3   0  33  36  32  26
;

Table cNav_Inv(i,j) costo di investimento [k$\10^6 m3] per il trasporto navale da i a j
     1    2    3    4    5
1  275  303  238    0  285
2  293  318  270  250  265
3    0  283  275  268  240
;

Parameter C(i,j) costo di trasporto unitario [k$\10^6 m3] da i a j in f.o. ;

Variables
 x(i,j) Legname [10^6 m3] trasportato da i a j
 z      Variabile obiettivo (Costi totali [k$])
;

Positive Variables x ;

Equations
 obiettivo    Funzione obiettivo
 offerta(i)   Vincolo di offerta alla fonte i
 domanda(j)   Vincolo di domanda al mercato j
 imp(i,j)     Tratte inammissibili
;

obiettivo..   z =e= sum((i,j),C(i,j)*x(i,j)) ;
offerta(i)..  sum(j,x(i,j)) =e= S(i) ;
domanda(j)..  sum(i,x(i,j)) =e= D(j) ;
imp(i,j)$(C(i,j)=0)..  x(i,j) =e= 0 ;

Model Transport /all/ ;

***Punto A - Trasporto Ferroviario
C(i,j) = cFer(i,j) ;
Solve Transport using LP minimizing z ;
Display x.l,z.l ;

***Punto B - Trasporto Navale
C(i,j) = cNav_var(i,j) + 0.1*cNav_Inv(i,j) ;
Solve Transport using LP minimizing z ;
Display x.l,z.l ;

***Punto C - Trasporto Misto
C(i,j)$(cNav_Var(i,j)=0) = cFer(i,j) ;
C(i,j)$(cNav_var(i,j)>0) = min(cFer(i,j) , cNav_Var(i,j) + 0.1*cNav_Inv(i,j)) ;
Solve Transport using LP minimizing z ;
Display x.l,z.l ;
