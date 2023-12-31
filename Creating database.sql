CREATE TABLE YliopistonKurssit (
	kurssikoodi TEXT NOT NULL,
	kurssinNimi TEXT,
	opintopistemaara INTEGER CHECK (opintopistemaara >= 0),
PRIMARY KEY(kurssikoodi)
	
);

CREATE TABLE Toteutus (
kurssikoodi TEXT NOT NULL,
toteutusID TEXT NOT NULL,
toteutusAlkamisaika TEXT,
toteutusPaattymisaika TEXT,
lukukausi TEXT,
PRIMARY KEY(toteutusID, kurssikoodi),
FOREIGN KEY(kurssikoodi) REFERENCES YliopistonKurssit(kurssikoodi)
);


CREATE TABLE Tentti (
	kurssikoodi TEXT NOT NULL,
	tenttiID TEXT NOT NULL,
	tenttiAlkamisaika TEXT NOT NULL,
	tenttiPaattymisaika TEXT,
	PRIMARY KEY (tenttiID, tenttiAlkamisaika, kurssikoodi),
	FOREIGN KEY(kurssikoodi) REFERENCES Yliopistonkurssit (kurssikoodi)
);

CREATE TABLE Luennot (
kurssikoodi TEXT NOT NULL,
toteutusID TEXT NOT NULL,
luennotAlkamisaika TEXT NOT NULL,
luennotPaattymisaika TEXT,
numero TEXT NOT NULL,
PRIMARY KEY (luennotAlkamisaika, toteutusID, kurssikoodi),
FOREIGN KEY(kurssikoodi, toteutusID) REFERENCES Toteutus (kurssikoodi, toteutusID),
FOREIGN KEY(numero) REFERENCES Varaukset(numero)
);


CREATE TABLE Harjoitusryhmat (
	kurssikoodi TEXT NOT NULL,
	toteutusID TEXT NOT NULL,
	ryhmaID TEXT NOT NULL,
	maxOsallistujamaara INTEGER CHECK(maxOsallistujamaara >= 0),
	PRIMARY KEY(ryhmaID, toteutusID, kurssikoodi),
FOREIGN KEY(toteutusID, kurssikoodi) REFERENCES Toteutus (toteutusID, kurssikoodi)
);

CREATE TABLE Kokoontumiset (
	kurssikoodi TEXT NOT NULL,
	toteutusID TEXT NOT NULL,
	ryhmaID TEXT NOT NULL,
	kokoontumisenID TEXT NOT NULL,
	kokoontumisetAlkamisaika TEXT,
	kokoontumisetPaattymisaika TEXT,
	numero TEXT,
	PRIMARY KEY (kurssikoodi, toteutusID, ryhmaID, kokoontumisenID),
	FOREIGN KEY(kurssikoodi, toteutusID, ryhmaID) REFERENCES Harjoitusryhmat (kurssikoodi, toteutusID, ryhmaID)
);


CREATE TABLE Opiskelija (
	opiskelijaNimi TEXT NOT NULL,
	opiskelijanumero TEXT,
	syntymaaika TEXT,
	tutkintoohjelma TEXT,
	opiskelijaAloitus TEXT,
	opiskelijaValmistuu TEXT,
	PRIMARY KEY (opiskelijanumero)
);

CREATE TABLE IlmoittautuuKurssille (
	kurssikoodi TEXT NOT NULL,
	toteutusID TEXT NOT NULL,
	ryhmaID TEXT NOT NULL,
	opiskelijanumero TEXT NOT NULL,
	PRIMARY KEY(kurssikoodi, toteutusID, ryhmaID, opiskelijanumero),
	FOREIGN KEY(kurssikoodi, toteutusID, ryhmaID) REFERENCES Harjoitusryhmat (kurssikoodi, toteutusID, ryhmaID),
	FOREIGN KEY(opiskelijanumero) REFERENCES Opiskelija(opiskelijanumero)
);

CREATE TABLE IlmoittautuuTenttiin (
	kurssikoodi TEXT NOT NULL,
	tenttiID TEXT NOT NULL,
	tenttiAlkamisaika TEXT NOT NULL,
	opiskelijanumero TEXT NOT NULL,
	PRIMARY KEY(kurssikoodi, tenttiID, tenttiAlkamisaika, opiskelijanumero),
	FOREIGN KEY(kurssikoodi, tenttiID, tenttiAlkamisaika) REFERENCES Tentti(kurssikoodi, tenttiID, tenttiAlkamisaika),
	FOREIGN KEY(opiskelijanumero) REFERENCES Opiskelija(opiskelijanumero)
);

CREATE TABLE Varaukset (
	numero TEXT NOT NULL,
	varauksetAlku TEXT,
	varauksetLoppu TEXT, 
	varatutPaikat INTEGER,
	salinID TEXT,
	PRIMARY KEY (numero)
);

