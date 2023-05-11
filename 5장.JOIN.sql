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
-- �� ���̺��� ���� �÷� : department_id
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

-- 5.3 non-equi join
-- 5.4 outer join
-- 5.5 self join
-- 5.6 ansi join
-- 5.7 inner join
-- 5.8 outer join
