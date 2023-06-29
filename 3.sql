-->> Problem Statement:
Suppose you have a car travelling certain distance and the data is presented as follows -
Day 1 - 50 km
Day 2 - 100 km
Day 3 - 200 km

Now the distance is a cumulative sum as in
    row2 = (kms travelled on that day + row1 kms).

How should I get the table in the form of kms travelled by the car on a given day and not the sum of the total distance?


-->> Sample Dataset:
drop table car_travels;
create table car_travels
(
    cars                    varchar(40),
    days                    varchar(10),
    cumulative_distance     int
);
insert into car_travels values ('Car1', 'Day1', 50);
insert into car_travels values ('Car1', 'Day2', 100);
insert into car_travels values ('Car1', 'Day3', 200);
insert into car_travels values ('Car2', 'Day1', 0);
insert into car_travels values ('Car3', 'Day1', 0);
insert into car_travels values ('Car3', 'Day2', 50);
insert into car_travels values ('Car3', 'Day3', 50);
insert into car_travels values ('Car3', 'Day4', 100);

select * from car_travels

-- Approach-1
select j.cars,j.days,
(j.cumulative_distance-j.distance_travel_on_prev) as km_travels from (
select h.cars,h.days,h.cumulative_distance,
	case when h.distance_travel_on_prev is null then 0 else h.distance_travel_on_prev end as distance_travel_on_prev 
from (
	select * ,
	lag(cumulative_distance,1) over(partition by cars) distance_travel_on_prev
	from car_travels )h
)j

--Approach 2 
select cars,days,
 (cumulative_distance - lag(cumulative_distance,1,0) 
 	over(partition by cars order by days)) as  km_travels  
from car_travels



-----------------
-- Dataset
drop table emp_input;
create table emp_input
(
id      int,
name    varchar(40)
);
insert into emp_input values (1, 'Emp1');
insert into emp_input values (2, 'Emp2');
insert into emp_input values (3, 'Emp3');
insert into emp_input values (4, 'Emp4');
insert into emp_input values (5, 'Emp5');
insert into emp_input values (6, 'Emp6');
insert into emp_input values (7, 'Emp7');
insert into emp_input values (8, 'Emp8');

select * from emp_input;

--1

with cte as
    (select concat(id, ' ', name) as name
    , ntile(4) over(order by id) as buckets
    from emp_input)
	
select string_agg(name, ',') as final_result
from cte
group by buckets
order by 1

--Q3 
Create table If Not Exists Tree (id int, p_id int)
Truncate table Tree
insert into Tree (id, p_id) values (1, null);
insert into Tree (id, p_id) values (2, 1);
insert into Tree (id, p_id) values (3, 1);
insert into Tree (id, p_id) values (4, 2);
insert into Tree (id, p_id) values (5, 2);

select * from Tree

select id,
	case when p_id is null then 'root'
		 when p_id is not null and id in (select distinct p_id from tree) then 'inner'
	     else 'leaf'
	end as Type
from Tree


	