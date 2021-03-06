CREATE DATABASE WMS
uSE WMS
CREATE TABLE Clients(
ClientId INT PRIMARY KEY IDENTITY NOT NULL,
FirstName VARCHAR(50) NOT NULL,
LastName  VARCHAR(50) NOT NULL,
Phone CHAR(12) NOT NULL
)

CREATE TABLE Mechanics(
MechanicId INT PRIMARY KEY IDENTITY NOT NULL,
FirstName VARCHAR(50) NOT NULL,
LastName  VARCHAR(50) NOT NULL,
[Address] VARCHAR(255) NOT NULL
)
CREATE TABLE Models(
ModelId INT PRIMARY KEY IDENTITY NOT NULL,
[Name]  VARCHAR(50) UNIQUE NOT NULL
)

CREATE TABLE Jobs(
JobId INT PRIMARY KEY IDENTITY NOT NULL,
ModelId INT FOREIGN KEY REFERENCES Models(ModelId),
[Status] VARCHAR(11) NOT NULL 
 CHECK([Status] IN('Pending','In Progress','Finished') ) DEFAULT 'Pending',
 ClientId INT FOREIGN KEY REFERENCES Clients(ClientId),
 MechanicId INT FOREIGN KEY REFERENCES Mechanics(MechanicId),
 IssueDate DATE NOT NULL,
 FinishDate DATE
 )

 CREATE TABLE Orders(
OrderId INT PRIMARY KEY IDENTITY NOT NULL,
JobId INT FOREIGN KEY REFERENCES Jobs(JobId) NOT NULL,
IssueDate DATE,
Delivered BIT NOT NULL DEFAULT 0
 )
 CREATE TABLE Vendors(
 VendorId INT PRIMARY KEY IDENTITY NOT NULL,
 [Name] VARCHAR(50) NOT NULL UNIQUE
 )

 CREATE TABLE Parts(
 PartId INT PRIMARY KEY IDENTITY NOT NULL,
 SerialNumber VARCHAR(50) NOT NULL UNIQUE,
 [Description] VARCHAR(255),
 Price NUMERIC(6,2) NOT NULL CHECK(Price>0),
 VendorId INT FOREIGN KEY REFERENCES Vendors(VendorId) NOT NULL,
 StockQty INT NOT NULL CHECK(StockQty>=0) DEFAULT 0
 )

 CREATE TABLE OrderParts(
 OrderId INT NOT NULL FOREIGN KEY REFERENCES Orders(OrderId) ,
 PartId INT NOT NULL FOREIGN KEY REFERENCES Parts(PartId),
 CONSTRAINT PK_OrderParts
 PRIMARY KEY(OrderId,PartId),
 Quantity INT NOT NULL CHECK(Quantity>0) DEFAULT 1
 )
  CREATE TABLE PartsNeeded(
 JobId INT NOT NULL FOREIGN KEY REFERENCES Jobs(JobId) ,
 PartId INT NOT NULL FOREIGN KEY REFERENCES Parts(PartId),
 CONSTRAINT PK_PartsNeeded
 PRIMARY KEY(JobId,PartId),
 Quantity INT NOT NULL CHECK(Quantity>0) DEFAULT 1
 )