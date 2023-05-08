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

--2.3.4 ������ ������(p.8)
--������ ������ ���� ���� �� �� �ִ�.
--���� ������ ���� ��� ������ ���ǵ��� AND, OR �����ڸ� �̿��� �����Ѵ�.

[����2-13] 30�� �μ� ��� �� �޿��� 10000������ ����� ������ ��ȸ�Ѵ�.
--����� ������ : employees 
--employee_id ~ department_id : ���� ������� ���� �� � Ư�� �÷����� ����
--�μ� ������ departments�� ������, ������� �μ� 10~110������ �ҼӵǾ� ����

select employee_id, first_name ||' ' || last_name as name, salary,department_id
from employees
where department_id = 30 and salary<=10000;

[����2-14] 30�� �μ� ��� �� �޿��� 10000�����̰�, �Ի� ���ڰ� 2005�� ������ ����� ������ ��ȸ�Ѵ�.
select employee_id, first_name ||' ' || last_name as name, salary,department_id
from employees
where department_id = 30 and salary<=10000 and hire_date<'2005-01-01';

[����2-15] 30�� �μ��� 60�� �μ��� ���� ����� ������ ��ȸ�Ͻÿ�.
select first_name||' '|| last_name as name, salary, department_id as dept_id, hire_date
from employees
where (department_id = 30 or department_id = 60)and hire_date<'2005-01-01';

select first_name||' '|| last_name as name
from employees
where department_id=60 and hire_date<'2005-01-01';

--2.3.5 ���� ���� ������ between �ʱⰪ(�̻�) and ��������(����)
[���� 2-18] ��� 110������ 120�������� ��� ������ ��ȸ�Ѵ�.
select employee_id as emp_id, first_name ||' '|| last_name as name, salary, department_id as dept_id
from employees
where employee_id between 110 and 120;

[���� 2-18] ��� 110������ 120�������� ������ ��� ������ ��ȸ�Ѵ�.
select employee_id as emp_id, first_name ||' '|| last_name as name, salary, department_id as dept_id
from employees
where not employee_id between 110 and 120;

--between�̳� ���迬���ڷ� ���� �� �ִ� ���� ����, ����, ��¥ �������̴�.

--��¥ �������� ��ȯ�ϴ� �Լ� : TO_DATE('��¥������');
--RR/MM/DD �Ǵ� TO_DATE('��¥������', '�������� YY-MM-DD HH:MI:SS')
--3��. �Լ� - ��ȯ�Լ� ��Ʈ(p.27)

--2.3.7 IN ���ǿ�����(p.11)
--OR ������ ��� IN������ ==> ������, ���Ἲ

[����2-25] 30�� �μ��� �Ǵ� 60�� �μ��� �Ǵ� 90�� �μ����� ������ ��ȸ
select *
from employees
where department_id in(30,60,90);

--2.3.8 like ������(p.11)
--�÷��� �� Ư�� ���Ͽ� ���ϴ� ���� ��ȸ�� �� ����ϴ� ���ڿ� ���� ������
-- 1) % : ���� ���� ���ڿ��� ��Ÿ����.
-- 2) _ : �ϳ��� ���ڿ��� ��Ÿ����.

[����2-28] �̸��� K�� ���۵Ǵ� ��� ������ ��ȸ�Ѵ�.
select *
from employees
where first_name like 'K%';

[����2-28] ���� s�� ������ ��� ������ ��ȸ�Ѵ�.
select *
from employees
where last_name like '%s';

desc employees;
--varchar2(����) : ���� ������
--varchar(����) : �Ϲ����� �������� ��� x, ����Ŭ���� ����� ������ Ÿ�� -> �츮�� ��� x
--number(����) : ����
--number(�� ����, �Ҽ������� ����) : �Ǽ�
--date : ��¥

[����2-31] �̸����� ���� ° ���ڰ� B�� ��������� ��ȸ�Ѵ�.
select *
from employees
where email like '__B%';

[����2-31] �̸����� �ڿ��� ���� ° ���ڰ� B�� ��������� ��ȸ�Ѵ�.
select *
from employees
where email like '%B__';

--like ���� in, between �� ���� not �����ڿ� �Բ� ��� ����(p.14)

[����2-33] ��ȭ��ȣ�� 6���� ���۵��� �ʴ� ����� ������ ��ȸ�Ѵ�.
select *
from employees
where phone_number not like '6%';

--Q. %�� _ ��ü�� ���ڿ��� ǥ���ϰ��� �ϸ�?
[����2-34] job_id�� _A�� �� ��� ������ ��ȸ
select *
from employees
where job_id like '%_A%';

--2.3.9 NULL ���� ó��
select *
from locations
where state_province is null;

select *
from locations
where state_province is not null;

--is null : null�� �����͸� ��ȸ
--is not null : null�� �ƴ� �����͸� ��ȸ


--commission_pct : (�ŷ��� ����) ��������
--commission_pct�� not null�� ����! �⺻�� ����, �����Ḧ å���ؼ� �����ϴ� ����
--                     null�� ����! �Ǹźμ��� �ƴ�, �⺻ �޿��� ���ų