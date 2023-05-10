[��������3-5]

1. ����� ���, �̸�, ����, ��������� ��ȸ�ϴ� �������� DECODE �Լ��� ����Ͽ� �ۼ��Ѵ�.
��, ���� ����� ������ ���� ����ȴ�

-------------------
����        ���
------------------
AD_PRES     A
ST_MAN      B
IT_PROG     C
SA_REP      D
ST_CLERK    E
��Ÿ        X
------------------

select employee_id, first_name, job_id,
        decode(job_id, 'AD_PRES', 'A',
                       'ST_MAN', 'B',
                       'IT_PROG', 'C',
                       'SA_REP', 'D',
                       'ST_CLERK', 'E',
                    'X'
        ) 
        as job_grade
from employees;


2. ����� ���, �̸�, �Ի���, �ٹ����, �ټӻ��¸� ��ȸ�ϴ� �������� �ۼ��Ѵ�
��, �ٹ������ ���� ��¥�� �������� �������·� ǥ���Ѵ�  ex> 3.56 ==> 3
�ټӻ��´� �ٹ����   3�� �̸�  '3�� �̸�'
                      3�� ~ 5��  '3��ټ�'
                      5�� ~ 7��  '5�� �ټ�'
                      8�� ~ 10�� '7�� �ټ�'
                      10��~      '10�� �̻� �ټ�'
                      
select employee_id, first_name, hire_date, round(months_between(sysdate, hire_date)/12) as "�ٹ����", 
       case when round(months_between(sysdate, hire_date)/12) < 10 then '10��̸�'
            when round(months_between(sysdate, hire_date)/12) between 12 and 15 then '12��ټ�'
            when round(months_between(sysdate, hire_date)/12) between 15 and 20 then '15��ټ�'
            when round(months_between(sysdate, hire_date)/12) between 20 and 23 then '20��ټ�'
            when round(months_between(sysdate, hire_date)/12) >=25 then '25���̻�ټ�'
            end as "�ټӻ���"
from employees;
                      
                      
                      