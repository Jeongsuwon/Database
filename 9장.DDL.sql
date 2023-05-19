--9��. DDL

--Data Definition Language, �����ͺ��̽� ���Ǿ�
--1)���̺� ���� 2)�� 3)�ε���

--9.1 ������ Ÿ�� --> �����ͺ��̽��� ���̺� �÷� ���� �ڷ���, ����(Bytes)�� �˾ƾ� �ùٸ��� ����
--���� ���� ����ϴ� �ڷ���
--1) ������: �������� ������ char, �������� ������ varchar2
--       ��(������ �� ���� ������): nchar, nvarchar2        
--2) ������: ����, �Ǽ�
--3) ��¥��: ��¥
--��NLS ������ ���� �ٸ�
--���� > ȯ�漳�� > NLS �Ǵ� 
SELECT * FROM v$nls_parameters;

--9.1.1 ����(��)�� ������
--���� ����: char(����Ʈ ��) -> char(5): 5 bytes ���ڿ� �����ϴ� �÷��� ���̸� ����
--���� ����: varchar2(����Ʈ ��) -> varchar2(5) : ""
--�� 5byte �÷��� 3byte �Է��ϸ� -> 2byte ��ȯ x, �����Ͱ� ����� ������ ����Ŭ�� 
--                                                �����ϴ� ��ȣ�� �����ϴ� ����

--9.1.2 ������ ������
--int �÷� ���� -> number
--number(n): ���� n����Ʈ ���̷� ����
--number(p, s): ��ü���� p, ���� p-s����, �Ҽ� s ���̷� ����
--ex)number(5,2): ��ü���� 5, �������� 3, �Ҽ� 2

--9.1.3 ��¥�� ������
--date Ÿ��, ��¥�� �ð� ������ ���´�.

--DDL: �����ͺ��̽� ��ü�� ����(����, ����)�ϴ� ��ɾ� : create, alter, drop, truncate
--trunc(number | date): (�Ҽ��� ����) ������ �Լ�(����, ��¥)

--9.2 ���̺� ����
[����9-1] 3byte ���� id �÷�, 20byte ���� fname �÷����� �̷���� TMP ���̺� ����
create table tmp(
    id number(3),
    fname varchar(20)
);

drop table tmp;

[����9-2] tmp ���̺� ȫ�浿�� �̼����� �����͸� ����
insert into tmp(id, fname) values (1, 'ȫ�浿');
insert into tmp(id, fname) values (2, '�̼���');

[����9-3] id�� 1���� ����� name �÷��� �����͸� ȫ�浿 -> ȫ���� ����
update tmp set fname='ȫ��' where id=1;

[����9-4] �μ� ���̺� �����͸� �����Ͽ� dept1 ���̺�� ����(=����)�Ѵ�.
create table dept1 as
select *
from departments;

select * from dept1;
select * from emp20;
[����9-5] ��� ���̺��� 20�� �μ��� �Ҽӵ� ���, �̸�, �Ի��� �÷��� �����͸�
          �����Ͽ� emp20 ���̺��� �����Ѵ�.
          
create table emp20 as
select employee_id, first_name, hire_date
from employees where department_id=20;

[����9-6] �μ� ���̺��� ������ ���� dept2 ���̺��� �����Ͽ� ����
-- ��ġ�ϴ� ������ �����Ͱ� ���� ��� --> dept2 ���̺� ����: OK, ������: NO
-- CTAS�� WHERE ������ ��������!! -> �÷���, �ڷ����� �״�� ����, �����͸� ����!!
CREATE TABLE dept2 as
select *
from departments
where 1=2;



--9.3 ���̺� ���� ����
--9.3.1 �÷� �߰�: ������?�� null ä����
--���� ���̺� ���ο� �÷��� �߰��ϴ� ����
alter table ���̺�� add �÷��� �ڷ���(����);

[����9-7] emp20 ���̺� ����Ÿ�� �޿� �÷�(salary), ����Ÿ�� �����ڵ�(job_id) �÷��� �߰�
alter table emp20 add (salary number, job_id varchar2(10));

select * from emp20;

--9.3.2 �÷� ����(�̸�, ����, �ڷ���, ��������), ������ ���ǰ��ɼ�
--�÷���, ������ Ÿ��, ũ�⸦ �����ϴ� ����
alter table ���̺��
modify (�÷��� ������Ÿ��);

[����9-8] emp20 ���̺��� salary �÷��� job_id �÷��� ������ ũ�⸦ ���� ����
-- ����: salary number --> number(8, 2), job_id varchar2(5) --> 10byte
alter table emp20
modify (salary number(8, 2), job_id  varchar2(10));

insert into emp20 values (203, 'Steve', sysdate, 10000, 'sa_man');

alter table emp20
modify salary number(8,2);

--9.3.3 �÷� ���� : ������ ����
--���̺��� �÷��� �����ϴ� ����
alter table ���̺��
drop column �÷���;

[����9-9] emp20 ���̺��� �����ڵ� �÷� job_id �÷��� ����
alter table emp20
drop column job_id;

select * from emp20;

--9.4 ���̺� ����
drop table ���̺��;

--���� �ȵǰ� ���̺� ����: ������ ��ġ�� �ʰ� ������ ����(�����Ұ�)
drop table ���̺�� purge;

--���̺��� �̸��� ����
rename ������ ���̺�� to ����� ���̺��;


--9.5 ���̺� ������ ���� -> truncate
--���̺��� ������ ���ܵΰ�, ��� �� �����͸� ����
truncate table ���̺��;
