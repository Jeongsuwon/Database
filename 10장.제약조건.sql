--10��. ��������

--���Ἲ ��������: �������� ��Ȯ���� �����ϱ� ���� �δ� ����/���� ����
--1) ���̺� ���� �� ����
--2) ���̺� ���� �� �߰�

--10.1 not null 
--���̺� ������ �÷� �������� ����
[����10-1] null_test��� ���̺��� �����ϵ� �÷��� col1 ����Ÿ�� 5����Ʈ ����,
          null ������� �ʰ�, col2 ����Ÿ�� 5����Ʈ ���̷� ����

create table null_test(
    col1 varchar2(5) not null, --�÷�����
    col2 varchar2(5)
);

[����10-2]
insert into null_test(col1)
values('AA');

[����10-3]
insert into null_test(col2)
values('BB');

select * from null_test;
--col1�� not null�̶� ���� �����

--========����� �������� ������(���̺���) ���������� ��� ��ϵ� ������ ���̺� ��ü==============
select*
from user_constraints
where table_name='NULL_TEST';

update null_test
set col2 = 'BB';

[����10-4]
alter table null_test
modify (col2 not null);

[����10-5]
alter table null_test
modify (col2 null);

update null_test
set col2 = 'bb';
commit;

--10.2 check - ���� ����(p.80)
--���ǿ� �´� �����͸� ������ �� �ֵ��� �ϴ� ��������
--�÷� ����, ���̺� �������� ����
--�÷� ����
--���̺� ����

--I.���̺� ���� �� �������� �߰�/����

[����10-6]
create table check_test(
    name varchar2(10) not null,
    gender varchar2(10) not null check(gender IN('����','����','male','female','man','woman')),
    salary number(8),
    dept_id number(4),
    constraint check_salary_ck check(salary>2000) --���̺� ����
);

select*
from user_constraints
where table_name = 'CHECK_TEST';


--���̺��_�÷���_�������� ���(NN: NOT NULL, CK: CHECK, PK: PRIMARY KEY, FK: FOREIGN, UK(UNIQUE KEY)

[����10-7] �����͸� check_test ���̺� �����غ��ÿ�

insert into check_test
values('ȫ�浿', '����', 3000, 10);

[����10-9]
update check_test
set salary=2000
where name='ȫ�浿'; --ORA-02290: üũ ��������(HANUL.CHECK_SALARY_CK)�� ����Ǿ����ϴ�

--II.���̺� ���� �� �������� �߰�/����
--����
[����10-10]
alter table check_test
drop constraint check_salary_ck;

--�ٽ� �߰�
[����10-11]
alter table check_test
add constraint check_salary_dept_ck check (salary between 2000 and 10000 and dept_id in(10,20,30));

[����10-12]
update check_test
set salary = 12000
where name='ȫ�浿'; --üũ ��������(HANUL.CHECK_SALARY_DEPT_CK)�� ����Ǿ����ϴ�

--10.3 unique - �ߺ�����
--�����Ͱ� �ߺ����� �ʵ��� ���ϼ��� �����ϴ� ��������
--�÷� ����, ���̺� �������� ����
--����Ű(Composite Key)�� ������ �� �ִ�. ��)���� ��� vs ���+�̸�
--primary key: unique + not null
--���̺� ������ unique ����
--I.�÷����� ����
[����10-13]
create table unique_test(
    col1    varchar2(5) unique not null,
    col2    varchar2(5),
    col3    varchar2(5) not null,
    col4    varchar2(5) not null,
    constraint uni_col2_uk unique(col2),
    constraint uni_col34_uk unique(col3, col4)
);

[����10-14]�ߺ� ���� �����ϴ��� �Է� �׽�Ʈ
insert into unique_test (col1, col2, col3, col4)
values('A1','B1','C1','D1');

insert into unique_test (col1, col2, col3, col4)
values('A2','B2','C2','D2');

