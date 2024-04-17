

create table NGUOI_AN(ten VARCHAR(30) NOT NULL , tuoi int, phai VARCHAR(6));
create table LUI_TOI(ten VARCHAR(30)NOT NULL, quanPizza VARCHAR(30) NOT NULL);
create table AN(ten VARCHAR(30)NOT NULL, pizza VARCHAR(30) NOT NULL);
create table PHUC_VU(quanPizza VARCHAR(30)NOT NULL, pizza VARCHAR(30)NOT NULL, gia numeric (6,3));


insert into NGUOI_AN values('Amy', 16, 'female');
insert into NGUOI_AN values('Ben', 21, 'male');
insert into NGUOI_AN values('Cal', 33, 'male');
insert into NGUOI_AN values('Dan', 13, 'male');
insert into NGUOI_AN values('Eli', 45, 'male');
insert into NGUOI_AN values('Fay', 21, 'female');
insert into NGUOI_AN values('Gus', 24, 'male');
insert into NGUOI_AN values('Hil', 30, 'female');
insert into NGUOI_AN values('Ian', 18, 'male');

insert into LUI_TOI values('Amy', 'Pizza Hut');
insert into LUI_TOI values('Ben', 'Pizza Hut');
insert into LUI_TOI values('Ben', 'Chicago Pizza');
insert into LUI_TOI values('Cal', 'Straw Hat');
insert into LUI_TOI values('Cal', 'New York Pizza');
insert into LUI_TOI values('Dan', 'Straw Hat');
insert into LUI_TOI values('Dan', 'New York Pizza');
insert into LUI_TOI values('Eli', 'Straw Hat');
insert into LUI_TOI values('Eli', 'Chicago Pizza');
insert into LUI_TOI values('Fay', 'Dominos');
insert into LUI_TOI values('Fay', 'Little Caesars');
insert into LUI_TOI values('Gus', 'Chicago Pizza');
insert into LUI_TOI values('Gus', 'Pizza Hut');
insert into LUI_TOI values('Hil', 'Dominos');
insert into LUI_TOI values('Hil', 'Straw Hat');
insert into LUI_TOI values('Hil', 'Pizza Hut');
insert into LUI_TOI values('Ian', 'New York Pizza');
insert into LUI_TOI values('Ian', 'Straw Hat');
insert into LUI_TOI values('Ian', 'Dominos');

insert into AN values('Amy', 'pepperoni');
insert into AN values('Amy', 'mushroom');
insert into AN values('Ben', 'pepperoni');
insert into AN values('Ben', 'cheese');
insert into AN values('Cal', 'supreme');
insert into AN values('Dan', 'pepperoni');
insert into AN values('Dan', 'cheese');
insert into AN values('Dan', 'sausage');
insert into AN values('Dan', 'supreme');
insert into AN values('Dan', 'mushroom');
insert into AN values('Eli', 'supreme');
insert into AN values('Eli', 'cheese');
insert into AN values('Fay', 'mushroom');
insert into AN values('Gus', 'mushroom');
insert into AN values('Gus', 'supreme');
insert into AN values('Gus', 'cheese');
insert into AN values('Hil', 'supreme');
insert into AN values('Hil', 'cheese');
insert into AN values('Ian', 'supreme');
insert into AN values('Ian', 'pepperoni');

insert into PHUC_VU values('Pizza Hut', 'pepperoni', 12);
insert into PHUC_VU values('Pizza Hut', 'sausage', 12);
insert into PHUC_VU values('Pizza Hut', 'cheese', 9);
insert into PHUC_VU values('Pizza Hut', 'supreme', 12);
insert into PHUC_VU values('Little Caesars', 'pepperoni', 9.75);
insert into PHUC_VU values('Little Caesars', 'sausage', 9.5);
insert into PHUC_VU values('Little Caesars', 'cheese', 7);
insert into PHUC_VU values('Little Caesars', 'mushroom', 9.25);
insert into PHUC_VU values('Little Caesars', 'supreme', 9);
insert into PHUC_VU values('Dominos', 'cheese', 9.75);
insert into PHUC_VU values('Dominos', 'mushroom', 11);
insert into PHUC_VU values('Straw Hat', 'pepperoni', 8);
insert into PHUC_VU values('Straw Hat', 'cheese', 9.25);
insert into PHUC_VU values('Straw Hat', 'sausage', 9.75);
insert into PHUC_VU values('New York Pizza', 'pepperoni', 8);
insert into PHUC_VU values('New York Pizza', 'cheese', 7);
insert into PHUC_VU values('New York Pizza', 'supreme', 8.5);
insert into PHUC_VU values('Chicago Pizza', 'cheese', 7.75);
insert into PHUC_VU values('Chicago Pizza', 'supreme', 8.5);
--Bai 1
Alter table NGUOI_AN
ADD CONSTRAINT kc_nguoian Primary key (ten)

