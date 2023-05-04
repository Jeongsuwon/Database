--�����Ͱ� ��� ���̺� ������ ��ȸ ���
--desc ���̺��;
--describe ���̺��;
--��, �ҹ��� �������� ����.
--�� ���� ����â [+] ������ ���� ���! (������ Ȯ��)

desc departments;
--������ ���̺��� ��� ��ȸ�غ�����!
select * from employees;
select * from countries;
select * from departments;
select * from job_history;
select * from jobs;
select * from locations;
select * from regions;
--2. �����͸� ��ȸ�ϴ� select
--select * from ���̺��;

--�� ���� ���ӿ��� �� ���̺��� ����Ŭ���ϰ�, [������] �÷��� Ŭ���ϸ� ���� ���

/*
HR ��Ű���� �ִ� ���̺�(=����Ŭ �����ͺ��̽� ��ü �� �ϳ�)
==========================================================
�̸�                  ����
----------------------------------------------------------

*/

-- 2.1 ���̺� ����
-- ����Ŭ(=�����ͺ��̽� ���� �ý���)�� �����͸� 2���� ����(ǥ, table�� ��� ����)�� �⺻������ ����
-- ���̺� : � ������ �ִµ� <--> �����ͺ��̽� : ����(Relation)
-- ex> (ȸ��) �μ� ���� ���̺�, ��� ���� ���̺�
-- �� Document : ��, �� ������ �ƴ� vs RDBMS : ���̺�(��, ��)

select * from employees where department_id=80;

select * from departments where department_id=80;

select department_id, department_name, location_id from departments where department_id = 80;
select department_id, department_name, location_id from departments where department_name = 'Sales'; --���ڴ� '�� �ۼ�, ��/�ҹ��� ����[��¥��]

/*
    where �������� �����ϴ� �׸��� �з�(p.5)
    1) �÷�, ����, ����
    2) ���������(+,-,*,/), �񱳿�����(=, <=, <, >, >=, <>) --MOD(����,������) : % ��� ����ϴ� �Լ�
    3) any, some, all
    4) exists
*/


--2.2 ������
--2.2.1 ���������
--��������ڴ� select ��ϰ� �������� ����� �� �ֽ��ϴ�.

select 2+2 as �� from dual; --���� �������� �ʴ� ���̺� dual, �ܼ��� �������, �ý��� ��¥ ���, �Լ��� ����, ��ȯ�� Ȯ��
select 2-1 as �� from dual;
--�ҹ��� ���̺������ �ۼ��Ϸ��� ������ �� "�ҹ���"�� ����� ó��!

select employee_id, last_name, salary ,salary*12 as ����, department_id 
from employees 
where salary*12>=200000; 

[����2-4] 80�� �μ� ����� �� �� ���� ���� �޿��� ��ȸ�Ѵ�.
select employee_id as ���, last_name as ��, salary * 12 as ����
from employees
where department_id=80;

--2.3.2 ���Ῥ����

[����2-5] �� �� ���� ���� �޿��� 120000�� ��������� ��ȸ�Ѵ�.
select employee_id, last_name, salary*12 || '$'  -- ���ڿ� ���� ������ : || , ���ڿ� ���� �Լ� -> CONCAT()
from employees                                   -- ���� ������, ���� ������ : '�� ����
where salary*12=120000;

[����2-6] ����� 101���� ����� ������ ��ȸ�Ѵ�.
select employee_id, last_name ||''|| first_name 
from employees 
where employee_id = 101;
--�μ� ��ȣ�� 90�� �μ�
select department_name 
from departments 
where department_id=90;

[����2-8] ����� 101���� ����� ���� �� �� ���� ���� �޿��� ��ȸ�Ѵ�.
select employee_id as ���, last_name ��, salary * 12 as "ANNUAL SALARY"
from employees
where employee_id=101;

--2.3.3 �񱳿����� (p.6)
--���� ũ�� ��
[����2-9] �޿��� 3000������ ����� ������ ��ȸ�Ѵ�.
select employee_id, last_name, salary, department_id
from employees
where salary<=3000;

[����2-10] �μ��ڵ尡 80�� �ʰ��� ����� ������ ��ȸ�Ѵ�.
--�μ��ڵ� : deparment_id
--����ڵ� : employee_id
--�����ڵ� : job_id
--�μ����ڵ� : manager_id

select *
from employees
where department_id>80;

-- ���� ������, ���� ������ : '�� ���� / ��ҹ��� ����
select *
from employees
where last_name = 'Chen'; --'chen' ����

select employee_id, last_name, hire_date
from employees
where hire_date>'05/09/28';

[����2-11] ���� King�� ����� ������ ��ȸ�Ѵ�.
select employee_id,last_name, email, phone_number, hire_date 
from employees
where last_name='King';

[����2-12] �Ի����� 2004�� 1�� 1�� ������ ����� ������ ��ȸ
select *
from employees
where hire_date<='04/01/01';









