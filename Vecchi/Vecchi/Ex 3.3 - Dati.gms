$Title Pianificazione Produzione - Dati

$Ontext
Dati dell'esercizio 3 (Modelli 3)
$Offtext

Sets
 I reparti /smerigliatura,
            foratura_verticale,
            foratura_orizzontale,
            alesatura,
            piallatura/
 J prodotti /P1*P7/
 T mesi /Gen,Feb,Mar,Apr,Mag,Giu/
;

Parameters
 Ntot(i) numero di macchinari nel reparto i
/
smerigliatura        4
foratura_verticale   2
foratura_orizzontale 3
alesatura            1
piallatura           1
/

 P(j) profitto unitario del prodotto j
/
P1 10
P2  6
P3  8
P4  4
P5 11
P6  9
P7  3
/
;

Table D(t,j) domanda di j al mese t
      P1   P2   P3   P4   P5   P6   P7
Gen  500  1000 300  300  800  200  100
Feb  600  500  200    0  400  300  150
Mar  300  600    0    0  500  400  100
Apr  200  300  400  500  200    0  100
Mag    0  100  500  100  1000 300    0
Giu  500  500  100  300  1100 500   60
;

Table tl(i,j) tempo unitario di lavorazione di j in i
                       P1   P2   P3   P4   P5   P6   P7
Smerigliatura         0.5  0.7    0    0  0.3  0.2  0.5
Foratura_verticale    0.1  0.2    0  0.3    0  0.6    0
Foratura_orizzontale  0.2    0  0.8    0    0    0  0.6
Alesatura            0.05 0.03    0 0.07  0.1    0 0.08
Piallatura              0    0 0.01    0 0.05    0 0.05
;

Table Nman(i,t) numero di macchinari in i in manutenzione nel mese t
                     Gen Feb Mar Apr Mag Giu
Smerigliatura          1   0   0   0   1   0
Foratura_verticale     0   0   0   1   1   0
Foratura_orizzontale   0   2   0   0   0   1
Alesatura              0   0   1   0   0   0
Piallatura             0   0   0   0   0   1
;

Scalars
 S_max livello massimo del magazzino / 100 /
 S0    livello iniziale del magazzino / 50 /
 cs    costo di stoccaggio / 0.5 /
 G     giorni lavorativi / 24 /
 h     durata dei turni / 8 /
 TU    turni giornalieri / 2 /
;


Scalar hAP numero di ore di apertura;
hAP = G*h*TU;

Variables
x(j,t) produzione
v(j,t) vendita
s(j,t) stoccaggio
z variabile obiettivo
;

Positive Variables x,v,s;

Equations
obiettivo funzione obiettivo
bilancio(j,t) vincolo bilancio
lavorazioni(i,t) vincolo tempi lavorazione
;

** Gestiscolo vincoli semplici con estensioni e non con equazioni
v.up(j,t) = D(t,j);
s.up(j,t) = S_max;
s.fx(j,'Giu') = S0;
* Oppure: (prendo ultimo mese dell'insieme dei mesi)
*s.fx(j,t)$(ord(t)=card(t)) = S0;

obiettivo.. z =e= sum((j,t), P(j)*v(j,t)) - cs*sum((j,t), s(j,t));

bilancio(j,t).. x(j,t) + s(j,t-1)$(ord(t)>1) + S0$(ord(t)=1) =e= v(j,t) + s(j,t);

lavorazioni(i,t).. sum(j,tl(i,j)*x(j,t)) =l= hAP*(Ntot(i)-Nman(i,t));

Model Production /all/;
Solve Production using LP maximizing z;
Display x.l,v.l,s.l,z.l;

**PUNTO B
Integer Variables Nm(i, t) numero di macchinari di in manutenzione in i al mese t;
Nm.up(i,t) = Ntot(i);

Equations
    lavorazioni_b(i,t) Vincolo sulle lavorazioni al punto b
    Nmax(t) Massimo numero di manutenzioni
    manutenzioni(i) Vincolo sui macchinari in manutenzione nel reparto i (diverso dalla smerigliatura)
    manutenzioni_1 Macchinari in manutenzione nel reparto di smerigliatura
;

lavorazioni_b(i,t).. sum(j,tl(i,j)*x(j,t)) =l= hAP*(Ntot(i)-Nman(i,t));
Nmax(t).. sum(i, Nm(i,t)) =l= 3;
manutenzioni(i)$(ord(i)>1)..  sum(t, nm(i,t)) =e= Ntot(i);
manutenzioni_1.. sum(t, Nm('Smerigliatura', t)) =e= 2;

Model Production_b /obiettivo, bilancio, lavorazioni_b, Nmax, manutenzioni, manutenzioni_1/;

Production_b.optca = 0;
Production_b.optcr = 0;

Solve Production_b using MIP minimizing z;
Display x.l,v.l,s.l,z.l;









