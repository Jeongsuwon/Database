--12장. PL/SQL
--SQL --> 절차적인|선언적인 프로그래밍 --> PL/SQL
--       Procedural Language extension to SQL : 절차적인 프로그래밍 언어 + SQL ==> SQL에서 프로그래밍!(확장)
--1) 프로그래밍              2) SQL: DML(개발자)  
--(데이터베이스를 다루는 프로그램)
--시중교재: PL/SQL로 분리할 만큼 분량 방대함 


-- DBMS_OUTPUT 패키지 : 화면에 출력하는 명령이 포함 ---> .PUT_LINE()  : 줄바꿈없이 텍스트 출력
-- SQL DEVELOPER 결과 확인 전, [보기 > DBMS 출력] 창을 선택해서 활성화 ==> + 눌러서 HR 계정 연결!
-- ※SQLPLUS 확인하려면? SET SERVEROUTPUT ON | OFF;

-- 12.1 PL/SQL 구분

DECLARE
    -- 선언부: 변수, 상수를 선언하는 부분
    -- 상수는 선언과 동시에 초기화 -> 안하면 오류!

BEGIN
    -- 필수
    -- 실행부: 일반적인 처리 로직을 작성
    -- 조건문, 선택문, 반복문, SQL(=DML)이 위치
    
    EXCEPTION
    -- 예외처리부 : 옵션
END;

-- 변수명 자료형 :=값;  - 변수에 값을 할당하는 부분
--예시)
DECLARE
    -- 변수명 자료형;
    -- 변수명 자료형 := 초기값;
    -- 상수명 CONSTANT 자료형 := 초기값;
    nInt INTEGER := 10;
BEGIN
    -- 변수명 := 초기값;
    DBMS_OUTPUT.PUT_LINE('카운트: ' ||nInt);
END;

-- 예) SQL를 포함한 예시
DECLARE 
    nSalary NUMBER(8, 2);
BEGIN
    SELECT SALARY
    into nSalary
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = 100;
    
    DBMS_OUTPUT.PUT_LINE('nSalary: '||nSalary);
END;

--1) 익명 블럭
--    일반적인 표현식, 출력 ..


declare
    iInt Integer := 10;
begin
    dbms_output.put_line('iInt:'||iInt);
end;

declare
    num1 integer := 1;
    num2 integer := 2;
    result integer;
begin
    num2 := 0;
    result := num1/num2;
    dbms_output.put_line('출력 되나?');
    exception when others then --예외처리 : 0으로 나누면 에러 (자바에서 try~catch)
    num2 := 1;
    result := num1 / num2;
    dbms_output.put_line('result: '||result);
end;

--===================================
--1) 사전에 정의된 예외(Pre_defined Exception)
--2) 사용자 정의하는 예외(User_defined Exception)
-- ※ https://docs.oracle.com/en/database/oracle/oracle-database/19/lnpls/plsql-error-handling.html#GUID-8C327B4A-71FA-4CFB-8BC9-4550A23734D6

EXCEPTION
  WHEN 예외명1 THEN 처리구문1              -- Exception handler
  WHEN 예외명2 OR 예외명33 THEN 처리구문2  -- Exception handler
  WHEN OTHERS THEN 처리구문3               -- 어떤 예외라도 발생하면, Exception 처리!
END;

--=====================================

-- 조건문 : IF 문
-- https://docs.oracle.com/en/database/oracle/oracle-database/19/lnpls/plsql-control-statements.html#GUID-1D6FD34F-F58B-4D0B-B7FC-F7C2C22377C3
-- FORTRAN, COBOL, PASCAL, C언어를 참고해서 만들어낸 오라클의 '프로그래밍 가능한 SQL'

if 조건 then
처리문
end if;

if 조건 then
처리문1
else
처리문2
end if;

-- 조건이 여러개
IF 조건1 THEN
처리문1
ELSIF 조건2 THEN
처리문2
ELSIF 조건2 THEN
처리문3
...계속...
ELSE
처리문n
END IF;

-- 예) 성적 ==> 점수에 따라 A등급, B등급, C등급... A등급이면 Excellent! 출력~

DECLARE
    grade CHAR(1) := 'A';
