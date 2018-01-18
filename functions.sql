
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




CREATE OR REPLACE FUNCTION Liczenie_liczby_kursow(Linia INTEGER, data DATE) RETURNS INTEGER AS'
DECLARE
	czas TIME;
	i INTEGER;
BEGIN
	czas := (SELECT Pierwszy_kurs from Linie WHERE id_linii=Linia);
	i := 0;
	if to_char(data, ''dy'') = ''sun'' THEN
		WHILE czas < (SELECT Ostatni_Kurs from Linie WHERE id_linii=Linia) LOOP
			czas = czas + (SELECT Czestosc_swieta from Linie WHERE id_linii=Linia )* interval ''1 minute'';
			i = i+1;
		END LOOP;
	ELSE 
	IF to_char(data, ''dy'') = ''sat'' THEN
		WHILE czas < (SELECT Ostatni_Kurs from Linie WHERE id_linii=Linia) LOOP
			czas = czas + (SELECT Czestosc_polswieta from Linie WHERE id_linii=Linia) * interval ''1 minute'';
			i = i+1;
		END LOOP;
	ELSE
	WHILE czas < (SELECT Ostatni_Kurs from Linie WHERE id_linii=Linia) LOOP
			czas = czas + (SELECT Czestosc_powszednia from Linie WHERE id_linii=Linia )* interval ''1 minute'';
			i = i+1;
		END LOOP;
	END IF;
	END IF;
	RETURN i;
END;
' LANGUAGE 'plpgsql'; 





CREATE OR REPLACE FUNCTION Przydziel_pojazdy() RETURNS VOID AS'
DECLARE
	cur_tramwaj CURSOR FOR SELECT id_pracownika FROM KIEROWCY where pj_tramwaj=true;
	cur_autobus CURSOR FOR SELECT id_pracownika FROM KIEROWCY where pj_autobus=true;
	cur_pojazd_tramwaj CURSOR FOR SELECT id_pojazdu from Pojazdy_czytelne WHERE typ=''Tramwaj'';
	cur_pojazd_autobus CURSOR FOR SELECT id_pojazdu from Pojazdy_czytelne WHERE typ=''Autobus'';
	kierowca integer;
	pojazd integer;
BEGIN
	OPEN cur_tramwaj;
	OPEN cur_autobus;
	OPEN cur_pojazd_autobus;
	OPEN cur_pojazd_tramwaj;
	UPDATE KIEROWCY set id_pojazdu=NULL;
	LOOP FETCH cur_tramwaj INTO kierowca; 
	EXIT WHEN NOT FOUND;
		FETCH cur_pojazd_tramwaj INTO pojazd;
		UPDATE KIEROWCY SET id_pojazdu=pojazd where id_pracownika=kierowca;
			
	END LOOP;
	LOOP FETCH cur_autobus INTO kierowca; 
	EXIT WHEN NOT FOUND;
		FETCH cur_pojazd_autobus INTO pojazd;
		UPDATE KIEROWCY SET id_pojazdu = pojazd where id_pracownika=kierowca;
	END LOOP;
	Close cur_tramwaj;
	Close cur_autobus;
	Close cur_pojazd_autobus;
	Close cur_pojazd_tramwaj;
END;
' LANGUAGE 'plpgsql';

SELECT k1.id_pracownika, k2.id_pracownika, k1.id_pojazdu, k2.id_pojazdu as drugie_id from kierowcy k1, kierowcy k2 where k1.id_pracownika<>k2.id_pracownika AND k1.id_pojazdu=k2.id_pojazdu;



select generuj_grafik( CAST (N'14.01.2018' AS DATE) );


CREATE OR REPLACE FUNCTION Generuj_grafik(data_dzien DATE) RETURNS VOID AS'
DECLARE
	cur_tramwaj CURSOR FOR SELECT id_pracownika FROM KIEROWCY where pj_tramwaj=true;
	cur_autobus CURSOR FOR SELECT id_pracownika FROM KIEROWCY where pj_autobus=true;
	cur_linie CURSOR FOR SELECT id_linii from LINIE;
	linia INTEGER;
	kierowca INTEGER;
	czas_koniec TIME;
	czestosc INTEGER;
	czas TIME;
	czas_pomocniczy TIME;
	czas_drogi INTEGER;
	ilosc INTEGER;
	czas_poczatkowy TIME;
	skip INTEGER;
BEGIN
	OPEN cur_tramwaj;
	OPEN cur_autobus;
	OPEN cur_linie;
	LOOP FETCH cur_linie INTO linia;
	EXIT WHEN NOT FOUND; 
		DELETE FROM GRAFIK g WHERE g.data=data_dzien;
		czas := (select Pierwszy_kurs from Linie where id_linii=linia);
		czas_poczatkowy := (select Pierwszy_kurs from Linie where id_linii=linia);
		czas_koniec := (select Ostatni_Kurs from Linie where id_linii=linia);
		IF (( SELECT to_char(data_dzien, ''dy'') ) = ''sun'') THEN

			czestosc := (select Czestosc_swieta from Linie where id_linii=Linia);	
		ELSE IF ( (SELECT to_char(data_dzien, ''dy'') )= ''sat'') THEN
			czestosc :=(select Czestosc_polswieta from Linie where id_linii=Linia);
		ELSE
			czestosc := (select Czestosc_powszednia from Linie where id_linii=Linia);
		END IF;
		END IF;
		czas_drogi := (Select czas_podrozy from Linie where id_linii = Linia);
		skip := 0;
		WHILE czas <= czas_koniec LOOP
			IF linia < 100 THEN
				FETCH cur_tramwaj INTO kierowca; 
			ELSE
				FETCH cur_autobus INTO kierowca;
			END IF;
			czas_pomocniczy := czas;
			ilosc:=1;
			WHILE czas_pomocniczy - czas_drogi * interval ''1 minute'' < czas_koniec AND czas_drogi* ilosc *2 <= 480 LOOP
				ilosc := ilosc+1;
				czas_pomocniczy:= czas_pomocniczy+2 * czas_drogi * interval ''1 minute'';
			
			END LOOP;
			IF ilosc > 1 THEN
				ilosc:= ilosc-1;
			END If;			
			INSERT INTO GRAFIK VALUES (DEFAULT, linia, kierowca, czas, ilosc, data_dzien);
			IF czas_poczatkowy + ((2 *czas_drogi - czestosc)+ skip) * interval  ''1 minute'' <= czas  THEN
				czas := czas + (2 *czas_drogi * (ilosc-1) + czestosc) * interval ''1 minute'';
				skip:= skip + 2 *czas_drogi * (ilosc) ;
			ELSE
				czas := czas +  czestosc * interval ''1 minute'';
			END IF;
		END LOOP;
	END LOOP;
	CLOSE cur_tramwaj;
	CLOSE cur_autobus;
	CLOSE cur_linie;
END;
' LANGUAGE 'plpgsql';
