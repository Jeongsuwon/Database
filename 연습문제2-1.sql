/* ===================================================
   [�������� 2-1] (p.18)
   �� HR �������� �ǽ��ϼ���!
=================================================== */

1. ����� 200�� ����� �̸��� �μ���ȣ�� ��ȸ�ϴ� �������� �ۼ��Ѵ�.
desc employees;

select first_name||' '||last_name, department_id
from employees
where employee_id=200;

2. �޿��� 3000���� 15000 ���̿� ���Ե��� �ʴ� ����� ���, �̸�, �޿� ������ ��ȸ�ϴ� �������� �ۼ��Ѵ�.
(��, �̸��� ���� �̸��� ���鹮�ڸ� �ξ� ���ļ� ��ȸ�Ѵ�. ������� �̸��� John �̰�, ���� Seo�̸� 
John Seo�� ��ȸ�Ѵ�)

select employee_id,first_name||' '||last_name as name, salary
from employees
where not salary between 3000 and 15000;



3. �μ���ȣ 30�� 60�� �Ҽӵ� ����� ���, �̸�, �μ���ȣ, �޿��� ��ȸ�ϴµ� �̸��� ���ĺ� ������ �����Ͽ�
��ȸ�ϴ� �������� �ۼ��Ѵ�.
select employee_id, first_name, department_id, salary
from employees
order by first_name;



4. �޿��� 3000���� 15000 ���̸鼭, �μ���ȣ�� 30 �Ǵ� 60�� �Ҽӵ� ����� ���, �̸�, �޿��� ��ȸ�ϴ�
�������� �ۼ��Ѵ�(��, ��ȸ�Ǵ� �÷����� ���� �̸��� ������ �ξ� ���� name����, �޿��� Monthly Salary��)

select employee_id, first_name||' '||last_name as name, salary as "Monthly Salary"
from employees
where (salary between 3000 and 15000) and department_id in(30,60); 



5. �Ҽӵ� �μ���ȣ�� ���� ����� ���, �̸�, ����ID�� ��ȸ�ϴ� �������� �ۼ��Ѵ�.

select employee_id, first_name, job_id
from employees
where department_id is null;


6. Ŀ�̼��� �޴� ����� ���, �̸�, �޿�, Ŀ�̼��� ��ȸ�ϴµ� Ŀ�̼��� ���� ������� ���� ��� ������
�����Ͽ� ��ȸ�ϴ� �������� �ۼ��Ѵ�.
select employee_id, first_name, salary, commission_pct
from employees
where commission_pct is not null
order by commission_pct desc;



7. �̸��� ���� z�� ���Ե� ����� ����� �̸��� ��ȸ�ϴ� �������� �ۼ��Ѵ�.
select employee_id, first_name
from employees
where first_name like '%z%';

