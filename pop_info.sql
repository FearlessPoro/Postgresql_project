set search_path to MPK;

INSERT INTO  Typy_polaczen VALUES (DEFAULT, 'Autobusowe');
INSERT INTO  Typy_polaczen VALUES (DEFAULT, 'Tramwajowe');
INSERT INTO  Typy_polaczen VALUES (DEFAULT, 'Autobusowo-Tramwajowe');

INSERT INTO  Zajezdnie VALUES (DEFAULT, 'Jana Brożka 3', 75);
INSERT INTO  Zajezdnie VALUES (DEFAULT, 'Ujastek 12', 100);
INSERT INTO  Zajezdnie VALUES (DEFAULT, 'Walerego Sławka 10', 200);

INSERT INTO  Modele VALUES (DEFAULT, 'Autobus', 'Solaris', 'Urbino 18');
INSERT INTO  Modele VALUES (DEFAULT, 'Autobus', 'Solaris', 'Urbino 12');
INSERT INTO  Modele VALUES (DEFAULT, 'Autobus', 'Mercedes-Benz', '0530G');
INSERT INTO  Modele VALUES (DEFAULT, 'Autobus', 'Solaris', 'Urbino 18 Hybrid');
INSERT INTO  Modele VALUES (DEFAULT, 'Tramwaj', 'Bombardier', 'NGT6');
INSERT INTO  Modele VALUES (DEFAULT, 'Tramwaj', 'Bombardier', 'NGT8');
INSERT INTO  Modele VALUES (DEFAULT, 'Tramwaj', 'SGP', 'E1');
INSERT INTO  Modele VALUES (DEFAULT, 'Tramwaj', 'Rotax', 'EU8N');
INSERT INTO  Modele VALUES (DEFAULT, 'Tramwaj', 'Düwag', 'GT8S');

--8
INSERT INTO   Przystanki VALUES (DEFAULT, 'Borek Fałęcki', false);
INSERT INTO  Przystanki VALUES (DEFAULT, 'Plac Wszystkich Świętych', false);
INSERT INTO  Przystanki VALUES (DEFAULT, 'Filharmonia', false);
INSERT INTO  Przystanki VALUES (DEFAULT, 'Teatr Bagatela', false);
INSERT INTO  Przystanki VALUES (DEFAULT, 'Bronowice Małe', false);

--2
INSERT INTO  Przystanki VALUES (DEFAULT, 'Salwator', false);
--Filharmonia
--bagatela
INSERT INTO  Przystanki VALUES (DEFAULT, 'Dworzec Główny', false);
INSERT INTO  Przystanki VALUES (DEFAULT, 'Cmentarz Rakowicki', false);

--4
INSERT INTO  Przystanki VALUES (DEFAULT, 'Wzgórza Krzesławickie', false);
INSERT INTO  Przystanki VALUES (DEFAULT, 'Rondo Mogilskie', false);
--Dworzec glowny
--bagatela
--Bronowice male

--159
INSERT INTO  Przystanki VALUES (DEFAULT, 'Os.Piastów', false);
INSERT INTO  Przystanki VALUES (DEFAULT, 'Nowy Kleparz', false);
INSERT INTO  Przystanki VALUES (DEFAULT, 'Czarnowiejska', false);
INSERT INTO  Przystanki VALUES (DEFAULT, 'Kawiory', false);
INSERT INTO  Przystanki VALUES (DEFAULT, 'Miasteczko Studenckie AGH', false);
INSERT INTO  Przystanki VALUES (DEFAULT, 'Cichy Kącik', false);

--201
--Borek Falecki
INSERT INTO  Przystanki VALUES (DEFAULT, 'Góra Borkowska', false);
INSERT INTO  Przystanki VALUES (DEFAULT, 'Zawiła', false);
INSERT INTO  Przystanki VALUES (DEFAULT, 'Skawina Podlipki', true);
INSERT INTO  Przystanki VALUES (DEFAULT, 'Skawina', true);

