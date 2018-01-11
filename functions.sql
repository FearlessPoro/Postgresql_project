
--Sprawdzanie czy zajezdnie maja wolne miejsca
CREATE OR REPLACE FUNCTION sprawdz_zajezdnie() RETURNS TRIGGER AS'
DECLARE
i integer;
BEGIN
IF TG_OP = ''INSERT'' OR TG_OP = ''UPDATE'' THEN
	i := (SELECT COUNT(*) FROM pojazdy WHERE ID_Zajezdni=NEW.ID_zajezdni);
	IF( i >= (SELECT z.Pojemnosc FROM Zajezdnie z WHERE z.ID_Zajezdni=NEW.id_zajezdni) ) THEN
		RAISE NOTICE ''Ta zajezdnia(ID_zajezdni=%) jest juz pelna(Liczba przypisanych pojazdow: %), wybierz inną'',  new.ID_zajezdni, i;
		RETURN NULL;
	ELSE RETURN NEW;
	END IF;
END IF;
END;
' LANGUAGE 'plpgsql';

CREATE TRIGGER zajezdnie BEFORE INSERT OR UPDATE ON pojazdy FOR EACH ROW EXECUTE PROCEDURE sprawdz_zajezdnie();


--sprawdzanie czy przelozony jest kierownikiem
CREATE OR REPLACE FUNCTION sprawdz_przelozonego() returns TRIGGER AS'
BEGIN
IF TG_OP = ''INSERT'' OR TG_OP = ''UPDATE'' THEN
	IF ( (SELECT p.stanowisko from pracownicy p WHERE p.id_pracownika=new.przelozony)<>''Kierownik'') THEN
	RAISE NOTICE ''Tylko kierownik moze byc przelozonym!'';
	RETURN NULL;
	ELSE RETURN NEW;
	END IF;
END IF;
END;
' LANGUAGE 'plpgsql';

CREATE TRIGGER przelozony BEFORE INSERT OR UPDATE ON pracownicy FOR EACH ROW EXECUTE PROCEDURE sprawdz_przelozonego();

--Funkcja sprawdzajaca czy dodajemy/usuwamy z konca linii
-- TODO Dodac mozliwosc usuwania i dodawania na srodek? 
CREATE OR REPLACE FUNCTION czy_jest_polaczenie() RETURNS TRIGGER AS'
DECLARE
 size integer;
BEGIN 
	
if TG_OP = ''DELETE'' OR TG_OP = ''UPDATE'' THEN
	size = (SELECT COUNT(*) from przystanki_linie WHERE id_linii=old.id_linii);
	if old.kolejnosc <> size THEN
		RAISE NOTICE ''Nie mozna usuwac polaczen ze srodka linii! (obecna liczba przystankow w linii: %)'', size;
		RETURN NULL;
	ELSE RETURN OLD;
	END IF;
END IF;
if tg_op = ''INSERT'' OR tg_op = ''update'' THEN
		size = (SELECT COUNT(*) from przystanki_linie WHERE id_linii=new.id_linii);
		if new.kolejnosc = size+1 THEN 
			-- TODO sprawdzanie czy mozna dodac polaczenie na podstawie istnienia polaczen
			-- if new.id_linii < 100 THEN
			-- 	if new.id_ THEN
			-- 	END IF;
			-- ELSE if  THEN
			-- 	END IF;
			-- END IF;
			return NEW;
		ELSE RAISE NOTICE ''Mozna dodawac przystanki tylko na koniec linii!(obecna liczba przystankow w linii: %)'', size;
		RETURN NULL;
		END IF;
END IF;

END;
' LANGUAGE 'plpgsql';


CREATE TRIGGER dziury_w_liniach BEFORE INSERT OR UPDATE OR DELETE ON przystanki_linie FOR EACH ROW EXECUTE PROCEDURE czy_jest_polaczenie();


--funkcja do liczenia czasu przejazdu liniami, argument to id_linii, zwraca czas w minutach
CREATE OR REPLACE FUNCTION Licz_czas_przejazdu(n INTEGER) RETURNS INTEGER AS'
DECLARE
	size INTEGER;
	czas FLOAT8;
BEGIN
	czas = 0;
	size = (SELECT COUNT(*) from przystanki_linie where id_linii=n) -1;

	FOR i IN 1..size LOOP
		czas := czas + (SELECT dlp.czas_podrozy from do_liczenia_podrozy dlp WHERE dlp.id_linii=n AND dlp.kolejnosc=i );
	END LOOP;
	RETURN czas;
END;
' LANGUAGE 'plpgsql'; 


CREATE OR REPLACE FUNCTION Uzupelnianie_czasu_podrozy() RETURNS TRIGGER AS'
BEGIN
if(TG_OP = ''UPDATE'' OR TG_OP = ''INSERT'') THEN
	UPDATE Linie set czas_podrozy=Licz_czas_przejazdu(new.id_linii) WHERE id_linii=new.id_linii;
	RETURN NEW;
ELSE IF(TG_OP ==''DELETE'') THEN
	UPDATE Linie set czas_podrozy=Licz_czas_przejazdu(old.id_linii) WHERE id_linii=OLD.id_linii;
	RETURN NEW;
END IF;
END IF;
END;
' LANGUAGE 'plpgsql'; 

CREATE TRIGGER uzupelnij_czas AFTER INSERT OR UPDATE OR DELETE ON przystanki_linie FOR EACH ROW EXECUTE PROCEDURE Uzupelnianie_czasu_podrozy();


--tego nie trzeba, mozna zalozyc ze czasy miedzy przystankami sie nie zmieniaja
-- CREATE OR REPLACE FUNCTION Uzupelnianie_czasu_podrozy2() RETURNS TRIGGER AS'
-- BEGIN
-- if(TG_OP = ''UPDATE'' ) THEN
-- 	for i in 1..300 LOOP
-- 	INSERT INTO 
-- 	END LOOP;
-- END IF;
-- END;
-- ' LANGUAGE 'plpgsql';

-- CREATE TRIGGER uzupelnij_czas2 AFTER UPDATE ON polaczenia_przystankow FOR EACH ROW EXECUTE PROCEDURE Uzupelnianie_czasu_podrozy2();


--castowanie daty na dzien: select to_char(CAST (N'09.01.2018' AS DATE), 'day');

CREATE OR REPLACE FUNCTION Liczenie_lizby_kursow() RETURNS INTEGER AS'
BEGIN

END;
' LANGUAGE 'plpgsql'; 