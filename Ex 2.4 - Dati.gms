$Title Decentralizzazione - Dati

$Ontext
Dati dell'esercizio 4 (Modelli 2)
$Offtext

Sets
 I insieme dei sili  / s1*s6 /
 J insieme delle fattorie / f1*f7 /
;

Parameters
 D(j) fornitura media richiesta dalla fattoria j [q\giorno]
/
f1    36
f2    42
f3    34
f4    50
f5    27
f6    30
f7    43
/

 Q(i) massima quantit� di foraggio nel silo potenziale i [q\giorno]
/
s1     80
s2     90
s3    110
s4    120
s5    100
s6    120
/

 CF(i) costi fissi per 4 anni del silo potenziale i [�]
/
s1    321420
s2    350640
s3    379860
s4    401775
s5    350640
s6    336030
/

 cs(i)  costo di stoccaggio del silo potenziale i [�\q)]
/
s1    0.15
s2    0.18
s3    0.20
s4    0.18
s5    0.15
s6    0.17
/
;

Table dist(i,j) distanza tra silo potenziale i e fattoria j [km]
      f1  f2  f3  f4  f5  f6  f7
s1    18  23  19  21  24  17   9
s2    21  18  17  23  11  18  20
s3    27  18  17  20  23   9  18
s4    16  23   9  31  21  23  10
s5    31  20  18  19  10  17  18
s6    18  17  29  21  22  18   8
;

Scalar c costo di trasporto [�\(Km*quintale)] / 0.06 / ;


Parameters
    f(i) Frazione giornaliera dei costi fissi
    ct(i,j) costo unitario
;

f(i) = CF(i) / (4*365+1);
ct(i,j) = 2*dist(i,j)*c;

Variables
    x(i,j) Trasporto da i a j
    s(i) stoccaggio in i
    y(i) Binaria: 1 se attivato - altrimenti 0
    z variabile obiettivo (costi totali)
;

Positive Variables x,s;
Binary variables  y;

Equations
    obiettivo     Funzione obiettivo
    domanda(j)    Vincolo di domanda
    stoccaggio(i) Vincolo di stoccaggio
    coerenza(i)   Vincolo sulla capacità di stoccaggio (coerenza)
;

obiettivo.. z =e= sum(i, f(i)*y(i)) + sum(i, cs(i)*s(i)) +sum((i,j), ct(i,j)*x(i,j));

domanda(j).. sum(i,x(i,j)) =e= D(j);
stoccaggio(i).. s(i) =e= sum(j,x(i,j));
coerenza(i).. s(i) =l= Q(i)*y(i);

Model Location /all/;
Location.optca = 0;
Location.optcr = 0;
Solve Location using MIP minimizing z;

Scalar Ytot numero di sili attivati;
Ytot = sum(i, y.l(i));

Display x.l, s.l, y.l, z.l, Ytot;

**Punto B
Equation Nsili vincolo sul numero minimo di sili attivati;
Nsili.. sum(i, y(i)) =g= 4;

**Aggiunta della nuova equazioe
Model Location_b /Location + Nsili/;
Location_b.optca = 0;
Location_b.optcr = 0;

Solve Location_b using MIP minimizing z;

Ytot = sum(i, y.l(i));
Display x.l, s.l, y.l, z.l;

**Punto C -> concetto di minimo tecnico
** Esiste la possibilità
Equation min_fornitura(i) Minimo tecncico sullo stoccaggio;
min_fornitura(i).. s(i) =g= 0.5*Q(i)*y(i);

Model Location_c /Location_b+min_fornitura/;
Location_c.optca = 0;
Location_c.optcr = 0;


Solve Location using MIP minimizing z;
Display x.l, s.l, y.l, z.l;

**Punto D
Equations
v312 condizione logica tra 3-1-2
v64 condizione logica tra 6-4
v65 condizione lofica tra 6-5
;

v312.. y('s3') =l= y('s1')+y('s2');
v64..  y('s6') =l= y('s4');
v65..  y('s6') =l= y('s5');

Model Location_d /all/;
Location_d.optca = 0;
Location_d.optcr = 0;

Solve Location_d using MIP minimizing z;
display x.l, s.l, y.l, z.l;