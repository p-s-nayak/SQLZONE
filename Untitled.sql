create table payments_data(
   trx_date date,
	merchant varchar(10),
	amount int,
	payment_mode varchar(10)
)
select * from payments_data
insert into payments_data values('2022-04-02','m_1',500,'Online');
insert into payments_data values ('2022-04-03','m_2',450,'Online');
insert into payments_data values('2022-04-03','m_1',100,'CASH');
insert into payments_data values ('2022-04-03','m_3',600,'CASH');
insert into payments_data values('2022-04-05','m_5',570,'Online');
insert into payments_data values ('2022-04-05','m_2',400,'Online');


select merchant,
sum(case when payment_mode = 'Online' then amount else 0 end )as online_mode,
sum(case when payment_mode = 'CASH' then amount else 0 end )as CASH_mode
from payments_data 
group by merchant



create table marks_data(student_id int, subject varchar(50), marks int);
insert into marks_data values(1001, 'English', 88);
insert into marks_data values(1001, 'Science', 90);
insert into marks_data values(1001, 'Maths', 85);
insert into marks_data values(1002, 'English', 70);
insert into marks_data values(1002, 'Science', 80);
insert into marks_data values(1002, 'Maths', 83);

select student_id, 
	SUM(case when subject ='English' then marks else 0 end )as English,
	SUM(case when subject ='Science' then marks else 0 end )as Science,
	SUM(case when subject ='Maths' then marks else 0 end )as Maths
	from marks_data
group by student_id
order by student_id


create table user_activity(date date,user_id int,activity varchar(50));

insert into user_activity values('2022-02-20',1,'abc');
insert into user_activity values('2022-02-20',2,'xyz');
insert into user_activity values('2022-02-22',1,'xyz');
insert into user_activity values('2022-02-22',3,'klm');
insert into user_activity values('2022-02-24',1,'abc');
insert into user_activity values('2022-02-24',2,'abc');
insert into user_activity values('2022-02-24',3,'abc');