CREATE TABLE Luentovaraukset(
	numero TEXT NOT NULL,
	PRIMARY KEY(numero)
	FOREIGN KEY(numero) REFERENCES Varaukset (numero)
);

CREATE TABLE Harjoitusryhmavaraukset (
	numero TEXT NOT NULL, 
	PRIMARY KEY (numero),
	FOREIGN KEY (numero) REFERENCES Varaukset (numero)
);

CREATE TABLE Tenttivaraukset (
	numero TEXT NOT NULL,
	PRIMARY KEY (numero),
	FOREIGN KEY (numero) REFERENCES Varaukset (numero)
);

CREATE TABLE numero (
	numero TEXT NOT NULL,
	PRIMARY KEY (numero),
	FOREIGN KEY (numero) REFERENCES Varaukset (numero)
);

CREATE TABLE TenttienVaraus (
	numero TEXT NOT NULL,
	kurssikoodi TEXT NOT NULL,
	tenttiID TEXT NOT NULL,
	tenttiAlkamisaika TEXT NOT NULL,
	PRIMARY KEY (numero, kurssikoodi, tenttiID, tenttiAlkamisaika),
	FOREIGN KEY (numero) REFERENCES Varaukset (numero),
	FOREIGN KEY (kurssikoodi, tenttiID, tenttialkamisaika) REFERENCES Tentti (kurssikoodi, tenttiID, tenttiAlkamisaika)
);

CREATE TABLE Sali(
	salinID TEXT NOT NULL,
	paikkamaara INTEGER CHECK (paikkamaara >= 0),
	tenttijat INTEGER CHECK (tenttijat >= 0),
	rakennuksenID TEXT NOT NULL,
	PRIMARY KEY(salinID)
);

CREATE TABLE Yliopistorakennus(
	rakennuksenID TEXT NOT NULL,
	yliopistorakennusNimi TEXT,
	katuosoite TEXT,
	PRIMARY KEY(rakennuksenID)
);

CREATE TABLE Varusteet(
	varusteenID TEXT NOT NULL,
	varusteetNimi TEXT,
	ominaisuudet TEXT,
	PRIMARY KEY(varusteenID)
);

CREATE TABLE SalinVarusteet(
	varusteenID TEXT NOT NULL,
	salinID TEXT NOT NULL,
	count INTEGER,
	PRIMARY KEY(varusteenID, salinID)
	FOREIGN KEY(varusteenID) REFERENCES Varusteet(varusteenID)
	FOREIGN KEY(salinID) REFERENCES Sali(salinID) 
);





INSERT INTO YliopistonKurssit
VALUES('RAH-100101', 'Rahoituksen Perusteet', 6);

INSERT INTO YliopistonKurssit
VALUES('RAH-100102', 'Value Investing', 6);

INSERT INTO YliopistonKurssit
VALUES('TTK-100239', 'Tietokannat', 5);

INSERT INTO YliopistonKurssit
VALUES('TTK-100654', 'Software Development', 5);

INSERT INTO YliopistonKurssit
VALUES('MAR-200345', 'Markkinoinnin Perusteet', 6);

INSERT INTO YliopistonKurssit
VALUES('MAR-200430', 'Personal Branding', 6);


INSERT INTO Toteutus
VALUES('RAH-100101', 'RAHTOT-100101-1', '2020-10-08 00:00:00', '2020-12-12 00:00:00', '2020-2021');

INSERT INTO Toteutus
VALUES('RAH-100101', 'RAHTOT-100101-2', '2021-10-08 00:00:00', '2021-12-12 00:00:00', '2021-2022');

INSERT INTO Toteutus
VALUES('RAH-100102', 'RAHTOT-100102-1', '2020-10-08 00:00:00', '2020-12-12 00:00:00', '2020-2021');

INSERT INTO Toteutus
VALUES('RAH-100102', 'RAHTOT-100102-2', '2021-10-08 00:00:00', '2021-12-12 00:00:00', '2021-2022');

INSERT INTO Toteutus
VALUES('TTK-100239', 'TTKTOT-100239-1', '2020-10-08 00:00:00', '2020-12-12 00:00:00', '2020-2021');

INSERT INTO Toteutus
VALUES('TTK-100239', 'TTKTOT-100239-2', '2021-10-08 00:00:00', '2022-12-12 00:00:00', '2021-2022');

INSERT INTO Toteutus
VALUES('TTK-100654', 'TTKTOT-100654-1', '2020-10-08 00:00:00', '2020-12-12 00:00:00', '2020-2021');

INSERT INTO Toteutus
VALUES('TTK-100654', 'TTKTOT-100654-2', '2021-10-08 00:00:00', '2021-12-12 00:00:00', '2021-2022');

INSERT INTO Toteutus
VALUES('MAR-200345', 'MARTOT-200345-1', '2020-10-08 00:00:00', '2020-12-12 00:00:00', '2020-2021');

