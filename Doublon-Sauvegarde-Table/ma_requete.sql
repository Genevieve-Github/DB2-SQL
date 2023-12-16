-- Script SQL    
CREATE DATABASE TBLSCRPT;  

CONNECT TO TBLSCRPT;  
------------------------------------------------ 
-- 1 Sauvegarde d’une table1 vers une table2 
------------------------------------------------ 
CREATE TABLE TABLE1 (id INT NOT NULL PRIMARY KEY GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1), NOM VARCHAR(50), MODELE VARCHAR(50));

INSERT INTO TABLE1 (NOM, MODELE) VALUES ('VW', 'POLO'), ('VW', 'TIGUAN'), ('VW', 'GOLF'), ('VW', 'POLO'), ('VW', 'T-CROSS'), ('VW', 'TOURAN'), ('JEEP', 'GRAND CHEROKEE'), ('VW', 'POLO'), ('JEEP', 'AVENGER'), ('JEEP', 'WRANGLER'), ('FIAT', '500'), ('FIAT', 'TIPO'), ('FIAT', 'PANDA'), ('FIAT', '500 Nouvelle'), ('FIAT', 'TIPO');

SELECT * FROM TABLE1;  

CREATE TABLE TABLE1_SAVE (id INT NOT NULL PRIMARY KEY GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1), NOM VARCHAR(50), MODELE VARCHAR(50)); 
INSERT INTO TABLE1_SAVE (NOM, MODELE) SELECT NOM, MODELE FROM TABLE1; 

SELECT * FROM TABLE1_SAVE;  

--------------------------------------------------------------------- 
-- 2 Recuperer les doublons d’une table1 dans une nouvelle table2 
--------------------------------------------------------------------- 
CREATE TABLE TABLE2 (id INT NOT NULL PRIMARY KEY GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1), NOM VARCHAR(50), MODELE VARCHAR(50)); 

INSERT INTO TABLE2 (NOM, MODELE) SELECT NOM, MODELE FROM TABLE1 WHERE (NOM, MODELE) IN (SELECT DISTINCT NOM, MODELE FROM TABLE1 GROUP BY NOM, MODELE HAVING COUNT(*) > 1); 
SELECT * FROM TABLE2;  

--------------------------------------------- 
-- 3 Supprimer les doublons dans la table1 
--------------------------------------------- 
DELETE FROM TABLE1 WHERE TABLE1.ID NOT IN (SELECT MIN(ID) FROM TABLE1 GROUP BY NOM, MODELE); 
SELECT * FROM TABLE1;  

-------------------------------- 
-- 4 Supprimer la table2 
-------------------------------- 
DROP TABLE TABLE2;

-------------------------------- 
-- 5 Restaurer la table1 
-------------------------------- 
DROP TABLE TABLE1; 

CREATE TABLE TABLE1 (id INT NOT NULL PRIMARY KEY GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1), NOM VARCHAR(50), MODELE VARCHAR(50)); 
INSERT INTO TABLE1 (NOM, MODELE) SELECT NOM, MODELE FROM TABLE1_SAVE; 

SELECT * FROM TABLE1.  

DISCONNECT ALL; 

DROP DATABASE TBLSCRPT;   

TERMINATE;