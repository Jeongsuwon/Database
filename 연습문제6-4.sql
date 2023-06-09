[연습문제6-4]

1. 급여가 적은 상위 5명 사원의 순위, 사번, 이름, 급여를 조회하는 쿼리문을 인라인 뷰 서브쿼리로
작성한다.

select rownum, e.*
from ( select employee_id, first_name, salary from employees order by salary asc ) e
where rownum<=5;


2. 부서별로 가장 급여를 많이 받는 사원의 사번, 이름, 부서번호, 급여, 업무코드를 조회하는 쿼리문을
인라인 뷰 서브쿼리를 사용하여 작성한다.

select department_id, max(salary)
from employees
where department_id is not null
group by department_id
order by  1;
