--11��. ��� ������

--�����ͺ��̽� �뵵, ���� ���� �ٸ�
--������ vs �����ͺ��̽� ������
--���̺�       ���̺�, ��, �Լ�, �ε���,...
--��
--�Լ�
--������
--���̺�
--Ʈ����

--11.1 �� (VIEW)
--��� �����Ͱ� �������� �ʴ� ���� ���̺�: �޸𸮿��� -> ������ �����ߴٰ� ������ ��� ��ȯ �� �Ҹ�
--���Ȱ� ����� ���Ǹ� ���� ���
--HR������ �⺻ �並 ��ȸ

SELECT *
FROM EMP_DETAILS_VIEW;

--���� EMP_DETAILS_VIEW�� SQL�� ����� �����_�� ������ü
SELECT *
FROM USER_VIEWS;

[����11-1] 80�� �μ��� �ٹ��ϴ� ������� ������ ��� v_emp80�� �並 ����
create or replace view v_emp80 as --�̹� ������? replace!
select employee_id as emp_id, first_name, last_name, email, hire_date
from employees
where department_id = 80;
-- with read only; --�б����� �� �����ɼ�: �並 ���� �����͸� ������ �� ������!!

--1. ���� ���̺� ������ ���� --> �信 ����?
desc employees;

insert into employees(employee_id, first_name, last_name, email, hire_date, job_id, salary, department_id)
values (207, 'Gildong', 'Hong', 'GILDONGHONG', sysdate, 'SA_REP', 6500, 80);

-- v-emp80 �並 ��ȸ: ȫ�浿�� �߰��Ǿ�����?
select *
from v_emp80;

--���: ���� ���̺� ������ ���� -> v_emp80�� ��ȸ�ϸ� �߰��� �����Ͱ� ��Ÿ��!

--2. �信 ������ ���� --> ���� ���̺� ����: employees

insert into v_emp80(emp_id, first_name, last_name, email, hire_date)
values(208, 'SUNSHIN', 'LEE', 'SUNSHINLEE', SYSDATE);
--����: ���� employees ���̺��� �ʼ��Է� �÷��� v_emp80���� �����ϱ�, Ȯ�ο� ��ü ��� ��

create or replace view v_emp_all as --�̹� ������? replace!
select *
from employees;


insert into employees(employee_id, first_name, last_name, email, hire_date, job_id, salary, department_id)
values (208, 'SUNSHIN', 'LEE', 'SUNSHINLEE', sysdate, 'SA_REP', 6600, 80);


rollback;

[����11-2] v_dept �並 ���� - �μ��ڵ�, �μ���, �����޿�, �ִ�޿�, ��ձ޿� ����
create or replace view v_dept as
select d.department_id, d.department_name,
        min(e.salary) as min_sal, max(e.salary) as max_sal, round(avg(e.salary)) as avg_sal
from employees e, departments d
where e.department_id = d.department_id
group by d.department_id, d.department_name
order by 1;

select *
from employees;

delete from employees where employee_id = 207;

commit;

[����11-3]
drop view v_dept;
drop view v_emp80;
drop view v_emp_all;
--�ٽ� ����� �ƴ϶�, v_dept�� �÷��� �߰�|�����Ǹ� create or replace ó��!

/* �� ������
    create [or replace] view ��� as
    select ����
    
    �� ����
    drop view ���;
    
*/


--11.2 ������
--�������� ��ȣ�� ������ �ʿ��� ��� sequence�� ����Ͽ�, �ڵ����� ������ִ� ���
--�ǻ��÷� currval, nextval�� ���� ��ȸ�ϰ� ����� �� �ִ�.

select *
from user_sequences; --�ý��� ���� ��: ������ ����� �� �ְ�~

/*
DEPARTMENTS_SEQ: �μ���� (10�� ���� --> 9990����)
EMPLOYEES_SEQ: ������ (1�� ���� --> 9999999999999999)
LOCATIONS_SEQ: �μ���ġ ���(100�� ���� --> 9900����)
*/

-- �� �������� �����? ������ �Է��� ������, Ư�� ������ ���� ����ص� �ʿ䰡 ��������.

