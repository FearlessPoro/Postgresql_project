
CREATE SEQUENCE MPK.typy_polaczen_id_typu_seq_1;

CREATE TABLE MPK.Typy_polaczen (
                ID_Typu INTEGER NOT NULL DEFAULT nextval('MPK.typy_polaczen_id_typu_seq_1'),
                Typ VARCHAR NOT NULL,
                CONSTRAINT id_typu PRIMARY KEY (ID_Typu)
);


ALTER SEQUENCE MPK.typy_polaczen_id_typu_seq_1 OWNED BY MPK.Typy_polaczen.ID_Typu;

CREATE SEQUENCE MPK.zajezdnie_id_zajezdni_seq_1;

CREATE TABLE MPK.Zajezdnie (
                ID_Zajezdni INTEGER NOT NULL DEFAULT nextval('MPK.zajezdnie_id_zajezdni_seq_1'),
                Adres VARCHAR NOT NULL,
                Pojemosc NUMERIC NOT NULL,
                CONSTRAINT id_zajezdni PRIMARY KEY (ID_Zajezdni)
);


ALTER SEQUENCE MPK.zajezdnie_id_zajezdni_seq_1 OWNED BY MPK.Zajezdnie.ID_Zajezdni;

CREATE SEQUENCE MPK.modele_id_model_seq;

CREATE TABLE MPK.Modele (
                ID_Model INTEGER NOT NULL DEFAULT nextval('MPK.modele_id_model_seq'),
                Typ VARCHAR NOT NULL,
                Producent VARCHAR NOT NULL,
                Nazwa_modelu VARCHAR NOT NULL,
                CONSTRAINT id_a_model PRIMARY KEY (ID_Model)
);


ALTER SEQUENCE MPK.modele_id_model_seq OWNED BY MPK.Modele.ID_Model;

CREATE SEQUENCE MPK.linie_id_linii_seq;

CREATE TABLE MPK.Linie (
                ID_Linii INTEGER NOT NULL DEFAULT nextval('MPK.linie_id_linii_seq'),
                Poczatek INTEGER NOT NULL,
                Koniec INTEGER NOT NULL,
                Czestosc_powszednia INTEGER NOT NULL,
                Czestosc_polswieta INTEGER NOT NULL,
                Czestosc_swieta INTEGER NOT NULL,
                Pierwszy_Kurs TIME NOT NULL,
                Ostatni_Kurs TIME NOT NULL,
                Czas_podrozy INTEGER NOT NULL,
                CONSTRAINT id_linii PRIMARY KEY (ID_Linii)
);


ALTER SEQUENCE MPK.linie_id_linii_seq OWNED BY MPK.Linie.ID_Linii;

CREATE SEQUENCE MPK.przystanki_id_przystanku_seq;

CREATE TABLE MPK.Przystanki (
                ID_Przystanku INTEGER NOT NULL DEFAULT nextval('MPK.przystanki_id_przystanku_seq'),
                Nazwa VARCHAR NOT NULL,
                Aglomeracyjny BOOLEAN NOT NULL,
                CONSTRAINT id_przystanku PRIMARY KEY (ID_Przystanku)
);


ALTER SEQUENCE MPK.przystanki_id_przystanku_seq OWNED BY MPK.Przystanki.ID_Przystanku;

CREATE TABLE MPK.Polaczenia_przystankow (
                Od INTEGER NOT NULL,
                Do_1 INTEGER NOT NULL,
                Czas_podrozy INTEGER NOT NULL,
                ID_Typu INTEGER NOT NULL,
                CONSTRAINT id_polaczen PRIMARY KEY (Od, Do_1)
);


CREATE TABLE MPK.Przystanki_Linie (
                ID_Linii INTEGER NOT NULL,
                ID_Przystanku INTEGER NOT NULL,
                Kolejnosc INTEGER NOT NULL,
                CONSTRAINT id_pl PRIMARY KEY (ID_Linii, ID_Przystanku, Kolejnosc)
);


CREATE SEQUENCE MPK.pracownicy_id_pracownika_seq;

