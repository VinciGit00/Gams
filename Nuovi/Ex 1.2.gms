$Title Pianificazione della produzione

$Ontext
Soluzione dell'esercizio 2 (Modelli 1)
$Offtext

Sets
 J insieme dei prodotti / P1*P4 /
 I insieme dei reparti / A*D /
;

Parameters
 Pr(j) Profitto unitario del prodotto j
/
P1 30
P2 40
P3 20
P4 10
/

 Pen(j) Penalità unitaria di j
/
P1 15
P2 20
P3 10
P4  8
/

 D(j) Domanda di j
/
P1 800
P2 750
P3 600
P4 500
/

 C(i) Capacità [h] di i
/
A 1000
B 1000
C 1000
D 1000
/
;

Table tl(i,j) tempo unitario di lavorazione di j in i
     P1    P2    P3    P4
A   0.3   0.3  0.25  0.15
B  0.25  0.35   0.3   0.1
C  0.45   0.5   0.4  0.22
D  0.15  0.15   0.1  0.05
;

Variables
 x(j) quantità di j prodotta
 s(j) quantità di domanda di j non soddisfatta
 z    variabile obiettivo (profitti totali)
;

Positive variables x,s ;
*Integer variables x,s ;

** Se lavorate con variabili intere ricordatevi di modificare gli upper bound, ponendo:
*x.up(j)=D(j);
*s.up(j)=D(j);

Equations
 obiettivo    funzione obiettivo
 capacita(i)  vincolo di disponibilità del reparto i
 domanda(j)   vincolo di domanda
;

obiettivo..    z =e= sum(j,Pr(j)*x(j)) - sum(j,Pen(j)*s(j)) ;

capacita(i)..  sum(j,tl(i,j)*x(j)) =l= C(i) ;

domanda(j)..   x(j) + s(j) =e= D(j) ;

Model Production /all/;

*Se LP
Solve Production using LP maximizing z ;

*Se MIP
*Production.optca=0 ;
*Production.optcr=0 ;
*Solve Production using MIP maximizing z ;

Scalar Xtot ;
Xtot = sum(j,x.l(j)) ;

Parameter Ratio(i) ;
Ratio(i) =  sum(j,tl(i,j)*x.l(j)) / C(i) ;

Display x.l,s.l,z.l ;
Display Xtot, Ratio ;
