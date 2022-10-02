$Title Primo esempio

*Implementazione GAMS del primo esempio

$onText
Implementazione GAMS del primo esempio
$offText

*Insiemi degli indici
Sets
    I insieme delle risorse /i1*i3/
    J insieme dei prodotti  /j1*j5/
;
*Oppure
*  J insieme dei prodotti /1*5/ -> va da 1 a 5

*Insieme degli scalari
Scalars
    f lower bound /0.1/
    g upper bound /1/
;
 
*Vettori
Parameters
    c(j) profitto del prodotto j
    /
    j1 -1
    j2  1.5
    j3  2
    j4  2.5
    j5  3
    /
    
    b(i) disponibilità della risorsa i
    /
    i1 0.5
    i2 1
    i3 1
    /
;

*Matrici
Table A(i,j) consumo di risorsa i del prodotto j
        j1  j2  j3  j4  j5
    i1 0.5 0.7 0.2 0.4 0.5
    i2 0.3 0.1 0.4 0.5 0.6
    i3 0.2 0.5 0.4 0.6 0.5
;

*Importante = trasposta di una matrice usando una matrice già usata come variabile precedentemente 
Parameter At(j, i);

*Qui faccio l'assegnamento, prima va dichiarata    
At(j, i) = A(i, j);

*Variabili dell'equazione
*z è il risultato    
Variables
    x(j) produzione del prodotto j
    z variabile obiettivo (profitto totale)
;

*Specifico che x(j) è una variabile solo positiva (>=0) ma è comunque una variabile continua
Positive variable x;
*Quando inizializzo è di default free, quindi la riga non è necessaria
Free variable z è una variabile perchè dipende da una variabile;

$onText
    Negative variable (<=0)
    Free variable  (in R)
    Integer variable (in [0...100])
    Binary variable in ([0,1]-> boolean)
$offText


*Ogni equazione sarebbe una riga della foto
Equations
    obiettivo funzione obiettivo
    disp(i)   disponibilità delle risorse
    lb(j)     lower bound sul prodotto j
    ub(j)     upper bound sul prodotto j
;

$onText
 =l= => minore  uguale
 =g= => maggiore uguale
 =e= => uguale
$offText


obiettivo.. z =e= sum(j, c(j)*x(j));
disp(i).. sum(j, A(i,j)*x(j)) =l= b(i);
*Devo fare necessariamente due 
lb(j).. x(j) =g= f;
ub(j).. x(j) =l= g;


*Un modello è una raccolta di equazioni
*Creo un modello che usa tutte le equazioni all'interno del codice
*In fase di elencazione non scrivo l'indice
Model Example   /all/;
Model Example2 /obiettivo, disp/;
Model Example3 /Example -ub/;
Model Example4 /Example2 + ub/;

*Chiamo la funzione
Solve Example using LP maximixing z

$onText
    LP  => linear programming => tutte le variabili sono positive/negative/free (SOLO variabili continue)
    MIP => almeno una variabile integer o binary (anche solo una variabile che è intera o bianria)
    maximixing => trova il massimo
    minimixing => trova il minimo
$offText


*Visualizzazione dei risultati
Display x.l , z.l;

*x.l permette di accedere al level della variabile decisionale
*x.up upper bound
*x.lb lower bound
*x.m marginal della variabile
*x.fx fissa il livello della variabile