Alter table LUI_TOI
ADD CONSTRAINT kc_luitoi primary key (ten,quanPizza)

Alter table An 
ADD CONSTRAINT kc_an primary key (ten,pizza)

Alter table PHUC_VU
ADD CONSTRAINT kc_phucvu primary key (quanPizza,pizza,gia)

Alter table Lui_toi
ADD CONSTRAINT kn_luitoi foreign key (ten) references Nguoi_an

Alter table An
Add constraint kn_an foreign key (ten) references Nguoi_an

 --Bai 2
select pizza
from Phuc_vu
where quanPizza like 'Pizza Hut'

--Bai 3
select pizza
from phuc_vu

--Bai 4
select quanPizza
from Phuc_vu
where pizza like '%m%'

--Bai 5
select a.ten, a.tuoi
from Nguoi_an a, Lui_toi b
where a.ten=b.ten and b.quanPizza like 'Dominos'

select ten, tuoi
from Nguoi_an
Natural join Lui_Toi
where quanPizza like 'Dominos'

--Bai 6
select quanPizza,  count(pizza)
from phuc_vu
group by quanPizza

--Bai 7
select quanPizza, Max(gia)
from phuc_vu
group by quanPizza
having Max(gia) = (
    select Max(gia)
    from phuc_vu
)
--Bai 8
select quanPizza
from An a, Lui_toi l
where a.ten like '%lan%' and a.ten=l.ten

--Bai 9
select quanPizza
from An a, Lui_toi l
where a.ten not like '%Eli%' and a.ten=l.ten

--Cau 10
select quanpizza
from phuc_vu
where pizza IN (
    select pizza
    from an
    where ten like '%Eli%'
) 
group by quanPizza
having Count(pizza) = (
    select count(pizza)
    from an
    where ten like '%Eli%'
    group by ten
)

--Cau 11
select quanPizza
from phuc_vu
group by quanPizza
having min(gia) > (
    select max(gia)
    from phuc_vu
    group by quanpizza 
    having quanpizza = 'New York Pizza'
)

--Cau 12
select quanPizza
from phuc_vu
group by quanPizza
having max(gia) < 10

--Cau 13
select pizza
from phuc_vu
where quanPizza like 'New York Pizza'
Union
select pizza
from phuc_vu
where quanPizza like 'Dominos'

--cau 14
select pizza
from phuc_vu
where quanPizza like 'Little Caesars'
Minus
select pizza
from phuc_vu
where quanPizza like 'Pizza hunt'

--Cau 15
select quanPizza
from phuc_vu
group by quanPizza
having count(pizza) = (
select count(distinct pizza)
from phuc_vu)

--Cau 16
select quanPizza
from phuc_vu
where pizza in(
    select pizza
    from an
    where ten='Gus'
)
group by quanpizza
having count(pizza) >= 2

--Cau 17--Not found
select pizza
from an
where ten='%lan%'

--Cau 18
select ten, count(quanPizza)
from lui_toi
group by ten
having count(quanPizza) >= 3

--Cau 19
select quanPizza, count(pizza)
from phuc_vu
group by quanPizza
--Cau 20
select ten, count(pizza)
from an
where pizza IN (
    select pizza
    from an
    where ten='Hil'
)
group by ten
having count(pizza) >=(
    SELECT COUNT(pizza)
    FROM AN
    WHERE ten = 'Hil'
)
