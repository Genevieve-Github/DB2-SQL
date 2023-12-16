-------------------------------------------------
-- Création de la base de données et connection
-------------------------------------------------
CREATE DATABASE BDDTEST;

CONNECT TO BDDTEST;

--------------------------
-- Création des tables
--------------------------
CREATE TABLE Customers (CustomerID INT NOT NULL PRIMARY KEY, FirstName VARCHAR(255), LastName VARCHAR(255), Email VARCHAR(255) NOT NULL UNIQUE);

CREATE TABLE Categories (CategoryID INT NOT NULL PRIMARY KEY, CategoryName VARCHAR(255));

CREATE TABLE Products (ProductID INT NOT NULL PRIMARY KEY, ProductName VARCHAR(255), Price DECIMAL, CategoryID INT, FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID));

-----------------------------------------------
-- DEPLACER LA CREATION DE TABLE CATEGORIE
-- AVANT LA CREATION DE LA TABLE PRODUCTS
-----------------------------------------------
-- CREATE TABLE Categories (
-- CategoryID INT PRIMARY KEY,
-- CategoryName VARCHAR(255)
-- );

CREATE TABLE Orders (OrderID INT NOT NULL PRIMARY KEY, OrderDate DATE, CustomerID INT, FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID));
SELECT * FROM Orders;

CREATE TABLE OrderDetails (OrderDetailID INT NOT NULL PRIMARY KEY, OrderID INT, ProductID INT, Quantity INT, FOREIGN KEY (OrderID) REFERENCES Orders(OrderID), FOREIGN KEY (ProductID) REFERENCES Products(ProductID));
SELECT * FROM OrderDetails;

----------------------------------------------
-- Insertion de donnéees (A titre d'exemple)
----------------------------------------------
INSERT INTO Customers (CustomerID, FirstName, LastName, Email) VALUES (1, 'John', 'Doe', 'john.doe@example.com'), (2, 'Jane', 'Smith', 'jane.smith@example.com'), (3, 'Geneviève', 'Giannasi', 'genevieve.giannasi@gmail.com');
SELECT * FROM Customers;

INSERT INTO Categories (CategoryID, CategoryName) VALUES (1, 'Electronics'), (2, 'Clothing');
SELECT * FROM Categories;

INSERT INTO Products (ProductID, ProductName, Price, CategoryID) VALUES (1, 'Laptop', 999.99, 1), (2, 'Smartphone', 499.99, 1), (3, 'T-Shirt', 19.99, 2);
SELECT * FROM Products;

INSERT INTO Orders (OrderID, OrderDate, CustomerID) VALUES (101, '2023-01-01', 1), (102, '2023-01-02', 2);
SELECT * FROM Orders;

INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity) VALUES (201, 101, 1, 2), (202, 102, 3, 5), (203, 101, 2, 2), (204, 102, 3, 1);
SELECT * FROM OrderDetails;

---------------------------------------------------------------------------------------------------------------------
-- Toutes les commandes avec les détails complets du client, y compris les produits commandés et leurs catégories.
---------------------------------------------------------------------------------------------------------------------
SELECT Customers.*, Orders.*, OrderDetails.*, Products.*, Categories.* FROM Customers JOIN Orders ON Customers.CustomerID = Orders.CustomerID JOIN OrderDetails ON OrderDetails.OrderID = Orders.OrderID JOIN Products ON OrderDetails.ProductID = Products.ProductID JOIN Categories ON Products.CategoryID = Categories.CategoryID ORDER BY Orders.CustomerID ASC;

--------------------------------------------
-- Le client qui a le plus d'achats
--------------------------------------------
SELECT Customers.CustomerID, Customers.LastName, SUM(OrderDetails.Quantity) FROM Customers JOIN Orders ON Customers.CustomerID = Orders.CustomerID JOIN OrderDetails ON OrderDetails.OrderID = Orders.OrderID GROUP BY Customers.CustomerID, Customers.LastName ORDER BY SUM(OrderDetails.Quantity) DESC LIMIT 1;

-------------------------------------------------------------------------------------------------------------
-- Tous les produits dans une catégorie spécifique avec le nombre total d'unités vendues pour chaque produit
-------------------------------------------------------------------------------------------------------------
SELECT Categories.CategoryID, CategoryName, Products.ProductID, ProductName, SUM(Quantity) as TotalQty FROM Products inner JOIN OrderDetails ON OrderDetails.ProductID = Products.ProductID INNER JOIN Categories ON Categories.CategoryID = Products.CategoryID GROUP BY Products.ProductID, ProductName, Categories.CategoryID, CategoryName;

-------------------------------------------------------
-- Les clients qui n'ont pas encore passé de commande. 
-------------------------------------------------------
SELECT Customers.* FROM Customers LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID WHERE Orders.CustomerID IS NULL;

-----------------------
-- FIN de TRAITEMENT
-----------------------
DROP TABLE OrderDetails;
DROP TABLE Orders;
DROP TABLE Products;
DROP TABLE Categories;
DROP TABLE Customers;

DISCONNECT ALL;

DROP DATABASE BDDTEST;

TERMINATE;