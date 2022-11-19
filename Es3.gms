$ Title Pianificazione Multiperiodo


$onText Soluzione dell'esercizio 3
$offText

Set T insieme dei mesi /1*6/

Parameters
    D(t) domanda del mese t
    /
    1 100
    2 250
    3 190
    4 140
    5 220
    6 110
    /
    
    cp(t) Costo unitario di produzione al mese
    /
    1 50
    2 45
    3 55
    4 48
    5 52
    6 50
    /
    
Scalars
    cs costo unitario di stoccaggio /8/
    I0 giacenza iniziale del magazzino /0/
    Imax Giacenza massima de lmagaazino (e serve per il punto d) /100/
;

Variables
    x(t) produzione al mese t
    I(t) Livello delle scorte a fine mese t
    z variabile obiettivo (costi totali)
;

Positive Variables x,I;

Equations
    obiettivo   Funzione obiettivo
    bilancio(t) Vincolo di bilancio al mese t
;

obiettivo.. z =e= sum(t, cp(t)*x(t)) + cs*sum(t,I(t));

* Con il dollaro posso mettere dei valori condizionali
* Bilancio mese per mese

bilancio(t).. I(t-1)$(ord(t)>1) + I0$(ord(t)=1) + x(t) =e= D(t) +I(t);
* ord(t) --> ordine dell'elemento all'interno dell'insieme T, prende il primo elemento dell'array, non il suo valore numerico
* Dentro le condizioni posso mettere dentro anche
* gt --> >
* lt --> <
* ge --> >=
* le --> <=

Model production /all/;
Solve production using LP minimizing z;

*postProcessamento, introduco due nuovi scalari
Scalars
    Xtot Produzione nei 6 mesi
    Itot Stoccaggio nei 6 mesi
;

*Ottengo la sommatoria totale
Xtot = sum(t, x.l(t));
Itot = sum(t, I.l(t));

Display x.l, I.l, z.l, Xtot, Itot;


*** Punto b
* Cambio una variabile 
I0 = 50;
Solve Production using LP minimizing z;

Display x.l, I.l, z.l;

*** Punto c
* Aggiunta vincolo: I6 = I0
* Estensione I.fx va a controllare l'upper bound e il lower bound della variabile I
I.fx('6') = I0;
Solve Production using LP minimizing z;

Display x.l, I.l, z.l;

*Serve per la domanda finale
Scalar fo_c valore della funzione obiettivo al punto c;
fo_c = z.l;

**Punto D
*Aggiunta vincolo It<= Imax
*Card => 6
I.up(t)$(ord(t)<card(t)) = Imax;
Solve Production using LP minimizing z;

Display x.l, I.l, z.l;

**Domanda finale-> raddoppio il magazzino
Scalar delta Risparmio nei costi ottenuto raddoppiano il magazzino;
delta = z.l - fo_c;
Display delta;

