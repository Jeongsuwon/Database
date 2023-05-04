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