INSERT INTO Toteutus
VALUES('MAR-200345', 'MARTOT-200345-2', '2021-10-08 00:00:00', '2022-12-12 00:00:00', '2021-2022');

INSERT INTO Toteutus
VALUES('MAR-200430', 'MARTOT-200430-1', '2020-10-08 00:00:00', '2021-12-12 00:00:00', '2020-2021');


INSERT INTO Toteutus
VALUES('MAR-200430', 'MARTOT-200430-2', '2021-10-08 00:00:00', '2022-12-12 00:00:00', '2021-2022');


INSERT INTO Opiskelija
VALUES('Raimo Pitkanen', '569874', '03-04-1999', 'Rahoitus', 2016, 2022); 

INSERT INTO Opiskelija
VALUES('Ina Korhonen', '677893', '21-10-1998', 'Rahoitus', 2017, 2023);

INSERT INTO Opiskelija
VALUES('Gabriela Lappalainen', '549854', '15-08-1998', 'Rahoitus', 2015, 2021);

INSERT INTO Opiskelija
VALUES('Jussi Virtanen', '678953', '06-07-1997', 'Rahoitus', 2016, 2022);

INSERT INTO Opiskelija
VALUES('Juuso Leppanen', '776890', '13-02-1999', 'Rahoitus', 2017, 2023);

INSERT INTO Opiskelija
VALUES('Elena Alanko', '543678', '02-02-1997', 'Tietotekniikka', 2016, 2022);

INSERT INTO Opiskelija
VALUES('Antti Pilvinen', '555432', '30-03-1999', 'Tietotekniikka', 2015, 2021);

INSERT INTO Opiskelija
VALUES('Emilia Silakka', '987654', '20-01-1998', 'Tietotekniikka', 2017, 2023);

INSERT INTO Opiskelija
VALUES('Kaisa Makikoskela', '123456', '14-05-1998', 'Tietotekniikka', 2015, 2021);

INSERT INTO Opiskelija
VALUES('Henri Hynninen', '554367', '12-12-1999', 'Tietotekniikka', 2015, 2021);

INSERT INTO Opiskelija
VALUES('Jesse Haapanen', '234564', '12-05-1997', 'Markkinointi', 2016, 2022);

INSERT INTO Opiskelija
VALUES('Akseli Manninen', '435678', '21-03-1999', 'Markkinointi', 2015, 2021);

INSERT INTO Opiskelija
VALUES('Iiris Makinen', '234789', '02-05-1998', 'Markkinointi', 2017, 2023);

INSERT INTO Opiskelija
VALUES('Saramaria Ritala', '43289', '02-07-1998', 'Markkinointi', 2017, 2023);

INSERT INTO Opiskelija
VALUES('Joonas Ylinen', '234752', '18-09-1999', 'Markkinointi', 2015, 2021);


INSERT INTO Varaukset
VALUES('35647', '2020-09-12 09:00:00',  '2020-09-12 12:00:00', 50, 'SAL-1');

INSERT INTO Varaukset
VALUES('32654', '2020-12-12 09:00:00',  '2020-12-12 12:00:00', 100, 'SAL-2');

INSERT INTO Varaukset
VALUES('30987', '2021-09-12 09:00:00',  '2021-09-12 12:00:00', 25, 'SAL-3');

INSERT INTO Varaukset
VALUES('35888', '2020-09-12 13:00:00',  '2020-09-12 15:00:00', 30, 'SAL-4');

INSERT INTO Varaukset
VALUES('34627', '2020-12-12 13:00:00', '2021-12-12 15:00:00', 45, 'SAL-5');

INSERT INTO Varaukset
VALUES('37886', '2021-09-22 13:00:00',  '2021-09-22 15:00:00', 35, 'SAL-6');

INSERT INTO Varaukset
VALUES('34343', '2020-12-08 09:00:00', '2020-12-08 12:00:00', 50, 'SAL-1');

INSERT INTO Varaukset
VALUES('32256', '2021-01-08 09:00:00', '2021-01-08 12:00:00', 100, 'SAL-2');

INSERT INTO Varaukset
VALUES('31156', '2021-12-08 09:00:00', '2021-12-08 12:00:00', 25, 'SAL-3');

INSERT INTO Varaukset
VALUES('35567', '2020-12-08 09:00:00', '2020-12-08 12:00:00', 30, 'SAL-4');

INSERT INTO Varaukset
VALUES('36672', '2021-01-08 09:00:00', '2021-01-08 12:00:00', 45, 'SAL-5');

INSERT INTO Varaukset
VALUES('31116', '2021-12-08 09:00:00', '2021-12-08 12:00:00', 35, 'SAL-6');

INSERT INTO Varaukset
VALUES('39984','2020-12-08 09:00:00', '2020-12-08 12:00:00', 50, 'SAL-1');

INSERT INTO Varaukset
VALUES('34526', '2021-02-08 15:00:00', '2021-02-08 18:00:00', 100, 'SAL-2');

