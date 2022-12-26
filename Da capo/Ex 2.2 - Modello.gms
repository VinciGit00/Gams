$Title Vincoli di precedenza - Modello

$Ontext
Soluzione dell'esercizio 2 (Modelli 2)
$Offtext

$Include "Ex 2.2 - Dati.gms"

Scalar M scalare sufficientemente grande ;
*Lo scalare M può essere scelto come un numero arbitrariamente grande, di un ordine
*di grandezza maggiore rispetto ai dati:
M = 100 ;
*O in maniera più intelligente può essere legato ai dati del problema, scegliendo
*ad esempio la somma di tutti i tempi di lavorazione:
M = sum(j,tl(j)) ;

Variables
 x(j)       Inizio lavorazione su j
 Splus(j)   Ritardo su j
 Sminus(j)  Anticipo su j
 y(i,j)     Binaria: 1 se il lavoro i anticipa j e 0 altrimenti
 z          Funzione obiettivo : Penalità per i ritardi
;

Positive Variables x,Splus,Sminus ;
Binary Variables y ;

Equations
 obiettivo     Funzione obiettivo
 bilancio(j)   Bilancio nei tempi
 prec1(i,j)    Precedenza i-j
 prec2(i,j)    Precedenza j-i
;

obiettivo..    z =e= sum(j,P(j)*Splus(j)) ;
bilancio(j)..  x(j) + tl(j) + Sminus(j) =e= D(j) + Splus(j) ;
prec1(i,j)$(ord(i)<ord(j)).. x(i) + tl(i) =l= x(j) + (1-y(i,j))*M ;
prec2(i,j)$(ord(i)<ord(j)).. x(j) + tl(j) =l= x(i) + y(i,j)*M ;

Model Job /all/;
Job.optcr=0;
Job.optca=0;
Solve Job using mip minimizing z ;

Display x.l, y.l ;
