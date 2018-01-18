--Do latwiejszego ogladania polaczen przystankow
CREATE VIEW polaczenia_przystankow_czytelne AS 
SELECT p.nazwa AS od, p2.nazwa AS do, pp.czas_podrozy, tp.typ 
FROM przystanki p, przystanki p2, polaczenia_przystankow pp, typy_polaczen tp 
WHERE p.id_przystanku=pp.od 
AND p2.id_przystanku=pp.do_1
 AND tp.id_typu=pp.id_typu
 ORDER BY od;

--latwiejsze ogladanie pojazdow
CREATE VIEW pojazdy_czytelne AS 
select p.id_pojazdu, m.typ, m.producent AS marka, m.nazwa_modelu AS model, z.adres 
from pojazdy p, zajezdnie z, modele m 
WHERE z.id_zajezdni=p.id_zajezdni 
AND m.id_model=p.id_model
ORDER BY id_pojazdu;

--latwiejsze ogladanie kierowcow
CREATE VIEW kierowcy_czytelne AS
Select k.id_pracownika, p.imie, p.nazwisko, poj.typ, k.PJ_autobus, k.PJ_tramwaj 
FROM pracownicy p, kierowcy k, pojazdy_czytelne poj 
WHERE k.id_pracownika=p.id_pracownika 
AND poj.id_pojazdu=k.id_pojazdu
ORDER BY id_pracownika;

--latwiejsze ogladanie polaczen przystanek-linia
CREATE VIEW przystanki_linie_czytelne AS 
SELECT pl.id_linii, p.nazwa, pl.kolejnosc 
FROM przystanki_linie pl, przystanki p 
WHERE pl.id_przystanku=p.id_przystanku
ORDER BY id_linii, kolejnosc;

--Pomaga w wyliczaniu czasu przejazdu calej trasy
CREATE VIEW polaczenia_pomocnicze AS 
SELECT pl.id_linii, pl.id_przystanku,  AS od, pl2.id_przystanku AS do, pl.kolejnosc 
from przystanki_linie pl, przystanki_linie pl2 
WHERE pl.id_linii = pl2.id_linii 
AND pl2.kolejnosc=pl.kolejnosc+1;


--Pomaga w wyliczaniu calej trasy linii
CREATE VIEW do_liczenia_podrozy AS 
SELECT pl.id_linii, pl.od, pl.do, pp.czas_podrozy, pl.kolejnosc 
FROM polaczenia_przystankow pp, polaczenia_pomocnicze pl 
WHERE (pl.od=pp.od AND pl.do=pp.do_1) 
OR (pl.od=pp.do_1 AND pl.do=pp.od );