BEGIN
    IF  grade = 'A' THEN
        DBMS_OUTPUT.PUT_LINE('Excellent!');
    ELSIF grade = 'B' THEN
        DBMS_OUTPUT.PUT_LINE('Good!');
    ELSIF grade = 'C' THEN
        DBMS_OUTPUT.PUT_LINE('Not Bad!');
    ELSE
        DBMS_OUTPUT.PUT_LINE('WORK HARD!');
    END IF;
END;


-- 반복문
-- https://docs.oracle.com/en/database/oracle/oracle-database/19/lnpls/plsql-control-statements.html#GUID-4CD12F11-2DB8-4B0D-9E04-DF983DCF9358
-- Basic LOOP : LOOP ~statements~ END LOOP;
-- FOR LOOP : FOR 변수명 IN 최소값..최대값 LOOP ~ statements ~ END LOOP;
-- Cursor FOR LOOP
-- WHILE LOOP : WHILE condition LOOP ~ statements(EXIT WHEN condition)~ END LOOP;

--for 루프로 숫자값 출력
declare
    start_num Integer := 1;
    num integer := 2;
    result integer;
begin
    for num in 2..9 loop
    for start_num in 1..9 loop
        result := num*start_num;
        dbms_output.put_line(num||' x ' ||start_num||' = '|| result);
        end loop;
    end loop;
end;

-- 명명된 블럭(Named Block) <---> 오라클, 서브프로그램이라고 함
-- A PL/SQL subprogram is a named PL/SQL block that can be invoked repeatedly. If the subprogram has parameters, their values can differ for each invocation.
-- https://docs.oracle.com/en/database/oracle/oracle-database/19/lnpls/plsql-subprograms.html#GUID-117C2D94-EB7C-4A9E-A080-99F4829D69B0

-- 1) 프로시저 : 사원의 사번, 올려줄 급여만 넣고 실행하는 프로시저 --> DML 실제 데이터 업데이트
-- 프로시저 생성

-- declare 대신
create or replace procedure 프로시저명 (파라미터1 데이터타입, 파라미터2 데이터타입,..) is
        -- 변수 선언부;
        -- raise_salary(사번, 올려줄 급여)
begin
        --실행 처리
        update employees
        set salary = 올려줄 급여
        where employee_id = 사번;
        commit;
end;

--프로시저 실행: exec 급여변경_프로시저(사번, 결정된 salary)
exec raise_salary(120, 18000); -- vs dml로 처리하는 것과 비교

--직접 만들어보기
create or replace procedure update_emp_salary(emp_id number, final_salary number)
is
begin
    update employees
    set salary = final_salary
    where employee_id = emp_id;
    commit;
    exception when others then
    rollback;
    dbms_output.put_line('====error 발생====');
    dbms_output.put_line('=====procedure success=====');
end;

-- 사원 1명을 선택하고, 급여를 입력 ==> jobs 테이블의 min_sal, max_sal 제약조건?
select *
from user_constraints
where constraint_name like '%SALARY%';

select employee_id, salary
from employees
where employee_id = 206;

exec update_emp_salary(206, 18000);

DESC DEPARTMENTS;

desc employees;

SELECT * FROM DEPARTMENTS;

select * from employees;

create or replace procedure add_emp(
    e_id INTEGER, 
    l_name VARCHAR2,
    e_mail VARCHAR2,
    h_date DATE,
    s_money NUMBER,
    j_id VARCHAR2
)
is
begin
    insert into employees (employee_id, last_name, email, hire_date, salary, job_id)
    values (e_id,l_name, e_mail, h_date,s_money, j_id); 
    commit;
    exception when others then
        rollback;
        dbms_output.put_line('====error 발생====');
    dbms_output.put_line('=====procedure success=====');
end;

exec add_emp(EMPLOYEES_SEQ.NEXTVAL, '장', 'Jangbogo', sysdate, 2000, 'ST_CLERK');
exec add_emp(EMPLOYEES_SEQ.NEXTVAL, '박', 'Jangbogo', sysdate, 2000, 'ST_CLERK');
exec add_emp(EMPLOYEES_SEQ.NEXTVAL, '이', 'Jangbogo', sysdate, 2000, 'ST_CLERK');

SELECT  *
FROM    employees
WHERE   last_name = '장'
ORDER BY 1 DESC;

commit;
-- ※ 프로시저는 반환 값(X) VS 함수는 반환 값(O)

-- 2) 함수 : MAX() 처럼, 새로운 함수를 생성!


