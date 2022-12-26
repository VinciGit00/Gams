$Title Pianificazione Multiperiodo

$Ontext
Soluzione dell'esercizio 3 (Modelli 1)
$Offtext

Set T insieme dei mesi /1*6/ ;

Parameters
 D(t) Domanda al mese t
/
1 100
2 250
3 190
4 140
5 220
6 110
/

 cp(t) Costo unitario di produzione al mese t
/
1 50
2 45
3 55
4 48
5 52
6 50
/
;

Scalars
 cs Costo unitario di stoccaggio /8/
 I0 Giacenza iniziale del magazzino /0/
 Imax Giacenza massima del magazzino /100/
;

Variables
 x(t) Produzione al mese t
 I(t) Livello delle scorte a fine mese t
 z    Variabile obiettivo (Costi totali)
;

Positive Variables x,I ;

Equations
 obiettivo   Funzione obiettivo
 bilancio(t) Vincolo di bilancio al mese t
;

obiettivo..  z =e= sum(t,cp(t)*x(t))
                 + cs*sum(t,I(t)) ;

bilancio(t)..  I(t-1)$(ord(t)>1) + I0$(ord(t)=1) + x(t) =e= D(t) + I(t) ;

$Ontext
ord(t) ---> ordine dell'elemento t all'interno dell'Insieme T
gt ---> >
lt ---> <
ge ---> >=
le ---> <=
$Offtext

Model Production /all/ ;
Solve Production using LP minimizing z ;

Scalars
 Xtot Produzione nei 6 mesi
 Itot Stoccaggio nei 6 mesi
;
Xtot = sum(t,x.l(t)) ;
Itot = sum(t,I.l(t)) ;

Display x.l,I.l,z.l,Xtot,Itot ;

***Punto B
** Cambia solo questo rispetto al punto precdente
I0 = 50 ;
Solve Production using LP minimizing z ;
Display x.l,I.l,z.l ;

***Punto C
*Aggiunta vincolo: I6 = I0
I.fx('6') = I0 ;
*I.fx ---> controlla l'upper bound e il lower bound di I
Solve Production using LP minimizing z ;
Display x.l,I.l,z.l ;
Scalar fo_c valore della funzione obiettivo al punto c ;
fo_c = z.l ;

***Punto D
*Aggiunta vincolo: It <= Imax
I.up(t)$(ord(t)<card(t)) = Imax ;
Solve Production using LP minimizing z ;
Display x.l,I.l,z.l ;

Scalar delta Risparmio nei costi ottenuto raddoppiando la capacit� del magazzino ;
delta = z.l - fo_c ;
Display delta ;






