set autocommit=0;

select *
from student;

update student
set name='Levi'
where ID=45678;

select *
from student
where ID=45678;

rollback;

select *
from student
where ID=45678;

update student
set name='Levi'
where ID=45678;

commit ;

select *
from student
where ID=45678;

rollback ;

select *
from student
where ID=45678;

update student
set tot_cred=tot_cred+5;
select *
from student;

rollback;

select *
from student;

update student
set tot_cred=tot_cred+5;
commit ;

select *
from student;

rollback ;

select *
from student;

create user Yogesh identified by 'yogesh123';
select user
from mysql.user;

create role manager;
grant manager to 'Yogesh';

grant select on university.student to 'Yogesh';
select * from university.student;

create user 'abc' identified by 'cba';
grant all privileges on *.* to 'abc' with grant option ;

create user 'def' identified by 'fed';

grant select, update on university.student to 'def';

drop user 'abc';
drop user 'def';
