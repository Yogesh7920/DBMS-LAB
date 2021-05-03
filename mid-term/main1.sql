# 1


# 2
create user 'userdba' identified by 'dbapwd';
grant all privileges on *.* to 'userdba' with grant option;

create user 'tom' identified by 'mot';
create user 'jerry' identified by 'yrrej';
grant select on university_midsem.instructor to 'tom';
select * from university_midsem.instructor limit 4;

create user 'simba' identified by 'abmis';
create role 'jerry_simba';
grant 'jerry_simba' to 'jerry';
grant 'jerry_simba' to 'simba';

grant select on university_midsem.student to 'jerry_simba';
set role jerry_simba;
select * from university_midsem.student limit 4;

# 3

create table onlynames6 as ( select name, dept_name from instructor where salary>60000 );
select * from onlynames6;

# 4
# a
create view rank_stud as (
 select ID, name, dept_name, tot_cred
 from student
 order by tot_cred
);
select *
from rank_stud;

# b

update rank_stud
set tot_cred=20
where name='Tanaka';

select *
from rank_stud;

# 5

select dept_name
from instructor
group by dept_name
having avg(salary) > (select avg(salary) from instructor);

# 6

select c1.course_id, c1.title
from prereq
inner join course c1 on prereq.course_id = c1.course_id
inner join course c2 on prereq.prereq_id = c2.course_id
where c1.dept_name<>c2.dept_name;

# 7

select name, dept_name
from (
 select i_ID
 from advisor
 group by i_ID
 having count(s_ID)=2
) as two_students_advisor
inner join instructor on i_ID=instructor.ID;



