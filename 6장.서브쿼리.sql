--6장. 서브쿼리(p.51)

--※ SQL문장 안에 존재하는 또 다른 SQL문장을 서브쿼리라고 한다.
--1) 서브쿼리는 괄호(, )로 묶어서 사용한다.
--2) 서브쿼리가 포함된 쿼리문을 메인 쿼리라고 한다.

-- 오라클 -> 서브쿼리
-- MSSQL -> T-SQL
-- 각종 DBMS마다 약간 다른 이름

[예제6-1] 평균급여보다 더 적은 급여를 받는 사원의 사번, 이름, 성 정보를 조회한다.
select employee_id, first_name, last_name
from employees
where salary < (select avg(salary) from employees)
order by   1;

--실행순서 : 서브쿼리가 먼저 실행되고 그 다음 메인쿼리 실행




--====================서브 쿼리의 유형=========================
--서브쿼리 실행 결과의 갯수에 따른 구분
--6.1 단일 행 서브쿼리 : 하나의 결과 행을 반환하는 서브쿼리
-- -> 단일 행 연산자 ( =, >=, >, <, <=,<>,!=)
-- -> 4장. 그룹 함수를 사용하는 경우가 많다. (avg, sum, count, max, min)
[예제6-2] 월 급여가 가장 많은 사원의 사번, 이름, 성 정보를 조회한다.
select employee_id 사번, first_name 이름, last_name 성, salary 급여
from employees
where salary = (select max(salary) from employees);

[예제6-3] 사번 108번의 급여보다 더 많은 급여를 받는 사원의 정보를 조회한다.
select * 
from employees
where salary > ( select salary from employees where employee_id = 108);

[예제6-4] 월급여가 가장 많은 사원의 사번, 이름, 성, 업무제목 정보를 조회
select e.employee_id, e.first_name, e.last_name, j.job_title
from employees e , jobs j
where  e.job_id = j.job_id and
e.salary = (select max(e.salary) from employees e);


--6.2 다중 행 서브쿼리
[예제6-5] 부서(위치코드, location_id)가 영국(UK)인 부서코드, 위치코드, 부서명 정보 조회

select department_id, location_id, department_name
from departments
where location_id in ( select location_id from locations where country_id = 'UK');

--6.3 다중 컬럼 서브쿼리

--6.4 상호연관 서브쿼리

--서브쿼리 작성 위치에 따른 구분 : 보통은 where절에 작성/사용
--6.5 스칼라 서브쿼리 : select절에 작성/사용
--6.6 인라인 뷰 서브쿼리 : from절에 작성/사용