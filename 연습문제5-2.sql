[��������5-2]

1. ����� 110, 130, 150�� �ش��ϴ� ����� ���, �̸�, �μ����� ��ȸ�ϴ� �������� ansi join���� �ۼ�
select e.employee_id, e.first_name, d.department_name
from employees e inner join departments d
on e.department_id = d.department_id
and e.employee_id in(110, 130, 150);

2. ��� ����� ���, �̸�, �μ���, �����ڵ�, ���������� ��ȸ�Ͽ� ��� ������ �����ϴ� ����

select e.employee_id, e.first_name, d.department_name, j.job_title
from employees e inner join departments d
on e.department_id = d.department_id
inner join jobs j
on e.job_id = j.job_id
order by employee_id;