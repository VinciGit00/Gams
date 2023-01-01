$Title Estrazione Mineraria - Modello

$OnText
Soluzione dell'esercizio 2 (Esercitazione 3)
$OffText

$Include "Ex 3.2 - Dati.gms"

Variables
 x(i,t)     Quantit� [Mton] estratta dalla miniera i all'anno t
 y(t)       Quantit� [Mton] di prodotto finito venduta all'anno t
 delta(i,t) Binaria: 1 se la miniera i � utilizzata all'anno t - 0 altrimenti
 gamma(i,t) Binaria: 1 se la miniera i � aperta all'anno t - 0 altrimenti
 z          Variabile obiettivo : Profitti totali [M$]
;

Positive Variables x,y ;
Binary Variables delta,gamma ;

Equations
 obiettivo       Definizione della funzione obiettivo
 prod_fin(t)     Definizione della quantit� di prodotto finito
 capacita(i,t)   Collegamento tra variabili continue e binarie
 nmax(t)         Numero massimo di miniere utilizzabili
 legame(i,t)     Collegamento tra binarie
 chiusura(i,t)   Irreversibilit� delle chiusure delle miniere
 qualita(t)      Requisiti di qualit� del prodotto finito
 corr1(t)        Se 1 � utilizzata anche 3 � utilizzata
 corr2(t)        Se 2 � utilizzata anche 3 � utilizzata
;

obiettivo..       z =e= p*sum(t,y(t)) - sum((i,t),R(i)*gamma(i,t)) ;
prod_fin(t)..     y(t) =e= sum(i,x(i,t)) ;
capacita(i,t)..   x(i,t) =l= C(i)*delta(i,t) ;
nmax(t)..         sum(i,delta(i,t)) =l= N ;
legame(i,t)..     delta(i,t) =l= gamma(i,t) ;
chiusura(i,t)$(ord(t)>1)..   gamma(i,t) =l= gamma(i,t-1) ;
qualita(t)..      sum(i,q(i)*x(i,t)) =e= qf(t)*y(t) ;
corr1(t)..        delta('3',t)  =g= delta('1',t) ;
corr2(t)..        delta('3',t)  =g= delta('2',t) ;

Model Estrazione /all/ ;
Estrazione.optca=0;
Estrazione.optcr=0;
Solve Estrazione using MIP maximizing z ;

Parameter Use(t) Numero di miniere utilizzate all'anno t ;
Use(t) = sum(i,delta.l(i,t)) ;

Display z.l,x.l,y.l,gamma.l,delta.l, Use ;
