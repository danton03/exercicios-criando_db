--1 - Criar o banco de dados do exercício:
create database "exercicio-criando_DBs";

--2 - Criar a tabela principal do exercício:
CREATE TABLE "customers"(
	"id" serial NOT NULL PRIMARY KEY,
	"fullName" varchar(50) NOT NULL,
	"cpf" varchar(11) NOT NULL UNIQUE,
	"email" text NOT NULL UNIQUE,
	"password" text NOT NULL
);

--3 - Criar as tabelas que se relacionam com a tabela principal:
CREATE TABLE "customerPhones"(
	"customerId" integer NOT NULL REFERENCES customers(id),
	"number" varchar(11) NOT NULL,
	"type" text NOT NULL
);

CREATE TABLE "cities"(
	"id" serial NOT NULL PRIMARY KEY,
	"name" text NOT NULL,
	"stateId" integer NOT NULL REFERENCES states(id)
);

CREATE TABLE "states"(
	"id" serial NOT NULL PRIMARY KEY,
	"name" text NOT NULL
);

CREATE TABLE "customerAddresses"(
	"customerId" integer NOT NULL REFERENCES customers(id) UNIQUE,
	"street" text NOT NULL,
	"number" integer NOT NULL,
	"complement" text,
	"postalCode" text NOT NULL,
  "cityId" integer NOT NULL REFERENCES cities(id)
);

CREATE TABLE "bankAccount"(
	"id" serial NOT NULL PRIMARY KEY,
	"customerId" integer NOT NULL REFERENCES customers(id),
	"accountNumber" text NOT NULL UNIQUE,
	"agency" text NOT NULL,
	"openDate" DATE NOT NULL DEFAULT NOW(),
	"closeDate" DATE
);

CREATE TABLE "transactions"(
	"id" serial NOT NULL PRIMARY KEY,
	"bankAccountId" integer NOT NULL REFERENCES "bankAccount"(id),
	"amount" integer NOT NULL,
	"type" text NOT NULL,
	"time" timestamp NOT NULL DEFAULT NOW(),
	"description" text,
	"cancelled" bool
);

CREATE TABLE "creditCards"(
	"id" serial NOT NULL PRIMARY KEY,
	"bankAccountId" integer NOT NULL REFERENCES "bankAccount"(id),
	"name" text NOT NULL,
	"number" integer NOT NULL,
	"securityCode" varchar(3) NOT NULL,
	"expirationMonth" varchar(2) NOT NULL,
	"expirationYear" varchar(4) NOT NULL,
	"password" text NOT NULL,
	"limit" integer NOT NULL
);
