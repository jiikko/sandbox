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

# 3-2-1
join
```sql
select t2.EmployeeName, t1.PayDate, t1.Amount
from salary t1 inner join Employees t2 on t1.EmployeeID = t2.EmployeeID
order by t2.EmployeeID;
```

# 3-2-2
```sql
select s.Quantity, c.CustomerName, p.ProductName, e.EmployeeName
from Sales s, Customers c, Products p, Employees e
where
  s.CustomerID = c.CustomerID and
  s.ProductID = p.ProductID and
  s.EmployeeID = e.EmployeeID and
  s.Quantity > 200;
```
```sql
select s.Quantity, c.CustomerName, p.ProductName, e.EmployeeName
from Sales s
  join Customers c on s.CustomerID = c.CustomerID
  join Products p on s.ProductID = p.ProductID
  join Employees e on s.EmployeeID = e.EmployeeID
where s.Quantity > 200;
```

# 3-2-3
```sql
select sum(s.Quantity), p.ProductID, p.ProductName
from Sales s
join Products p on s.ProductID = p.ProductID
group by s.ProductID, p.ProductName
having sum(s.Quantity) > 300
```


# 3-2-5
```sql
select c.CustomerName, p.PrefecturalName, cc.CustomerClassName
from Customers c, Prefecturals p, CustomerClasses cc
where
  c.PrefecturalID = p.PrefecturalID and
  c.CustomerClassID = cc.CustomerClassID
order by p.PrefecturalID asc;
```

# 3-3-1
複数テーブルの結合
```sql
select c.CategoryName, sum(s.Quantity)
from sales s
  join Products p
    on s.ProductID = p.ProductID
  join Categories c
    on p.CategoryID = c.CategoryID
group by p.CategoryID, c.CategoryName
;
```


# 3-3-2
```sql
select p.PrefecturalID, p.PrefecturalName, sum(s.Quantity)
from Customers c
join Sales s
  on c.CustomerID = s.CustomerID
join Prefecturals p
  on p.PrefecturalID = c.PrefecturalID
group by p.PrefecturalID, p.PrefecturalName
;
```

# 3-3-3
```sql
select cc.CustomerClassID, cc.CustomerClassName, max(s.Quantity)
from Sales s
  join Customers c
    on s.CustomerID = c.CustomerID
  join CustomerClasses cc
    on c.CustomerClassID = cc.CustomerClassID
group by cc.CustomerClassID
;
```

# 3-3-4
```sql

select p.PrefecturalID, p.PrefecturalName, sum(s.Quantity)
from Sales s, Prefecturals p, Customers c
where
  s.CustomerID = c.CustomerID and
  c.PrefecturalID = p.PrefecturalID
group by p.PrefecturalID, p.PrefecturalName
;
```

# 3-3-5
```sql
select cc.CustomerClassID, cc.CustomerClassName, max(s.Quantity)
from Sales s, CustomerClasses cc, Customers c
where
  s.CustomerID = c.CustomerID and
  c.CustomerClassID = cc.CustomerClassID
group by cc.CustomerClassID, cc.CustomerClassName
;
```

# 3-4-1
```sql
select c.CustomerName, ifnull(sum(s.Quantity), 0)
from Customers c
left outer join Sales s
  on c.CustomerID = s.CustomerID
group by s.CustomerID, c.CustomerName
;
```

# 3-4-2
```sql
select e.EmployeeName, count(e.EmployeeID), sum(Quantity)
from Sales s
left outer join Employees e
  on s.EmployeeID = e.EmployeeID
group by e.EmployeeID, e.EmployeeName
;
```

# 3-4-3
```sql
select p.PrefecturalName, count(c.CustomerID) as 顧客数
from Customers c
  right outer join Prefecturals p
  on c.PrefecturalID = p.PrefecturalID
group by p.PrefecturalName
;
```

# 3-4-4
```sql
select e.EmployeeID, (
    select count(*)
    from Sales s
    where s.EmployeeID = e.EmployeeID
  ) as 販売件数
  from Employees e
;
```

```sql
select e.EmployeeID, ifnull(s.sc, 0)
  from Employees e
  left outer join (
    select ss.EmployeeID as ssid, count(*) as sc
    from Sales ss
    group by ss.EmployeeID
  ) as s
  on e.EmployeeID = s.ssid
  ;
```


# 3-4-5
```sql
select e.EmployeeName, ifnull(s.Amount, 0) 支給額
from Employees e
  left outer join Salary s
  on
    e.EmployeeID = s.EmployeeID and
    s.PayDate = '2007-02-25'
;
```
