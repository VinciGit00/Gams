$title Pianificazione urbana

$onText
Soluzione dell'esercizio 1
$offText

set J insieme delle abitazioni /1*4/;

Parameters
 Tax(j) tassa unitaria
/
1 1
2 1.9
3 2.7
4 3.4
/

 S(j) spazio unitario [acri]
 /
 1 0.18
 2 0.28
 3 0.4
 4 0.5
 /
 
 cc(j) costo unitario di cistruzione [kj]
 /
 1 50
 2 70
 3 130
 4 160
 /
 ;
 
Scalars
    Nmax Numero massimo di edifici demolibili /300/
    s0   Spazio di un vecchio edificio [acri] /0.25/
    cd   Costo di demolizione [k$] /2/
    qs   Quota di spazio non edificabile /0.15/
    p34  Percentuale di trilo+quadri /0.25/
    p1   Percentuale di monolocali /0.2/
    p2   Percentuale di bilocali /0.1/
    B    Budget [k$] /15000/
;


Variables
    x(j) Numero di abitazioni j costruite
    y    Numero di vecchie abitazioni demolite
    z   Variabili obiettico (tasse totali)

*Positive variables x, y;
*Modifica la classe del modello da LP a MIP
Integer variables x,y;
y.up = Nmax;

Equations
    obiettivo   Funzione obiettivo
    demolizioni Vincolo sulle demolizioni
    spazio      Vincolo di bilancio sullo spazio
    lb34        Lower bound su trilo + quadri
    lb1         Lower bound sui monolocali
    lb2         Lower bound sui bulocali
    budget      Vincolo di budget
;

obiettivo.. z =e= sum(j, Tax(j)*x(j));
demolizioni.. y=l= Nmax;
spazio.. sum(j, s(j)*x(j)) =l= s0*y*(1-qs);
*Uso una specifica componente del vettore
lb34.. x('3') + x('4') =g= p34*sum(j,x(j));
lb1.. x('1') =g= p1*sum(j, x(j));
lb2.. x('2') =g= p2*sum(j, x(j));
budget.. sum(j, cc(j)*x(j)) +cd*y =l= B;

Model Urban /all/;
Urban.optca = 0;
Urban.optcr = 0;
*Solve Urban using LP maximing z;
Solve Urban using MIP maximing z;

display x.l, y.l, z.l

Scalars
 Ntot numero totale di edifici costruiti
 R    rapporto tra spazio occupato e spazio libero
;

Ntot = sum(j, x.l(j));
R    = sum(j, S(j)*x.l(j))/(s0+y.l);


display Ntot, R;