INSERT INTO Varaukset
VALUES('35521', '2021-12-08 10:00:00', '2021-12-08 12:00:00', 25, 'SAL-3');

INSERT INTO Varaukset
VALUES('34429','2020-12-08 10:00:00', '2020-12-08 13:00:00', 30, 'SAL-4');

INSERT INTO Varaukset
VALUES('32367','2021-01-08 10:00:00', '2021-01-08 13:00:00', 45, 'SAL-5');

INSERT INTO Varaukset
VALUES('31546', '2021-12-08 10:00:00', '2021-12-08 13:00:00', 35, 'SAL-6');

INSERT INTO Varaukset
VALUES('10000', '2020-06-05 09:00:00', '2020-06-05 10:00:00', 50, 'SAL-3');

INSERT INTO Varaukset
VALUES('10001', '2020-06-06 09:00:00', '2020-06-06 10:00:00', 50, 'SAL-3');

INSERT INTO Varaukset
VALUES('10002', '2020-06-05 13:00:00', '2020-06-05 14:00:00', 50, 'SAL-3');

INSERT INTO Varaukset
VALUES('10003',  '2020-06-06 13:00:00', '2020-09-06 14:00:00', 50, 'SAL-3');

INSERT INTO Varaukset
VALUES('10004', '2020-09-05 09:00:00', '2020-09-05 10:00:00', 50, 'SAL-3');

INSERT INTO Varaukset
VALUES('10005', '2020-09-06 09:00:00', '2020-09-06 10:00:00', 50, 'SAL-3');

INSERT INTO Varaukset
VALUES('10006', '2020-09-05 13:00:00', '2020-09-05 14:00:00', 50, 'SAL-3');

INSERT INTO Varaukset
VALUES('10007',  '2020-09-06 13:00:00', '2020-09-06 14:00:00', 50, 'SAL-3');

INSERT INTO Varaukset
VALUES('10237', '2020-10-08 12:00:00', '2020-10-08 14:00:00', 100, 'SAL-1');

INSERT INTO Varaukset
VALUES('10238', '2020-10-20 12:00:00', '2020-10-20 14:00:00', 100, 'SAL-1');

INSERT INTO Varaukset
VALUES('10247', '2021-10-08 12:00:00', '2021-10-08 14:00:00', 100, 'SAL-1');

INSERT INTO Varaukset
VALUES('10248', '2021-10-15 12:00:00', '2021-10-15 14:00:00', 100, 'SAL-1');

INSERT INTO Varaukset
VALUES('10269', '2020-10-08 12:00:00', '2020-10-08 17:00:00', 200, 'SAL-2');

INSERT INTO Varaukset
VALUES('10268', '2020-11-09 12:00:00', '2020-11-09 17:00:00', 200, 'SAL-2');

INSERT INTO Varaukset
VALUES('10250', '2021-10-08 12:00:00', '2021-10-08 17:00:00', 100, 'SAL-1');

INSERT INTO Varaukset
VALUES('10251', '2021-11-08 12:00:00', '2021-11-08 17:00:00', 200, 'SAL-2');

INSERT INTO Varaukset
VALUES('20126', '2020-10-08 16:00:00', '2020-10-08 18:00:00', 90, 'SAL-5');

INSERT INTO Varaukset
VALUES('30126', '2020-10-13 16:00:00', '2020-10-13 18:00:00', 90, 'SAL-5');

INSERT INTO Varaukset
VALUES('50126', '2020-10-08 12:00:00', '2020-10-08 18:00:00', 70, 'SAL-6');

INSERT INTO Varaukset
VALUES('60126', '2021-10-08 12:00:00', '2021-10-08 18:00:00', 70, 'SAL-6');

INSERT INTO Varaukset
VALUES('61230', '2020-10-08 09:00:00', '2020-10-08 12:00:00', 200, 'SAL-2');

INSERT INTO Varaukset
VALUES('61430', '2021-10-08 09:00:00', '2021-10-08 12:00:00', 200, 'SAL-2');

INSERT INTO Varaukset
VALUES('21430', '2020-10-09 13:00:00', '2020-10-09 15:00:00', 200, 'SAL-2');

INSERT INTO Varaukset
VALUES('51430', '2021-10-09 13:00:00', '2021-10-09 15:00:00', 200, 'SAL-2');



INSERT INTO Tentti
VALUES('RAH-100101', 'R-27', '2020-09-12 09:00:00',  '2020-09-12 12:00:00');

INSERT INTO Tentti
VALUES('RAH-100101', 'R-28', '2020-12-12 09:00:00',  '2020-12-12 12:00:00');

INSERT INTO Tentti
VALUES('RAH-100101', 'R-37', '2021-09-12 09:00:00',  '2021-09-12 12:00:00');

INSERT INTO Tentti
VALUES('RAH-100102', 'R-33', '2020-09-12 13:00:00',  '2020-09-12 15:00:00');