SELECT * from unique_test;

[����10-15]������Ʈ �׽�Ʈ
update unique_test
set col1='A1'
where col1='A2'; --���Ἲ ���� ����(HANUL.SYS_C008375)�� ����˴ϴ�

desc unique_test;

[����10-16]������ �Է� �׽�Ʈ
insert into unique_test
values('A3', '', 'C3', 'D3');

insert into unique_test
values('A4', 'null', 'C4', 'D4');

--����������
select constraint_name, constraint_type
from user_constraints
where table_name = 'UNIQUE_TEST';

[����10-18] UNI-COL34_UK ���������� �����ϰ� col2,col3,col4�� UNIQUE ����Ű�� �����ϴ¡�
alter table unique_test
drop constraint uni_col34_uk;

[����10-19] UNI-COL234_UK �������� �߰�
alter table unique_test
add constraint uni_col234_uk unique(col2,col3,col4);

select *
from unique_test;

[����10-20]
insert into unique_test
values ('A7', null, 'C4', 'D4');

--10.4 primary key 
--������ ���� ��ǥ�ϵ��� �����ϰ� �ĺ��ϱ� ���� ��������
--unique + not null�� ����
--�÷�����, ���̺� �������� ���� �ں���Ű�ڸ� ������ �� �ִ�.

--I. �÷����� ����
�÷��� ������ Ÿ�� primary key : ��� --> sys_c008xxx
�÷��� ������ Ÿ�� constraint �������Ǹ� primary key --> ���̺��_�÷���_�������Ǿ��

--II. ���̺��� ����
constraint ���̺��_�÷���_�������Ǿ�� primary key(�÷���)

[����10-21] dept_test ���̺��� �����ϰ� dept_id, dept_name �÷� ���� ���� 4����Ʈ, �������� 30����Ʈ
������ �����ϵ� dept_name�� null�� ������� �ʰ�, dept_id�� �⺻Ű�� �����ϴ� ������ �ۼ�

create table dept_test(
    �÷��� ������ Ÿ�� �÷�����-��������,
    �÷��� ������ Ÿ��,
    ���̺���-��������
);

create table dept_test(
    dept_id number(4),
    dept_name varchar(30) not null,
    constraint dept_test_dept_id_pk primary key(dept_id)
);

[����10-22]
insert into dept_test values(10,'������');
insert into dept_test values(10,'���ߺ�');

[����10-23]
alter table dept_test
drop constraint dept_test_id_pk;

--10.5 foreign key - �ܷ�Ű(p.85)
--�θ� ���̺��� �÷��� �����ϴ� �ڽ� ���̺��� �÷���, �������� ���Ἲ�� �����ϱ� ���� ����
--null ���
--����Ű, �ܷ�Ű, FK
--�÷�����, ���̺������� ����, �ں���Ű�ڸ� ������ �� �ִ�.
--�÷��� ������ Ÿ�� references �θ����̺� (�����Ǵ� �÷���)
--�÷��� ������ Ÿ�� constranit �������Ǹ� references �θ����̺�(�����Ǵ� �÷���)

--���̺������� ����
--constraint ���̺��_�������Ǹ�_�������Ǿ�� foreign key (�����ϴ� �÷���) references �θ����̺� (�����Ǵ� �÷���)
--��� ���� ���̺� <---> �μ� ���� ���̺�
--����� �μ��� �Ҽӵȴ�(=����) N:1 [1:��] ���� : RDBMS���� ���� �⺻����
--�μ��� ����� �����Ѵ�(=����) 1:N [��:��] ���� : �����ؼ�
--HR ��Ű�� -> ���� �Ը��� �����ͺ��̽� -> ���ʿ� ����� ���̺� ����

--������ �𵨸�: �𵨷� -> ���̺� ����, �÷�, �������� ����
--������̺�
--�μ����̺� <--> � ȸ���� ������ �ľ�, �м� --> �����ͺ��̽� �ý��� ���� : ���� ����->������->��������
--�� �ۿ�...