CREATE TABLE MPK.Pracownicy (
                ID_Pracownika INTEGER NOT NULL DEFAULT nextval('MPK.pracownicy_id_pracownika_seq'),
                Imie VARCHAR NOT NULL,
                Nazwisko VARCHAR NOT NULL,
                Stanowisko VARCHAR NOT NULL,
                Pensja INTEGER NOT NULL,
                Przelozony INTEGER,
                CONSTRAINT id_pracownika PRIMARY KEY (ID_Pracownika)
);


ALTER SEQUENCE MPK.pracownicy_id_pracownika_seq OWNED BY MPK.Pracownicy.ID_Pracownika;

CREATE SEQUENCE MPK.pojazdy_id_pojazdu_seq;

CREATE TABLE MPK.Pojazdy (
                ID_Pojazdu INTEGER NOT NULL DEFAULT nextval('MPK.pojazdy_id_pojazdu_seq'),
                ID_Model INTEGER NOT NULL,
                ID_Zajezdni INTEGER NOT NULL,
                CONSTRAINT id_pojazdu PRIMARY KEY (ID_Pojazdu)
);


ALTER SEQUENCE MPK.pojazdy_id_pojazdu_seq OWNED BY MPK.Pojazdy.ID_Pojazdu;

CREATE TABLE MPK.Kierowcy (
                ID_Pracownika INTEGER NOT NULL,
                ID_Pojazdu INTEGER NOT NULL,
                PJ_Tramwaj BOOLEAN NOT NULL,
                PJ_Autobus BOOLEAN NOT NULL,
                CONSTRAINT id_kierowcy PRIMARY KEY (ID_Pracownika)
);


CREATE SEQUENCE MPK.grafik_id_zmiany_seq;

CREATE TABLE MPK.Grafik (
                ID_Zmiany INTEGER NOT NULL DEFAULT nextval('MPK.grafik_id_zmiany_seq'),
                ID_Linii INTEGER NOT NULL,
                ID_Pracownika INTEGER NOT NULL,
                Czas_rozpoczecia TIME NOT NULL,
                Liczba_kursow INTEGER NOT NULL,
                Data DATE NOT NULL,
                CONSTRAINT id_grafik PRIMARY KEY (ID_Zmiany)
);


ALTER SEQUENCE MPK.grafik_id_zmiany_seq OWNED BY MPK.Grafik.ID_Zmiany;

ALTER TABLE MPK.Polaczenia_przystankow ADD CONSTRAINT typy_polaczen_polaczenia_przystankow_fk
FOREIGN KEY (ID_Typu)
REFERENCES MPK.Typy_polaczen (ID_Typu)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE MPK.Pojazdy ADD CONSTRAINT zajezdnie_pojazdy_fk
FOREIGN KEY (ID_Zajezdni)
REFERENCES MPK.Zajezdnie (ID_Zajezdni)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE MPK.Pojazdy ADD CONSTRAINT modele_autobusow_pojazdy_fk
FOREIGN KEY (ID_Model)
REFERENCES MPK.Modele (ID_Model)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE MPK.Przystanki_Linie ADD CONSTRAINT linie_przystanki_linie_fk
FOREIGN KEY (ID_Linii)
REFERENCES MPK.Linie (ID_Linii)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE MPK.Grafik ADD CONSTRAINT linie_grafik_fk
FOREIGN KEY (ID_Linii)
REFERENCES MPK.Linie (ID_Linii)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE MPK.Przystanki_Linie ADD CONSTRAINT przystanki_przystanki_linie_fk
FOREIGN KEY (ID_Przystanku)
REFERENCES MPK.Przystanki (ID_Przystanku)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE MPK.Polaczenia_przystankow ADD CONSTRAINT przystanki_polaczenia_przystankow_fk
FOREIGN KEY (Od)
REFERENCES MPK.Przystanki (ID_Przystanku)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE MPK.Kierowcy ADD CONSTRAINT pracownicy_kierowcy_fk
FOREIGN KEY (ID_Pracownika)
REFERENCES MPK.Pracownicy (ID_Pracownika)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE MPK.Kierowcy ADD CONSTRAINT pojazdy_kierowcy_fk
FOREIGN KEY (ID_Pojazdu)
REFERENCES MPK.Pojazdy (ID_Pojazdu)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE MPK.Grafik ADD CONSTRAINT kierowcy_grafik_fk
FOREIGN KEY (ID_Pracownika)
REFERENCES MPK.Kierowcy (ID_Pracownika)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;