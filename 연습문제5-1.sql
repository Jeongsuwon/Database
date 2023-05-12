[연습문제5-1]

1. 이름에 소문자 v가 포함된 모든 사원의 사번, 이름, 부서명을 조회하는 쿼리문을 작성한다.

select e.employee_id, e.first_name, d.department_name
from employees e, departments d
where e.department_id = d.department_id(+) -- 오라클 아우터 조인
and e.first_name like '%v%';



2. 커미션을 받는 사원의 사번, 이름, 급여, 커미션 금액, 부서명을 조회하는 쿼리문을 작성한다.
(단, 커미션 금액은 월급여에 대한 커미션 금액을 나타낸다)

select e.employee_id, e.first_name, e.salary, e.commission_pct * e.salary, d.department_name
from employees e, departments d;
where e.department_id = d.department_id(+) 
and e.commission_pct is not null;



3. 각 부서의 부서코드, 부서명, 위치코드, 도시명, 국가코드, 국가명을 조회하는 쿼리문을 작성한다.

select d.department_id, d.department_name, d.location_id, l.city, l.country_id, c.country_name
from departments d, locations l, countries c
where d.location_id = l.location_id(+)
and l.country_id = c.country_id(+)
order by department_id;



4. 사원의 사번, 이름, 업무코드, 매니저의 사번, 매니저의 이름, 매니저의 업무코드를 조회하여
사원의 사번 순서로 정렬하는 쿼리문을 작성한다.

select e.employee_id, e.first_name, e.job_id, m.employee_id, m.first_name, m.job_id
from employees e, employees m
where e.manager_id = m.employee_id;


5. 모든 사원의 사번, 이름, 부서명, 도시명, 도로주소 정보를 조회하여 사번 순으로 정렬하는
쿼리문을 작성한다.

select e.employee_id, e.first_name, m.employee_id, m.first_name
from employees e, employees m
where e.manager_id = m.employee_id
order by e.employee_id;

-- 오라클 join 연산
-- 1) 카테시안 곱 : 조인 조건절을 생략했을 때 ~ 잘못된 결과(너무 많은 결과행)
-- 2) equi_join(동등조인, =) <--> inner join(=내부 조인)
-- 3) non-equi join (비교연산자, between, in_ <--> equi-join(사용할 일이 거의 없다.)
-- 4) outer join (=외부조인) <--> inner join과 반대되는 개념
-- 5) self join : 하나의 테이블에 공통된 데이터 컬럼을 이용한 자기순환 참조 join