INSERT INTO Tentti
VALUES('RAH-100102', 'R-34', '2020-12-12 13:00:00',  '2021-12-12 15:00:00');

INSERT INTO Tentti
VALUES('RAH-100102', 'R-43', '2021-09-22 13:00:00',  '2021-09-22 15:00:00');

INSERT INTO Tentti
VALUES('TTK-100239', 'TT-70', '2020-12-08 09:00:00', '2020-12-08 12:00:00');

INSERT INTO Tentti
VALUES('TTK-100239', 'TT-71', '2021-01-08 09:00:00', '2021-01-08 12:00:00');

INSERT INTO Tentti
VALUES('TTK-100239', 'TT-80', '2021-12-08 09:00:00', '2021-12-08 12:00:00');

INSERT INTO Tentti
VALUES('TTK-100654', 'TT-71', '2020-12-08 09:00:00', '2020-12-08 12:00:00');

INSERT INTO Tentti
VALUES('TTK-100654', 'TT-72', '2021-01-08 09:00:00', '2021-01-08 12:00:00');

INSERT INTO Tentti
VALUES('TTK-100654', 'TT-81', '2021-12-08 09:00:00', '2021-12-08 12:00:00');

INSERT INTO Tentti
VALUES('MAR-200345', 'MM-17', '2020-12-08 09:00:00', '2020-12-08 12:00:00');

INSERT INTO Tentti
VALUES('MAR-200345', 'MM-18', '2021-02-08 15:00:00', '2021-02-08 18:00:00');

INSERT INTO Tentti
VALUES('MAR-200345', 'MM-27', '2021-12-08 10:00:00', '2021-12-08 12:00:00');

INSERT INTO Tentti
VALUES('MAR-200430', 'MA-33',  '2020-12-08 10:00:00', '2020-12-08 13:00:00');

INSERT INTO Tentti
VALUES('MAR-200430', 'MA-34',  '2021-01-08 10:00:00', '2021-01-08 13:00:00');

INSERT INTO Tentti
VALUES('MAR-200430', 'MA-43',  '2021-12-08 10:00:00', '2021-12-08 13:00:00');
INSERT INTO Harjoitusryhmat
VALUES('RAH-100101', 'RAHTOT-100101-1', 'RYH-1', 20);


INSERT INTO Harjoitusryhmat
VALUES('RAH-100101', 'RAHTOT-100101-1', 'RYH-2', 25);

INSERT INTO Harjoitusryhmat
VALUES('RAH-100101', 'RAHTOT-100101-2', 'RYH-1', 20);

INSERT INTO Harjoitusryhmat
VALUES('RAH-100101', 'RAHTOT-100101-2', 'RYH-2', 25);

INSERT INTO Harjoitusryhmat
VALUES('RAH-100102', 'RAHTOT-100102-1', 'RYH-1', 30);

INSERT INTO Harjoitusryhmat
VALUES('RAH-100102', 'RAHTOT-100102-1', 'RYH-2', 30);

INSERT INTO Harjoitusryhmat
VALUES('RAH-100102', 'RAHTOT-100102-2', 'RYH-1', 30);

INSERT INTO Harjoitusryhmat
VALUES('RAH-100102', 'RAHTOT-100102-2', 'RYH-2', 30);

INSERT INTO Harjoitusryhmat
VALUES('TTK-100239', 'TTKTOT-100239-1', 'RYH-1', 50);

INSERT INTO Harjoitusryhmat
VALUES('TTK-100239', 'TTKTOT-100239-1', 'RYH-2', 50);

INSERT INTO Harjoitusryhmat
VALUES('TTK-100239', 'TTKTOT-100239-2', 'RYH-1', 50);

INSERT INTO Harjoitusryhmat
VALUES('TTK-100239', 'TTKTOT-100239-2', 'RYH-2', 50);

INSERT INTO Harjoitusryhmat
VALUES('TTK-100654', 'TTKTOT-100654-1', 'RYH-1', 15);

INSERT INTO Harjoitusryhmat
VALUES('TTK-100654', 'TTKTOT-100654-1', 'RYH-2', 15);

INSERT INTO Harjoitusryhmat
VALUES('TTK-100654', 'TTKTOT-100654-2', 'RYH-1', 15);

INSERT INTO Harjoitusryhmat
VALUES('TTK-100654', 'TTKTOT-100654-2', 'RYH-2', 15);

INSERT INTO Harjoitusryhmat
VALUES('MAR-200345', 'MARTOT-200345-1', 'RYH-1', 75);

INSERT INTO Harjoitusryhmat
VALUES('MAR-200345', 'MARTOT-200345-1', 'RYH-2', 75);

INSERT INTO Harjoitusryhmat
VALUES('MAR-200345', 'MARTOT-200345-2', 'RYH-1', 75);

INSERT INTO Harjoitusryhmat
VALUES('MAR-200345', 'MARTOT-200345-2', 'RYH-2', 75);


