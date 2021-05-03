select distinct grade
from takes
order by field(grade, 'A', 'A-', 'B+', 'B', 'B-', 'C+', 'C', 'C-', 'F');

select *
from section;

select *
from student;

select *
from takes
where grade='U';

delete
from takes
where grade='U';

select distinct grade from takes where grade is not null ;
