select * from employees;

 
select to_char(hire_date, 'yyyy') as "입사년도", count(*) "사원수" 
from employees group by to_char(hire_date, 'yyyy')
order by "입사년도";

select to_char(hire_date, 'MM') as "입사월", count(*) "사원수"
from employees group by to_char(hire_date, 'MM')
order by "입사월";

--사원 수가 많은 부서에 대해서
--년도별/월별 채용인원수 파악

--사원수가 많은 상위3위까지의 부서 조회

select * from employees;

select * 
from (select dense_rank() over(order by count(*) desc) rank, department_id, count(*) count
      from employees
      group by department_id) e
where rank <= 3
;


--순위, 부서코드, 부서명

select rank, department_id, '(TOP'|| rank || ')'|| department_name  department_name
from (select dense_rank() over(order by count(*) desc) rank, department_id, count(*) count
      from employees
      group by department_id) e left outer join departments d using(department_id)  
where rank <= 3
order by rank
;

--위 상위 부서(30,50,80,100)에 대해서만 월별 채용인원수 조회
--부서명, 입사월
select department_name, to_char(hire_date,'mm') unit
from employees e inner join
                    (select rank, department_id, '(TOP'|| rank || ')'|| department_name  department_name
                    from (select dense_rank() over(order by count(*) desc) rank, department_id, count(*) count
                          from employees
                          group by department_id) e left outer join departments d using(department_id)  
                    where rank <= 3) r using (department_id)
;

--세로 데이터행 --> 가로데이터행으로 변경:pivot
--가로 데이터행 --> 세로데이터행으로 변경:unpivot

--select 컬럼
--from (테이블,  인라인뷰서브쿼리로부터 데이터를 조회하는 select)
--pivot(집계함수(표현식) for 피벗대상컬럼 in (행으로 올릴 열))

select 5 "01월", 10 "02월", 15 "03월", 20 "04월", 3 "05월", 1 "06월",
       19 "07월", 17 "08월", 7 "09월", 9 "10월", 6 "11월", 2 "12월"
       from dual;


--열로 이루어진 데이터 행을 행으로 변환
select *
from (select 5 "01월", 10 "02월", 15 "03월", 20 "04월", 3 "05월", 1 "06월",
       19 "07월", 17 "08월", 7 "09월", 9 "10월", 6 "11월", 2 "12월"
       from dual)
unpivot (cnt for mm in("01월", "02월","03월","04월","05월","06월","07월","08월","09월","10월","11월","12월"))
;

--행으로 이루어진 데이터 행을 열로 변환
select*
from(select *
        from (select 5 "01월", 10 "02월", 15 "03월", 20 "04월", 3 "05월", 1 "06월",
                    19 "07월", 17 "08월", 7 "09월", 9 "10월", 6 "11월", 2 "12월"
              from dual)
        unpivot (cnt for mm in("01월", "02월","03월","04월","05월","06월","07월","08월","09월","10월","11월","12월")))
pivot(sum(cnt) for mm in ( '01월', '02월','03월','04월','05월','06월','07월','08월','09월','10월','11월','12월' ) )
;

--입사월별 사원수
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
pivot(count(*) for unit in('01' "01월", '02' "02월",'03' "03월",'04' "04월",'05' "05월",'06' "06월",'07' "07월",'08' "08월"
                            ,'09' "09월",'10' "10월",'11' "11월",'12' "12월" ))
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

--상위 3위 부서의 년도별 채용인원 수
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
pivot(count(*) for unit in('2001' "2001년", '2002' "2002년",'2003' "2003년",'2004' "2004년",'2005' "2005년",'2006' "2006년",'2007' "2007년",
                            '2008' "2008년",'2023' "2023년" ))
order by department_name
;

