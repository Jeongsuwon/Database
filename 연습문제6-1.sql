[��������6-2]

1. �޿��� ���� ����~ ����� ���, �̸�, �μ�(��), �޿��� ��ȸ�Ѵ�.

select e.employee_id, e.first_name, e.last_name, d.department_name, e.salary
from employees e, departments d
where e.department_id = d.department_id
and e.salary = (select min(e.salary) from employees e);


2. �μ��� Marketing�� �μ��� ���� ��� ����� ���, �̸�, �μ��ڵ�, �����ڵ带 ��ȸ�ϴ� ����
select employee_id, first_name, department_id, job_id
from employees
where department_id = ( select department_id from departments where department_name = 'Marketing');

select * from employees;

3. ȸ���� ���庸�� �� ���� �Ի��� ������� ���, �̸�, �Ի����� ��ȸ�ϴ� �������� �ۼ�
-- ������ �׸� �����ϴ� �Ŵ����� ���� ����̴�.
select employee_id, first_name, hire_date
from employees
where hire_date < (select hire_date from employees where job_id = 'AD_PRES')
order by   3;
