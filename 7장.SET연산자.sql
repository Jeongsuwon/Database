-- 7��. SET ������(p.63)

-- 5�� JOIN����. ���̺�(�� �÷�)�� ���η� �����ϴ� ����
-- 7�� SET������. ���̺�(�� ������/��)�� ���η� �����ϴ� ����
-- �� SET �����ڷ� ���̴� �� SELECT ���� (1) �÷��� �� , (2) ������ Ÿ���� ��ġ�ؾ��Ѵ�.
-- ��ȸ�Ǵ� �÷����� ù ��° �������� �÷����� ���ȴ�.
-- ORDER BY ��� �������� ���� �������� ����Ѵ�.


-- 7.1 UNION: ������
-- ���տ��� �����տ� �ش��ϴ� ������, �ߺ��� ������ ���� ��� ��ȯ.
[����7-1]
SELECT 1, 3, 4, 5, 7, 8, 'A' AS FIRST -- ��ȸ�Ǵ� �÷����� ù ��° �������� �÷����� ���ȴ�.
FROM dual
UNION
SELECT 2, 4, 5, 6, 8, NULL, 'B' AS SECOND
FROM dual
UNION
SELECT 1, 3, 4, 5, 7, 8, 'A' AS THIRD -- ��ȸ�Ǵ� �÷����� ù ��° �������� �÷����� ���ȴ�.
FROM dual;

[����7-2] �����ǰ� �ִ� �μ�, �����ǰ� �ִ� ���� ������ ��ȸ�Ѵ�.
select department_id as code, department_name as name
from departments
union
select location_id, city
from locations;


-- 7.2 UNION ALL: ������
--UNION : �ߺ����� / UNION ALL : �ߺ�����
[����7-4]
SELECT 1, 3, 4, 5, 7, 8, 'A' AS FIRST -- ��ȸ�Ǵ� �÷����� ù ��° �������� �÷����� ���ȴ�.
FROM dual
UNION all
SELECT 2, 4, 5, 6, 8, NULL, 'B' AS SECOND
FROM dual
UNION all
SELECT 1, 3, 4, 5, 7, 8, 'A' AS THIRD -- ��ȸ�Ǵ� �÷����� ù ��° �������� �÷����� ���ȴ�.
FROM dual;


-- 7.3 INTERSECT: ������
[����7-7] 80�� �μ��� 50�� �μ��� �������� �ִ� ����� �̸� ��ȸ
select first_name as name
from employees
where department_id = 80
intersect
select first_name as name
from employees
where department_id = 50;


-- 7.4 MINUS: ������
[����7-9] 80�� �μ����� �̸����� 50�� �μ����� �̸��� ����
--�����ϰ� 80�� �μ����� �����ϴ� �̸� ��ȸ

select first_name
from employees
where department_id = 80
minus
select first_name
from employees
where department_id = 50;
