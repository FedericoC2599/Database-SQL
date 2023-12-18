-- Author: Federico Cianci
-- Data: 18/12/2023

--Tabella degli autori
CREATE TABLE IF NOT EXISTS "Autori" (
	"IDAutore"	INTEGER NOT NULL CHECK("IDAutore" > 0),
	"NomeAutore"	TEXT NOT NULL CHECK(length("Nome") > 0 AND length("Nome") <= 1000),
	"CognomeAutore"	TEXT CHECK(length("Cognome") <= 1000),
	"NazionalitàAutore"	TEXT CHECK(length("Nazionalità") > 0 AND length("Nazionalità") <= 20),
	PRIMARY KEY("IDAutore")
);

-- Tabella: AutoriELibri
CREATE TABLE IF NOT EXISTS "AutoriELibri" (
	"IDAutore"	INTEGER CHECK("IDAutore" > 0),
	"IDLibro"	INTEGER CHECK("IDLibro" > 0),
	FOREIGN KEY("IDLibro") REFERENCES "Libri"("ID"),
	FOREIGN KEY("IDAutore") REFERENCES "Autori"("IDAutore"),
	PRIMARY KEY("IDAutore","IDLibro")
);

-- Tabella: CaseEditrici
CREATE TABLE IF NOT EXISTS "CaseEditrici" (
	"IDCasaEditrice"	INTEGER NOT NULL CHECK(IDCasaEditrice > 0),
	"NomeCasaEditrice"	TEXT CHECK(length(NomeCasaEditrice) > 0 AND length(NomeCasaEditrice) <= 1000) UNIQUE,
	PRIMARY KEY("IDCasaEditrice")
);

-- Tabella: CaseETraduttori
CREATE TABLE IF NOT EXISTS "CaseETraduttori" (
	"IDCasaEditrice"	INTEGER NOT NULL CHECK(IDCasaEditrice > 0),
	"IDTraduttore"	INTEGER NOT NULL CHECK(IDTraduttore > 0),
	FOREIGN KEY("IDTraduttore") REFERENCES "Traduttori"("IDTraduttore"),
	FOREIGN KEY("IDCasaEditrice") REFERENCES "CaseEditrici"("IDCasaEditrice"),
	PRIMARY KEY("IDCasaEditrice","IDTraduttore")
);

-- Tabella: Completamenti
CREATE TABLE IF NOT EXISTS "Completamenti" (
	"IDCompletamento"	INTEGER NOT NULL CHECK("IDCompletamento" > 0),
	"NumeroCompletamento"	INTEGER DEFAULT 1,
	"DataInizioLettura"	TEXT,
	"DataFineLettura"	TEXT,
	"PagineLette"	REAL CHECK("PagineLette" >= 0),
	PRIMARY KEY("IDCompletamento")
);

-- Tabella: CompletamentiLibri
CREATE TABLE IF NOT EXISTS "CompletamentiLibri" (
	"IDLibro"	INTEGER CHECK("IDLibro" > 0),
	"IDCompletamento"	INTEGER CHECK("IDCompletamento" > 0),
	FOREIGN KEY("IDLibro") REFERENCES "Libri"("ID"),
	FOREIGN KEY("IDCompletamento") REFERENCES "Completamenti"("IDCompletamento"),
	PRIMARY KEY("IDLibro","IDCompletamento")
);

-- Tabella: Edizioni
CREATE TABLE IF NOT EXISTS "Edizioni" (
	"IDEdizione"	INTEGER NOT NULL CHECK("IDEdizione" > 0),
	"IDLibro"	INTEGER CHECK("IDLibro" > 0),
	"IDCasaEditrice"	INTEGER NOT NULL CHECK("IDCasaEditrice" > 0),
	"NumeroEdizione"	INTEGER CHECK("NumeroEdizione" > 0),
	"AnnoEdizione"	INTEGER,
	FOREIGN KEY("IDCasaEditrice") REFERENCES "CaseEditrici"("IDCasaEditrice"),
	FOREIGN KEY("IDLibro") REFERENCES "Libri"("ID"),
	PRIMARY KEY("IDEdizione")
);

