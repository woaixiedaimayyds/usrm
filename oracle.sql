select * from student where sdept='CS';
--1、查询CS系年龄大于20岁的学生，列出学号，姓名，性别。
select sno,sname,ssex
from student
where sage>20 and sdept='CS';
commit;
--2、查询选了'DB'课程的学生的学号。
select sno from SC
where cno in(select cno from Course where cname='DB');


--3、查询CS系没有选'DB'课程的学生的学号，姓名，系。
select sno,sname,sdept
from Student
where not exists(select* from SC where sno=Student.sno 
and cno in(select cno from Course where cname='DB')) 
and sdept='CS';

--4、查询男（‘m’）同学选择了'DB'课程，但是没有选'Oracle'课程的学生，列出学号，姓名。(课程名要区分大小写)
select sno,sname from Student
where ssex='男' and sno in(select sno from SC where cno in(select cno from Course where cname='DB')) and sno not in(select sno from SC where cno in(select cno from Course where cname='Oracle'));


--1、查询每个学生的平均分，列出学生的学号，平均分（列名为savg）,并按平均分降序排列。
select sno,avg(grade) as savg
from SC
group by sno
order by savg desc;

--2、查询选课人数大于等于3人的课程，列出课程号，课程名，选课人数（列名为scnt）,并按课程号升序排列。
select SC.cno,cname,count(sno) as scnt
from Course,SC
where Course.cno=SC.cno 
group by SC.cno,cname
having count(sno)>=3
order by SC.cno;



--3、查询选课人数最多的课程。列出课程号，课程名。
select Course.cno,cname
from Course,SC
where Course.cno=SC.cno
group by Course.cno,cname
having count(sno)>=all(select count(sno) from SC group by SC.cno);

--4、查询CS系选课人数最多的课程。列出课程号，课程名，CS系的选课人数（列名为CScnt）。
select SC.cno,cname,count(Student.sno)as CScnt
from Course,SC,Student
where SC.sno=Student.sno and SC.cno=Course.cno and sdept='CS'
group by SC.cno,cname
having count(Student.sno)>=all(select count(Student.sno)from SC,Course,Student where SC.sno=Student.sno and SC.cno=Course.cno and sdept='CS' group by SC.cno,cname);