/*
create sequence ��������
start with ���۰�
maxvalue �ִ밪
increment by ������
nocache | cache 
nocycle | cycle
*/

[����11-4]
create sequence emp_seq
start with 103
maxvalue 99999999
minvalue 1
increment by 1
nocache
nocycle;

select emp_seq.currval,
       emp_seq.nextval
from dual;

[����11-5] emp_test�� ������ ����
select *
from emp_test;

insert into emp_test
values(emp_seq.nextval, 'choi', 20, 'ST_CLERK');

SELECT *
FROM USER_CONSTRAINTS
WHERE TABLE_NAME='EMP_TEST';

--����: oracle database disable constraint
/*
alter table table_name
[ENABLE|DISABLE] constraint
   constraint_name;
*/

ALTER TABLE emp_test
DISABLE CONSTRAINT EMP_TEST_DEPT_ID_FK; --EMP_TEST�� �ɸ� det_test_id_fk�� ����

ALTER TABLE emp_test
ENABLE CONSTRAINT EMP_TEST_DEPT_ID_FK; --EMP_TEST�� �ɸ� det_test_id_fk�� ���� : �������ǰ� ���� �ʴ� �� ����
-- ORA-02298: ���� (HANUL.EMP_TEST_DEPT_ID_FK)�� ��� �����ϰ� �� �� ���� - �θ� Ű�� �����ϴ�
-- �ܷ�Ű �������� : 10,20,30 ������ ���� 230�� ������ ����!!

SELECT *
FROM    emp_test;

-- 117�� �̼��� 230�� �μ� --> 10~ 30�� �ϳ��� ���� �� �������� ENABLE

UPDATE emp_test
SET dept_id = 30
WHERE   emp_id = 117;

ALTER TABLE emp_test
ENABLE CONSTRAINT EMP_TEST_DEPT_ID_FK; --EMP_TEST�� �ɸ� det_test_id_fk�� ����

-- �������� ENABLE/DISABLE : �׽�Ʈ �Ҷ� ���� ����� ���� �ִ�.
-- ��, �ٽ� ���������� ENABLE �Ҷ� �׽�Ʈ �ϴ� ���̺� �������ǰ� ��ġ�ϴ� �����Ͱ� �ִ��� Ȯ��!

COMMIT;


-- 12.����Ŭ �����ͺ��̽� ��ü
-- 12.1 ������ ����/������ ��ųʸ� : �����ͺ��̽��� �߿��� ����, ��ü���� �����ϰ� �ִ� ��ü
-- ����Ŭ�̶�� �ý����� ����ϴ� ������ + ����� ������

-- 12.2 ������ ���� ��ȸ
SELECT *
FROM    dict;

SELECT *
FROM    dictionary;

-- ���̺�, �並 ������ �����ͺ��̽� ��ü ���� : ��������, �ε���, Ŭ������, �ó��(=���Ǿ�), ...
-- ���, �����ͺ��̽� �����ڰ� ���� ����
-- ����ڰ� Ȱ���ϴ� ������ ����ִ�.

-- ��ȸ�غ� �� �ִ� ������ ���� ���̺�/���� ����
-- 1) ALL_ �����ϴ� �� : ���� ������� ������ ��ȸ�� �� �ִ� ������
-- 2) DBA_ �����ϴ� �� : DBA ������ ������ ��ȸ
-- 3) USER_�����ϴ� �� : ������ ������ ���Ե� �����͸� ��ȸ
-- 4) v$ �����ϴ� �� : ����Ŭ �����ͺ��̽����� ����,Ư¡���� ������ ��ȸ

SELECT *
FROM    v$nls_parameters;

SELECT  *
FROM    all_tables
WHERE   owner = 'HANUL';

SELECT  *
FROM    all_objects
WHERE   owner = 'HANUL';

