CREATE DATABASE BDDTEST4;

CONNECT TO BDDTEST4;

------------------------------------------------
-- Créez un schéma appelé "GestionClients".
------------------------------------------------
CREATE SCHEMA GestionClients;

------------------------------------------------------
-- Dans ce schéma, créez une table appelée "Clients"
------------------------------------------------------
CREATE TABLE GestionClients.Clients (IDClient INT, Nom VARCHAR(50), Email VARCHAR(100));

------------------------------------------------------------
-- Insérez quelques enregistrements dans la table "Clients"
------------------------------------------------------------
INSERT INTO GestionClients.Clients (IDClient, Nom, Email) VALUES ('100', 'DUPONT', 'dupont@gmail.com'), ('102', 'DURANT', 'durand@yahoo.fr'), ('200', 'LEBRUN', 'lebrun@hotmail.com'), ('300', 'LEROUX', 'leroux@gmail.com'), ('400', 'Leblond', 'Leblond@gmail.com');

-----------------------------------------------------------------------------------
-- Sélectionnez tous les clients de la table "Clients" du schéma "GestionClients"
------------------------------------------------------------------------------------
SELECT * FROM GestionClients.Clients;

------------------------------------------------------------------------------
-- Modifiez la table "Clients" pour ajouter une colonne NumTel (VARCHAR(15)).
------------------------------------------------------------------------------
ALTER TABLE GestionClients.Clients ADD NumTel VARCHAR(15);

---------------------------------------------------------------------------------
-- Mettez à jour quelques enregistrements pour inclure des numéros de téléphone.
---------------------------------------------------------------------------------
UPDATE GestionClients.Clients SET Numtel = '01.01.01.01.01' WHERE IDClient = 100;
UPDATE GestionClients.Clients SET Numtel = '02.02.02.02.02' WHERE IDClient = 102;
UPDATE GestionClients.Clients SET Numtel = '03.03.03.03.03' WHERE IDClient = 200;
UPDATE GestionClients.Clients SET Numtel = '04.04.04.04.04' WHERE IDClient = 300;
UPDATE GestionClients.Clients SET Numtel = '05.05.05.05.05' WHERE IDClient = 400;

---------------------------------------------------------------------------------------
-- Créez un nouvel utilisateur "Gestionnaire" avec le mot de passe "MotDePasseGestion"
---------------------------------------------------------------------------------------
-- connect to BDDTEST1;  
grant createtab,bindadd,connect on database to user GG;  

--------------------------------------------------------------------------------------------------------
-- Accordez à cet utilisateur le droit de SELECT sur la table "Clients" dans le schéma "GestionClients"
--------------------------------------------------------------------------------------------------------
GRANT SELECT ON TABLE GestionClients.Clients TO USER GG;
select * from GestionClients.Clients;

----------------------------------------------------------------------------
-- Supprimez le schéma "GestionClients" et tous les objets qu'il contient.
----------------------------------------------------------------------------
REVOKE SELECT ON TABLE GestionClients.Clients FROM GG;

DROP TABLE GestionClients.Clients;

DROP SCHEMA GestionClients RESTRICT;

DISCONNECT ALL;

DROP DATABASE BDDTEST4;

TERMINATE;