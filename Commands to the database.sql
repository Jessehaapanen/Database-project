SELECT *
FROM YliopistonKurssit
WHERE Opintopistemaara >= 3;

SELECT OpiskelijaNimi, opiskelijanumero, tutkintoohjelma
FROM Opiskelija
WHERE tutkintoohjelma = 'Markkinointi';

SELECT yliopistorakennusNimi, katuosoite
FROM Yliopistorakennus;

SELECT *
FROM Sali
WHERE paikkamaara > 100 AND tenttijat > 50;

SELECT Y1.kurssikoodi, Y1.kurssinNimi, T1.toteutusAlkamisaika, T1.toteutusPaattymisaika
FROM YliopistonKurssit as Y1, Toteutus as T1
WHERE Y1.kurssikoodi = T1.kurssikoodi AND T1.lukukausi = '2020-2021';

SELECT T1.tenttiID, T1.tenttiAlkamisaika, T1.tenttiPaattymisaika
FROM Tentti as T1, YliopistonKurssit as Y1
WHERE T1.kurssikoodi = Y1.kurssikoodi AND Y1.kurssinNimi = 'Rahoituksen Perusteet';

SELECT O1.opiskelijaNimi, O1.opiskelijanumero
FROM Harjoitusryhmat as H1, Opiskelija as O1, IlmoittautuuKurssille as K1
WHERE H1.kurssikoodi = K1.kurssikoodi AND H1.toteutusID = K1.toteutusID AND H1.ryhmaID = K1.ryhmaID AND O1.opiskelijanumero = K1.opiskelijanumero AND H1.ryhmaID = 'RYH-1' AND H1.kurssikoodi = 'RAH-100101' AND H1.toteutusID = 'RAHTOT-100101-1';

SELECT K1.kokoontumisenID, K1.kokoontumisetAlkamisaika, K1.kokoontumisetPaattymisaika
FROM Kokoontumiset as K1, Harjoitusryhmat as H1
WHERE K1.kurssikoodi = H1.kurssikoodi AND K1.toteutusID = H1.toteutusID AND K1.ryhmaID = H1.ryhmaID AND K1.ryhmaID = 'RYH-2' AND H1.kurssikoodi = 'RAH-100101' AND H1.toteutusID = 'RAHTOT-100101-1';

SELECT V1.varauksetAlku, V1.varauksetLoppu, V1.varatutPaikat
FROM Varaukset as V1, Luennot as L1
WHERE V1.numero = L1.numero AND L1.kurssikoodi = 'RAH-100101' AND L1.toteutusID = 'RAHTOT-100101-2' AND L1.luennotAlkamisaika = '2021-10-08 12:00:00';

SELECT V1.varusteenID, V1.varusteetNimi, V1.ominaisuudet
FROM Sali as S1, Varusteet as V1, SalinVarusteet as V2
WHERE S1.salinID = V2.salinID AND V1.varusteenID = V2.varusteenID AND S1.salinID = 'SAL-3';

SELECT SUM(S1.tenttijat)
FROM Sali as S1, Yliopistorakennus as Y1
WHERE S1.rakennuksenID = Y1.rakennuksenID AND Y1.rakennuksenID = 'RAK-3';

SELECT O1.opiskelijaNimi, O1.opiskelijanumero, O1.tutkintoohjelma
FROM Tentti as T1, IlmoittautuuTenttiin as I2, Opiskelija as O1
WHERE T1.kurssikoodi = I2.kurssikoodi AND T1.tenttiID = I2.tenttiID AND T1.tenttiAlkamisaika = I2.tenttiAlkamisaika AND O1.opiskelijanumero = I2.opiskelijanumero AND T1.kurssikoodi = 'TTK-100239' AND T1.tenttiID = 'TT-70' AND T1.tenttiAlkamisaika = '2020-12-08 09:00:00'; 

SELECT COUNT(K1.opiskelijanumero)
FROM (
SELECT DISTINCT K2.opiskelijanumero
FROM IlmoittautuuKurssille as K2
WHERE K2.kurssikoodi = 'MAR-200430' AND K2.toteutusID = 'MARTOT-200430-1') 
AS K1;

SELECT Y1.kurssikoodi, Y1.kurssinNimi, count(O1.opiskelijanumero)
FROM YliopistonKurssit AS Y1, Harjoitusryhmat AS H1, IlmoittautuuKurssille AS I1,
Opiskelija AS O1
WHERE Y1.kurssikoodi = H1.kurssikoodi AND Y1.kurssikoodi = I1.kurssikoodi AND O1.opiskelijanumero = I1.opiskelijanumero AND H1.toteutusID = I1.toteutusID AND 
H1.ryhmaID = I1.ryhmaID
GROUP BY Y1.kurssikoodi
ORDER BY Y1.kurssinNimi;

SELECT Y1.kurssikoodi, Y1.kurssinNimi, avg(H1.maxOsallistujamaara)
FROM YliopistonKurssit AS Y1, Harjoitusryhmat AS H1
WHERE Y1.kurssikoodi = H1.kurssikoodi
GROUP BY Y1.kurssikoodi;


CREATE VIEW MarkinointiOpiskelijat as 
SELECT O1.opiskelijaNimi, O1.opiskelijanumero, O1.tutkintoohjelma, H1.kurssikoodi, H1.toteutusID, H1.ryhmaID
FROM Opiskelija as O1, Harjoitusryhmat as H1, IlmoittautuuKurssille as I1
WHERE H1.kurssikoodi = I1.kurssikoodi and H1.toteutusID = I1.toteutusID and H1.ryhmaID = I1.ryhmaID and O1.opiskelijanumero = I1.opiskelijanumero and O1.tutkintoohjelma = 'Markkinointi';

CREATE INDEX SaliIndex ON Sali(salinID);

CREATE INDEX OpiskelijaIndex ON Opiskelija(opiskelijanumero);

CREATE INDEX KurssinIndex ON YliopistonKurssit(kurssikoodi);