INSERT INTO Harjoitusryhmat
VALUES('MAR-200430', 'MARTOT-200430-1', 'RYH-1', 65);

INSERT INTO Harjoitusryhmat
VALUES('MAR-200430', 'MARTOT-200430-1', 'RYH-2', 75);

INSERT INTO Harjoitusryhmat
VALUES('MAR-200430', 'MARTOT-200430-2', 'RYH-1', 65);

INSERT INTO Harjoitusryhmat
VALUES('MAR-200430', 'MARTOT-200430-2', 'RYH-2', 75);


INSERT INTO IlmoittautuuKurssille
VALUES('RAH-100101', 'RAHTOT-100101-1', 'RYH-1', '569874');

INSERT INTO IlmoittautuuKurssille
VALUES('RAH-100101', 'RAHTOT-100101-1', 'RYH-1', '677893');

INSERT INTO IlmoittautuuKurssille
VALUES('RAH-100102', 'RAHTOT-100102-1', 'RYH-1', '677893');

INSERT INTO IlmoittautuuKurssille
VALUES('TTK-100239', 'TTKTOT-100239-1', 'RYH-1', '543678');

INSERT INTO IlmoittautuuKurssille
VALUES('TTK-100654', 'TTKTOT-100654-1', 'RYH-1', '555432');

INSERT INTO IlmoittautuuKurssille
VALUES('MAR-200345', 'MARTOT-200345-1', 'RYH-1', '234564');

INSERT INTO IlmoittautuuKurssille
VALUES('MAR-200430', 'MARTOT-200430-1', 'RYH-1', '435678');

INSERT INTO IlmoittautuuKurssille
VALUES('MAR-200430', 'MARTOT-200430-1', 'RYH-1', '234564');

INSERT INTO IlmoittautuuKurssille
VALUES('MAR-200430', 'MARTOT-200430-1', 'RYH-1', '543678');


INSERT INTO IlmoittautuuTenttiin
VALUES('RAH-100101', 'R-27', '2020-09-12 09:00:00', '569874');

INSERT INTO IlmoittautuuTenttiin
VALUES('RAH-100102', 'R-33', '2020-09-12 13:00:00','677893');

INSERT INTO IlmoittautuuTenttiin
VALUES('TTK-100239', 'TT-70', '2020-12-08 09:00:00', '543678');


INSERT INTO IlmoittautuuTenttiin
VALUES('TTK-100654', 'TT-71', '2020-12-08 09:00:00', '555432');

INSERT INTO IlmoittautuuTenttiin
VALUES('MAR-200345', 'MM-17', '2020-12-08 09:00:00', '234564');


INSERT INTO IlmoittautuuTenttiin
VALUES('MAR-200430', 'MA-33',  '2020-12-08 10:00:00', '435678');


INSERT INTO TenttienVaraus
VALUES('35647','RAH-100101','R-27','2020-09-12 09:00:00');

INSERT INTO TenttienVaraus
VALUES('32654','RAH-100101','R-28','2020-12-12 09:00:00');

INSERT INTO TenttienVaraus
VALUES('30987','RAH-100101','R-37','2021-09-12 09:00:00');
INSERT INTO TenttienVaraus
VALUES('35888','RAH-100102','R-33','2020-09-12 13:00:00');

INSERT INTO TenttienVaraus
VALUES('34627','RAH-100102','R-34','2020-12-12 13:00:00');

INSERT INTO TenttienVaraus
VALUES('37886','RAH-100102','R-43','2021-09-22 13:00:00');

INSERT INTO TenttienVaraus
VALUES('34343','TTK-100239','TT-70','2020-12-08 09:00:00');

INSERT INTO TenttienVaraus
VALUES('32256','TTK-100239','TT-71','2021-01-08 09:00:00');

INSERT INTO TenttienVaraus
VALUES('31156','TTK-100239','TT-80','2021-12-08 09:00:00');

INSERT INTO TenttienVaraus
VALUES('35567','TTK-100654','TT-71','2020-12-08 09:00:00');

INSERT INTO TenttienVaraus
VALUES('36672','TTK-100654','TT-72','2021-01-08 09:00:00');

INSERT INTO TenttienVaraus
VALUES('31116','TTK-100654','TT-81','2021-12-08 09:00:00');

INSERT INTO TenttienVaraus
VALUES('39984','MAR-200345','MM-17','2020-12-08 09:00:00');

INSERT INTO TenttienVaraus
VALUES('34526','MAR-200345','MM-18','2021-02-08 15:00:00');

INSERT INTO TenttienVaraus
VALUES('35521','MAR-200345','MM-27','2021-12-08 10:00:00');

INSERT INTO TenttienVaraus
VALUES('34429','MAR-200430','MA-33','2020-12-08 10:00:00');

INSERT INTO TenttienVaraus
VALUES('32367','MAR-200430','MA-34','2021-01-08 10:00:00');