-- 12.3 �����ͺ��̽� ��ü ����
-- 1) ���̺�
-- 2) ��
-- 3) ������
-- 4) �Լ� : ����� ���� �Լ� vs MAX() ������~ MID() ����ڴٸ�!  ==> ��ȯ���� ����
-- 5) Ʈ���� : ��ȯ���� ���� �Լ�
-------------------- �����ڡ�   DBA �� ���� -----------------------------------------
-- 6) �ε��� : �˻� ���� ��󶧹���
-- 7) Ŭ������ :           "
-- 8) �ó�� : ��ü�� �Ǵٸ� �̸�(=����) ����
-- 9) ��Ű�� : PL/SQL�� �Լ��� Ʈ���ŵ��� �ѵ� ���� ����

/* 
[����URL] https://docs.oracle.com/en/database/oracle/oracle-database/21/lnpls/CREATE-TRIGGER-statement.html#GUID-AF9E33F1-64D1-4382-A6A4-EC33C36F237B
SQL vs PL/SQL - �Լ�, Ʈ����, ��Ű�� + �⺻ ���α׷��� ���� 
       Procedural Language + SQL : �������� ���α׷��� ��� + SQL ==> SQL���� ���α׷���!
       ����, ���, ������, ���ǹ�, �ݺ���...       
       I. �͸� ��(Anonymous Block)    /   II. �������α׷�(Named Block)
                                                - �Լ�
                                                - Ʈ����
*/       
       

-- Ʈ���� ���� : DML ó���� ����
CREATE OR REPLACE TRIGGER Ʈ���Ÿ�
[BEFORE | AFTER]
    INSERT OR 
    UPDATE OF salary, department_id OR  -- 2.� �۾��� �̷�����
    DELETE
  ON employees -- 1.� ���̺����� 
BEGIN
    -- 3. �Ʒ����� ������ ó���� �Ǵ� PL/SQL
    -- PL/SQL ����� : ����, ������, ���ǹ�, �ݺ��� ....
    -- ����ó���� : EXCEPTION 
END;

[���Ĺ��� ����] HR �������� ����
CREATE OR REPLACE TRIGGER t
  BEFORE | AFTER
    INSERT OR
    UPDATE OF salary, department_id OR
    DELETE
  ON employees
BEGIN
  CASE
    WHEN INSERTING THEN
      DBMS_OUTPUT.PUT_LINE('Inserting');
    WHEN UPDATING('salary') THEN
      DBMS_OUTPUT.PUT_LINE('Updating salary');
      -- ���� ó�� ����: ����� �޿����� ���̺�, ��������� �ڵ����� �Է�ó��
      INSERT INTO salary_changes (employee_id, salary_before, salary_after, reason)
      VALUES (��,��,��,��);      
      DBMS_OUTPUT.PUT_LINE('writing slarry change OK!');
      
    WHEN UPDATING('department_id') THEN
      DBMS_OUTPUT.PUT_LINE('Updating department ID');
    WHEN DELETING THEN
      DBMS_OUTPUT.PUT_LINE('Deleting');
  END CASE;
END;
/

 employees ������Ʈ --> salary 
 
 SELECT *
 FROM   employees; -- 205 Shelley �� �޿��� 12008 --> 12000 ���� ������Ʈ
 
-- DBMS_OUTPUT ��Ű�� : ȭ�鿡 ����ϴ� ����� ���� ---> .PUT_LINE()  : �ٹٲ޾��� �ؽ�Ʈ ���
-- SQL DEVELOPER ��� Ȯ�� ��, [���� > DBMS ���] â�� �����ؼ� Ȱ��ȭ ==> + ������ HR ���� ����!
UPDATE employees
SET salary = 12000
WHERE   employee_id = 205;

-- ���� �ڵ忡���� �ܼ� ��� �޽�����,
-- �����δ� Ư�� ���̺� ��������� �߰� �Է�, ��� �뵵�� Ȱ��
-- ex> �ֹ� ���̺� : ��ǰ�� ��� �ڵ����� ����   vs   ������ ���� ��� ������Ʈ �ؾ���!
-- ��SQLPLUS Ȯ���Ϸ���? SET SERVEROUTPUT ON | OFF;

DROP TRIGGER t;


-- 12.4 ����/����/����
-- CREATE ����
-- ALTER ����
-- DROP ����