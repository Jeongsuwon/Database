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
-- 두 테이블의 공통 컬럼 : department_id
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

-- 5.3 non-equi join
-- 5.4 outer join
-- 5.5 self join
-- 5.6 ansi join
-- 5.7 inner join
-- 5.8 outer join
