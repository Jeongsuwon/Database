-- 8��. DML
-- 8.1 select : ������ ��ȸ --> DQL(Data Query Language) : Query ���� --> ��û
-- 8.2 insert : �� ������ ����
-- ��¥ �����ʹ� ��¥ ���� ����(YYYY-MM-DD, RR/MM/DD..)�� ����ؼ� ���� ����
[����8-1] emp ���̺� 300�� ��� �̸��� 'steven', ���� 'jobs'�� ����� ������ ���� ��¥ �������� ���
-- 1. emp ���̺� ����
create table emp(
    emp_id number,
    fname varchar2(30),
    lname varchar2(20),
    hire_date date default sysdate,
    job_id varchar2(20),
    salary number(9,2), --������(������: 7, �Ҽ���: 2) 
    comm_pct number(3,2), --������(������:1, �Ҽ���: 2)
    dept_id number
);

drop table emp;

--���̺� ���� �� Ȯ���ϴ� ��� 1)
select *
from user_tables --����� �������� ������ ���̺���� ����Ǵ� ���̺�(��ü)
where table_name='emp';

-- 2. �����͸� ����
-- 2.1 ���̺��� ���� ��ȸ : desc
desc emp;

insert into emp (emp_id, fname, lname, hire_date)
values (300, 'steven', 'jobs', sysdate);

select * from emp;

[����8-2] ����� 301�̰� �̸��� 'bill', ���� 'gate'�� ����� 2013�� 5�� 26���ڷ� emp ���̺� ����
insert into emp(emp_id, fname, lname, hire_date) values(301,'bill', 'gate', to_date('2013-05-26 10:00:00', 'yyyy-MM-dd hh:mi:ss')); 

--null �Ǵ� �� ���ڿ��� ����� �������� null ���� ����

[����8-3]
insert into department values(300, 'health services', null, null);

[����8-4]
insert into emp (emp_id, fname, lname, hire_date, job_id, salary)
values(302, 'warren', 'buffett', sysdate, '','');

--values �� ���� select���� ����� �������� ���̺�κ��� ���� ������ ���� ����, ���� ����
--insert���� ������ �÷� ��ϰ� select���� �÷� ��� ������ ��ġ

[����8-5]
insert into emp(emp_id, fname, lname, hire_date, job_id, dept_id)
select employee_id, first_name, last_name, hire_date, job_id, department_id
from employees
where department_id in (10, 20);

[����8-6] ���� �޿� ���� ���̺� �μ��ڵ� �� �����͸� ���� ����

create table month_salary(
    dept_id number,
    emp_count number,
    tot_sal number,
    avg_sal number
);

drop table month_salary;

insert into month_salary(dept_id, emp_count, tot_sal, avg_sal)
select department_id, count(*), sum(salary), round(avg(salary),2)
from employees
where department_id is not null
group by department_id
order by 1;

select * from month_salary;

[����8-7] ������̺��� �μ��ڵ尡 30���� 60���� �ش��ϴ� ������� ������ ��ȸ �� emp ���̺� ����
insert into emp
select employee_id, first_name, last_name, hire_date, job_id, salary, commission_pct, department_id 
from employees
where department_id between 30 and 60;

-- 8.3 update : ���� �����͸� ���� �� ����
[����8-8] emp ���̺��� ����� 300�� �̻��� ����� �μ��ڵ带 20���� ����
-- emp : ���� 300�� �̻� 3�� + employees ���̺� 30~60�� �μ��� 60�� -> 63��
update emp
set dept_id = 20
where emp_id >= 300;

[����8-9] ����� 300���� ����� �޿�, Ŀ�̼���, �����ڵ带 �����Ѵ�.
update emp
set salary = 2000,
    comm_pct = 0.1,
    job_id = 'it_prog'
where emp_id = 300;

--���������� �̿��� ������ ���� ����
--�����ڵ�, �޿�, Ŀ�̼��� -> ���� �÷� �������� -> update �� �� ���
[����8-11] emp ���̺� ��� 103�� ����� �޿��� employees ���̺��� 20�� �μ��� �ִ� �޿��� ����
update emp
set salary = ( select max(salary) from employees where department_id = 20)
where emp_id = 103;

[����8-12] emp ���̺� ��� 180�� ����� ���� �ؿ� �Ի��� ������� �޿��� employees ���̺� 50��
           �μ��� ��� �޿��� ����
update emp
set salary = (select round(avg(salary),1) from employees where department_id = 50)
where to_char(hire_date, 'yyyy') = (select to_char(hire_date, 'yyyy') from emp where emp_id = 180);
--SQL ����: ORA-00932: �ϰ��� ���� ������ ����: DATE��(��) �ʿ������� NUMBER��
--��ȯ�Լ��� �̿��� Ÿ���� ���������



create table month_salary2(
    dept_id number,
    emp_count number,
    tot_sal number,
    avg_sal number
);

drop table month_salary2;

insert into month_salary2(dept_id)
select department_id
from employees
where department_id is not null
group by department_id;

select * from month_salary2;

commit;

update month_salary2 m
set emp_count = (select count(*)
                from employees e
                where e.department_id = m.dept_id
                group by e.department_id),
    tot_sal =  (select sum(e.salary)
                from employees e
                where e.department_id = m.dept_id
                group by e.department_id),
    avg_sal =   (select avg(e.salary)
                from employees e
                where e.department_id = m.dept_id
                group by e.department_id);

[����8-14] month_salary2�� emp_count, tot_sal, avg_sal �÷��� �����÷� ���������� Ȱ����
           employees�� �μ��� ����� �����͸� ������Ʈ(��, �޿������ ������ ǥ��)
           
update month_salary2 m
set (emp_count, tot_sal, avg_sal) = ( select count(*),sum(salary),round(avg(salary))
                                     from employees e
                                     where e.department_id = m.dept_id
                                     group by e.department_id
                                     )

-- 8.4 delete : ���� �����͸� �����ϴ� ���
-- ���̺��� �� �����͸� �����ϴ� �⺻ ����
-- where ���� ���ǿ� ��ġ�ϴ� �� �����͸� ����(where �� ������ ��� �� �����Ͱ� ����)

[����8-15] emp���̺��� 60�� �μ��� ��� ������ ����
--��ȸ
select *
from emp
order by dept_id;

delete from emp where dept_id=60;

-- commit : �����͸� ����(�޸�) -> (�������� ������ġ��) �ݿ�
-- rollback : ������ ���� -> ��������� ����