INSERT INTO TenttienVaraus
VALUES('31546','MAR-200430','MA-43','2021-12-08 10:00:00');



INSERT INTO Luentovaraukset
VALUES('10237');

INSERT INTO Luentovaraukset
VALUES('10238');

INSERT INTO Luentovaraukset
VALUES('10247');

INSERT INTO Luentovaraukset
VALUES('10248');

INSERT INTO Luentovaraukset
VALUES('10250');

INSERT INTO Luentovaraukset
VALUES('10268');

INSERT INTO Luentovaraukset
VALUES('10269');

INSERT INTO Luentovaraukset
VALUES('10251');

INSERT INTO Luentovaraukset
VALUES('20126');

INSERT INTO Luentovaraukset
VALUES('30126');

INSERT INTO Luentovaraukset
VALUES('50126');

INSERT INTO Luentovaraukset
VALUES('60126');


INSERT INTO Harjoitusryhmavaraukset
VALUES('10000');

INSERT INTO Harjoitusryhmavaraukset
VALUES('10001');

INSERT INTO Harjoitusryhmavaraukset
VALUES('10002');

INSERT INTO Harjoitusryhmavaraukset
VALUES('10003');

INSERT INTO Harjoitusryhmavaraukset
VALUES('10004');

INSERT INTO Harjoitusryhmavaraukset
VALUES('10005');

INSERT INTO Harjoitusryhmavaraukset
VALUES('10006');

INSERT INTO Harjoitusryhmavaraukset
VALUES('10007');



INSERT INTO Tenttivaraukset
VALUES('35647');

INSERT INTO Tenttivaraukset
VALUES('32654');

INSERT INTO Tenttivaraukset
VALUES('30987');

INSERT INTO Tenttivaraukset
VALUES('35888');

INSERT INTO Tenttivaraukset
VALUES('34627');

INSERT INTO Tenttivaraukset
VALUES('37886');

INSERT INTO Tenttivaraukset
VALUES('34343');

INSERT INTO Tenttivaraukset
VALUES('32256');

INSERT INTO Tenttivaraukset
VALUES('31156');

INSERT INTO Tenttivaraukset
VALUES('35567');

INSERT INTO Tenttivaraukset
VALUES('36672');

INSERT INTO Tenttivaraukset
VALUES('31116');

INSERT INTO Tenttivaraukset
VALUES('39984');

INSERT INTO Tenttivaraukset
VALUES('34526');

INSERT INTO Tenttivaraukset
VALUES('35521');

INSERT INTO Tenttivaraukset
VALUES('34429');

INSERT INTO Tenttivaraukset
VALUES('32367');

INSERT INTO Tenttivaraukset
VALUES('31546');


INSERT INTO Kokoontumiset
VALUES('RAH-100101', 'RAHTOT-100101-1', 'RYH-1', 'KOK-1', '2020-06-05 09:00:00', '2020-06-05 10:00:00', '10000');

INSERT INTO Kokoontumiset
VALUES('RAH-100101', 'RAHTOT-100101-1', 'RYH-1', 'KOK-2', '2020-06-06 09:00:00', '2020-06-06 10:00:00', '10001');

INSERT INTO Kokoontumiset
VALUES('RAH-100101', 'RAHTOT-100101-1', 'RYH-2', 'KOK-1', '2020-06-05 13:00:00', '2020-06-05 14:00:00', '10002');

INSERT INTO Kokoontumiset
VALUES('RAH-100101', 'RAHTOT-100101-1', 'RYH-2', 'KOK-2', '2020-06-06 13:00:00', '2020-06-06 14:00:00', '10003');

INSERT INTO Kokoontumiset
VALUES('RAH-100101', 'RAHTOT-100101-2', 'RYH-1', 'KOK-1', '2020-09-05 09:00:00', '2020-09-05 10:00:00', '10004');

INSERT INTO Kokoontumiset
VALUES('RAH-100101', 'RAHTOT-100101-2', 'RYH-1', 'KOK-2', '2020-09-06 09:00:00', '2020-09-06 10:00:00', '10005');

INSERT INTO Kokoontumiset
VALUES('RAH-100101', 'RAHTOT-100101-2', 'RYH-2', 'KOK-1', '2020-09-05 13:00:00', '2020-09-05 14:00:00', '10006');

INSERT INTO Kokoontumiset
VALUES('RAH-100101', 'RAHTOT-100101-2', 'RYH-2', 'KOK-2', '2020-09-06 13:00:00', '2020-09-06 14:00:00', '10007');



INSERT INTO Luennot
VALUES('RAH-100101', 'RAHTOT-100101-1', '2020-10-08 12:00:00', '2020-10-08 14:00:00','10237');

INSERT INTO Luennot
VALUES('RAH-100101', 'RAHTOT-100101-1', '2020-10-20 12:00:00', '2020-10-20 14:00:00','10238');

