$Title Pianificazione multiperiodo della produzione

Sets
    J insieme dei prodotti da produrre /j1*j4/
    I insieme dei reparti /i1*i4/
;

 Parameters
    domanda(j) domanda massima che può produrre l'azienda
    /
    j1 800
    j2 750
    j3 600
    j4 500
    /
    
    limite(i) limite di produzione
    /
    i1 1000
    i2 1000
    i3 1000
    i4 1000
    /
    
    profitto(j) profitto per singola unità
    /
    j1 30
    j2 40
    j3 20
    j4 10
    /
    
    penality(j) perdità per unità non svolta
    /
    j1 15
    j2 20
    j3 10
    j4 8
    /
;


Table A(i,j)
    j1   j2   j3   j4
i1  0.3  0.3  0.25 0.15
i2  0.25 0.35 0.3  0.1
i3  0.45 0.5  0.4  0.22
i4  0.15 0.15 0.1  0.06
;

Variables
    x(j) Produzione ottimale
    z    Variabile risposta
;

Integer variable x;

Equations
   timelimit(i)
   produzione(j)
   guadagno
   
;

timelimit(i)..  sum(j, A(i,j)*x(j)) =l= limite(i);
produzione(j).. x(j) =l= domanda(j);
guadagno..      z=e= sum(j, x(j)*profitto(j)) - sum(j, (domanda(j)-x(j)*penality(j)));

Model Calculus /all/;

Calculus.optca = 0;
Calculus.optcr = 0;
Solve Calculus using MIP maximing z;
display x.l, z.l;

Parameter tasso(i);

tasso(i) = sum(j, x.l(j)*A(i,j))/limite(i);

display tasso;