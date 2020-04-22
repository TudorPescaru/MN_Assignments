Copyright 2020 Pescaru Tudor-Mihai

# In spatele unui motor de cautare

## AdjMatrix
Functia primeste numele fisierului ce contine datele despre graf si valorile 
val1 si val2. Aceasta returneaza matricea de adiacenta a grafului si val1 si 
val2. Aceasta acceseaza fisierul dat prin nume, citeste numarul de noduri iar 
apoi pentru fiecare nod citeste numarul de adiacente si lista de adiacente a 
nodului respectiv.

## Iterative
Se apeleaza functia AdjMatrix pentru a creea matricea de adiacenta. Pe baza 
acesteia se calculeaza matricea diagonala K care are pe diagonala numarul de 
conexiuni al fiecarui nod. Deoarece este matrice diagonala se calculeaza 
usor inversa si impreuna cu matricea de adiacenta A se calculeaza matricea M 
ce va fi folosita in calculul iterativ al vectorului PageRank. Vectorul se 
initializeaza cu 1/N, N numarul de pagini web si se calculeaza iterativ pana 
cand diferenta dintre doi pasi este mai mica decat o toleranta data.

## SST
Functia implementeaza rezolvarea unui sistem de tip Ax=b unde A este o 
matrice superior triunghiulara iar x si b sunt vectori coloana.

## PR_Inv
Functia implementeaza varianta modificata a algoritmului Gram-Schmidt pentru 
o mai buna stabilitate numerica si factorizeaza matricea primita in doua 
matrici Q si R apoi aplica metoda SST folosind matricea identitate pentru a 
determina inversa matricei date.

## Algebraic
Se utilizeaza functia AdjMatrix pentru a creea matricea de adiacenta si se 
foloseste acelasi proces pentru a creea matricea M. Se foloseste functia 
PR_Inv pentru a determina inversul necesar in calcularea prin formula 
algebrica a vectorului PageRank si apoi se calculeaza acesta.

## Apartenenta
Se implementeaza functia membru utilizata in determinarea valorilor de 
importanta si clasificarea paginilor web. Se afla valorile a sib in functie 
de val1 si val2 astfel incat functia sa fie continua.

## PageRank
Se parseaza fisierul ce contine datele despre graf prin functia AdjMatrix, 
pentru a determina N numarul de pagini web si val1 si val2. Se scrie in 
fisierul de output N. Se determina vectorul PageRank R1 prin metoda Iterativa 
si vectorul PageRank R2 prin metoda Algebraic si se scriu amandoua. Apoi se 
sorteaza descrescator R2 si se afiseaza ordine in functie de importanta si 
valoarea determinata folosind functia membru.

