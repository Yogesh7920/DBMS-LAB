use university;

# A

set global event_scheduler = on;

show events;

create event test_event
    on schedule every 1 minute
    do update department set budget=budget*1.05;

select curtime();

select * from department;

SHOW EVENTS\G;

alter event test_event
    on schedule every 1 minute
    ends current_timestamp + interval 5 minute
    do update department set budget=budget+100;

drop event test_event;


# B

SET profiling = 1;

show processlist ;

select *
from department
where budget>50000;

select *
from student
where name='wood';
show profile CPU for query 31;

show profiles;

# C
delimiter //
create trigger valid_grade
    before insert on takes
    for each row
    begin
    if NEW.grade not in (select distinct grade from takes where grade is not null )
    then signal sqlstate '45000' set message_text = 'Not a valid grade';
    end if;
    end; //
delimiter ;

insert into takes
values (12345, 'CS-101', 1, 'Spring', 2010, 'A');

drop trigger valid_grade;


