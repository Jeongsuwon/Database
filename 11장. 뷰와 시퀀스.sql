--11장. 뷰와 시퀀스

--데이터베이스 용도, 권한 따라서 다름
--개발자 vs 데이터베이스 관리자
--테이블       테이블, 뷰, 함수, 인덱스,...
--뷰
--함수
--시퀀스
--테이블
--트리거

--11.1 뷰 (VIEW)
--뷰는 데이터가 존재하지 않는 가상 테이블: 메모리에서 -> 쿼리를 저장했다가 실행한 결과 반환 후 소멸
--보안과 사용자 편의를 위해 사용
--HR계정의 기본 뷰를 조회

SELECT *
FROM EMP_DETAILS_VIEW;

--실제 EMP_DETAILS_VIEW의 SQL이 저장된 사용자_뷰 정보객체
SELECT *
FROM USER_VIEWS;

[예제11-1] 80번 부서에 근무하는 사원들의 정보를 담는 v_emp80인 뷰를 생성
create or replace view v_emp80 as --이미 있으면? replace!
select employee_id as emp_id, first_name, last_name, email, hire_date
from employees
where department_id = 80;
-- with read only; --읽기전용 뷰 생성옵션: 뷰를 통해 데이터를 조작할 수 없도록!!

--1. 원래 테이블에 데이터 삽입 --> 뷰에 영향?
desc employees;

insert into employees(employee_id, first_name, last_name, email, hire_date, job_id, salary, department_id)
values (207, 'Gildong', 'Hong', 'GILDONGHONG', sysdate, 'SA_REP', 6500, 80);

-- v-emp80 뷰를 조회: 홍길동이 추가되었는지?
select *
from v_emp80;

--결과: 실제 테이블에 데이터 삽입 -> v_emp80을 조회하면 추가된 데이터가 나타남!

--2. 뷰에 데이터 삽입 --> 원래 테이블에 영향: employees

insert into v_emp80(emp_id, first_name, last_name, email, hire_date)
values(208, 'SUNSHIN', 'LEE', 'SUNSHINLEE', SYSDATE);
--오류: 실제 employees 테이블의 필수입력 컬럼이 v_emp80에는 없으니까, 확인용 전체 사원 뷰

create or replace view v_emp_all as --이미 있으면? replace!
select *
from employees;


insert into employees(employee_id, first_name, last_name, email, hire_date, job_id, salary, department_id)
values (208, 'SUNSHIN', 'LEE', 'SUNSHINLEE', sysdate, 'SA_REP', 6600, 80);


rollback;

[예제11-2] v_dept 뷰를 생성 - 부서코드, 부서명, 최저급여, 최대급여, 평균급여 정보
create or replace view v_dept as
select d.department_id, d.department_name,
        min(e.salary) as min_sal, max(e.salary) as max_sal, round(avg(e.salary)) as avg_sal
from employees e, departments d
where e.department_id = d.department_id
group by d.department_id, d.department_name
order by 1;

select *
from employees;

delete from employees where employee_id = 207;

commit;

[예제11-3]
drop view v_dept;
drop view v_emp80;
drop view v_emp_all;
--다시 만들게 아니라, v_dept가 컬럼만 추가|수정되면 create or replace 처리!

/* 뷰 생성문
    create [or replace] view 뷰명 as
    select 이하
    
    뷰 삭제
    drop view 뷰명;
    
*/


--11.2 시퀀스
--연속적인 번호의 생성이 필요한 경우 sequence를 사용하여, 자동으로 만들어주는 기능
--의사컬럼 currval, nextval을 통해 조회하고 사용할 수 있다.

select *
from user_sequences; --시스템 만든 뷰: 누구나 사용할 수 있게~

/*
DEPARTMENTS_SEQ: 부서등록 (10씩 증가 --> 9990까지)
EMPLOYEES_SEQ: 사원등록 (1씩 증가 --> 9999999999999999)
LOCATIONS_SEQ: 부서위치 등록(100씩 증가 --> 9900까지)
*/

