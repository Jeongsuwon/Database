-- 5��. JOIN(����)
-- ����Ŭ ������ �����ͺ��̽��̴� -> ���� : ���̺�� ���̺��� ����
-- (Relation, �����̼� - �����ͺ��̽� ������ �� ���̺��� �����̼��̶�� ��)
-- JOIN ���� ���̺��� �����Ͽ� (HR: 7��, ���� : n) �����͸� ��ȸ�Ѵ�.
-- ex) ��� ���̺� ~ �μ� ���̺� ���� : ��������� �μ�����(�μ��̸�, �μ���ġ�ڵ�)�� ��ȸ�� ��!

-- 5.1 cartesian product
-- Join ���� : �� �̻��� ���̺��� ���踦 ���� ��, ������ �Ǵ� �÷��� ����
-- Join ������ ������� ���� �� �߸��� ����� �߻��ϴµ�, �̰��� ī�׽þ� ��(=�ռ���)�̶�� ��.
-- ������ �ȳ� -> �����Ǵ� �����ͺ��� ���ٸ�, �ǽ�!

/*
select �÷���1, �÷���2,...
from ���̺��1, ���̺��2, ...
where Join����(��)
*/

[����5-1] ��� ���̺�� �μ� ���̺��� �̿��� ����� ������ ��ȸ�ϰ��� �Ѵ�. ���, ��, �μ� �̸��� ��ȸ
-- �ٸ� ���̺��� ���� ����� �ۼ�!!(������)

select employee_id, last_name, --�ֵ� ������ ��ȸ�Ϸ��� ���̺��� �÷�
       department_name --�ΰ����� ����
from employees, departments;


-- ������̺� ������/�� �� : 107
-- �μ����̺� ������/�� �� : 27
-- ī�׽þ� �� : 2889 -> 107*27

-- 5.2 equi join : �������(=)�� ����� JOIN ����(=��������)
-- �� ���̺��� ���� �÷� : department_id (manager_id : �μ����̺��� �ĺ���x)
-- ������ ������ ����� �����ؼ� ����� �ݿ� -> ����� �� ��� (��ü��� ����) -> outer join ó��!
-- ���̺��� �̿��� Join -> ��� ���̺� � �÷������� ���!
select e.employee_id, e.last_name, --�ֵ� ������ ��ȸ�Ϸ��� ���̺��� �÷�
       d.department_name --�ΰ����� ����
from employees e, departments d
where e.department_id = d.department_id;  --�������̺�.�����÷� = ������̺�.�����÷�

[����5-4] (������̺�, �������̺��� �̿���) ���, �̸�, �����ڵ�, �������� ������ ��ȸ
select e.employee_id, e.first_name, e.job_id, j.job_title
from employees e, jobs j
where e.job_id = j.job_id
order by e.employee_id;

[����5-5] (��� ���̺�, �μ����̺�, ���� ���̺��� �̿���) ���, �̸�, �μ���, �������� ������ ��ȸ
select e.employee_id, e.first_name, d.department_name, j.job_title
from employees e, departments d, jobs j
where e.department_id = d.department_id and e.job_id = j.job_id
order by e.employee_id;

desc jobs;
desc departments;
desc employees

-- where �������� join ���ǰ� �Ϲ� ������ �Բ� ����Ѵ�.
[����5-6] ����� 101���� ����� ���, �̸�, �μ���, �������� ������ ��ȸ�Ѵ�.
-- ���, �̸� : employees -> e, emp
-- �μ��� : departments -> d, dept
-- �������� : jobs -> j, job
-- �� ���̺��� ������ join ������ ���� : ���̺� ���� -1 (join������ ����)

select e.employee_id, e.first_name, d.department_name, j.job_title
from employees e, departments d, jobs j
where e.department_id = d.department_id and e.job_id = j.job_id and e.employee_id = 101;


-- 5.3 non-equi join (�������(=) �̿��� �����ȣ)
-- �񱳿�����
[����5-7] �޿��� ���� ������ ���� ���� �ִ� 10�� �μ����� ���, �̸�, �޿�, ���������� ��ȸ�Ѵ�.
-- �޿��� �ְ�, ������ : ��, ���� ����
select e.employee_id, e.first_name, e.salary, j.job_title
from employees e, jobs j
where e.salary >= j.min_salary
and e.salary <= j.max_salary
and e.department_id = 10;


-- 5.4 outer join : equi join �������� join�ϴ� ���̺� �������� �����Ǵ� ����
--                  ��������� ������� ��ȯ�Ѵ�. ������, outer join�� �����Ǵ� ����
--                  ���� ����� ������� ��ȯ(�����Ǵ� ���� ���� ���̺� �÷��� (+) ��ȣ ǥ��
[����5-8] ��� ����� ���, �̸�, �޿�, �μ��ڵ�, �μ��� ������ ��ȸ�Ѵ�.

select e.employee_id, e.first_name, e.salary, d.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id(+);

[����5-9] ��� ����� ���, �̸�, �޿�, �μ��ڵ�, �μ���, ��ġ�ڵ�, �����̸� ������ ��ȸ�Ѵ�.

select e.employee_id, e.first_name, e.salary, d.department_id, d.department_name, l.location_id, l.city
from employees e, departments d, locations l
where e.department_id = d.department_id(+)
and d.location_id = l.location_id(+)
order by e.employee_id;

-- 5.5 self join : �ϳ��� ���̺��� �� �� ����Ͽ�, ������ ���̺� �ΰ��κ��� join�� ����
--                 �����͸� ��ȸ�� ����� ��ȯ�Ѵ�.
-- 1) ������ ���̺��� �ΰ��ΰ� �� ������? (���������� ����Ǵ� ���� ����)
-- 2) �� �� ����Ѵ� (�޸𸮻�-�ӵ� ����! - ���������� �ߺ��� ������ ���� x,
--                                          ���̺��� �����ϴ� ��ó�� join ����

[����5-10] ����� ���, �̸�, �Ŵ����� ���, �Ŵ����� �̸� ������ ��ȸ.
select employee_id, first_name, manager_id
from employees;

--self join
select e.employee_id, e.first_name,
       m.employee_id manager, m.first_name
from employees e, employees m
where e.manager_id = m.employee_id
order by e.employee_id;


-- 5.6 ansi join
-- 5.6.1 inner join <--> ����Ŭ join���� inner join�� ���, equi-join
-- from���� inner join�� ����ϰ�, join ����(=where)�� on ���� ���

[����5-12] ����� ���, �̸�, �μ��ڵ�, �μ��� ������ ��ȸ�Ѵ�.

--����Ŭ join

select e.employee_id, e.first_name, d.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id(+)
and e.manager_id is not null
order by e.employee_id;

-- ansi inner join

select e.employee_id, e.first_name, d.department_id, d.department_name
from employees e inner join departments d --1) from ���� inner join�� ��� : , ���!
where e.department_id = d.department_id   --2) join ������ on ���� ǥ�� : where ���
and e.manager_id is not null
order by e.employee_id;



-- 5.8 outer join



