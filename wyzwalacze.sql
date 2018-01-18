
--Sprawdzanie czy zajezdnie maja wolne miejsca
CREATE OR REPLACE FUNCTION sprawdz_zajezdnie() RETURNS TRIGGER AS'
DECLARE
i integer;
BEGIN
IF TG_OP = ''INSERT'' OR TG_OP = ''UPDATE'' THEN
	i := (SELECT COUNT(*) FROM pojazdy WHERE ID_Zajezdni=NEW.ID_zajezdni);
	IF( i >= (SELECT z.Pojemnosc FROM Zajezdnie z WHERE z.ID_Zajezdni=NEW.id_zajezdni) ) THEN
		Raise EXCEPTION ''Ta zajezdnia(ID_zajezdni=%) jest juz pelna(Liczba przypisanych pojazdow: %), wybierz inną'',  new.ID_zajezdni, i;
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
	Raise EXCEPTION ''Tylko kierownik moze byc przelozonym!'';
	RETURN NULL;
	ELSE RETURN NEW;
	END IF;
END IF;
END;
' LANGUAGE 'plpgsql';

CREATE TRIGGER przelozony BEFORE INSERT OR UPDATE ON pracownicy FOR EACH ROW EXECUTE PROCEDURE sprawdz_przelozonego();

--Funkcja sprawdzajaca czy dodajemy/usuwamy z konca linii
CREATE OR REPLACE FUNCTION czy_jest_polaczenie() RETURNS TRIGGER AS'
DECLARE
 size integer;
BEGIN 
	
if TG_OP = ''DELETE'' OR TG_OP = ''UPDATE'' THEN
	size = (SELECT COUNT(*) from przystanki_linie WHERE id_linii=old.id_linii);
	if old.kolejnosc <> size THEN
		Raise EXCEPTION ''Nie mozna usuwac polaczen ze srodka linii! (obecna liczba przystankow w linii: %)'', size;
		RETURN NULL;
	ELSE RETURN OLD;
	END IF;
END IF;
if tg_op = ''INSERT'' OR tg_op = ''update'' THEN
		size = (SELECT COUNT(*) from przystanki_linie WHERE id_linii=new.id_linii);
		if new.kolejnosc = size+1 THEN 
			return NEW;
		ELSE Raise EXCEPTION ''Mozna dodawac przystanki tylko na koniec linii!(obecna liczba przystankow w linii: %)'', size;
		RETURN NULL;
		END IF;
END IF;

END;
' LANGUAGE 'plpgsql';
CREATE TRIGGER dziury_w_liniach BEFORE INSERT OR UPDATE OR DELETE ON przystanki_linie FOR EACH ROW EXECUTE PROCEDURE czy_jest_polaczenie();

CREATE OR REPLACE FUNCTION Uzupelnianie_czasu_podrozy() RETURNS TRIGGER AS'
BEGIN
if(TG_OP = ''UPDATE'' OR TG_OP = ''INSERT'') THEN
	UPDATE Linie set czas_podrozy=Licz_czas_przejazdu(new.id_linii) WHERE id_linii=new.id_linii;
	RETURN NEW;
ELSE IF(TG_OP =''DELETE'') THEN
	UPDATE Linie set czas_podrozy=Licz_czas_przejazdu(old.id_linii) WHERE id_linii=OLD.id_linii;
	RETURN NEW;
END IF;
END IF;
END;
' LANGUAGE 'plpgsql'; 

CREATE TRIGGER uzupelnij_czas AFTER INSERT OR UPDATE OR DELETE ON przystanki_linie FOR EACH ROW EXECUTE PROCEDURE Uzupelnianie_czasu_podrozy();


CREATE OR REPLACE FUNCTION Sprawdz_czy_sa_polaczenia(n INTEGER) RETURNS TRIGGER AS'
DECLARE
	size INTEGER;
