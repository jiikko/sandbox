Table	Create Table
BelongTo	CREATE TABLE `BelongTo` (\n  `BelongID` int(11) NOT NULL,\n  `StartDate` date DEFAULT NULL,\n  `EndDate` date DEFAULT NULL,\n  `DepartmentID` int(11) DEFAULT NULL,\n  `EmployeeID` int(11) DEFAULT NULL,\n  PRIMARY KEY (`BelongID`)\n) ENGINE=InnoDB DEFAULT CHARSET=utf8
Table	Create Table
Categories	CREATE TABLE `Categories` (\n  `CategoryID` int(11) NOT NULL,\n  `CategoryName` varchar(100) DEFAULT NULL,\n  PRIMARY KEY (`CategoryID`)\n) ENGINE=InnoDB DEFAULT CHARSET=utf8
Table	Create Table
CustomerClasses	CREATE TABLE `CustomerClasses` (\n  `CustomerClassID` int(11) NOT NULL,\n  `CustomerClassName` varchar(100) DEFAULT NULL,\n  PRIMARY KEY (`CustomerClassID`)\n) ENGINE=InnoDB DEFAULT CHARSET=utf8
Table	Create Table
Customers	CREATE TABLE `Customers` (\n  `CustomerID` int(11) NOT NULL,\n  `CustomerCode` int(11) DEFAULT NULL,\n  `CustomerName` varchar(100) DEFAULT NULL,\n  `Address` varchar(100) DEFAULT NULL,\n  `CustomerClassID` int(11) DEFAULT NULL,\n  `PrefecturalID` int(11) DEFAULT NULL,\n  PRIMARY KEY (`CustomerID`)\n) ENGINE=InnoDB DEFAULT CHARSET=utf8
Table	Create Table
Departments	CREATE TABLE `Departments` (\n  `DepartmentID` int(11) NOT NULL,\n  `DepartmentName` varchar(100) DEFAULT NULL,\n  PRIMARY KEY (`DepartmentID`)\n) ENGINE=InnoDB DEFAULT CHARSET=utf8
Table	Create Table
Employees	CREATE TABLE `Employees` (\n  `EmployeeID` int(11) NOT NULL,\n  `EmployeeName` varchar(100) DEFAULT NULL,\n  `Height` decimal(10,0) DEFAULT NULL,\n  `EMail` varchar(100) DEFAULT NULL,\n  `Weight` decimal(10,0) DEFAULT NULL,\n  `HireFiscalYear` int(11) DEFAULT NULL,\n  `Birthday` date DEFAULT NULL,\n  `BloodType` varchar(2) DEFAULT NULL,\n  PRIMARY KEY (`EmployeeID`)\n) ENGINE=InnoDB DEFAULT CHARSET=utf8
Table	Create Table
Prefecturals	CREATE TABLE `Prefecturals` (\n  `PrefecturalID` int(11) NOT NULL,\n  `PrefecturalName` varchar(100) DEFAULT NULL,\n  PRIMARY KEY (`PrefecturalID`)\n) ENGINE=InnoDB DEFAULT CHARSET=utf8
Table	Create Table
Products	CREATE TABLE `Products` (\n  `ProductID` int(11) NOT NULL,\n  `ProductCode` int(11) DEFAULT NULL,\n  `ProductName` varchar(100) DEFAULT NULL,\n  `Price` decimal(10,0) DEFAULT NULL,\n  `CategoryID` int(11) DEFAULT NULL,\n  PRIMARY KEY (`ProductID`)\n) ENGINE=InnoDB DEFAULT CHARSET=utf8
Table	Create Table
Salary	CREATE TABLE `Salary` (\n  `SalaryID` int(11) NOT NULL,\n  `PayDate` date DEFAULT NULL,\n  `Amount` decimal(10,0) DEFAULT NULL,\n  `EmployeeID` int(11) DEFAULT NULL,\n  PRIMARY KEY (`SalaryID`)\n) ENGINE=InnoDB DEFAULT CHARSET=utf8
Table	Create Table

Sales	CREATE TABLE `Sales` (\n  `SaleID` int(11) NOT NULL,\n  `Quantity` decimal(10,0) DEFAULT NULL,\n  `CustomerID` int(11) DEFAULT NULL,\n  `ProductID` int(11) DEFAULT NULL,\n  `EmployeeID` int(11) DEFAULT NULL,\n  `SaleDate` date DEFAULT NULL,\n  PRIMARY KEY (`SaleID`)\n) ENGINE=InnoDB DEFAULT CHARSET=utf8












select Employees.EmployeeId, Employees.EmployeeName
  from Employees
  where Employees.EmployeeId in (
    select salary.EmployeeId
    from salary
    group by salary.EmployeeId
    having max(salary.Amount) > 30000
  );



select saleid, Quantity, CustomerID, (
  select CustomerName
  from Customers
  where sales.CustomerID = Customers.CustomerID
) as CustomerName
  from sales
  where Quantity >= 100;















