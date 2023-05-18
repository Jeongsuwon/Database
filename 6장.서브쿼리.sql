--6��. ��������(p.51)

--�� SQL���� �ȿ� �����ϴ� �� �ٸ� SQL������ ����������� �Ѵ�.
--1) ���������� ��ȣ(, )�� ��� ����Ѵ�.
--2) ���������� ���Ե� �������� ���� ������� �Ѵ�.

-- ����Ŭ -> ��������
-- MSSQL -> T-SQL
-- ���� DBMS���� �ణ �ٸ� �̸�

[����6-1] ��ձ޿����� �� ���� �޿��� �޴� ����� ���, �̸�, �� ������ ��ȸ�Ѵ�.
select employee_id, first_name, last_name
from employees
where salary < (select avg(salary) from employees)
order by   1;

--������� : ���������� ���� ����ǰ� �� ���� �������� ����




--====================���� ������ ����=========================
--�������� ���� ����� ������ ���� ����
--6.1 ���� �� �������� : �ϳ��� ��� ���� ��ȯ�ϴ� ��������
-- -> ���� �� ������ ( =, >=, >, <, <=,<>,!=)
-- -> 4��. �׷� �Լ��� ����ϴ� ��찡 ����. (avg, sum, count, max, min)
[����6-2] �� �޿��� ���� ���� ����� ���, �̸�, �� ������ ��ȸ�Ѵ�.
select employee_id ���, first_name �̸�, last_name ��, salary �޿�
from employees
where salary = (select max(salary) from employees);

[����6-3] ��� 108���� �޿����� �� ���� �޿��� �޴� ����� ������ ��ȸ�Ѵ�.
select * 
from employees
where salary > ( select salary from employees where employee_id = 108);

[����6-4] ���޿��� ���� ���� ����� ���, �̸�, ��, �������� ������ ��ȸ
select e.employee_id, e.first_name, e.last_name, j.job_title
from employees e , jobs j
where  e.job_id = j.job_id and
e.salary = (select max(e.salary) from employees e);


--6.2 ���� �� ��������
-- 6.2 ���� �� ��������(p.53)
-- ���� �� ������ (IN, NOT, ANY(=SOME), ALL, EXISTS)

-- 6.2.1 IN ������
-- OR ������ ��� --> ����

[����6-5] �μ�(��ġ�ڵ�, location_id)�� ����(UK)�� �μ��ڵ�, ��ġ�ڵ�, �μ��� ���� ��ȸ

select department_id, location_id, department_name
from departments
where location_id in ( select location_id from locations where country_id = 'UK');

-- 2. ��������
SELECT  department_id, location_id, department_name
FROM    departments
--WHERE   location_id = (2400, 2500, 2600); 
WHERE   location_id = 2400
OR      location_id = 2500
OR      location_id = 2600;

-- 6.2.2 NOT ������
-- not in �����ڿ� <> all�� ���� ���
[����6-16] �μ����̺��� �μ��ڵ� 10, 20, 30, 40�� �ش����� �ʴ� �μ��ڵ带 ��ȸ
select department_id, department_name
from departments
where department_id not in (10, 20, 30, 40); 

select department_id, department_name
from departments
where department_id ^= all (10, 20, 30, 40);


-- 6.2.3 ANY(=SOME) ������
-- 6.2.4 ALL ������

-- WHERE    location_id IN (2400, 2500, 2600)
-- ORA-01797: �������� �ڿ� ANY �Ǵ� ALL�� ������ �ֽʽÿ�  ==> = ANY () �� = ALL () ���·� �ۼ�
-- 01797. 00000 -  "this operator must be followed by ANY or ALL"

--=============================================================================================
/*
1. any
=any : ��ġ�ϴ� �� �ϳ��� ������ true ���(�������� ���� ����� ���� ���� ��ȯ�� ��)
>any : (�������� ���࿡ ���� ��ȯ����� ���������) > �ּҰ�(min�Լ�)�� ����.
<any : (�������� ���࿡ ���� ��ȯ����� ���������) < �ּҰ�(min�Լ�)�� ����.
2. all
=all : (�������� ���࿡ ���� ��ȯ����� ���������) = ��� ����� ���ؼ� true���� �ϴ� ���� -> ����� �ȳ����� ���
>all : (�������� ���࿡ ���� ��ȯ����� ���������) > �ִ밪(max�Լ�) �� ����.
<all : (�������� ���࿡ ���� ��ȯ����� ���������) < �ִ밪(max�Լ�) �� ����.
*/

