 -- 1.
 select prod_id from product
 where substring(prod_id,1,1) = 'p'
   and price < 300;
 
 -- 2. IN Stmt  ****
 select r.pname, s.* 
 from stock s
 join product r on s.prod_id = r.prod_id
 where dep_id in ('d2');
 
 select r.pname, s.* 
 from stock s
 join product r on s.prod_id = r.prod_id
 where dep_id not in ('d2');
 
 -- NOT IN Stmt
 select r.pname, s.* 
 from stock s
 join product r on s.prod_id = r.prod_id
 where dep_id = ('d2');
 
 select r.pname, s.* 
 from stock s
 join product r on s.prod_id = r.prod_id
 where dep_id <> ('d2');
 
-- 3. 
-- Out of stock by Depot for products
select s.PROD_ID, p.PNAME, s.DEP_ID, qty
from (select DEP_ID, PROD_ID, sum(QUANTITY) qty from STOCK
             group by DEP_ID, PROD_ID) s
join PRODUCT p on s.PROD_ID = p.PROD_ID
where qty < 1;


select PROD_ID, PNAME
from PRODUCT
where PROD_ID in (select PROD_ID from (select DEP_ID, PROD_ID, sum(QUANTITY) qty from STOCK group by DEP_ID, PROD_ID) a
                        where qty < 1 );

 
-- 4.


select s.dep_id, addr 
from stock s
join depot d on s.dep_id = d.dep_id
where prod_id = ('p1')
  and quantity > 0;
  

select s.dep_id, addr 
from stock s
join depot d on s.dep_id = d.dep_id
where prod_id in ('p1')
  and quantity > 0;
  
select s.dep_id, addr 
from stock s
join depot d on s.dep_id = d.dep_id
where prod_id not in ('p2', 'p3')
  and quantity > 0;
  
  
   
select d.dep_id, addr 
from depot d
where exists(select prod_id from stock s 
			    where prod_id in ('p1')
               and quantity > 0 and d.dep_id = s.dep_id);


select d.dep_id, addr 
from depot d
where not exists(select prod_id from stock s 
			    where prod_id in ('p1')
               and quantity < 1 and d.dep_id = s.dep_id);

-- 5.
select prod_id, price from product where price >= 250
intersect  
select prod_id, price from product where price <= 400;


select prod_id, price from product
where price between 250 and 400;



-- 6.
select  count(*) from stock
where quantity < 1;



-- 7. 
select   avg(PRICE)
from STOCK s
join PRODUCT p on s.PROD_ID = p.PROD_ID
where DEP_ID = 'd2'
  and QUANTITY > 0;

 
-- 8.

select dep_id, quantity from stock
where quantity in (select max(quantity) qty from STOCK);
  


-- 9. 

select prod_id, sum(quantity) qty from STOCK s
where QUANTITY > 0
group by prod_id;

-- 10.

select pname, p.prod_id
from product p
join (select prod_id, count(*) total from stock s group by prod_id) t
      on p.prod_id = t.prod_id
where total >= 3;

 

select pname, p.prod_id
from product p
join (select prod_id, sum(1) total from stock s group by prod_id) t
      on p.prod_id = t.prod_id
where total >= 3;

-- 11.


select s.prod_id
from (select  prod_id,  count(*) prod_cnt from stock group by prod_id ) s
where   prod_cnt  in  (select count(*) dep_cnt from depot); 

  
select s.prod_id
from (select  prod_id,  count(*) prod_cnt from stock group by prod_id ) s
where    exists (select dep_cnt from (select count(*) dep_cnt from depot) a where  prod_cnt = dep_cnt );
 

select s.prod_id
from (select  prod_id,  count(*) prod_cnt from stock group by prod_id ) s
where  not  exists (select dep_cnt from (select count(*) dep_cnt from depot) a where  prod_cnt <> dep_cnt );
 





