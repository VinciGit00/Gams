$Title Abbattimento Emissioni - Dati

$OnText
Dati dell'esercizio 1 (Modelli 3)
$OffText

Sets
 I fonti di inquinamento / altiforni,fornaci /
 J metodi di abbattimento / ciminiere,filtri,additivi /
;

Table p(i,j) riduzione di particolato data dall'installazione su i di j
           ciminiere filtri additivi
altiforni      12       25     17
fornaci         9       20     13
;

Table s(i,j) riduzione di ossidi di zolfo data dall'installazione su i di j
           ciminiere filtri additivi
altiforni      35       18     56
fornaci        42       31     49
;

Table h(i,j) riduzione di idrocarburi data dall'installazione su i di j
           ciminiere filtri additivi
altiforni      37       28     29
fornaci        53       24     20
;

Table Inv(i,j) costo di investimento
           ciminiere filtri additivi
altiforni      8        7     11
fornaci        10       8      9
;

Scalars
 P_min minime riduzioni di particolato  / 60 /
 S_min minime riduzioni di ossidi di zolfo / 150 /
 H_min minime riduzioni di idrocarburi  / 125 /
;


Variables
x(i,j) Frazione di installazione di j su i
z Variabile obiettivo (costi totali di investimento)
;

Positive Variable x;
*è una frazione e quindi il valore massimo è 1 
x.up(i,j) = 1;

Equations
obiettivo funzione obiettivo
particolato riduzione emisssioni di particolato
ossidi riduzione delle emissioni di ossidi di zolfo
idro vincolo sulla riduzione di emissioni di idrocarburi
;

obiettivo..   z =e= sum((i,j), Inv(i,j)*x(i,j));
particolato.. sum((i,j), p(i,j)*x(i,j)) =g= P_min;
ossidi..      sum((i,j), s(i,j)*x(i,j)) =g= S_min;
idro..        sum((i,j), h(i,j)*x(i,j)) =g= H_min;

Model Pollution /all/;
Solve Pollution using LP minimizing z;
display x.l, z.l;


**Punto b
Scalar I_F incentivo fiscale /3.5/;

Integer Variable teta aumenti del 10% nell'abbattiemnto delle emissioni;

Equations
obiettivo_b funzione obiettivo al punto b
particolato_b
ossidi_b
idro_b
;

obiettivo_b..   z =e= sum((i,j), Inv(i,j)*x(i,j))- I_F*teta;
particolato_b.. sum((i,j), p(i,j)*x(i,j)) =g= P_min*(1+teta/10);
ossidi_b..      sum((i,j), s(i,j)*x(i,j)) =g= S_min*(1+teta/10);
idro_b..        sum((i,j), h(i,j)*x(i,j)) =g= H_min*(1+teta/10);

Model Pollution_b /obiettivo_b, particolato_b , ossidi_b, idro_b/;
Pollution_b.optca = 0;
Pollution_b.optcr = 0;

solve Pollution_b using MIP minizing z;

Scalar teta_hat Riduzione percentuale effettiva;
teta_hat = teta.l/10;

Display x.l, teta.l, teta_hat, z.l;


**Punto c
I_F = 0.35;
Equations
particolato_c
ossidi_c
idro_c
;

particolato_c.. sum((i,j), p(i,j)*x(i,j)) =g= P_min*(1+teta/100);
ossidi_c..      sum((i,j), s(i,j)*x(i,j)) =g= S_min*(1+teta/100);
idro_c..        sum((i,j), h(i,j)*x(i,j)) =g= H_min*(1+teta/100);


Model Pollution_c /obiettivo_b, particolato_c, ossidi_c, idro_c/;
Pollution_c.optca = 0;
Pollution_c.optcr = 0;

Solve Pollution_c using MIP minimizing z;

teta_hat = teta.l/100;
Display x.l, teta.l, teta_hat, z.l;


