[��������6-2]

1. �μ���ġ�ڵ尡 1700�� �ش��ϴ� ��� ����� ���, �̸�, �μ��ڵ�, �����ڵ带 ��ȸ�ϴ� ��������
������ ���������� �ۼ��Ѵ�.

-- 1.1 �������� ���� ��ȸ
select employee_id, first_name, department_id, job_id
from employees
where department_id in ();


-- 1.2 ���������� ��ȸ
select employee_id, first_name, department_id, job_id
from employees
where department_id = any (select department_id from departments
                     where location_id = 1700);



2. �μ����� ���� �޿��� ���� �޴� ����� ���, �̸�, �μ���ȣ, �޿�, �����ڵ带 ��ȸ�ϴ� ��������
���� �÷� ���������� ����Ͽ� �ۼ��Ѵ�.

select employee_id, first_name, department_id, salary, job_id
from employees
where (department_id, salary) = any( select department_id, max(salary) from employees
                                group by department_id);
