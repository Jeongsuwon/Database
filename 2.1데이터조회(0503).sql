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
