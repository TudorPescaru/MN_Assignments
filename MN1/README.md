*315CA Pescaru Tudor-Mihai 2020*

# PART 1

## generate-probabilities-system
Pentru a construi matricea returnata de aceasta functie am iterat prin numarul 
de randuri al labirintului, rows, apoi prin numarul de noduri de pe fiecare 
rand, acestea fiind si liniile matricei, si in final am iterat prin numarul de 
ecuatii, adica numarul de coloane din matrice. am folosit o serie de 
conditionari pentru a verifica pozitia fiecarui nod in cadrul labirintului, 
respectiv daca acesta se afla in colturile labirntului triunghiular pe laturi 
sau in interiorul acestuia. Astfel matricea avea pe diagonala numarul de 
legaturi al nodului corspunzator liniei iar in rest, pe fiecare linie se punea 
-1 pe coloana corespunzatoare unui nod legat la nodul liniei sau 0 in caz 
contrar.

## Jacobi-factorization
Am folosit algoritmul clasic pentru calcularea matricei si vectorului de 
iteratie Jacobi, folosind inversulu lui N, P sib.

## Jacobi-sparse
Am folosit algoritmul clasic cu modificarea ca in calcularea noului x la 
fiecare iteratie se folosea functia de csr-multiplication.

## matrix-to-csr
Am implementat algoritmul descris de pseudocodul dat.

# PART 2

## clustering-pc
Am inceput prin a initializa matricele pentru cluseterele de puncte, una 
pentru a insuma punctele si una pentru a le numara. Am calculat si adaugat 
valorile pentru aceste matrice folosind pozitia i%NC pentru punctul i
si pozitia NC pentru cazul in care i%NC = 0. Mai apoi am construit vectorul 
de centroizi facand impartirea intre valoare din sum si cea din count. 
Folosind acest vector am realizat trecerea initiala prin algoritm pentru a 
avea un punct de plecare. Pentru fiecare punct am calculat distanta cea mai 
mica la un centroid si am adaugat punctul in grupul acelui centroid. Apoi am 
realizat recalcularea centroizilor folosind punctele din fiecare grup.
Am repetat acest algoritm pana cand, calculand distanta dintre vechea pozitie 
a centroizilor si cea nou obtinuta, obtineam valoarea 0.

## compute-cost-pc
Am folosit acelasi sistem de calculare a distantei minime de la un punct la un 
centroid ca in functia precedenta.

# PART 3

## rgbHistogram
Am folosit functia imread pentru a obtine matrice tridimensionala pentru 
imaginea data prin path. Aceasta matrice a fost separata in alte 3, folosind 
cele 3 planuri are matricei imaginii. Aceste matrici au reprezentat valorile 
red, green si blue ale pixelilor. Am construit un vetor de numere de la 0 la 
256 cu pasul 256/count-bins, iar fiecare doua puncte din acest vector au format 
intervalele folosite in functia histc pentru a calcula fiecare histograma.

## hsvHistogram
Am folosit acelasi sistem ca la rgbHistogram cu diferenta ca matricea imagini 
a fost convertita folosind o functie RGB2HSV implementata pentru a obtine o
matrice echivalenta in sistem HSV. Aici vetctorul de numere a avut elemente 
intre 0 si 101 cu pasul 101/count-bins care au fost mai apoi scalate la interval 
[0, 1] prin impartirea la 100.

## RGB2HSV
Am folosit o implementare vectorizata a pseudocodului dat, functia primind o 
matrice tridimensionala in sistem RGB si returnand una tridimensionala in 
sistem HSV. Am utilizat functia max pentru a obtine matricea cu elemente maxime 
si matricea cu indici corespunzatori matricei de unde a fost luat elementul 
maxim. Aceasta a fost folosita in calcularea lui H. Am folosit 3 vectori de 
indici liniari, generati cu functia find aplicata matricea generata de conditia 
logica == realizata intre matricea de indecsi si fiecare dintre cazuri pentru a 
determina pozitiile pe care se vor pune elementele calculate conform celor 3 
cazuri si 3 matrici auxiliare pentru a calcula valorile din fiecare caz. Am 
asamblat apoi valorile folosind vectorii pentru a obtine astfel matricea finala 
pentru hue. Am adus apoi aceste valori in interval [0, 1]. Matricea pentru 
saturation a fost calculata impartind delta element cu element la matricea 
maxima iar matricea pentru value este chiar matricea maxima.

## Householder & SST
Am folosit algoritmi clasici, fara inmultiri de matrici insa, pentru a acomoda 
matrici nepatratice.

## preprocess
Am construit path-urile catre folderele cats si not-cats iar apoi am extras 
imaginile din fiecare folosind dir si am trecut prin fiecare contruind 
histograma rgb sau hsv in functie de caz, adaugand aceasta histograma la 
matricea de histograme si adaugand 1 sau -1 in vectorul de clasificare.

## learn
Am construit X-tilda adaugand coloana termenilor de bias si am aplicat 
Householder si SST pentru a genera modelul.

## evaluate
Am construit path-urile catre folderele cats si not-cats si am iterat prin 
imagini, construind histograma in forma coloana, adaugand termenul de bias 
la final si inmultind-o cu transpusa modelului. Rezultatul era mai apoi 
verificat si se adauga incrementul de procentaj la procentajul total. In 
final se scala procentajul la interval [0, 1].

# PART 4

Am adaugat functiile rgbHistogram, hsvHistogram, RGB2HSV, preprocess din PART 3

## learn
Am contruit X-tilda adaugand coloana termenilor de bias si scaland fiecare 
coloana dupa regula data. Am initializat w cu valori random. Am iterat pentru 
numarul de epoci date. La fiecare iteratie am selectat batch-size=64 linii 
random din X-tilda si linia corespunzatoare din y si am caclulat noul w 
dupa formula data.

## evaluate
Aceasta functie este la fel cu cea de la PART 3 cu diferenta ca aici, pentru 
fiecare histograma, in afara de adaugarea termenului de bias, se face si 
scalarea coloanelor dupa regula.

# FEEDBACK
O tema foarte interesanta si educativa. As fi dorit insa ca anumite aspecte 
sa fie explicate mai in detaliu, in principal in PART 3 si 4, cum ar fi 
dimensiunile anumitor vectori/matrici, daca vectorii sunt coloana sau linie, 
procesul de evaluare al modelului. O problema obervata este aceea ca se 
specifica faptul ca evaluate returneaza un numar in interval [0, 100] dar 
verificarea se face pe interval [0, 1]. Echipa a raspuns in mod util la 
intrebarile de pe forum.