--���θ� ����: ���θ� ���� �ľ�(��-��ǰ �ֹ�, ����, ȸ��-��ǰ ����, �߼�..)
--���伳��: ���� ���� �߿� Ű���带 ���� -> ��ƼƼ(=���̺�), �÷�(=Ư��)....
--������: �׸����� ��ü, Ư��, ���踦 ǥ���ϴ� ����
--��������: CREATE TABLE ~ ALTER TABLE~ INSERT INTO ~


--(���-�μ�) I.���伳��
--�� ������ ��� ���̺� : CUSTOMERS(��ID, ����, ����ó...)
--��ǰ ������ ��� ���̺� : ITEMS(��ǰID, ��ǰ��, ����)

--II.������
--������
---------------------------------------
��ID    ����    ����ó..
PK         NN
---------------------------------------
0001     ȫ�浿     010-1234-5645
0002     �̱浿
0003     �ڱ浿

--III.��������: SQL
CREATE TABLE CUSTOMERS(
    id number(4),
    name varchar2(20) not null,
    phone varchar2(11),
    constraint customers_id_pk primary key(id)
);

create table items(
    p_id number(4),
    p_type char(2) not null,
    p_born char(2) not null,
    regdate date,
    constraint items_p_id_pk primary key(p_id)
);

[����10-26] emp_test: employees ���̺��� �����ϰ�, �������� �Žÿ�.
create table emp_test(
    emp_id number(4) primary key,
    ename varchar2(30) not null,
    dept_id number(4),
    job_id varchar2(10),
    constraint emp_test_dept_fk foreign key (dept_id)
    references dept_test (dept_id)
);

--hanul ������ ����(ROLE)�� hr ������ �ִ� ���̺� ������ �� ���� ���¶��, ������ �߻�
--������ �ο�(DCL)�� �ʿ���.

select *
from dept_test;

[����10-27]
insert into emp_test (emp_id, ename, dept_id, job_id)
values (100, 'King', 10, 'ST_MAN');

insert into emp_test (emp_id, ename, dept_id, job_id) 
values (101, 'Kong', 30, 'AC_MG'); --�μ����̺� 30�� �μ��� �������� �ʴµ�, �Է� �õ�
--ORA-02291: ���Ἲ ��������(HANUL.EMP_TEST_DEPT_FK)�� ����Ǿ����ϴ�- �θ� Ű�� �����ϴ�
--30�� �μ������� dept_test�� �Է� �� ��������� ���Է� -> ����

insert into dept_test(dept_id, dept_name)
values (30, '�Ǹź�');

--���̺� ���� �� FK �߰�����
--�ϴ� ���� ������ --> ���� ���� �̸��� ����
SELECT constraint_name, constraint_type
from user_constraints
where table_name = 'EMP_TEST';

--EMP_TEST_DEPT_ID_FK�� ����
ALTER TABLE emp_test
DROP CONSTRAINT EMP_TEST_DEPT_ID_FK;

--�ٽ� ����: ���� ������ �����ϰ�(�����)
ALTER TABLE emp_test
add constraint emp_test_dept_id_fk foreign key (dept_id) references dept_test (dept_id);

--default
--�÷������� �����Ǵ� �Ӽ�, �����͸� �Է����� �ʾƵ� ������ ���� �⺻ �Էµǵ��� �Ѵ�.
--���������� �ƴ�����, �÷� �������� �ۼ�

[����10-30]
create table default_test(
    name varchar2(10) not null,
    hire_date date default sysdate not null,
    salary number(8) default 2500
);

insert into default_test (name, hire_date, salary)
values ('ȫ�浿', to_date('2023-05-22', 'YYYY-MM-DD'), 3000); 

insert into default_test (name)
values ('��浿');

select *
from default_test;

commit;