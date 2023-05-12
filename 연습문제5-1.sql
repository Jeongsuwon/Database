[��������5-1]

1. �̸��� �ҹ��� v�� ���Ե� ��� ����� ���, �̸�, �μ����� ��ȸ�ϴ� �������� �ۼ��Ѵ�.

select e.employee_id, e.first_name, d.department_name
from employees e, departments d
where e.department_id = d.department_id(+) -- ����Ŭ �ƿ��� ����
and e.first_name like '%v%';



2. Ŀ�̼��� �޴� ����� ���, �̸�, �޿�, Ŀ�̼� �ݾ�, �μ����� ��ȸ�ϴ� �������� �ۼ��Ѵ�.
(��, Ŀ�̼� �ݾ��� ���޿��� ���� Ŀ�̼� �ݾ��� ��Ÿ����)

select e.employee_id, e.first_name, e.salary, e.commission_pct * e.salary, d.department_name
from employees e, departments d;
where e.department_id = d.department_id(+) 
and e.commission_pct is not null;



3. �� �μ��� �μ��ڵ�, �μ���, ��ġ�ڵ�, ���ø�, �����ڵ�, �������� ��ȸ�ϴ� �������� �ۼ��Ѵ�.

select d.department_id, d.department_name, d.location_id, l.city, l.country_id, c.country_name
from departments d, locations l, countries c
where d.location_id = l.location_id(+)
and l.country_id = c.country_id(+)
order by department_id;



4. ����� ���, �̸�, �����ڵ�, �Ŵ����� ���, �Ŵ����� �̸�, �Ŵ����� �����ڵ带 ��ȸ�Ͽ�
����� ��� ������ �����ϴ� �������� �ۼ��Ѵ�.

select e.employee_id, e.first_name, e.job_id, m.employee_id, m.first_name, m.job_id
from employees e, employees m
where e.manager_id = m.employee_id;


5. ��� ����� ���, �̸�, �μ���, ���ø�, �����ּ� ������ ��ȸ�Ͽ� ��� ������ �����ϴ�
�������� �ۼ��Ѵ�.

select e.employee_id, e.first_name, m.employee_id, m.first_name
from employees e, employees m
where e.manager_id = m.employee_id
order by e.employee_id;

-- ����Ŭ join ����
-- 1) ī�׽þ� �� : ���� �������� �������� �� ~ �߸��� ���(�ʹ� ���� �����)
-- 2) equi_join(��������, =) <--> inner join(=���� ����)
-- 3) non-equi join (�񱳿�����, between, in_ <--> equi-join(����� ���� ���� ����.)
-- 4) outer join (=�ܺ�����) <--> inner join�� �ݴ�Ǵ� ����
-- 5) self join : �ϳ��� ���̺� ����� ������ �÷��� �̿��� �ڱ��ȯ ���� join

