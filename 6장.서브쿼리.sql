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
-- 6.2 다중 행 서브쿼리(p.53)
-- 다중 행 연산자 (IN, NOT, ANY(=SOME), ALL, EXISTS)

-- 6.2.1 IN 연산자
-- OR 연산자 대신 --> 간결

[예제6-5] 부서(위치코드, location_id)가 영국(UK)인 부서코드, 위치코드, 부서명 정보 조회

select department_id, location_id, department_name
from departments
where location_id in ( select location_id from locations where country_id = 'UK');

-- 2. 서브쿼리
SELECT  department_id, location_id, department_name
FROM    departments
--WHERE   location_id = (2400, 2500, 2600); 
WHERE   location_id = 2400
OR      location_id = 2500
OR      location_id = 2600;

-- 6.2.2 NOT 연산자
-- not in 연산자와 <> all은 같은 기능
[예제6-16] 부서테이블에서 부서코드 10, 20, 30, 40에 해당하지 않는 부서코드를 조회
select department_id, department_name
from departments
where department_id not in (10, 20, 30, 40); 

select department_id, department_name
from departments
where department_id ^= all (10, 20, 30, 40);


-- 6.2.3 ANY(=SOME) 연산자
-- 6.2.4 ALL 연산자

-- WHERE    location_id IN (2400, 2500, 2600)
-- ORA-01797: 연산자의 뒤에 ANY 또는 ALL을 지정해 주십시오  ==> = ANY () 나 = ALL () 형태로 작성
-- 01797. 00000 -  "this operator must be followed by ANY or ALL"

--=============================================================================================
/*
1. any
=any : 일치하는 것 하나라도 있으면 true 결과(서브쿼리 실행 결과가 다중 행을 반환할 때)
>any : (서브쿼리 실행에 따른 반환결과가 결과적으로) > 최소값(min함수)과 같다.
<any : (서브쿼리 실행에 따른 반환결과가 결과적으로) < 최소값(min함수)과 같다.
2. all
=all : (서브쿼리 실행에 따른 반환결과가 결과적으로) = 모든 결과와 비교해서 true여야 하는 조건 -> 결과행 안나오는 경우
>all : (서브쿼리 실행에 따른 반환결과가 결과적으로) > 최대값(max함수) 과 같다.
<all : (서브쿼리 실행에 따른 반환결과가 결과적으로) < 최대값(max함수) 과 같다.
*/

[예제6-10] 100번 부서원 모두의 급여보다 높은 급여를 받는 사원의 사번, 이름, 부서번호, 급여를 급여의 오름차순으로 조회
select department_id, count(*) as cnt
from employees
group by department_id
order by  1;

select employee_id, first_name, department_id, salary
from employees
where department_id = 100
order by  4;

select employee_id, first_name, department_id, salary
from employees
where salary > all ( select salary from employees where department_id = 100 ); --서브 쿼리, 다중 행 서브쿼리



--6.3 (단일 행, 다중 행)다중 컬럼 서브쿼리(p.57)
-- 서브쿼리도 메인쿼리처럼 여러 개의 컬럼을 (비교하는데) 사용할 수 있다.
-- where 절에 (컬럼명 1, 컬럼명 2,...) 처럼 작성
-- 컬럼의 갯수와 데이터 타입이 일치해야 함.
[예제6-18] 매니저가 없는 사원이 매니저로 있는 부서코드, 부서명을 조회
-- 서브쿼리가 없어도 조회가 가능! -> 서브쿼리를 사용할 줄 알면, 절차를 간단하게 줄일 수 있다.
select department_id, department_name
from departments
where (비교컬럼1, 비교컬럼2) 비교연산 (서브쿼리 결과행-다중컬럼);

select department_id, department_name
from departments
where (department_id, manager_id) = ( select department_id, employee_id
                                       from employees
                                       where manager_id is null);

-- 다중컬럼 서브쿼리 -> 한 번에 두 개 이상의 컬럼을 비교하는 서브쿼리

-- 6.3.1 EXISTS 연산자(상호연관서브쿼리에서 사용)
--상호연관 서브쿼리(p.57)
--상호: 서로 ~ / 연관 : 관련 ~ 연결 -> join연산 vs set 연산
--서브쿼리인데, join연산을 활용한 서브쿼리! --> 메인 쿼리의 테이블과 서브쿼리의 
--                                              테이블간의 join 조건이 사용
--메인쿼리의 컬럼이 서브쿼리의 조건절에 사용되어 메인쿼리에 독립적이지 않은 형식

[예제6-19] 매니저가 있는 부서코드에 소속된 사원들의 수를 조회
select count(*)
from employees
where department_id = any (select department_id from employees
                        where manager_id is not null);

select count(*)
from employees e
where department_id in (select department_id from departments d
                        where manager_id is not null and nvl(e.department_id, 0) = d.department_id);

-- null 처리함수 : nvl, nvl2                        

-- in 연산자를 exists 연산자로 바꿔 사용할 수 있다.
--ORA-00920: 관계 연산자가 부적합합니다 - > where절 비교 컬럼이 없어야함.
--exists 연산자를 사용할 때, 서브쿼리의 select목록과는 무관한 메인 쿼리 컬럼과의 join 조건이 핵심


select count(*)
from employees e
where exists (select department_id from departments d
                        where manager_id is not null and e.department_id = d.department_id);

-- ==================================================================================================
-- 1) 서브쿼리 결과행에 따른 구분 : 단일 행, 다중행, 다중 컬럼☆
-- 2) 연관성에 따른 구분(=JOIN연산 사용) : 상호연관 서브쿼리
-- 3) 서브쿼리 사용위치에 따른 구분 : 스칼라 서브쿼리, 인라인 뷰 서브쿼리★, (일반, WHERE절에 )서브쿼리★
-- ==================================================================================================


