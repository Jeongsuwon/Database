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
select * from regions
--2. 데이터를 조회하는 select
--select * from 테이블명;

--※ 왼쪽 접속에서 각 테이블을 더블클릭하고, [데이터] 컬럼을 클릭하면 같은 기능