select * from student where sdept='CS';
--1����ѯCSϵ�������20���ѧ�����г�ѧ�ţ��������Ա�
select sno,sname,ssex
from student
where sage>20 and sdept='CS';
commit;
--2����ѯѡ��'DB'�γ̵�ѧ����ѧ�š�
select sno from SC
where cno in(select cno from Course where cname='DB');


--3����ѯCSϵû��ѡ'DB'�γ̵�ѧ����ѧ�ţ�������ϵ��
select sno,sname,sdept
from Student
where not exists(select* from SC where sno=Student.sno 
and cno in(select cno from Course where cname='DB')) 
and sdept='CS';

--4����ѯ�У���m����ͬѧѡ����'DB'�γ̣�����û��ѡ'Oracle'�γ̵�ѧ�����г�ѧ�ţ�������(�γ���Ҫ���ִ�Сд)
select sno,sname from Student
where ssex='��' and sno in(select sno from SC where cno in(select cno from Course where cname='DB')) and sno not in(select sno from SC where cno in(select cno from Course where cname='Oracle'));


--1����ѯÿ��ѧ����ƽ���֣��г�ѧ����ѧ�ţ�ƽ���֣�����Ϊsavg��,����ƽ���ֽ������С�
select sno,avg(grade) as savg
from SC
group by sno
order by savg desc;

--2����ѯѡ���������ڵ���3�˵Ŀγ̣��г��γ̺ţ��γ�����ѡ������������Ϊscnt��,�����γ̺��������С�
select SC.cno,cname,count(sno) as scnt
from Course,SC
where Course.cno=SC.cno 
group by SC.cno,cname
having count(sno)>=3
order by SC.cno;



--3����ѯѡ���������Ŀγ̡��г��γ̺ţ��γ�����
select Course.cno,cname
from Course,SC
where Course.cno=SC.cno
group by Course.cno,cname
having count(sno)>=all(select count(sno) from SC group by SC.cno);

--4����ѯCSϵѡ���������Ŀγ̡��г��γ̺ţ��γ�����CSϵ��ѡ������������ΪCScnt����
select SC.cno,cname,count(Student.sno)as CScnt
from Course,SC,Student
where SC.sno=Student.sno and SC.cno=Course.cno and sdept='CS'
group by SC.cno,cname
having count(Student.sno)>=all(select count(Student.sno)from SC,Course,Student where SC.sno=Student.sno and SC.cno=Course.cno and sdept='CS' group by SC.cno,cname);


