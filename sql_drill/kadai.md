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


# 3-5-1
```sql
select
  p1.ProductName, p2.ProductName
  from Products p1
  inner join Products p2
    on p1.CategoryID = p2.CategoryID and p1.ProductID < p2.ProductID
;
```

# 3-5-2
```sql
select c1.CustomerName  顧客名1, c2.CustomerName 顧客名2
from Customers c1
inner join Customers c2
on c1.CustomerID < c2.CustomerID and
c1.PrefecturalID = c2.PrefecturalID and
c1.CustomerClassID = c2.CustomerClassID
;
```



# 3-5-3
```sql
select e1.EmployeeName 従業員名1, e2.EmployeeName  従業員名2, e1.EmployeeID, e2.EmployeeID
  from Employees e1
  inner join Employees e2
  on
    e1.Birthday > e2.Birthday
order by e1.EmployeeID, e2.EmployeeID
;
```

# 3-5-4
```sql

select c1.CategoryName カテゴリ名1, c2.CategoryName カテゴリ名2
  from
    Categories c1
    inner join Categories c2
    on
      c1.CategoryID < c2.CategoryID
      and
      c1.CategoryID <> c2.CategoryID
;
```

# 3-5-5
```sql
select c1.CustomerName  顧客名1, c2.CustomerName 顧客名2
from Customers c1
inner join Customers c2
on c1.CustomerID < c2.CustomerID and
c1.PrefecturalID = c2.PrefecturalID and
c1.CustomerClassID = c2.CustomerClassID
where c2.PrefecturalID != 13
;
```

# 3-6-1
```sql
select distinct s.ProductID, p.ProductName, Quantity
from Sales s
  join Products p
    on s.ProductID = p.ProductID
  where Quantity = (
    select max(s2.Quantity)
    from Sales s2
    where s.ProductID = s2.ProductID
  )
  order by s.ProductID asc
;
```
```sql
-- null/0が出現してくる
select p.ProductID, p.ProductName, ifnull((
  select max(s.Quantity)
    from Sales s
    where s.ProductID = p.ProductID
  ), 0) as Quantity
  from Products p
  order by p.ProductID asc
;
```
```sql
-- 相関サブクエリにならない
-- joinテーブル
select p.ProductID, p.ProductName, t.Quantity
  from Products p
  inner join (
    select max(Quantity) as Quantity, s.ProductID
    from Sales s
    group by s.ProductID
  ) as t
  on p.ProductID = t.ProductID
  order by p.ProductID asc
;
```

# 3-6-2
```sql
-- 相関サブクエリ
select p.ProductID, p.ProductName
from Products p
where exists (
  select 'x'
  from Sales s
  where p.ProductID = s.ProductID
)
;
```
```sql
-- 相関サブクエリ. 結合方向が非効率
select distinct s.ProductID, p.ProductName
  from Sales s
  inner join Products p
  on s.ProductID = p.ProductID
  where exists (
    select 'x'
    from Products pp
    where pp.ProductID = s.ProductID
  )
;
```
```sql
-- rails で`Products.joins(:sales).distinct で吐かれるSQL`
select distinct s.ProductID, p.ProductName
  from Products p
  inner join Sales s
  on s.ProductID = p.ProductID
;
```
```sql
-- distinctが不要になる. 1対1になるように結合している
select p.ProductID, p.ProductName
  from Products p
  inner join (
    select s.ProductID as ProductID
    from Sales s
    group by s.ProductID
  ) s
  on p.ProductID = s.ProductID
;
```

# 3-6-3
```sql
-- 相関サブクエリ
select p.ProductID, p.ProductName
  from Products p
  where
    not exists (
      select 'x'
      from Sales s
      where p.ProductID = s.ProductID
    )
;
```
```sql
-- rails で`Products.where.not(id: Products.joins(:sales).distinct) で吐かれるSQL`
select p.ProductID, p.ProductName
  from Products p
  where
    p.ProductID not in (
      select pp.ProductID
      from Products pp
      inner join (
        select s.ProductID ProductID
        from Sales s
        group by s.ProductID
      ) s
      on pp.ProductID = s.ProductID
    )
;
```

```sql
-- 結合して存在しないレコードを抽出している
select p.ProductID, p.ProductName
  from Products p
  left outer join Sales s
  on p.ProductID = s.ProductID
  where s.ProductID is null
;
```


* join
  * inner, outer
    * from句に結合条件を書く
* 相関サブクエリ
* where にサブクエリをかく(not相関)
  * 集合関数使っていると無理？

# 3-6-5
```sql
-- 計算してから結合しているのでコストが安い
select p.ProductID, p.ProductName
  from Products p
  inner join (
    select max(ss.Quantity) max, avg(ss.Quantity) avg, ss.ProductID
    from Sales ss
    group by ss.ProductID
  ) s
  on s.ProductID = p.ProductID
  where (s.max / 10) > s.avg
  order by p.ProductID
;
```
```sql
-- 相関サブクエリ
select p.ProductID, p.ProductName
  from Products p
  inner join (
    select t.ProductID
    from Sales t
    group by t.ProductID
  ) s
  on s.ProductID = p.ProductID
  where ((
    select max(ss.Quantity)
    from Sales ss
    where ss.ProductID = s.ProductID
  ) / 10) > (
    select avg(sss.Quantity)
    from Sales sss
    where sss.ProductID = s.ProductID
  )
  order by p.ProductID
;
```
