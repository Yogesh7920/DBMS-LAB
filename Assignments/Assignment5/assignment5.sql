drop table members;


# 1.1

create table projects (
    ID int primary key ,
    name varchar(25) not null ,
    domain varchar(25)
);

create table members (
     projectID int,
     ID int primary key ,
     name varchar(25) not null,
     age int,
     role varchar(20) check (
         role in ('manager', 'designer', 'sysadmin', 'developer')
         ),
     constraint foreign key (projectID)
         references projects(ID)
         on delete cascade
);


drop table projects;

# 1.2

insert into projects
values (1, 'P1', 'CS');


insert into members
values (1, 1, 'Yogesh', 20, 'developer');

insert into members
values (1, 2, null, 24, 'sysadmin');


# 1.3

delete from projects
where ID=1;
select * from projects;
select * from members;

# 2
# drop database sample_with_data;
# drop database sample_without_data;

# 3

select count(distinct studentID) as number_of_students
from (
    select takes.ID as studentID
    from takes
          inner join teaches on takes.course_id=teaches.course_id
    where teaches.ID=10101
) as temp;


# 4

select name
from instructor
where salary>(
    select min(salary) from instructor
    where dept_name='Biology'
);

# 5

select dept_name, (
    select COUNT(*)
    from instructor
    where department.dept_name = instructor.dept_name
) as total_instructors from department;

# 6

select name, salary
from instructor
where salary=(select max(salary)
              from instructor
              where salary <> (
                  select max(salary)
                  from instructor
              ));


# 7
select topper.dept_name, topper.name as topper, topper.tot_cred
from (
         select dept_name, count(ID) as count
         from student
         group by dept_name
         having count>1
     ) as more_than_one
         inner join (
    select name, dept_name, tot_cred
    from student
             join (
        select dept_name, max(tot_cred) as tot_cred
        from student
        group by dept_name
    ) as top_marks using (dept_name, tot_cred)
) as topper on more_than_one.dept_name=topper.dept_name;