--서브쿼리 작성 위치에 따른 구분 : 보통은 where절에 작성/사용
--6.5 스칼라 서브쿼리 : select절에 작성/사용
--스칼라 : (물리) 방향을 갖지 않고 크기만 갖는 개념(1차원) vs 벡터 : 크기와 방향을 모두 갖는 개념(2차원)
--select절에 사용하는 서브쿼리 -> select절은 컬럼(하나하나)을 작성하는 곳(절)
--코드성 테이블에서 코드명 조회하거나 그룹함수의 결과 값을 조회할 때 사용

[예제6-22] 사원의 이름, 급여, 부서코드, 부서명을 조회
select first_name, salary, department_id,
        (select department_name from departments d
        where nvl(e.department_id, 0) = d.department_id)
        from employees e;

-- 코드성 테이블?? 부서평균급여를 기록해 둔 물리적 테이블 존재x, 있는 것처럼 서브쿼리로 조회
[예제6-23] 사원의 사번, 이름, 급여, 부서코드, 부서평균급여
select employee_id, first_name, salary, department_id,
        ( select round(avg(salary)) from employees e1
          where e1.department_id = e2.department_id) as avg_sal
        from employees e2;

--6.6 인라인 뷰 서브쿼리 : from절에 작성/사용
--from 절에 사용되는 서브쿼리 -> from절은 테이블 나열 -> 인라인 뷰 서브쿼리
--뷰 : 가상의 테이블(=메모리에만 존재, 쿼리 실행 시 메모리에서 실행, 결과를 반환 후 사라짐)
--select 절에 사용되는 서브쿼리 -> 스칼라 서브쿼리
--메인 쿼리와 독립적 -> 별도의 테이블이기에
--where 절에 메인 쿼리의 테이블과 join을 통해 관계를 맺는다.
--> 보통은 where절에 (일반) 서브쿼리: 가장 많이 사용!

[예제6-24] 급여가 회사 평균급여 이상이고, 최대급여 이하인 사원의 사번, 이름, 급여,
회사평균급여, 회사최대급여를 조회
-- hr 계정: 회사의 평균 집계 테이블 존재 x, 가상으로 있는 것처럼 서브쿼리 조회

select e.employee_id, e.first_name, e.salary,
       a.avg_sal, a.max_sal
from employees e, 
(select round(avg(salary)) as avg_sal, max(salary) as max_sal
from employees) a
where salary between avg_sal and max_sal;
--join 연산 중 non-equi join 형식 : = 이외의 연산자
--거의 사용하지 않는 형식

[예제6-25, 26] 월별 입사 현황 테이블은 없지만, 인라인 뷰 서브쿼리 형식으로, 월별 입사자 현황 조회
--요구되는 테이블의 구조
--1월 ....6월 .... 12월
--14(명)..11(명)..7(명)
-- 1) 결과 행이 하나이다.
-- 2) 컬럼의 수는 1~12월까지 12개
-- 3) 데이터는 사원 수의 합계
-- decode / 함수   vs case ~ end / 표현식   <--------> 오라클 if ~ else문! --> 한 번 다시 상기해보기
-- 동등비교만!           동등비교, 범위비교

select decode(to_char(hire_date, 'MM'), '01', count(*), 0) as "1월",
       decode(to_char(hire_date, 'MM'), '02', count(*), 0) as "2월",
       decode(to_char(hire_date, 'MM'), '03', count(*), 0) as "3월",
       decode(to_char(hire_date, 'MM'), '04', count(*), 0) as "4월",
       decode(to_char(hire_date, 'MM'), '05', count(*), 0) as "5월",
       decode(to_char(hire_date, 'MM'), '06', count(*), 0) as "6월",
       decode(to_char(hire_date, 'MM'), '07', count(*), 0) as "7월",
       decode(to_char(hire_date, 'MM'), '08', count(*), 0) as "8월",
       decode(to_char(hire_date, 'MM'), '09', count(*), 0) as "9월",
       decode(to_char(hire_date, 'MM'), '10', count(*), 0) as "10월",
       decode(to_char(hire_date, 'MM'), '11', count(*), 0) as "11월",
       decode(to_char(hire_date, 'MM'), '12', count(*), 0) as "12월"
from employees 
group by to_char(hire_date, 'MM')
order by to_char(hire_date, 'MM');

--수업에서는 인라인 뷰 실습용
--업무 -> 집계성 테이블은 실제 db에 반영하고, 기업 경영하는데 필요한 데이터로 누적해서 관리!

-- rownum 또는 row_number() : 테이블에 존재하지 않는 의사컬럼으로 select 절과 where절에 사용
-- 쿼리문의 결과는 각 행에 대한 순서 값
--===============랭크(순위) 관련 함수=======================
--row_number() over (rank_clause) : 동순위는 표시 x
--dense_rank() : rank 함수처럼 순위 함수 -> 동순위 표시o, 다음 순위 ex) 1,1,2
--rank() : 일반적이 랭크(=순위) 함수 -> 동순위 표시 o , 다음 순위+1 ex) 1,1,3
--average_rank() : 평균 값을 이용한 순위 함수 -> 오라클 21c에서는 실행 안됨

[예제6-27] 사번, 이름을 10건 조회
select rownum, employee_id, last_name
from employees
where rownum<=10;

[예제6-28] 급여가 높은 상위 10명 사원의 사번, 이름, 급여 정보 조회
select *
from (select employee_id, last_name, salary
        from employees
        order by salary desc)
where rownum <= 10;

--순위함수를 사용할 떄
select employee_id, last_name, salary,
        rank() over(order by salary desc) as salary_rank
from employees;