[����6-10] 100�� �μ��� ����� �޿����� ���� �޿��� �޴� ����� ���, �̸�, �μ���ȣ, �޿��� �޿��� ������������ ��ȸ
select department_id, count(*) as cnt
from employees
group by department_id
order by  1;

select employee_id, first_name, department_id, salary
from employees
where department_id = 100
order by  4;

select employee_id, first_name, department_id, salary
from employees
where salary > all ( select salary from employees where department_id = 100 ); --���� ����, ���� �� ��������



--6.3 (���� ��, ���� ��)���� �÷� ��������(p.57)
-- ���������� ��������ó�� ���� ���� �÷��� (���ϴµ�) ����� �� �ִ�.
-- where ���� (�÷��� 1, �÷��� 2,...) ó�� �ۼ�
-- �÷��� ������ ������ Ÿ���� ��ġ�ؾ� ��.
[����6-18] �Ŵ����� ���� ����� �Ŵ����� �ִ� �μ��ڵ�, �μ����� ��ȸ
-- ���������� ��� ��ȸ�� ����! -> ���������� ����� �� �˸�, ������ �����ϰ� ���� �� �ִ�.
select department_id, department_name
from departments
where (���÷�1, ���÷�2) �񱳿��� (�������� �����-�����÷�);

select department_id, department_name
from departments
where (department_id, manager_id) = ( select department_id, employee_id
                                       from employees
                                       where manager_id is null);

-- �����÷� �������� -> �� ���� �� �� �̻��� �÷��� ���ϴ� ��������

-- 6.3.1 EXISTS ������(��ȣ���������������� ���)
--��ȣ���� ��������(p.57)
--��ȣ: ���� ~ / ���� : ���� ~ ���� -> join���� vs set ����
--���������ε�, join������ Ȱ���� ��������! --> ���� ������ ���̺�� ���������� 
--                                              ���̺��� join ������ ���
--���������� �÷��� ���������� �������� ���Ǿ� ���������� ���������� ���� ����

[����6-19] �Ŵ����� �ִ� �μ��ڵ忡 �Ҽӵ� ������� ���� ��ȸ
select count(*)
from employees
where department_id = any (select department_id from employees
                        where manager_id is not null);

select count(*)
from employees e
where department_id in (select department_id from departments d
                        where manager_id is not null and nvl(e.department_id, 0) = d.department_id);

-- null ó���Լ� : nvl, nvl2                        

-- in �����ڸ� exists �����ڷ� �ٲ� ����� �� �ִ�.
--ORA-00920: ���� �����ڰ� �������մϴ� - > where�� �� �÷��� �������.
--exists �����ڸ� ����� ��, ���������� select��ϰ��� ������ ���� ���� �÷����� join ������ �ٽ�


select count(*)
from employees e
where exists (select department_id from departments d
                        where manager_id is not null and e.department_id = d.department_id);

-- ==================================================================================================
-- 1) �������� ����࿡ ���� ���� : ���� ��, ������, ���� �÷���
-- 2) �������� ���� ����(=JOIN���� ���) : ��ȣ���� ��������
-- 3) �������� �����ġ�� ���� ���� : ��Į�� ��������, �ζ��� �� ����������, (�Ϲ�, WHERE���� )����������
-- ==================================================================================================


--�������� �ۼ� ��ġ�� ���� ���� : ������ where���� �ۼ�/���
--6.5 ��Į�� �������� : select���� �ۼ�/���
--��Į�� : (����) ������ ���� �ʰ� ũ�⸸ ���� ����(1����) vs ���� : ũ��� ������ ��� ���� ����(2����)
--select���� ����ϴ� �������� -> select���� �÷�(�ϳ��ϳ�)�� �ۼ��ϴ� ��(��)
--�ڵ强 ���̺��� �ڵ�� ��ȸ�ϰų� �׷��Լ��� ��� ���� ��ȸ�� �� ���

[����6-22] ����� �̸�, �޿�, �μ��ڵ�, �μ����� ��ȸ
select first_name, salary, department_id,
        (select department_name from departments d
        where nvl(e.department_id, 0) = d.department_id)
        from employees e;

-- �ڵ强 ���̺�?? �μ���ձ޿��� ����� �� ������ ���̺� ����x, �ִ� ��ó�� ���������� ��ȸ
[����6-23] ����� ���, �̸�, �޿�, �μ��ڵ�, �μ���ձ޿�
select employee_id, first_name, salary, department_id,
        ( select round(avg(salary)) from employees e1
          where e1.department_id = e2.department_id) as avg_sal
        from employees e2;