--208
INSERT INTO  Przystanki VALUES (DEFAULT, 'Dworzec Główny Wschód', false);
--Nowy kleparz
--Czarnowiejska
--kawiory
--miasteczko studenckie agh
INSERT INTO  Przystanki VALUES (DEFAULT, 'Armii Krajowej', false);
--Bronowice Male
INSERT INTO  Przystanki VALUES (DEFAULT, 'Mydlniki', false);
INSERT INTO  Przystanki VALUES (DEFAULT, 'Szczyglice', true);
INSERT INTO  Przystanki VALUES (DEFAULT, 'Kraków Airport', true);




INSERT INTO  Linie VALUES (8, 1, 5, 15, 20, 30, (CAST (N'5:30:00' AS Time)), (CAST (N'22:30:00' AS Time)),  0);
INSERT INTO  Linie VALUES (2, 6, 8, 15, 20, 30, (CAST (N'5:30:00' AS Time)), (CAST (N'22:30:00' AS Time)),  0);
INSERT INTO  Linie VALUES (4, 9, 5, 15, 20, 30, (CAST (N'5:30:00' AS Time)), (CAST (N'22:30:00' AS Time)),  0);
INSERT INTO  Linie VALUES (159, 11, 16, 20, 30, 60, (CAST (N'4:30:00' AS Time)), (CAST (N'22:00:00' AS Time)),  0);
INSERT INTO  Linie VALUES (201, 1, 20, 15, 20, 30, (CAST (N'5:30:00' AS Time)), (CAST (N'22:30:00' AS Time)),  0);
INSERT INTO  Linie VALUES (208, 21, 25, 15, 20, 30, (CAST (N'5:30:00' AS Time)), (CAST (N'22:30:00' AS Time)),  0);



INSERT INTO Polaczenia_przystankow VALUES (1, 2, 10, 2);
INSERT INTO Polaczenia_przystankow VALUES (2, 3, 10, 2);
INSERT INTO Polaczenia_przystankow VALUES (3, 4, 15, 2);
INSERT INTO Polaczenia_przystankow VALUES (4, 5, 15, 2);

INSERT INTO Polaczenia_przystankow VALUES (6, 3, 15, 2);
INSERT INTO Polaczenia_przystankow VALUES (4, 7, 15, 3);
INSERT INTO Polaczenia_przystankow VALUES (7, 8, 10, 2);

INSERT INTO Polaczenia_przystankow VALUES (9, 10, 10, 2);
INSERT INTO Polaczenia_przystankow VALUES (7, 10, 10, 2);

INSERT INTO Polaczenia_przystankow VALUES (11, 12, 10, 1);
INSERT INTO Polaczenia_przystankow VALUES (12, 13, 10, 1);
INSERT INTO Polaczenia_przystankow VALUES (13, 14, 10, 1);
INSERT INTO Polaczenia_przystankow VALUES (14, 15, 10, 1);
INSERT INTO Polaczenia_przystankow VALUES (15, 16, 10, 1);


INSERT INTO Polaczenia_przystankow VALUES (1, 17, 10, 1);
INSERT INTO Polaczenia_przystankow VALUES (17, 18, 10, 1);
INSERT INTO Polaczenia_przystankow VALUES (18, 19, 10, 1);
INSERT INTO Polaczenia_przystankow VALUES (19, 20, 10, 1);

INSERT INTO Polaczenia_przystankow VALUES (12, 21, 10, 1);
INSERT INTO Polaczenia_przystankow VALUES (15, 22, 10, 1);
INSERT INTO Polaczenia_przystankow VALUES (5, 22, 10, 1);
INSERT INTO Polaczenia_przystankow VALUES (5, 23, 10, 1);
INSERT INTO Polaczenia_przystankow VALUES (23, 24, 10, 1);
INSERT INTO Polaczenia_przystankow VALUES (24, 25, 10, 1);


