[연습문제3-5]

1. 사원의 사번, 이름, 업무, 업무등급을 조회하는 쿼리문을 DECODE 함수를 사용하여 작성한다.
단, 업무 등급은 다음과 같이 적용된다

-------------------
업무        등급
------------------
AD_PRES     A
ST_MAN      B
IT_PROG     C
SA_REP      D
ST_CLERK    E
기타        X
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


2. 사원의 사번, 이름, 입사일, 근무년수, 근속상태를 조회하는 쿼리문을 작성한다
단, 근무년수는 오늘 날짜를 기준으로 정수형태로 표기한다  ex> 3.56 ==> 3
근속상태는 근무년수   3년 미만  '3년 미만'
                      3년 ~ 5년  '3년근속'
                      5년 ~ 7년  '5년 근속'
                      8년 ~ 10년 '7년 근속'
                      10년~      '10년 이상 근속'
                      
select employee_id, first_name, hire_date, round(months_between(sysdate, hire_date)/12) as "근무년수", 
       case when round(months_between(sysdate, hire_date)/12) < 10 then '10년미만'
            when round(months_between(sysdate, hire_date)/12) between 12 and 15 then '12년근속'
            when round(months_between(sysdate, hire_date)/12) between 15 and 20 then '15년근속'
            when round(months_between(sysdate, hire_date)/12) between 20 and 23 then '20년근속'
            when round(months_between(sysdate, hire_date)/12) >=25 then '25년이상근속'
            end as "근속상태"
from employees;
                      
                      
                      