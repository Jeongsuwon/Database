-- 5장. JOIN(연산)
-- 오라클 관계형 데이터베이스이다 -> 관계 : 테이블과 테이블을 맺음
-- (Relation, 릴레이션 - 데이터베이스 설계할 때 테이블을 릴레이션이라고 함)
-- JOIN 여러 테이블을 연결하여 (HR: 7개, 업무 : n) 데이터를 조회한다.
-- ex) 사원 테이블 ~ 부서 테이블 연결 : 사원정보에 부서정보(부서이름, 부서위치코드)를 조회할 때!

-- 5.1 cartesian product
-- Join 조건 : 둘 이상의 테이블의 관계를 맺을 때, 기준이 되는 컬럼을 지정
-- Join 조건을 기술하지 않을 때 잘못된 결과가 발생하는데, 이것을 카테시안 곱(=합성곱)이라고 함.
-- 오류는 안남 -> 예측되는 데이터보다 많다면, 의심!

/*
select 컬럼명1, 컬럼명2,...
from 테이블명1, 테이블명2, ...
where Join조건(비교)
*/

[예제5-1] 사원 테이블과 부서 테이블을 이용해 사원의 정보를 조회하고자 한다. 사번, 성, 부서 이름을 조회
-- 다른 테이블은 행을 나누어서 작성!!(가독성)

select employee_id, last_name, --주된 내용을 조회하려는 테이블의 컬럼
       department_name --부가적인 정보
from employees, departments;


-- 사원테이블 데이터/행 수 : 107
-- 부서테이블 데이터/행 수 : 27
-- 카테시안 곱 : 2889 -> 107*27

-- 5.2 equi join : 동등연산자(=)를 사용해 JOIN 연산(=동등조인)
-- 두 테이블의 공통 컬럼 : department_id (manager_id : 부서테이블의 식별자x)
-- 누락된 데이터 행까지 포함해서 결과를 반영 -> 제대로 된 결과 (전체사원 기준) -> outer join 처리!
-- 테이블을 이용한 Join -> 어느 테이블에 어떤 컬럼인지를 명시!
select e.employee_id, e.last_name, --주된 내용을 조회하려는 테이블의 컬럼
       d.department_name --부가적인 정보
from employees e, departments d
where e.department_id = d.department_id;  --기준테이블.공통컬럼 = 대상테이블.공통컬럼

[예제5-4] (사원테이블, 업무테이블을 이용해) 사번, 이름, 업무코드, 업무제목 정보를 조회
select e.employee_id, e.first_name, e.job_id, j.job_title
from employees e, jobs j
where e.job_id = j.job_id
order by e.employee_id;

[예제5-5] (사원 테이블, 부서테이블, 업무 테이블을 이용해) 사번, 이름, 부서명, 업무제목 정보를 조회
select e.employee_id, e.first_name, d.department_name, j.job_title
from employees e, departments d, jobs j
where e.department_id = d.department_id and e.job_id = j.job_id
order by e.employee_id;

desc jobs;
desc departments;
desc employees

-- where 조건절에 join 조건과 일반 조건을 함께 사용한다.
[예제5-6] 사번이 101번인 사원의 사번, 이름, 부서명, 업무제목 정보를 조회한다.
-- 사번, 이름 : employees -> e, emp
-- 부서명 : departments -> d, dept
-- 업무제목 : jobs -> j, job
-- ※ 테이블의 갯수와 join 조건의 관계 : 테이블 갯수 -1 (join조건의 갯수)

select e.employee_id, e.first_name, d.department_name, j.job_title
from employees e, departments d, jobs j
where e.department_id = d.department_id and e.job_id = j.job_id and e.employee_id = 101;


-- 5.3 non-equi join (동등연산자(=) 이외의 연산기호)
-- 비교연산자
[예제5-7] 급여가 업무 상하한 범위 내에 있는 10번 부서원의 사번, 이름, 급여, 업무제목을 조회한다.
-- 급여의 최고, 최저선 : 상, 하한 범위
select e.employee_id, e.first_name, e.salary, j.job_title
from employees e, jobs j
where e.salary >= j.min_salary
and e.salary <= j.max_salary
and e.department_id = 10;


-- 5.4 outer join : equi join 쿼리문은 join하는 테이블간 공통으로 만족되는 값을
--                  가진경우의 결과만을 반환한다. 하지만, outer join은 만족되는 값이
--                  없는 경우의 결과까지 반환(만족되는 값이 없는 테이블 컬럼명에 (+) 기호 표시
[예제5-8] 모든 사원의 사번, 이름, 급여, 부서코드, 부서명 정보를 조회한다.

select e.employee_id, e.first_name, e.salary, d.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id(+);

[예제5-9] 모든 사원의 사번, 이름, 급여, 부서코드, 부서명, 위치코드, 도시이름 정보를 조회한다.

select e.employee_id, e.first_name, e.salary, d.department_id, d.department_name, l.location_id, l.city
from employees e, departments d, locations l
where e.department_id = d.department_id(+)
and d.location_id = l.location_id(+)
order by e.employee_id;

-- 5.5 self join : 하나의 테이블을 두 번 명시하여, 동일한 테이블 두개로부터 join을 통해
--                 데이터를 조회한 결과를 반환한다.
-- 1) 실제로 테이블을 두개인게 더 나을까? (물리적으로 저장되는 공간 낭비)
-- 2) 두 번 명시한다 (메모리상-속도 빠름! - 물리적으로 중복된 데이터 저장 x,
--                                          테이블이 존재하는 것처럼 join 연산

[예제5-10] 사원의 사번, 이름, 매니저의 사번, 매니저의 이름 정보를 조회.
select employee_id, first_name, manager_id
from employees;

--self join
select e.employee_id, e.first_name,
       m.employee_id manager, m.first_name
from employees e, employees m
where e.manager_id = m.employee_id
order by e.employee_id;


-- 5.6 ansi join
-- 5.6.1 inner join <--> 오라클 join에서 inner join은 사실, equi-join
-- from절에 inner join을 사용하고, join 조건(=where)은 on 절에 명시

[예제5-12] 사원의 사번, 이름, 부서코드, 부서명 정보를 조회한다.

--오라클 join

select e.employee_id, e.first_name, d.department_id, d.department_name
from employees e, departments d
where e.department_id = d.department_id(+)
and e.manager_id is not null
order by e.employee_id;

-- ansi inner join

select e.employee_id, e.first_name, d.department_id, d.department_name
from employees e inner join departments d --1) from 절에 inner join을 사용 : , 대신!
where e.department_id = d.department_id   --2) join 조건은 on 절에 표시 : where 대신
and e.manager_id is not null
order by e.employee_id;



-- 5.8 outer join



