[��������8-1]

1. EMP ���̺� (������) ������ ���� �����Ͻÿ�

desc emp;

insert into emp(emp_id, fname, lname, hire_date, salary)
values (400, 'Johns', 'Hopkins', to_date('2008/10/15', 'YYYY/MM/DD'), 5000);

insert into emp(emp_id, fname, lname, hire_date, salary)
values (401, 'Abraham', 'Lincoln', to_date('2010/03/03', 'YYYY/MM/DD'), 12500);

insert into emp(emp_id, fname, lname, hire_date, salary)
values (402, 'Tomas', 'Edison', to_date('2013/06/21', 'YYYY/MM/DD'), 7000);

2. EMP ���̺��� ��� 401�� ����� �μ��ڵ带 90����, �����ڵ带 SA_MAN���� ���� ��
   ������ ���� ������ Ȯ��
select * from emp;   

update emp set job_id = 'SA_MAN' where emp_id=401; 

commit;

3. EMP ���̺��� �޿��� 8000 �̸��� ��� ����� �μ��ڵ带 80���� ���� ��, �޿��� employees 
    ���̺��� 80�� �μ��� ��� �޿��� ������ ����(��, ��ձ޿��� �ݿø��� ���� ���)
   
update emp set dept_id = 80, salary = (select round(avg(salary),0) from employees where department_id=80)
where salary < 8000;    

4. emp ���̺��� 2010�� ���� �Ի��� ����� ������ ����
--to_char(hire_date, 'YYYY')
delete from emp where to_char(hire_date, 'YYYY') < '2010-01-01'; 