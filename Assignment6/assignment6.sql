# 1

select student.name as student_name, course.dept_name as dept_name,
       course.title as course_title, instructor.name as instructor_name
from takes
inner join student using (ID)
inner join course using (course_id)
inner join teaches using (course_id, year, sec_id, semester)
inner join instructor on teaches.ID = instructor.ID;

# 2

# 2 a

select student.name as student_name,
       instructor.name as instructor_name
from advisor
inner join student on advisor.s_ID = student.ID
inner join instructor on advisor.i_ID = instructor.ID;

# 2 b

create view advisor_names as (
    select student.name as student_name,
        instructor.name as instructor_name
    from advisor
    inner join student on advisor.s_ID = student.ID
    inner join instructor on advisor.i_ID = instructor.ID
);

# 2 c

update advisor_names
set student_name='Yogesh'
where instructor_name='Singh';

select *
from advisor_names
where student_name='Yogesh';

# 2 d

delete from advisor_names
where student_name='Yogesh';

# 2 e

insert into advisor_names
values ('Yogesh', 'Advisor1');

drop view advisor_names;

# 3

select student.name, student.ID, instructor.name, instructor.ID
from student
left join advisor on student.ID = advisor.s_ID
left join instructor on advisor.i_ID = instructor.ID;

# 4

# 4 a
create view advisor_dept_budg as (
 select distinct ID, name, dept_name, salary
 from (
          select ID, name, dept_name, salary
          from instructor
          where dept_name in (
              select dept_name
              from instructor
              group by dept_name
              having sum(salary)>100000
          )
      ) as more_salary
          inner join advisor on more_salary.ID = advisor.i_ID
);

select *
from advisor_dept_budg;

# 4 b

update instructor
set salary=salary*1.1;

select *
from advisor_dept_budg;

drop view advisor_dept_budg;

# 5

create view courses_in_2009 as (
    select instructor.ID, instructor.name, course_id,
          sec_id, semester, section.building, section.room_number
    from teaches
            inner join instructor using (ID)
            inner join section using (sec_id, course_id, semester, year)
    where year=2009
);

select *
from courses_in_2009;

drop view courses_in_2009;

# 6

select student.ID as ID, name, dept_name
from student
left join takes on student.ID = takes.ID
where takes.ID is null;

# 7
create view A_graders_2009 as (
select student.ID ,student.name, course_id
from takes
inner join student on takes.ID = student.ID
where year=2009 and grade='A'
);

select *
from A_graders_2009;

drop view A_graders_2009;

# 8

select instructor.ID, name,number_of_courses
from
(select ID, count(course_id) as number_of_courses
      from teaches
      group by ID
      having number_of_courses>=2
    ) as two_or_more
         inner join instructor on two_or_more.ID=instructor.ID;

# 9

create view not_teach_2010 as (
select instructor.*
from (
       select ID
       from teaches
       where year=2010
   ) as teaches_2010
       right join instructor on instructor.ID=teaches_2010.ID
where teaches_2010.ID is null
);

select *
from not_teach_2010;

drop view not_teach_2010;

# 10

select dept_name, department.building
from (
     select building
     from department
     group by building
     having count(dept_name)>1
 ) as more_than_one
inner join department on
 department.building=more_than_one.building;

# 11

select student.name,instructor.name
from (
 select s_ID, i_ID
 from advisor
          inner join (
     select ID
     from teaches
     where year=2010
     group by ID
     having count(course_id)>=1
 ) as teaches_2010_gte1 on advisor.i_ID=teaches_2010_gte1.ID
          inner join (
     select ID
     from takes
     where year=2010
     group by ID
     having count(course_id)>=1
 ) as takes_2010_gte1 on advisor.s_ID=takes_2010_gte1.ID
) as desired_ID_pairs
inner join student on student.ID=desired_ID_pairs.s_ID
inner join instructor on instructor.ID=desired_ID_pairs.i_ID;

