[��������6-4]

1. �޿��� ���� ���� 5�� ����� ����, ���, �̸�, �޿��� ��ȸ�ϴ� �������� �ζ��� �� ����������
�ۼ��Ѵ�.

select rownum, e.*
from ( select employee_id, first_name, salary from employees order by salary asc ) e
where rownum<=5;


2. �μ����� ���� �޿��� ���� �޴� ����� ���, �̸�, �μ���ȣ, �޿�, �����ڵ带 ��ȸ�ϴ� ��������
�ζ��� �� ���������� ����Ͽ� �ۼ��Ѵ�.

select department_id, max(salary)
from employees
where department_id is not null
group by department_id
order by  1;
