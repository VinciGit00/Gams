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
