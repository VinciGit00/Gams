$Title Abbattimento Emissioni - Modello

$Ontext
Soluzione dell'esercizio 1 (Modelli 3)
$Offtext

$Include "Ex 3.1 - Dati.gms" ;
Display Inv ;

Variables
 x(i,j) Frazione di installazione di j su i
 z      Variabile obiettivo (costi di investimento)
;

Positive Variables x ;
x.up(i,j) = 1 ;

Equations
 obiettivo   Funzione obiettivo
 particolato Riduzione emissioni particolato
 ossidi      Riduzione emissioni ossidi di zolfo
 idro        Riduzione emissioni idrocarburi
;

obiettivo..  z =e= sum((i,j),Inv(i,j)*x(i,j)) ;
*             z =e= sum(i,sum(j,Inv(i,j)*x(i,j)))

particolato.. sum((i,j),p(i,j)*x(i,j)) =g= P_min ;
ossidi..      sum((i,j),s(i,j)*x(i,j)) =g= S_min ;
idro..        sum((i,j),h(i,j)*x(i,j)) =g= H_min ;

Model Pollution /all/ ;
Solve Pollution using LP minimizing z ;
Display x.l,z.l ;

***Punto b.
Scalar I_F incentivo fiscale /3.5/ ;
Integer Variable teta aumenti del 10% nell'abbattimento delle emissioni ;

Equations
 obiettivo_b   Funzione obiettivo al punto b
 particolato_b
 ossidi_b
 idro_b
;

obiettivo_b..   z =e= sum((i,j),Inv(i,j)*x(i,j)) - I_F*teta ;
particolato_b.. sum((i,j),p(i,j)*x(i,j)) =g= P_min*(1+teta/10) ;
ossidi_b..      sum((i,j),s(i,j)*x(i,j)) =g= S_min*(1+teta/10) ;
idro_b..        sum((i,j),h(i,j)*x(i,j)) =g= H_min*(1+teta/10) ;

Model Pollution_b /obiettivo_b,particolato_b,ossidi_b,idro_b/ ;
Pollution_b.optca = 0 ;
Pollution_b.optcr = 0 ;
Solve Pollution_b using MIP minimizing z ;

Scalar teta_hat Riduzione percentuale effettiva ;
teta_hat = teta.l/10 ;

Display x.l,teta.l,teta_hat,z.l ;


***Punto c.
I_F = 0.35 ;
Equations
 particolato_c
 ossidi_c
 idro_c
;
particolato_c.. sum((i,j),p(i,j)*x(i,j)) =g= P_min*(1+teta/100) ;
ossidi_c..      sum((i,j),s(i,j)*x(i,j)) =g= S_min*(1+teta/100) ;
idro_c..        sum((i,j),h(i,j)*x(i,j)) =g= H_min*(1+teta/100) ;

Model Pollution_c /obiettivo_b,particolato_c,ossidi_c,idro_c/ ;
Pollution_c.optca = 0 ;
Pollution_c.optcr = 0 ;
Solve Pollution_c using MIP minimizing z ;

teta_hat = teta.l/100 ;
Display x.l,teta.l,teta_hat,z.l ;