-- 왜 시퀀스를 만들까? 데이터 입력할 때마다, 특정 패턴의 값을 기억해둘 필요가 없어진다.

/*
create sequence 시퀀스명
start with 시작값
maxvalue 최대값
increment by 증감값
nocache | cache 
nocycle | cycle
*/

[예제11-4]
create sequence emp_seq
start with 103
maxvalue 99999999
minvalue 1
increment by 1
nocache
nocycle;

select emp_seq.currval,
       emp_seq.nextval
from dual;

[예제11-5] emp_test에 데이터 삽입
select *
from emp_test;

insert into emp_test
values(emp_seq.nextval, 'choi', 20, 'ST_CLERK');

SELECT *
FROM USER_CONSTRAINTS
WHERE TABLE_NAME='EMP_TEST';

--구글: oracle database disable constraint
/*
alter table table_name
[ENABLE|DISABLE] constraint
   constraint_name;
*/

ALTER TABLE emp_test
DISABLE CONSTRAINT EMP_TEST_DEPT_ID_FK; --EMP_TEST에 걸린 det_test_id_fk를 해제

ALTER TABLE emp_test
ENABLE CONSTRAINT EMP_TEST_DEPT_ID_FK; --EMP_TEST에 걸린 det_test_id_fk를 설정 : 제약조건과 맞지 않는 값 존재
-- ORA-02298: 제약 (HANUL.EMP_TEST_DEPT_ID_FK)을 사용 가능하게 할 수 없음 - 부모 키가 없습니다
-- 외래키 제약조건 : 10,20,30 범위에 없는 230번 데이터 때문!!

SELECT *
FROM    emp_test;

-- 117번 이순신 230번 부서 --> 10~ 30중 하나로 변경 후 제약조건 ENABLE

UPDATE emp_test
SET dept_id = 30
WHERE   emp_id = 117;

ALTER TABLE emp_test
ENABLE CONSTRAINT EMP_TEST_DEPT_ID_FK; --EMP_TEST에 걸린 det_test_id_fk를 설정

-- 제약조건 ENABLE/DISABLE : 테스트 할때 가끔 사용할 일이 있다.
-- 단, 다시 제약조건을 ENABLE 할때 테스트 하는 테이블에 제약조건과 일치하는 데이터가 있는지 확인!

COMMIT;


-- 12.오라클 데이터베이스 객체
-- 12.1 데이터 사전/데이터 딕셔너리 : 데이터베이스의 중요한 정보, 객체등을 저장하고 있는 객체
-- 오라클이라는 시스템이 사용하는 데이터 + 사용자 데이터

-- 12.2 데이터 사전 조회
SELECT *
FROM    dict;

SELECT *
FROM    dictionary;

-- 테이블, 뷰를 포함한 데이터베이스 객체 정보 : 제약조건, 인덱스, 클러스터, 시노님(=동의어), ...
-- 사실, 데이터베이스 관리자가 보는 정보
-- 사용자가 활용하는 정보가 담겨있다.

-- 조회해볼 수 있는 고유한 정보 테이블/뷰의 종류
-- 1) ALL_ 시작하는 뷰 : 권한 상관없이 누구든 조회할 수 있는 데이터
-- 2) DBA_ 시작하는 뷰 : DBA 권한이 있을때 조회
-- 3) USER_시작하는 뷰 : 접속한 계정에 포함된 데이터를 조회
-- 4) v$ 시작하는 뷰 : 오라클 데이터베이스에서 요약된,특징적인 정보를 조회

SELECT *
FROM    v$nls_parameters;

SELECT  *
FROM    all_tables
WHERE   owner = 'HANUL';

SELECT  *
FROM    all_objects
WHERE   owner = 'HANUL';

