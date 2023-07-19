select * from employees;

 
select to_char(hire_date, 'yyyy') as "�Ի�⵵", count(*) "�����" 
from employees group by to_char(hire_date, 'yyyy')
order by "�Ի�⵵";

select to_char(hire_date, 'MM') as "�Ի��", count(*) "�����"
from employees group by to_char(hire_date, 'MM')
order by "�Ի��";

--��� ���� ���� �μ��� ���ؼ�
--�⵵��/���� ä���ο��� �ľ�

--������� ���� ����3�������� �μ� ��ȸ

select * from employees;

select * 
from (select dense_rank() over(order by count(*) desc) rank, department_id, count(*) count
      from employees
      group by department_id) e
where rank <= 3
;


--����, �μ��ڵ�, �μ���

select rank, department_id, '(TOP'|| rank || ')'|| department_name  department_name
from (select dense_rank() over(order by count(*) desc) rank, department_id, count(*) count
      from employees
      group by department_id) e left outer join departments d using(department_id)  
where rank <= 3
order by rank
;

--�� ���� �μ�(30,50,80,100)�� ���ؼ��� ���� ä���ο��� ��ȸ
--�μ���, �Ի��
select department_name, to_char(hire_date,'mm') unit
from employees e inner join
                    (select rank, department_id, '(TOP'|| rank || ')'|| department_name  department_name
                    from (select dense_rank() over(order by count(*) desc) rank, department_id, count(*) count
                          from employees
                          group by department_id) e left outer join departments d using(department_id)  
                    where rank <= 3) r using (department_id)
;

--���� �������� --> ���ε����������� ����:pivot
--���� �������� --> ���ε����������� ����:unpivot

--select �÷�
--from (���̺�,  �ζ��κ伭�������κ��� �����͸� ��ȸ�ϴ� select)
--pivot(�����Լ�(ǥ����) for �ǹ�����÷� in (������ �ø� ��))

select 5 "01��", 10 "02��", 15 "03��", 20 "04��", 3 "05��", 1 "06��",
       19 "07��", 17 "08��", 7 "09��", 9 "10��", 6 "11��", 2 "12��"
       from dual;


--���� �̷���� ������ ���� ������ ��ȯ
select *
from (select 5 "01��", 10 "02��", 15 "03��", 20 "04��", 3 "05��", 1 "06��",
       19 "07��", 17 "08��", 7 "09��", 9 "10��", 6 "11��", 2 "12��"
       from dual)
unpivot (cnt for mm in("01��", "02��","03��","04��","05��","06��","07��","08��","09��","10��","11��","12��"))
;

--������ �̷���� ������ ���� ���� ��ȯ
select*
from(select *
        from (select 5 "01��", 10 "02��", 15 "03��", 20 "04��", 3 "05��", 1 "06��",
                    19 "07��", 17 "08��", 7 "09��", 9 "10��", 6 "11��", 2 "12��"
              from dual)
        unpivot (cnt for mm in("01��", "02��","03��","04��","05��","06��","07��","08��","09��","10��","11��","12��")))
pivot(sum(cnt) for mm in ( '01��', '02��','03��','04��','05��','06��','07��','08��','09��','10��','11��','12��' ) )
;

--�Ի���� �����
select *
from(select to_char(hire_date, 'mm') mm from employees)
pivot(count(*) for mm in ( '01', '02','03','04','05','06','07','08','09','10','11','12' ))
;


select *
from(
    select department_name, to_char(hire_date,'mm') unit
    from employees e inner join
                (select rank, department_id, '(TOP'|| rank || ')'|| department_name  department_name
                from (select dense_rank() over(order by count(*) desc) rank, department_id, count(*) count
                      from employees
                      group by department_id) e left outer join departments d using(department_id)  
                where rank <= 3) r using (department_id)
    )
pivot(count(*) for unit in('01' "01��", '02' "02��",'03' "03��",'04' "04��",'05' "05��",'06' "06��",'07' "07��",'08' "08��"
                            ,'09' "09��",'10' "10��",'11' "11��",'12' "12��" ))
order by department_name
;
    
    
2001
2002
2003
2004
2005
2006
2007
2008
2023

--���� 3�� �μ��� �⵵�� ä���ο� ��
select *
from(
    select department_name, to_char(hire_date,'yyyy') unit
    from employees e inner join
                (select rank, department_id, '(TOP'|| rank || ')'|| department_name  department_name
                from (select dense_rank() over(order by count(*) desc) rank, department_id, count(*) count
                      from employees
                      group by department_id) e left outer join departments d using(department_id)  
                where rank <= 3) r using (department_id)
    )
pivot(count(*) for unit in('2001' "2001��", '2002' "2002��",'2003' "2003��",'2004' "2004��",'2005' "2005��",'2006' "2006��",'2007' "2007��",
                            '2008' "2008��",'2023' "2023��" ))
order by department_name
;

