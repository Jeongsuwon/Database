[��������3-4]

1. ����� ���, �̸�, �μ�, �Ŵ�����ȣ�� ��ȸ�ϴ� �������� �ۼ��Ѵ�
(��, �Ŵ����� �ִ� ����� �Ŵ���, �Ŵ����� ���� ����� No Manager�� ǥ���ϵ��� �Ѵ�)

select employee_id, first_name, job_id, 
        nvl2(manager_id, to_char(manager_id), 'no manager') �Ŵ�����ȣ       
from employees;

select * from employees;