--6.6 �ζ��� �� �������� : from���� �ۼ�/���
--from ���� ���Ǵ� �������� -> from���� ���̺� ���� -> �ζ��� �� ��������
--�� : ������ ���̺�(=�޸𸮿��� ����, ���� ���� �� �޸𸮿��� ����, ����� ��ȯ �� �����)
--select ���� ���Ǵ� �������� -> ��Į�� ��������
--���� ������ ������ -> ������ ���̺��̱⿡
--where ���� ���� ������ ���̺�� join�� ���� ���踦 �δ´�.
--> ������ where���� (�Ϲ�) ��������: ���� ���� ���!

[����6-24] �޿��� ȸ�� ��ձ޿� �̻��̰�, �ִ�޿� ������ ����� ���, �̸�, �޿�,
ȸ����ձ޿�, ȸ���ִ�޿��� ��ȸ
-- hr ����: ȸ���� ��� ���� ���̺� ���� x, �������� �ִ� ��ó�� �������� ��ȸ

select e.employee_id, e.first_name, e.salary,
       a.avg_sal, a.max_sal
from employees e, 
(select round(avg(salary)) as avg_sal, max(salary) as max_sal
from employees) a
where salary between avg_sal and max_sal;
--join ���� �� non-equi join ���� : = �̿��� ������
--���� ������� �ʴ� ����

[����6-25, 26] ���� �Ի� ��Ȳ ���̺��� ������, �ζ��� �� �������� ��������, ���� �Ի��� ��Ȳ ��ȸ
--�䱸�Ǵ� ���̺��� ����
--1�� ....6�� .... 12��
--14(��)..11(��)..7(��)
-- 1) ��� ���� �ϳ��̴�.
-- 2) �÷��� ���� 1~12������ 12��
-- 3) �����ʹ� ��� ���� �հ�
-- decode / �Լ�   vs case ~ end / ǥ����   <--------> ����Ŭ if ~ else��! --> �� �� �ٽ� ����غ���
-- ����񱳸�!           �����, ������

select decode(to_char(hire_date, 'MM'), '01', count(*), 0) as "1��",
       decode(to_char(hire_date, 'MM'), '02', count(*), 0) as "2��",
       decode(to_char(hire_date, 'MM'), '03', count(*), 0) as "3��",
       decode(to_char(hire_date, 'MM'), '04', count(*), 0) as "4��",
       decode(to_char(hire_date, 'MM'), '05', count(*), 0) as "5��",
       decode(to_char(hire_date, 'MM'), '06', count(*), 0) as "6��",
       decode(to_char(hire_date, 'MM'), '07', count(*), 0) as "7��",
       decode(to_char(hire_date, 'MM'), '08', count(*), 0) as "8��",
       decode(to_char(hire_date, 'MM'), '09', count(*), 0) as "9��",
       decode(to_char(hire_date, 'MM'), '10', count(*), 0) as "10��",
       decode(to_char(hire_date, 'MM'), '11', count(*), 0) as "11��",
       decode(to_char(hire_date, 'MM'), '12', count(*), 0) as "12��"
from employees 
group by to_char(hire_date, 'MM')
order by to_char(hire_date, 'MM');

--���������� �ζ��� �� �ǽ���
--���� -> ���輺 ���̺��� ���� db�� �ݿ��ϰ�, ��� �濵�ϴµ� �ʿ��� �����ͷ� �����ؼ� ����!

-- rownum �Ǵ� row_number() : ���̺� �������� �ʴ� �ǻ��÷����� select ���� where���� ���
-- �������� ����� �� �࿡ ���� ���� ��
--===============��ũ(����) ���� �Լ�=======================
--row_number() over (rank_clause) : �������� ǥ�� x
--dense_rank() : rank �Լ�ó�� ���� �Լ� -> ������ ǥ��o, ���� ���� ex) 1,1,2
--rank() : �Ϲ����� ��ũ(=����) �Լ� -> ������ ǥ�� o , ���� ����+1 ex) 1,1,3
--average_rank() : ��� ���� �̿��� ���� �Լ� -> ����Ŭ 21c������ ���� �ȵ�

[����6-27] ���, �̸��� 10�� ��ȸ
select rownum, employee_id, last_name
from employees
where rownum<=10;

[����6-28] �޿��� ���� ���� 10�� ����� ���, �̸�, �޿� ���� ��ȸ
select *
from (select employee_id, last_name, salary
        from employees
        order by salary desc)
where rownum <= 10;

--�����Լ��� ����� ��
select employee_id, last_name, salary,
        rank() over(order by salary desc) as salary_rank
from employees;













