$Title Costi Fissi - Dati

$Ontext
Dati dell'esercizio 1 (Modelli 2)
$Offtext

Set J insieme delle compagnie telefoniche /A*C/ ;

Parameters
 F(j) canone fisso di j
/
A 16
B 25
C 22
/

 c(j) costo variabile di j
/
A  0.25
B  0.21
C  0.22
/
;

Scalars
 D domanda / 250 /
 S soglia / 100 /
;

Parameters
 c1(j) costo entro la soglia
 c2(j) costo oltre la soglia
;

Variables
    x(j)
    y(j)
    z
;

Positive Variable x;
Positive Variable y;

Equations
    obiettivo
    utilizzo
    coerenza(j)
;

obiettivo.. z =e= sum(j, F(j)*y(j)+c(j)*x(j));
utilizzo.. sum(j, x(j)) =e= D;
coerenza(j).. x(j) =l= D*y(j);

Model Fix /all/;
Fix.optca = 0;
Fix.optcr = 0;
Solve Fix using MIP minimizing z;
Display x.l, y.l, z.l;


**Punto B
c1(j) = c(j);
*Da testo ci dicono che raddoppia dal punto precedent4
c2(j) = 2*c(j);

Positive Variables
    x1(j) utilizzo entro la soglia
    x2(j) utilizzo oltre la soglia
;

Equations
    obiettivo_b funzione obiettivo al punto b
    scomp(j)    scompostizione di x(j)
;

x1.up(j) = S;
obiettivo_b.. z =e= sum(j, F(j)*y(j)+c1(j)+x1(j)+c2(j)*x2(j));


scomp(j).. x(j) =e= x1(j) +x2(j);

Model fix_b /obiettivo_b, utilizzo, coerenza, scomp/;

Fix_b.optca = 0;
Fix_b.optcr = 0;

Solve fix_b using MIP minimizing z;
display x.l,x1.l, x2.l, y.l, z.l;

** Punto C
c1(j) = c(j);
c2(j) = c(j) * 0.9;
x2('B') = C('B') * 0.85;ra