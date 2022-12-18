$Title esercizio 4 16 12 2022



$Include "Ex 3.4 - Dati.gms";
Display CP;


Variables
x(i,j) trasporto tratta i-j
y(i,c) trasporto tratta i-c
k(j,c) trasporto tratta j-c
z variabile obiettivo (costi totali del trasporto)
;
Positive Variables x,y,k;

Equations
obiettivo funzione obiettivo
cap_prod(i) vincolo sulla produzione
cap_stoc(j) vincolo capacità stoccaggio
bilancio(j) bilancio ai depositi
domanda(c) vincolo domanda dei clienti
;

** Per il vincolo tratte inammissibili uso delle limitazioni e non dei vincoli
x.fx(i,j)$(ct1(i,j) = 0) = 0;
y.fx(i,c)$(ct2(i,c) = 0) = 0;
k.fx(j,c)$(ct3(j,c) = 0) = 0;

obiettivo.. z =e= sum((i,j), ct1(i,j)*x(i,j)) + sum((i,c), ct2(i,c)*y(i,c)) + sum((j,c), ct3(j,c)*k(j,c));
cap_prod(i).. sum(j, x(i,j)) + sum(c,y(i,c)) =l= CP(i);
cap_stoc(j).. sum(i, x(i,j)) =l= CS(j);
bilancio(j).. sum(i, x(i,j)) =e= sum(c, k(j,c));
domanda(c).. sum(i,y(i,c)) + sum(j, k(j,c)) =e= D(c);

Model transport /all/;

Solve transport using LP minimizing z;

Display x.l, y.l, k.l, z.l;


** PUNTO B
k.fx('Bergamo', 'C2') = D('C2');
k.fx('mantova', 'C3') = 0;
k.fx('Piacenza', 'C5') = 0;

Solve transport using LP minimizing z;

Display x.l, y.l, k.l, z.l;














