# 3-1
```
select Employees.EmployeeId, Employees.EmployeeName
  from Employees
  where Employees.EmployeeId in (
    select salary.EmployeeId
    from salary
    group by salary.EmployeeId
    having max(salary.Amount) > 30000
  );
```
```
Employees.select(:EmployeeId, :EmployeeName).where(
    EmployeeId: Salary.group(:EmployeeID).
    having("max(amount) > 300000").
    select(:EmployeeID)
)
 => "SELECT `Employees`.* FROM `Employees` WHERE `Employees`.`EmployeeId` IN (SELECT `Salary`.`EmployeeID` FROM `Salary` GROUP BY `Salary`.`EmployeeID` HAVING (max(amount) > 300000))"
```

# 3-2
```sql
select saleid, Quantity, CustomerID, (
  select CustomerName
  from Customers
  where sales.CustomerID = Customers.CustomerID
) as CustomerName
  from sales
  where Quantity >= 100;
```

```ruby
Sales.select(:saleid, :Quantity, :CustomerID).
  select(
      "(#{Customers.select(:CustomerName).where('sales.CustomerID = Customers.CustomerID').to_sql}) as CustomerName"
  ).where('Quantity >= 100')
 => "SELECT `saleid`, `Sales`.`Quantity`, `Sales`.`CustomerID`, (SELECT `Customers`.`CustomerName` FROM `Customers` WHERE (sales.CustomerID = Customers.CustomerID)) as CustomerName FROM `Sales` WHERE (Quantity >= 100)"
```

# 3-3
```sql
select ProductID, ProductName
from Products
where ProductID in (
  select ProductID
  from Sales
  group by ProductID
  having sum(Quantity) > 100
);
```

# 3-4
```
select Employees.EmployeeId, Employees.EmployeeName, (
  select max(salary.amount)
  from salary
  where Employees.EmployeeId = salary.EmployeeId
  ) as 最高給与額
  from Employees
  where Employees.EmployeeId in (
    select salary.EmployeeId
    from salary
    group by salary.EmployeeId
    having max(salary.Amount) > 30000
  );
```


# 3-5
```sql
select saleid, Quantity, CustomerID, (
  select CustomerName
  from Customers
  where sales.CustomerID = Customers.CustomerID
) as CustomerName, (
  select Productname from Products where Products.Productid = sales.productid
  ) as 商品名
  from sales
  where Quantity >= 100;
```
