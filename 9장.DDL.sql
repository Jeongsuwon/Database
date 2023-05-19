--9장. DDL

--Data Definition Language, 데이터베이스 정의어
--1)테이블 생성 2)뷰 3)인덱스

--9.1 데이터 타입 --> 데이터베이스의 테이블에 컬럼 정의 자료형, 길이(Bytes)를 알아야 올바르게 생성
--가장 자주 사용하는 자료형
--1) 문자형: 고정길이 문자형 char, 가변길이 문자형 varchar2
--       └(국가별 언어에 따른 문자형): nchar, nvarchar2        
--2) 숫자형: 정수, 실수
--3) 날짜형: 날짜
--※NLS 설정에 따라 다름
--도구 > 환경설정 > NLS 또는 
SELECT * FROM v$nls_parameters;

--9.1.1 문자(열)형 데이터
--고정 길이: char(바이트 수) -> char(5): 5 bytes 문자열 저장하는 컬럼의 길이를 정의
--가변 길이: varchar2(바이트 수) -> varchar2(5) : ""
--※ 5byte 컬럼에 3byte 입력하면 -> 2byte 반환 x, 데이터가 저장된 곳까지 오라클이 
--                                                구분하는 기호를 삽입하는 형식

--9.1.2 숫자형 데이터
--int 컬럼 정의 -> number
--number(n): 정수 n바이트 길이로 정의
--number(p, s): 전체길이 p, 정수 p-s길이, 소수 s 길이로 정의
--ex)number(5,2): 전체길이 5, 정수길이 3, 소수 2

--9.1.3 날짜형 데이터
--date 타입, 날짜와 시각 정보를 갖는다.

--DDL: 데이터베이스 객체를 조작(생성, 수정)하는 명령어 : create, alter, drop, truncate
--trunc(number | date): (소숫점 이하) 버리는 함수(숫자, 날짜)

--9.2 테이블 생성
[예제9-1] 3byte 숫자 id 컬럼, 20byte 문자 fname 컬럼으로 이루어진 TMP 테이블 생성
create table tmp(
    id number(3),
    fname varchar(20)
);

drop table tmp;

[예제9-2] tmp 테이블에 홍길동과 이순신의 데이터를 저장
insert into tmp(id, fname) values (1, '홍길동');
insert into tmp(id, fname) values (2, '이순신');

[예제9-3] id가 1번인 사람의 name 컬럼의 데이터를 홍길동 -> 홍명보로 변경
update tmp set fname='홍명보' where id=1;

[예제9-4] 부서 테이블 데이터를 복사하여 dept1 테이블로 생성(=복사)한다.
create table dept1 as
select *
from departments;

select * from dept1;
select * from emp20;
[예제9-5] 사원 테이블에서 20번 부서에 소속된 사번, 이름, 입사일 컬럼의 데이터를
          복사하여 emp20 테이블을 생성한다.
          
create table emp20 as
select employee_id, first_name, hire_date
from employees where department_id=20;

[예제9-6] 부서 테이블에서 데이터 없이 dept2 테이블을 복사하여 생성
-- 일치하는 조건의 데이터가 없는 경우 --> dept2 테이블 생성: OK, 데이터: NO
-- CTAS의 WHERE 조건을 거짓으로!! -> 컬럼명, 자료형은 그대로 복제, 데이터만 없다!!
CREATE TABLE dept2 as
select *
from departments
where 1=2;



--9.3 테이블 구조 변경
--9.3.1 컬럼 추가: 데이터?는 null 채워짐
--기존 테이블에 새로운 컬럼을 추가하는 형식
alter table 테이블명 add 컬럼명 자료형(길이);

[예제9-7] emp20 테이블에 숫자타입 급여 컬럼(salary), 문자타입 업무코드(job_id) 컬럼을 추가
alter table emp20 add (salary number, job_id varchar2(10));

select * from emp20;

--9.3.2 컬럼 변경(이름, 길이, 자료형, 제약조건), 데이터 유실가능성
--컬럼명, 데이터 타입, 크기를 변경하는 형식
alter table 테이블명
modify (컬럼명 데이터타입);

[예제9-8] emp20 테이블의 salary 컬럼과 job_id 컬럼의 데이터 크기를 각각 변경
-- 기존: salary number --> number(8, 2), job_id varchar2(5) --> 10byte
alter table emp20
modify (salary number(8, 2), job_id  varchar2(10));

insert into emp20 values (203, 'Steve', sysdate, 10000, 'sa_man');

alter table emp20
modify salary number(8,2);

--9.3.3 컬럼 삭제 : 데이터 유실
--테이블의 컬럼을 삭제하는 형식
alter table 테이블명
drop column 컬럼명;

[예제9-9] emp20 테이블의 업무코드 컬럼 job_id 컬럼을 삭제
alter table emp20
drop column job_id;

select * from emp20;

--9.4 테이블 삭제
drop table 테이블명;

--복구 안되게 테이블 삭제: 휴지통 거치지 않고 완전히 삭제(복구불가)
drop table 테이블명 purge;

--테이블의 이름을 변경
rename 원래의 테이블명 to 변경될 테이블명;


--9.5 테이블 데이터 삭제 -> truncate
--테이블의 구조만 남겨두고, 모든 행 데이터를 삭제
truncate table 테이블명;