BEGIN
	size = (SELECT COUNT(*) from przystanki_linie where id_linii=n) -1;

	FOR i IN 1..size LOOP
		if(SELECT dlp.czas_podrozy from do_liczenia_podrozy dlp WHERE dlp.id_linii=n AND dlp.kolejnosc=i )=NULL;
			Raise EXCEPTION ''Dodany przystanek nie ma polaczenia z kolejnym!'';
			RETURN NULL;
	END LOOP;
	RETURN NEW;
END;
' LANGUAGE 'plpgsql'; 

CREATE TRIGGER sprawdz_polaczenia AFTER INSERT OR UPDATE ON przystanki_linie FOR EACH ROW EXECUTE PROCEDURE Sprawdz_czy_sa_polaczenia();


CREATE OR REPLACE FUNCTION Nie_przemeczaj_kierowcow() RETURNS TRIGGER AS'
DECLARE
	size INTEGER;
BEGIN
	if (SELECT count(*) from Grafik g where new.id_pracownika=g.id_pracownika AND new.data=g.data) > 0 THEN
	Raise EXCEPTION ''Ten pracownik ma juz zmiane w ten dzien'';
	RETURN NULL;
	ELSE if new.Liczba_kursow * (SELECT l.czas_podrozy from LINIE l where new.ID_linii=l.id_linii) >= 480 THEN
			Raise EXCEPTION ''Za dlugi czas pracy kierowcy, nie mozna dodac tylu kursow, bo czas pracy przekroczy 8 godzin!'';
			RETURN NULL;
			ELSE RETURN NEW;
		END IF;
	END IF;
END;
' LANGUAGE 'plpgsql'; 

CREATE TRIGGER maksymalny_czas_pracy BEFORE INSERT OR UPDATE ON Grafik FOR EACH ROW EXECUTE PROCEDURE Nie_przemeczaj_kierowcow();


CREATE OR REPLACE FUNCTION dodaj_kierowce() RETURNS TRIGGER AS'
BEGIN
	if new.stanowisko=''Kierowca'' THEN
		INSERT INTO KIEROWCY VALUES (new.id_pracownika, NULL, false, false);
	END IF;
	RETURN NEW;
END;
' LANGUAGE 'plpgsql'; 

CREATE TRIGGER auto_kierowcy AFTER INSERT ON Pracownicy FOR EACH ROW EXECUTE PROCEDURE dodaj_kierowce();



CREATE OR REPLACE FUNCTION wyznacz_pensje() RETURNS TRIGGER AS'
DECLARE
	suma INTEGER;
	curs1 CURSOR FOR SELECT id_linii from Linie;
	linia INTEGER;
BEGIN
	suma:=0;
	OPEN curs1;
	if(TG_OP = ''UPDATE'' OR TG_OP = ''INSERT'') THEN
		LOOP FETCH curs1 INTO linia; 
		EXIT WHEN NOT FOUND;
			suma := suma + coalesce( (select SUM(Liczba_kursow) from grafik where id_pracownika=new.id_pracownika AND linia=id_linii ), 0) * (SELECT czas_podrozy from linie where linia=id_linii) * 80 ;
		END LOOP;
		UPDATE Pracownicy set Pensja=suma WHERE id_pracownika=new.id_pracownika;
	ELSE IF(TG_OP =''DELETE'') THEN
		LOOP FETCH curs1 INTO linia; 
		EXIT WHEN NOT FOUND; 
				suma := suma + coalesce( (select SUM(Liczba_kursow) from grafik where id_pracownika=old.id_pracownika AND linia=id_linii ), 0) * (SELECT czas_podrozy from linie where linia=id_linii) * 40 ;
		END LOOP;
		UPDATE Pracownicy set Pensja=suma WHERE id_pracownika=old.id_pracownika;
	END IF;
	END IF;
	CLOSE curs1;
	RETURN NEW;		
END;
' LANGUAGE 'plpgsql';

CREATE TRIGGER uaktualnianie_pensji AFTER INSERT OR UPDATE OR DELETE ON Grafik FOR EACH ROW EXECUTE PROCEDURE wyznacz_pensje();

