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
--10.2 check - ���� ����
--10.3 unique - �ߺ�����
--10.4 primary key - unique + not null
--10.5 foreign key - �ܷ�Ű



