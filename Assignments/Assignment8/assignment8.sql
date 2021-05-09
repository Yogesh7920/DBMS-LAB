use university;

#1

set @avg_cred  = (select avg(tot_cred) from student);

select round(@avg_cred*2, 4);

select *
from student
where tot_cred>(2*@avg_cred);

# 2

select *
from department
where budget>(
    select avg(budget)
    from department
);

DELIMITER //
create function avg_budget()
returns float
    begin
        return (
            select avg(budget)
            from department
            );
    end; //
DELIMITER ;

select avg_budget();

select *
from department
where budget>avg_budget();

drop function avg_budget;

# 3

DELIMITER //
create procedure top_budg(in N int)
begin
    select budget
    from department
    order by budget desc
    limit N;
end; //
DELIMITER ;

call top_budg(3);
call top_budg(5);

drop procedure top_budg;

# 4

DELIMITER //
create procedure new_student(in SID int)
begin
    set @SQL = (select concat('create user ', '\'', SID, '\''));
    prepare user_create from @SQL;
    execute user_create;
    set @view_name = (select concat('info', SID));
    set @SQL = (select concat('create view ', @view_name, ' as ( select ID, name, dept_name, if(ID=', SID, ', tot_cred, null) as tot_cred from student );'));
    prepare stmt from @SQL;
    execute stmt;
    set @SQL = (select concat('grant select on ', @view_name, ' to ', '\'', SID, '\''));
    prepare grant_stmt from @SQL;
    execute grant_stmt;
end; //
DELIMITER ;

insert into student
values (1, 'user1', 'Music', 100);
call new_student(1);

drop user '1';
drop view info1;
delete from student
where ID=1;

insert into student
values (2, 'user2', 'History', 70);
call new_student(2);
drop user '2';
drop view info2;
delete from student
where ID=2;

drop procedure new_student;
