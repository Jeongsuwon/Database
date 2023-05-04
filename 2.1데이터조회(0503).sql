--데이터가 담긴 테이블 구조를 조회 명령
--desc 테이블명;
--describe 테이블명;
--대, 소문자 구분하지 않음.
--※ 왼쪽 접속창 [+] 누르면 같은 기능! (구조를 확인)

desc departments;
--나머지 테이블을 모두 조회해보세요!
select * from employees;
select * from countries;
select * from departments;
select * from job_history;
select * from jobs;
select * from locations;
select * from regions;
--2. 데이터를 조회하는 select
--select * from 테이블명;

--※ 왼쪽 접속에서 각 테이블을 더블클릭하고, [데이터] 컬럼을 클릭하면 같은 기능

/*
HR 스키마에 있는 테이블(=오라클 데이터베이스 객체 중 하나)
==========================================================
이름                  정보
----------------------------------------------------------

*/

-- 2.1 테이블 구조
-- 오라클(=데이터베이스 관리 시스템)이 데이터를 2차원 구조(표, table의 행과 열로)로 기본적으로 저장
-- 테이블 : 어떤 정보가 있는데 <--> 데이터베이스 : 관계(Relation)
-- ex> (회사) 부서 정보 테이블, 사원 정보 테이블
-- ※ Document : 행, 열 구조가 아님 vs RDBMS : 테이블(행, 열)

select * from employees where department_id=80;

select * from departments where department_id=80;

select department_id, department_name, location_id from departments where department_id = 80;
select department_id, department_name, location_id from departments where department_name = 'Sales'; --문자는 '로 작성, 대/소문자 구분[날짜도]

/*
    where 조건절을 구성하는 항목의 분류(p.5)
    1) 컬럼, 숫자, 문자
    2) 산술연산자(+,-,*,/), 비교연산자(=, <=, <, >, >=, <>) --MOD(제수,피제수) : % 대신 사용하는 함수
    3) any, some, all
    4) exists
*/


--2.2 연산자
--2.2.1 산술연산자
--산술연산자는 select 목록과 조건절에 사용할 수 있습니다.

select 2+2 as 합 from dual; --실제 존재하지 않는 테이블 dual, 단순히 산술연산, 시스템 날짜 출력, 함수를 실행, 반환값 확인
select 2-1 as 차 from dual;
--소문자 테이블명으로 작성하려면 생성할 때 "소문자"로 명령을 처리!

select employee_id, last_name, salary ,salary*12 as 연봉, department_id 
from employees 
where salary*12>=200000; 

[예제2-4] 80번 부서 사원의 한 해 동안 받은 급여를 조회한다.
select employee_id as 사번, last_name as 성, salary * 12 as 연봉
from employees
where department_id=80;

--2.3.2 연결연산자

[예제2-5] 한 해 동안 받은 급여가 120000인 사원정보를 조회한다.
select employee_id, last_name, salary*12 || '$'  -- 문자열 연결 연산자 : || , 문자열 연결 함수 -> CONCAT()
from employees                                   -- 문자 데이터, 숫자 데이터 : '로 묶음
where salary*12=120000;

[예제2-6] 사번이 101번인 사원의 성명을 조회한다.
select employee_id, last_name ||''|| first_name 
from employees 
where employee_id = 101;
--부서 번호가 90인 부서
select department_name 
from departments 
where department_id=90;

[예제2-8] 사번이 101번인 사원의 성과 한 해 동안 받은 급여를 조회한다.
select employee_id as 사번, last_name 성, salary * 12 as "ANNUAL SALARY"
from employees
where employee_id=101;

--2.3.3 비교연산자 (p.6)
--값의 크기 비교
[예제2-9] 급여가 3000이하인 사원의 정보를 조회한다.
select employee_id, last_name, salary, department_id
from employees
where salary<=3000;

[예제2-10] 부서코드가 80번 초과인 사원의 정보를 조회한다.
--부서코드 : deparment_id
--사원코드 : employee_id
--업무코드 : job_id
--부서캊코드 : manager_id

select *
from employees
where department_id>80;

-- 문자 데이터, 숫자 데이터 : '로 묶음 / 대소문자 구분
select *
from employees
where last_name = 'Chen'; --'chen' 오류

select employee_id, last_name, hire_date
from employees
where hire_date>'05/09/28';

[예제2-11] 성이 King인 사원의 정보를 조회한다.
select employee_id,last_name, email, phone_number, hire_date 
from employees
where last_name='King';

[예제2-12] 입사일이 2004년 1월 1일 이전인 사원의 정보를 조회
select *
from employees
where hire_date<='04/01/01';









