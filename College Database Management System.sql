use project;
#view all tables
select * from finalres;(contains columns likesid varchar(20) 
name text 
dept text 
Year int 
Current_Sem int 
sem1 double 
sem2 double 
sem3 double 
sem4 double 
sem5 double 
sem6 double 
sem7 double 
sem8 double 
CGPA double 
backlog int)

select * from hostel_female;(contains columns like regno varchar(30) 
name varchar(30) 
dob date 
dept varchar(20) 
addr varchar(20) 
blood_grp varchar(20) 
fees int 
paid int 
bal int 
hstatus varchar(20))

select * from hostel_male;(contains columns like regno varchar(30) 
name varchar(30) 
dob date 
dept varchar(20) 
addr varchar(20) 
blood_grp varchar(20) 
fees int 
paid int 
bal int 
hstatus varchar(20))

select * from hostel_menu;(contains columns like Day text 
Breakfast text 
Lunch text 
Dinner text)

select * from it_dept_2ndyear_sem2_result1;(contains columns like sid varchar(20) 
stu_name text 
Dept text 
Computer_Architecture text 
Object_Oriented_Programming text 
Data_Structures text 
dbms text 
Data_Structures_Laboratory text 
Object_Oriented_Programming_Laboratory text) 

select * from mech_2ndyear_sem3;(contains columns like regno varchar(40) 
name varchar(90) 
dept varchar(30) 
Manufacturing_Technology_Laboratory1 varchar(90) 
Engineering_Thermodynamics varchar(90) 
Fluid_Mechanics_and_Machinery varchar(90) 
Manufacturing_Technology1 varchar(90) 
Electrical_Drives_and_Control varchar(90) 
Electrical_Engineering_Laboratory varchar(90) 
Computer_Aided_and_Machine_Drawing varchar(90))

select * from placement_table;(contains columns like regno varchar(20) 
Name text 
Dob text 
dept text 
addr text 
Placed_companies text)

select * from restult;(contains columns like sid text 
name text 
dept text 
Year int 
Current_Sem int 
sem1 double 
sem2 double 
sem3 double 
sem4 double 
sem5 double 
sem6 double 
sem7 double 
sem8 double 
CGPA double 
backlog bigint)

select * from sports_table;(contains columns like rno varchar(30) 
name varchar(20) 
dept varchar(20) 
sports_name varchar(20) 
slevel varchar(20))

select * from staff_hand_sub;(contains columns like sid varchar(20) 
staff_name varchar(20) 
dept varchar(20) 
sem1 varchar(20) 
sem2 varchar(20) 
sem3 varchar(30) 
sem4 varchar(20) 
sem5 varchar(20) 
sem6 varchar(20) 
sem7 varchar(30) 
sem8 varchar(20))

select * from staff_handling;(contains columns like sid varchar(20) 
sname text 
Department text 
Semester_1 text 
Semester_2 text 
Semester_3 text 
Semester_4 text 
Semester_5 text 
Semester_6 text 
Semester_7 text 
Semester_8 text)

select * from staff_table;(contains columns like staff_id varchar(20) PK 
Staff_name text 
qual text 
Dept text 
Salary int 
Desig text 
year_of_joining int)

select * from student_table;(contains columns like varchar(30) PK 
name varchar(20) 
dob date 
dept varchar(20) 
addr varchar(30) 
blood_grp varchar(10) 
gender varchar(10) 
hosteller varchar(20) 
yyear int 
current_sem int)


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

