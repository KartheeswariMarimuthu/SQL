use project;
-- 1-> who paid less than 50% of fees (in hostel)
select Dept,count(regno) as students_count
from hostel_male
where bal<=25000
group by dept
union 
select Dept,count(regno) as students_count
from hostel_female
where bal<=25000
group by dept;

select * from staff_handling;

-- 2->EEE department 3rd semester syllabus 
select Department,Semester_3
from staff_handling
where department="eee" and semester_3 is not null
group by department,semester_3;

-- 3-> who got arrears in thermodynamics subjects in MECH department
select s.sid,s.name,s.dept,s.yyear,s.current_sem,i.Engineering_Thermodynamics from student_table s join mech_2ndyear_sem3 i on s.sid=i.regno
where Engineering_Thermodynamics="RA"
union
select s.sid,s.name,s.
dept,s.yyear,s.current_sem,t.Engineering_Thermodynamics from student_table s join mech_3rdyear_sem3 t on s.sid=t.regno
where Engineering_Thermodynamics="RA"
union
select s.sid,s.name,s.dept,s.yyear,s.current_sem,y.Engineering_Thermodynamics from student_table s join mech_4thyear_sem3 y on s.sid=y.regno
where Engineering_Thermodynamics="RA";

-- 4->who got A+ grade in DBMS
select s.sid,s.name,s.dept,s.yyear,s.current_sem,i.dbms from student_table s join it_dept_2ndyear_sem2_result1 i on s.sid=i.sid
where dbms="A+"
union
select s.sid,s.name,s.dept,s.yyear,s.current_sem,t.dbms from student_table s join it_dept_3rdyear_sem2_result1 t on s.sid=t.student_id
where dbms="A+"
union
select s.sid,s.name,s.dept,s.yyear,s.current_sem,y.dbms from student_table s join it_dept_4thyear_sem2_result y on s.sid=y.regno
where dbms="A+";

select * from hostel_menu;
-- 5-> Wednesday Breakfast Menu(Hostel)
select *
from hostel_menu
where day='wednesday';

-- 6-> Placed and Non-Placed Studengts List in Civil Department
select count(p.regno) as Placed_students,count(s.sid) as Non_placed_students
from student_table s left join placement_table p
on s.sid=p.regno
where p.dept="civil" or s.dept="civil" and s.yyear=4;

-- 7-> In ECE dept who got placed in IT companies
select Dept,Name from placement_table 
where dept="ECE";

-- 8-> students count department wise who got placed in TCS
select Dept, count(regno) as Department
from placement_table
group by dept;

-- 9 -> CSE Department who got first three ranks in 3rd semester 
with sr as(
select regno,name,dept,rank() over(order by sem3 desc) as student_rank
from result
where dept="cse")
select regno,name,dept,student_rank
from sr
where student_rank<3;

-- 10-> staff who got first three highest salary
with hs as(
select *,dense_rank() over(order by salary desc) as highest_salary
from staff_table
)
select dept,staff_name,salary,highest_salary
from hs
where highest_salary<4;

-- 11-> Staff details of those currently handling python subjects
select * from stafF_handling where semester_1 like "%python%"
union
select * from stafF_handling where semester_2 like "%python%"
union
select * from stafF_handling where semester_3 like "%python%"
union
select * from stafF_handling where semester_4 like "%python%"
union
select * from stafF_handling where semester_5 like "%python%"
union
select * from stafF_handling where semester_6 like "%python%"
union
select * from stafF_handling where semester_7 like "%python%"
union
select * from stafF_handling where semester_8 like "%python%";

-- 12->Staff details of those currently handling subjects
select * from staff_handling where sid="IT005";

/* -- 13-> In the Mechanical Department, 
students who attained above 8 CGPA in the seventh semester 
and those who excelled in state-level volleybal */
SELECT s.name, s.sports_name, s.slevel, r.cgpa
SELECT s.name, s.sports_name, s.slevel, r.cgpa
FROM sports_table s
JOIN finalres r ON s.rno = r.sid
WHERE r.dept = 'mech' 
AND r.cgpa > 8 
AND s.slevel = 'state' 
AND s.sports_name = 'volley ball';

-- 14-> who still have 2 arrears  students dept wise
select dept,count(sid) as students_count
from finalres
where backlog>=2
group by dept;

-- 15-> who got highest cgpa(first 3 rank)
with highest_rank as (select *,rank() over(partition by dept order by cgpa desc) as toprank
from finalres)
select sid,name,dept,toprank
from highest_rank
where toprank<=3;

select * from student_table
where current_sem=4 and dept="eee";

select sid,cgpa from finalres
where current_sem=8;

select concat("My name is"," ",name," ","I am from"," ",addr) as result
from student_table;
select * from student_table;

select name
from student_table
where name like "_A_A%";

select max(sal) as maximum_Salary
from emp;
select sum(sal) as total,avg(sal) as average 
from emp;

select count(empid) as no_of_manager
from emp
where job="Manager";

select count(empid) as no_of_emp
from emp
where job not in ('clerk','analyst') and dept not in (10,20);
select max(sal) as maximum_sal,min(sal) as minimum_,min(comm) as minimum_sal
from emp
where name like "S%" and name not like "A";

select count( dept)as uni_dept
from student_table; 

select dept,min(current_sem) as yg
from student_table
group by dept;

select dept,max(salary) as ad
from staff_table
group by dept
having  max(salary)>10000 and max(salary)<80000;
select dept,alary as hf

from staff_table
where desig like "%professor%"
group by dept
having min(salary)>50000;
