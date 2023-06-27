CREATE TABLE LISTA_PAISES(
	Id             integer,
	Country 		VARCHAR(70),
	Country_local	VARCHAR(70),
	Country_code	VARCHAR(70),
	Continent		VARCHAR(70),
	Capital		VARCHAR(70),
	Population	VARCHAR(70),
	Area_sq_km	VARCHAR(70),
	Area_sq_mi	VARCHAR(70),
	Coastline_km	VARCHAR(70),
	Coastline_mi	VARCHAR(70),
	Government_form VARCHAR(70),
	Currency		VARCHAR(70),
	Currency_code	VARCHAR(70),
	Dialing_prefix	VARCHAR(70),
	Birthrate		VARCHAR(70),
	Deathrate		VARCHAR(70),
	Url			VARCHAR(70)
);

CREATE GENERATOR LISTA_PAISES_AUTOINC;

CREATE TRIGGER LISTA_PAISES_TRIGGER for LISTA_PAISES
BEFORE INSERT position 0
AS
BEGIN
new.id = gen_id("LISTA_PAISES_AUTOINC",1);
END;


CREATE TABLE LISTA_PAISES_DML(
	Id             integer,
	Country 		VARCHAR(70),
	Country_local	VARCHAR(70),
	Country_code	VARCHAR(70),
	Continent		VARCHAR(70),
	Capital		VARCHAR(70),
	Population	VARCHAR(70),
	Area_sq_km	VARCHAR(70),
	Area_sq_mi	VARCHAR(70),
	Coastline_km	VARCHAR(70),
	Coastline_mi	VARCHAR(70),
	Government_form VARCHAR(70),
	Currency		VARCHAR(70),
	Currency_code	VARCHAR(70),
	Dialing_prefix	VARCHAR(70),
	Birthrate		VARCHAR(70),
	Deathrate		VARCHAR(70),
	Url			VARCHAR(70)
);

CREATE GENERATOR LISTA_PAISES_DML_AUTOINC;

CREATE TRIGGER LISTA_PAISES_DML_TRIGGER for LISTA_PAISES_DML
BEFORE INSERT position 0
AS
BEGIN
new.id = gen_id("LISTA_PAISES_DML_AUTOINC",1);
END;
