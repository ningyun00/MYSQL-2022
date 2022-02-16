#创建数据库
DROP DATABASE IF EXISTS OrderDB;
CREATE DATABASE OrderDB CHARACTER SET utf8;

#使用数据库
USE OrderDB;

#建表--产品类别表
DROP TABLE IF EXISTS ProTypes;
CREATE TABLE ProTypes 
(
	TypeID INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	TypeName VARCHAR(100) NOT NULL UNIQUE
);

#查表
SELECT * FROM ProTypes;

#添加数据
INSERT INTO ProTypes VALUES(NULL,'01')
INSERT INTO ProTypes VALUES(NULL,'02');

#建表--产品表
DROP TABLE IF EXISTS Products;
CREATE TABLE Products
(
	ProID INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	ProName VARCHAR(100),	
	ProOldPrice DECIMAL(10,2),
	ProNewPrice DECIMAL(10,2),
	ProSale INT,
	Prodepot INT,
	ProSaleBegin DATETIME,
	ProSaleEnd DATETIME,
	ProTypeID INT,
	CONSTRAINT fk_ProTypes_Products FOREIGN KEY (ProTypeID) REFERENCES ProTypes(TypeID) 
);

#查询
SELECT * FROM Products;

#添加
INSERT INTO Products VALUES(NULL,'小樱',1.0,2.0,100,200,'2022-02-14','2022-02-15',1)
INSERT INTO Products VALUES(NULL,'樱花',1.0,2.0,100,200,'2022-02-14','2022-02-15',2);

#建表--客户表
DROP TABLE IF EXISTS Customers;
CREATE TABLE Customers
(
	CusID INT PRIMARY KEY AUTO_INCREMENT,
	CusNick VARCHAR(50) UNIQUE,
	CusLogin VARCHAR(50),
	CusPwd VARCHAR(50),
	CusPoint INT,
	CusCreateData DATETIME DEFAULT CURRENT_TIMESTAMP,
	CusLoginDate DATETIME	
);

#查询
SELECT * FROM Customers;

#添加数据
INSERT INTO Customers VALUES(NULL,'小樱','xiaoying','xiaoying01',0,DEFAULT,NULL);
INSERT INTO Customers VALUES(NULL,'樱花','yinghua','yinghua02',30,DEFAULT,NULL);

#建表--客户地址表
DROP TABLE IF EXISTS Cusadds;
CREATE TABLE Cusadds
(
	CAID INT PRIMARY KEY AUTO_INCREMENT,
	CACusID INT,
	CONSTRAINT fk_Customers_Cusadds FOREIGN KEY (CACusID) REFERENCES Customers (CusID),
	CAProvince VARCHAR(100),
	CACity VARCHAR(100),
	CAAddress VARCHAR(500),
	CADefault BIT DEFAULT 0
);

#查看表
SELECT * FROM Cusadds;

#添加数据
INSERT INTO Cusadds VALUES(NULL,1,'不知道','不知道','不知道',DEFAULT);
INSERT INTO Cusadds VALUES(NULL,1,'不知道','不知道','不知道',DEFAULT);
INSERT INTO Cusadds VALUES(NULL,1,'不知道','不知道','不知道',1);

#建表--评论表
DROP TABLE IF EXISTS Assess;
CREATE TABLE Assess
(
	AssID INT AUTO_INCREMENT PRIMARY KEY,
	AssCusID INT,
	CONSTRAINT fk_Customers_Assess FOREIGN KEY (AssCusID) REFERENCES Customers(CusID),
	AssProID INT,
	CONSTRAINT fk_Products_Assess FOREIGN KEY (AssProID) REFERENCES Products(ProID),
	AssContent VARCHAR(5000),
	AssDate DATETIME DEFAULT CURRENT_TIMESTAMP
);

#查看表
SELECT * FROM Assess;

#添加数据
INSERT INTO Assess VALUES(NULL,1,1,'打杂阿萨的菌丝',DEFAULT);
INSERT INTO Assess VALUES(NULL,1,1,'打杂阿萨的啊你发刺激菌丝',DEFAULT);

#建表--订单表
DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders
(
	OrderNum INT PRIMARY KEY AUTO_INCREMENT,
	OrdCAID INT,
	CONSTRAINT fk_CusAdds_Orders FOREIGN KEY (OrdCAID) REFERENCES Cusadds(CAID),
	OrdCusID INT,
	CONSTRAINT fk_Products_Orders FOREIGN KEY (OrdCusID) REFERENCES Customers(CusID),
	OrderDate DATETIME DEFAULT CURRENT_TIMESTAMP
);

#查看表
SELECT * FROM Orders;

#添加数据
INSERT INTO Orders VALUES(NULL,1,1,DEFAULT);
INSERT INTO Orders VALUES(NULL,1,1,DEFAULT);

#建表--订单详细表
DROP TABLE IF EXISTS OrderDetail;
CREATE TABLE OrderDetail
(
	ODID INT PRIMARY KEY AUTO_INCREMENT,
	ODrderNum INT,
	CONSTRAINT fk_Orders_OrderDetail FOREIGN KEY (ODrderNum) REFERENCES Orders(OrderNum),
	ODCount INT,
	ODPrice DECIMAL(10,2),
	ODProID INT,
	CONSTRAINT fk_Products_OrderDetail FOREIGN KEY (ODProID) REFERENCES Products(ProID)
);

#查看表
SELECT * FROM OrderDetail;

#添加数据
INSERT INTO OrderDetail VALUES(NULL,1,1,1,1);
INSERT INTO OrderDetail VALUES(NULL,1,1,1,1);