-- Tabella: Generi
CREATE TABLE IF NOT EXISTS "Generi" (
	"IDGenere"	INTEGER NOT NULL CHECK(IDGenere > 0),
	"NomeGenere"	INTEGER CHECK(length(NomeGenere) > 0 AND length(NomeGenere) <= 1000) UNIQUE,
	PRIMARY KEY("IDGenere")
);

-- Tabella: Libri
CREATE TABLE IF NOT EXISTS "Libri" (
	"ID"	INTEGER NOT NULL CHECK("ID" > 0),
	"ISBN13"	TEXT CHECK(length("ISBN13") >= 13 AND length("ISBN13") <= 26),
	"Titolo"	TEXT CHECK(length("Titolo") > 0 AND length("Titolo") <= 1000),
	"AnnoPubblicazione"	TEXT,
	"CasaEditrice"	INTEGER CHECK("CasaEditrice" > 0),
	"NumPagine"	NUMERIC CHECK("NumPagine" > 0),
	FOREIGN KEY("CasaEditrice") REFERENCES "CaseEditrici"("IDCasaEditrice"),
	PRIMARY KEY("ID")
);

-- Tabella: LibriEGeneri
CREATE TABLE IF NOT EXISTS "LibriEGeneri" (
	"IDLibro"	INTEGER CHECK("IDLibro" > 0),
	"IDGenere"	INTEGER CHECK("IDGenere" > 0),
	"IDSottogenere"	INTEGER CHECK(IDSottogenere > 0),
	FOREIGN KEY("IDGenere") REFERENCES "Generi"("IDGenere"),
	FOREIGN KEY("IDLibro") REFERENCES "Libri"("ID"),
	FOREIGN KEY("IDSottogenere") REFERENCES "Sottogeneri"("IDSottogenere"),
	PRIMARY KEY("IDLibro","IDGenere","IDSottogenere")
);

-- Tabella: Lingue
CREATE TABLE IF NOT EXISTS "Lingue" (
	"IDLingua"	INTEGER CHECK("IDLingua" > 0),
	"LinguaOriginale"	TEXT CHECK(length("Lingua") > 0 AND length("Lingua") <= 20),
	"LinguaLibro"	TEXT,
	PRIMARY KEY("IDLingua")
);

-- Tabella: LingueTesto
CREATE TABLE IF NOT EXISTS "LingueTesto" (
	"IDLibro"	INTEGER CHECK("IDLibro" > 0),
	"IDLingua"	INTEGER CHECK("IDLingua" > 0),
	PRIMARY KEY("IDLibro","IDLingua"),
	FOREIGN KEY("IDLibro") REFERENCES "Libri"("ID"),
	FOREIGN KEY("IDLingua") REFERENCES "Lingue"("IDLingua")
);

-- Tabella: Sottogeneri
CREATE TABLE IF NOT EXISTS "Sottogeneri" (
	"IDSottogenere"	INTEGER CHECK(IDSottogenere > 0),
	"NomeSottogenere"	TEXT CHECK(length(NomeSottogenere) > 0),
	PRIMARY KEY("IDSottogenere")
);

-- Tabella: Traduttori
CREATE TABLE IF NOT EXISTS "Traduttori" (
	"IDTraduttore"	INTEGER CHECK(IDTraduttore > 0),
	"NomeTraduttore"	TEXT CHECK(length(NomeTraduttore) > 0 AND length(NomeTraduttore) <= 1000),
	"CognomeTraduttore"	TEXT CHECK(length(CognomeTraduttore) > 0 AND length(CognomeTraduttore) <= 1000),
	PRIMARY KEY("IDTraduttore")
);

-- Tabella: Traduzioni
CREATE TABLE IF NOT EXISTS "Traduzioni" (
	"IDLibro"	INTEGER CHECK(IDLibro > 0),
	"IDTraduttore"	INTEGER CHECK(IDTraduttore > 0),
	"IDLingua"	INTEGER CHECK(IDLingua > 0),
	FOREIGN KEY("IDLingua") REFERENCES "Lingue"("IDLingua"),
	FOREIGN KEY("IDLibro") REFERENCES "Libri"("ID"),
	FOREIGN KEY("IDTraduttore") REFERENCES "Traduttori"("IDTraduttore"),
	PRIMARY KEY("IDLibro","IDTraduttore","IDLingua")
);