INSERT INTO Luennot
VALUES('RAH-100101', 'RAHTOT-100101-2', '2021-10-08 12:00:00', '2021-10-08 14:00:00','10247');

INSERT INTO Luennot
VALUES('RAH-100101', 'RAHTOT-100101-2', '2021-10-15 12:00:00', '2021-10-15 14:00:00','10248');

INSERT INTO Luennot
VALUES('RAH-100102', 'RAHTOT-100102-1', '2020-10-08 12:00:00', '2020-10-08 17:00:00','10269');

INSERT INTO Luennot
VALUES('RAH-100102', 'RAHTOT-100102-1', '2020-11-09 12:00:00', '2020-11-09 17:00:00','10268');

INSERT INTO Luennot
VALUES('RAH-100102', 'RAHTOT-100102-2', '2021-10-08 12:00:00', '2021-10-08 17:00:00','10250');

INSERT INTO Luennot
VALUES('RAH-100102', 'RAHTOT-100102-2', '2021-11-08 12:00:00', '2021-11-08 17:00:00','10251');

INSERT INTO Luennot
VALUES('TTK-100239', 'TTKTOT-100239-1', '2020-10-08 16:00:00', '2020-10-08 18:00:00','20126');

INSERT INTO Luennot
VALUES('TTK-100239', 'TTKTOT-100239-1', '2020-10-13 16:00:00', '2020-10-13 18:00:00','30126');

INSERT INTO Luennot
VALUES('TTK-100239', 'TTKTOT-100239-2', '2021-10-08 16:00:00', '2021-10-08 18:00:00','20126');

INSERT INTO Luennot
VALUES('TTK-100239', 'TTKTOT-100239-2', '2021-10-13 16:00:00', '2021-10-13 18:00:00','30126');

INSERT INTO Luennot
VALUES('TTK-100239', 'TTKTOT-100239-1', '2020-10-08 12:00:00', '2020-10-08 18:00:00','50126');

INSERT INTO Luennot
VALUES('TTK-100654', 'TTKTOT-100654-2', '2021-10-08 12:00:00', '2021-10-08 18:00:00','60126');

INSERT INTO Luennot
VALUES('MAR-200345', 'MARTOT-200345-1', '2020-10-08 09:00:00', '2020-10-08 12:00:00','61230');

INSERT INTO Luennot
VALUES('MAR-200345', 'MARTOT-200345-2', '2021-10-08 09:00:00', '2021-10-08 12:00:00','61430');

INSERT INTO Luennot
VALUES('MAR-200430', 'MARTOT-200430-1', '2020-10-09 13:00:00', '2020-10-09 15:00:00','21430');

INSERT INTO Luennot
VALUES('MAR-200430', 'MARTOT-200430-2', '2021-10-09 13:00:00', '2021-10-09 15:00:00','51430');


INSERT INTO Yliopistorakennus
VALUES('RAK-1', 'Kandikeskus', 'Otakaari1' );

INSERT INTO Yliopistorakennus
VALUES('RAK-2', 'Tietotekniikkatalo', 'Konemiehentie 2' );

INSERT INTO Yliopistorakennus
VALUES('RAK-3', 'TUAS', 'Maarintie 8');


INSERT INTO Sali
VALUES('SAL-1', '100', '50', 'RAK-1');

INSERT INTO Sali
VALUES('SAL-2', '200', '100', 'RAK-1');

INSERT INTO Sali
VALUES('SAL-3', '50', '25', 'RAK-2');

INSERT INTO Sali
VALUES('SAL-4', '60', '30', 'RAK-2');

INSERT INTO Sali
VALUES('SAL-5', '90', '45', 'RAK-3');

INSERT INTO Sali
VALUES('SAL-6', '70', '35', 'RAK-3');


INSERT INTO Varusteet
VALUES('VAR-1', 'Projektori', '4K UHD');

INSERT INTO Varusteet
VALUES('VAR-2', 'Projektori', 'Full HD');
INSERT INTO Varusteet
VALUES('VAR-3', 'Valkokangas', '200”');

INSERT INTO Varusteet
VALUES('VAR-4', 'Valkokangas', '250”');

INSERT INTO Varusteet
VALUES('VAR-5', 'Kamera', 'HD videokuvaus');

INSERT INTO Varusteet
VALUES('VAR-6', 'Kamera', 'Full HD videokuvaus');

INSERT INTO SalinVarusteet
VALUES('VAR-1', 'SAL-1', 1);

INSERT INTO SalinVarusteet
VALUES('VAR-3', 'SAL-1', 2);

INSERT INTO SalinVarusteet
VALUES('VAR-2', 'SAL-2', 1);

INSERT INTO SalinVarusteet
VALUES('VAR-3', 'SAL-2', 3);

INSERT INTO SalinVarusteet
VALUES('VAR-2', 'SAL-3', 2);

INSERT INTO SalinVarusteet
VALUES('VAR-4', 'SAL-3', 1);














