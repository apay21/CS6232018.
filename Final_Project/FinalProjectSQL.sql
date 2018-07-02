
Create Database product;



create table Product
(
   prod_id   varchar(5) not null,
   pname     varchar(50),
   price     numeric(10,2)
);
ALTER TABLE Product ADD PRIMARY KEY (prod_id);

insert into Product values ('p1', 'tape', 2.5);
insert into Product values ('p2', 'tv', 250);
insert into Product values ('p3', 'vcr', 80);



create table Depot
(
   dep_id   varchar(5) not null,
   addr     varchar(50),
   volume   integer
);
ALTER TABLE Depot ADD PRIMARY KEY (dep_id);

insert into Depot values ('d1', 'New York', 9000);
insert into Depot values ('d2', 'Syracuse', 6000);
insert into Depot values ('d4', 'New York', 2000);

 

create table Stock
(
   prod_id    varchar(5) not null,
   dep_id     varchar(5) not null,
   quantity   integer
);
ALTER TABLE Stock ADD PRIMARY KEY (prod_id, dep_id);


alter table stock
      add constraint fk_prod foreign key (prod_id) references product (prod_id);
	  

alter table stock
      add constraint fk_dep foreign key (dep_id) references depot (dep_id) on delete cascade;

insert into Stock values ('p1', 'd1', 1000);
insert into Stock values ('p1', 'd2', -100);
insert into Stock values ('p1', 'd4', 1200);
insert into Stock values ('p3', 'd1', 3000);
insert into Stock values ('p3', 'd4', 2000);
insert into Stock values ('p2', 'd4', 1500);
insert into Stock values ('p2', 'd1', -400);
insert into Stock values ('p2', 'd2', 2000);