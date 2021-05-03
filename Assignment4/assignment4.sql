use university;

# 1
select dept_name from (
select distinct teaches.ID as ID, dept_name, salary
from instructor
inner join teaches on instructor.ID = teaches.ID
where year=2010
) as temp
group by dept_name
having AVG(salary) > 50000;

# 2.a
insert into student values (1047, 'Yogesh', 'Comp. Sci.', 12);

# 2.b
select student.*
from student, (
    select *
    from (
             select MIN(tot_cred) as lowest, MAX(tot_cred) as highest
             from student
         ) as ends,
         (
             select tot_cred as mine
             from student
             where ID=1047
         ) as self
) as temp
where student.tot_cred
between (if(mine-lowest > highest-mine, lowest, mine))
and (if(mine-lowest > highest-mine, mine, highest))
order by tot_cred desc ;



# 2.c
delete from student
where ID=1047;

# 3
select sum(salary) as total_salary
from (
select distinct salary
from instructor
      inner join advisor on instructor.ID = advisor.i_ID
where name like 'K%'
) as salaryTable;


# 4
select concat(upper(substring(name, 1, 4)), '_', substring(dept_name, 1, 4)) as concatenated_names
from student;


# 5
select *
from section, course
where (building like '%ta%' or building like '%at%' or building like '%ka%')
and (section.course_id like 'CS%')
and (dept_name='Comp. Sci.');

# 6
select name, salary
from instructor
where dept_name='finance' or dept_name='biology'
order by salary desc ;

# 7
update instructor
set salary=NULL
where name like 'C%' or name like 'E%';

select *
from instructor
where salary is null ;


select *
from instructor
where salary is not null ;

# 8

select name, concat(name, repeat(lower(name), 2)) as name_3x_repeat
from student;

# 9

select name, length(name), grade
from student
inner join takes on student.ID = takes.ID
where grade in ('A', 'B', 'A-');

# 10

select *
from course
where title like '%comp%';
