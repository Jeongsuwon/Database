-- 8장. DML
-- 8.1 select : 데이터 조회 --> DQL(Data Query Language) : Query 질의 --> 요청
-- 8.2 insert : 새 데이터 저장
-- 날짜 데이터는 날짜 포맷 형식(YYYY-MM-DD, RR/MM/DD..)을 사용해서 저장 가능
[예제8-1] emp 테이블에 300번 사원 이름이 'steven', 성이 'jobs'인 사원의 정보를 오늘 날짜 기준으로 등록
-- 1. emp 테이블 생성
create table emp(
    emp_id number,
    fname varchar2(30),
    lname varchar2(20),
    hire_date date default sysdate,
    job_id varchar2(20),
    salary number(9,2), --숫자형(정수부: 7, 소수부: 2) 
    comm_pct number(3,2), --숫자형(정수부:1, 소수부: 2)
    dept_id number
);

drop table emp;

--테이블 생성 후 확인하는 방법 1)
select *
from user_tables --사용자 계정으로 생성한 테이블들이 저장되는 테이블(객체)
where table_name='emp';

-- 2. 데이터를 삽입
-- 2.1 테이블의 구조 조회 : desc
desc emp;

insert into emp (emp_id, fname, lname, hire_date)
values (300, 'steven', 'jobs', sysdate);

select * from emp;

[예제8-2] 사번이 301이고 이름이 'bill', 성이 'gate'인 사원을 2013년 5월 26일자로 emp 테이블에 저장
insert into emp(emp_id, fname, lname, hire_date) values(301,'bill', 'gate', to_date('2013-05-26 10:00:00', 'yyyy-MM-dd hh:mi:ss')); 

--null 또는 빈 문자열을 사용해 수동으로 null 저장 가능

[예제8-3]
insert into department values(300, 'health services', null, null);

[예제8-4]
insert into emp (emp_id, fname, lname, hire_date, job_id, salary)
values(302, 'warren', 'buffett', sysdate, '','');

--values 절 없이 select문을 사용해 서브쿼리 테이블로부터 여러 데이터 행을 복사, 저장 가능
--insert절의 저장할 컬럼 목록과 select절의 컬럼 목록 개수가 일치

[예제8-5]
insert into emp(emp_id, fname, lname, hire_date, job_id, dept_id)
select employee_id, first_name, last_name, hire_date, job_id, department_id
from employees
where department_id in (10, 20);

[예제8-6] 월별 급여 관리 테이블에 부서코드 행 데이터를 삽입 저장

create table month_salary(
    dept_id number,
    emp_count number,
    tot_sal number,
    avg_sal number
);

drop table month_salary;

insert into month_salary(dept_id, emp_count, tot_sal, avg_sal)
select department_id, count(*), sum(salary), round(avg(salary),2)
from employees
where department_id is not null
group by department_id
order by 1;

select * from month_salary;

[예제8-7] 사원테이블에서 부서코드가 30에서 60번에 해당하는 사원들의 정보를 조회 후 emp 테이블에 삽입
insert into emp
select employee_id, first_name, last_name, hire_date, job_id, salary, commission_pct, department_id 
from employees
where department_id between 30 and 60;

-- 8.3 update : 기존 데이터를 변경 후 저장
[예제8-8] emp 테이블에서 사번이 300번 이상인 사원의 부서코드를 20으로 변경
-- emp : 현재 300번 이상 3명 + employees 테이블 30~60번 부서원 60명 -> 63명
update emp
set dept_id = 20
where emp_id >= 300;

[예제8-9] 사번이 300번인 사원의 급여, 커미션율, 업무코드를 변경한다.
update emp
set salary = 2000,
    comm_pct = 0.1,
    job_id = 'it_prog'
where emp_id = 300;

--서브쿼리를 이용해 데이터 변경 가능
--업무코드, 급여, 커미션율 -> 다중 컬럼 서브쿼리 -> update 할 때 사용
[예제8-11] emp 테이블 사번 103번 사원의 급여를 employees 테이블의 20번 부서의 최대 급여로 변경
update emp
set salary = ( select max(salary) from employees where department_id = 20)
where emp_id = 103;

[예제8-12] emp 테이블 사번 180번 사원과 같은 해에 입사한 사원들의 급여를 employees 테이블 50번
           부서의 평균 급여로 변경
update emp
set salary = (select round(avg(salary),1) from employees where department_id = 50)
where to_char(hire_date, 'yyyy') = (select to_char(hire_date, 'yyyy') from emp where emp_id = 180);
--SQL 오류: ORA-00932: 일관성 없는 데이터 유형: DATE이(가) 필요하지만 NUMBER임
--변환함수를 이용해 타입을 맞춰줘야함



create table month_salary2(
    dept_id number,
    emp_count number,
    tot_sal number,
    avg_sal number
);

drop table month_salary2;

insert into month_salary2(dept_id)
select department_id
from employees
where department_id is not null
group by department_id;

select * from month_salary2;

commit;

update month_salary2 m
set emp_count = (select count(*)
                from employees e
                where e.department_id = m.dept_id
                group by e.department_id),
    tot_sal =  (select sum(e.salary)
                from employees e
                where e.department_id = m.dept_id
                group by e.department_id),
    avg_sal =   (select avg(e.salary)
                from employees e
                where e.department_id = m.dept_id
                group by e.department_id);

[예제8-14] month_salary2의 emp_count, tot_sal, avg_sal 컬럼을 다중컬럼 서브쿼리를 활용해
           employees의 부서별 집계된 데이터를 업데이트(단, 급여평균은 정수로 표시)
           
update month_salary2 m
set (emp_count, tot_sal, avg_sal) = ( select count(*),sum(salary),round(avg(salary))
                                     from employees e
                                     where e.department_id = m.dept_id
                                     group by e.department_id
                                     )

-- 8.4 delete : 기존 데이터를 삭제하는 명령
-- 테이블의 행 데이터를 삭제하는 기본 문법
-- where 절의 조건에 일치하는 행 데이터를 삭제(where 절 생략시 모든 행 데이터가 삭제)

[예제8-15] emp테이블에서 60번 부서의 사원 정보를 삭제
--조회
select *
from emp
order by dept_id;

delete from emp where dept_id=60;

-- commit : 데이터를 조작(메모리) -> (물리적인 저장장치에) 반영
-- rollback : 데이터 조작 -> 변경사항을 버림