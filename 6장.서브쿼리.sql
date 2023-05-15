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
[����6-5] �μ�(��ġ�ڵ�, location_id)�� ����(UK)�� �μ��ڵ�, ��ġ�ڵ�, �μ��� ���� ��ȸ

select department_id, location_id, department_name
from departments
where location_id in ( select location_id from locations where country_id = 'UK');

--6.3 ���� �÷� ��������

--6.4 ��ȣ���� ��������

--�������� �ۼ� ��ġ�� ���� ���� : ������ where���� �ۼ�/���
--6.5 ��Į�� �������� : select���� �ۼ�/���
--6.6 �ζ��� �� �������� : from���� �ۼ�/���