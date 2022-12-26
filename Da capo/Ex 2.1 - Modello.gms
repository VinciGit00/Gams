$Title Costi Fissi - Modello

$Ontext
Soluzione dell'esercizio 1 (Modelli 2)
$Offtext

$Include "Ex 2.1 - Dati.gms" ;
Display F,c ;

Variables
 x(j) Utilizzo di j
 y(j) Binaria: 1 se j è usata - 0 altrimenti
 z    Variabile obiettivo (Costi totali)
;

Positive Variables x ;
Binary Variables y ;

Equations
 obiettivo   Funzione obiettivo
 utilizzo    Vincolo di utilizzo mensile
 coerenza(j) Vincolo di coerenza tra var continue e binarie
;

obiettivo.. z =e= sum(j,F(j)*y(j) + c(j)*x(j)) ;
utilizzo..  sum(j,x(j)) =e= D ;
coerenza(j).. x(j) =l= D*y(j) ;

Model Fix /all/ ;
Fix.optca = 0 ;
Fix.optcr = 0 ;
Solve Fix using MIP minimizing z ;
Display x.l,y.l,z.l ;


***Punto B
c1(j) = c(j) ;
c2(j) = 2*c(j) ;

Positive Variables
 x1(j) Utilizzo entro la soglia
 x2(j) Utilizzo oltre la soglia
;

Equations
 obiettivo_b  Funzione obiettivo al punto b
 scomp(j)     Scomposizione di x(j)
;
x1.up(j) = S ;
obiettivo_b.. z =e= sum(j,   F(j)*y(j)
                         + c1(j)*x1(j)
                         + c2(j)*x2(j)) ;
scomp(j).. x(j) =e= x1(j) + x2(j) ;

Model Fix_b /obiettivo_b,utilizzo,coerenza,scomp/ ;
Fix_b.optca = 0 ;
Fix_b.optcr = 0 ;
Solve Fix_b using MIP minimizing z ;
Display x.l,x1.l,x2.l,y.l,z.l ;


***Punto C
c1(j) = c(j) ;
c2(j) = c(j)*0.9 ;
c2('B') = c('B')*0.85 ;

Binary Variables
 y1(j)   Binaria: 1 se x1(j)>0
 y2(j)   Binaria: 1 se x2(j)>0
;

Equations
 obiettivo_c   Funzione obiettivo al punto c
 coer1_c(j)    Vincolo di coerenza sul primo intervallo
 coer2_c(j)    Vincolo di coerenza sul secondo intervallo
 prec(j)       Vincolo di precedenza
;

obiettivo_c..  z =e= sum(j,  F(j)*y1(j)
                          + c1(j)*x1(j)
                          + c2(j)*x2(j) );

coer1_c(j)..  x1(j) =l= S*y1(j) ;
coer2_c(j)..  x2(j) =l= D*y2(j) ;
prec(j)..     y2(j) =l= x1(j)/S ;

Model Fix_c /obiettivo_c,coer1_c,coer2_c,prec,utilizzo,scomp/ ;
Fix_c.optca = 0 ;
Fix_c.optcr = 0 ;
Solve Fix_c using MIP minimizing z ;


