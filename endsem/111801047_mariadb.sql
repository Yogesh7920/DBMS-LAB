## Part 1

use university_endsem;

# 1

select instrutor_count.dept_name
from (
 select dept_name, count(ID) as students
 from student
 group by dept_name
) as student_count,
(
    select dept_name, count(ID) as instructors
    from instructor
    group by dept_name
 ) as instrutor_count

where (student_count.dept_name = instrutor_count.dept_name) and
      (student_count.students < instrutor_count.instructors);


# 2

select ID, name
from student
inner join (
    select distinct ID
    from takes
             inner join (
        select *
        from course
        where dept_name='Comp. Sci.'
    ) as cs using (course_id)
) as cs_students using(ID);

# 3

select ID, name, course_id, title
from teaches
inner join course using (course_id)
inner join (
    select ID, name
    from instructor
             inner join (
        select ID
        from teaches
        group by ID
        having count(course_id) > 1
    ) as more_courses using (ID)
) as more_teaching_inst using(ID);

# 4

select ID, name, student.dept_name as student_dept,
       course_id, title, course_dept.dept_name as course_dept
from student
inner join (
    select distinct ID, course_id, title, dept_name
    from takes
    inner join course using (course_id)
) as course_dept using (ID)
where course_dept.dept_name<>student.dept_name;

# 5

create table oddeven (
  x int,
  y varchar(5)
);

delimiter //

create procedure poe (in a int, in b int)
begin
    while a<= b do
        if a % 2 = 0 then
            insert into oddeven values (a, 'even');
        else
            insert into oddeven values (a, 'odd');
        end if;
        set a = a + 1;
    end while;
end //
delimiter ;

CALL poe(1, 4);
select *
from oddeven;


drop procedure poe;
drop table oddeven;

# 6
delimiter //

create function get_user()
returns varchar(32)
begin
return (select current_user());
end//
delimiter ;

select get_user();

create user 'Snow' identified by 'white';
GRANT all on university_endsem.* to 'Snow';

drop user 'Snow';

drop function get_user;


## Part 2

# 1

create database canteen;
use canteen;

create table menu (
    id int not null ,
    name varchar(50) not null ,
    type varchar(50),
    check ( type in ('healthy', 'unhealthy') )
);

create table customerorder (
    id int not null,
    count int not null
);

create table price (
    id int not null ,
    amount float
);

delimiter //
create trigger init_price
    after insert on menu
    for each row
        if (NEW.type = 'healthy')
        then
            insert into price (id, amount) values (NEW.id, 10);
        else
            insert into price (id, amount) values (NEW.id, 15);
        end if //
delimiter ;



insert into menu values (1, 'rice', 'healthy');
insert into menu values (2, 'burger', 'unhealthy');

select *
from menu;
select *
from price;

drop trigger init_price;

drop table price;
drop table menu;

drop database canteen;