-- 12.3 데이터베이스 객체 종류
-- 1) 테이블
-- 2) 뷰
-- 3) 시퀀스
-- 4) 함수 : 사용자 정의 함수 vs MAX() 있지만~ MID() 만들겠다면!  ==> 반환값이 있음
-- 5) 트리거 : 반환값이 없는 함수
-------------------- 개발자↑   DBA ↓ 까지 -----------------------------------------
-- 6) 인덱스 : 검색 성능 향상때문에
-- 7) 클러스터 :           "
-- 8) 시노님 : 객체의 또다른 이름(=별명) 생성
-- 9) 패키지 : PL/SQL로 함수나 트리거등을 한데 묶기 위해

/* 
[참조URL] https://docs.oracle.com/en/database/oracle/oracle-database/21/lnpls/CREATE-TRIGGER-statement.html#GUID-AF9E33F1-64D1-4382-A6A4-EC33C36F237B
SQL vs PL/SQL - 함수, 트리거, 패키지 + 기본 프로그래밍 문법 
       Procedural Language + SQL : 절차적인 프로그래밍 언어 + SQL ==> SQL에서 프로그래밍!
       변수, 상수, 연산자, 조건문, 반복문...       
       I. 익명 블럭(Anonymous Block)    /   II. 서브프로그램(Named Block)
                                                - 함수
                                                - 트리거
*/       
       

-- 트리거 생성 : DML 처리를 위함
CREATE OR REPLACE TRIGGER 트리거명
[BEFORE | AFTER]
    INSERT OR 
    UPDATE OF salary, department_id OR  -- 2.어떤 작업이 이뤄지면
    DELETE
  ON employees -- 1.어떤 테이블에서의 
BEGIN
    -- 3. 아래에서 지정한 처리가 되는 PL/SQL
    -- PL/SQL 실행부 : 변수, 연산자, 조건문, 반복문 ....
    -- 에러처리부 : EXCEPTION 
END;

[공식문서 예제] HR 계정으로 생성
CREATE OR REPLACE TRIGGER t
  BEFORE | AFTER
    INSERT OR
    UPDATE OF salary, department_id OR
    DELETE
  ON employees
BEGIN
  CASE
    WHEN INSERTING THEN
      DBMS_OUTPUT.PUT_LINE('Inserting');
    WHEN UPDATING('salary') THEN
      DBMS_OUTPUT.PUT_LINE('Updating salary');
      -- 실제 처리 로직: 사원의 급여변경 테이블에, 변경사항을 자동으로 입력처리
      INSERT INTO salary_changes (employee_id, salary_before, salary_after, reason)
      VALUES (값,값,값,값);      
      DBMS_OUTPUT.PUT_LINE('writing slarry change OK!');
      
    WHEN UPDATING('department_id') THEN
      DBMS_OUTPUT.PUT_LINE('Updating department ID');
    WHEN DELETING THEN
      DBMS_OUTPUT.PUT_LINE('Deleting');
  END CASE;
END;
/

 employees 업데이트 --> salary 
 
 SELECT *
 FROM   employees; -- 205 Shelley 의 급여가 12008 --> 12000 으로 업데이트
 
-- DBMS_OUTPUT 패키지 : 화면에 출력하는 명령이 포함 ---> .PUT_LINE()  : 줄바꿈없이 텍스트 출력
-- SQL DEVELOPER 결과 확인 전, [보기 > DBMS 출력] 창을 선택해서 활성화 ==> + 눌러서 HR 계정 연결!
UPDATE employees
SET salary = 12000
WHERE   employee_id = 205;

-- 예제 코드에서는 단순 출력 메시지만,
-- 실제로는 특정 테이블에 변경사항을 추가 입력, 기록 용도로 활용
-- ex> 주문 테이블 : 상품의 재고를 자동으로 변경   vs   개발자 직접 재고를 업데이트 해야함!
-- ※SQLPLUS 확인하려면? SET SERVEROUTPUT ON | OFF;

DROP TRIGGER t;


-- 12.4 생성/삭제/변경
-- CREATE 구문
-- ALTER 구문
-- DROP 구문