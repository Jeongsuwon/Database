--12��. PL/SQL
--SQL --> ��������|�������� ���α׷��� --> PL/SQL
--       Procedural Language extension to SQL : �������� ���α׷��� ��� + SQL ==> SQL���� ���α׷���!(Ȯ��)
--1) ���α׷���              2) SQL: DML(������)  
--(�����ͺ��̽��� �ٷ�� ���α׷�)
--���߱���: PL/SQL�� �и��� ��ŭ �з� ����� 


-- DBMS_OUTPUT ��Ű�� : ȭ�鿡 ����ϴ� ����� ���� ---> .PUT_LINE()  : �ٹٲ޾��� �ؽ�Ʈ ���
-- SQL DEVELOPER ��� Ȯ�� ��, [���� > DBMS ���] â�� �����ؼ� Ȱ��ȭ ==> + ������ HR ���� ����!
-- ��SQLPLUS Ȯ���Ϸ���? SET SERVEROUTPUT ON | OFF;

-- 12.1 PL/SQL ����

DECLARE
    -- �����: ����, ����� �����ϴ� �κ�
    -- ����� ����� ���ÿ� �ʱ�ȭ -> ���ϸ� ����!

BEGIN
    -- �ʼ�
    -- �����: �Ϲ����� ó�� ������ �ۼ�
    -- ���ǹ�, ���ù�, �ݺ���, SQL(=DML)�� ��ġ
    
    EXCEPTION
    -- ����ó���� : �ɼ�
END;

-- ������ �ڷ��� :=��;  - ������ ���� �Ҵ��ϴ� �κ�
--����)
DECLARE
    -- ������ �ڷ���;
    -- ������ �ڷ��� := �ʱⰪ;
    -- ����� CONSTANT �ڷ��� := �ʱⰪ;
    nInt INTEGER := 10;
BEGIN
    -- ������ := �ʱⰪ;
    DBMS_OUTPUT.PUT_LINE('ī��Ʈ: ' ||nInt);
END;

-- ��) SQL�� ������ ����
DECLARE 
    nSalary NUMBER(8, 2);
BEGIN
    SELECT SALARY
    into nSalary
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = 100;
    
    DBMS_OUTPUT.PUT_LINE('nSalary: '||nSalary);
END;

--1) �͸� ��
--    �Ϲ����� ǥ����, ��� ..


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
    dbms_output.put_line('��� �ǳ�?');
    exception when others then --����ó�� : 0���� ������ ���� (�ڹٿ��� try~catch)
    num2 := 1;
    result := num1 / num2;
    dbms_output.put_line('result: '||result);
end;

--===================================
--1) ������ ���ǵ� ����(Pre_defined Exception)
--2) ����� �����ϴ� ����(User_defined Exception)
-- �� https://docs.oracle.com/en/database/oracle/oracle-database/19/lnpls/plsql-error-handling.html#GUID-8C327B4A-71FA-4CFB-8BC9-4550A23734D6

EXCEPTION
  WHEN ���ܸ�1 THEN ó������1              -- Exception handler
  WHEN ���ܸ�2 OR ���ܸ�33 THEN ó������2  -- Exception handler
  WHEN OTHERS THEN ó������3               -- � ���ܶ� �߻��ϸ�, Exception ó��!
END;

--=====================================

-- ���ǹ� : IF ��
-- https://docs.oracle.com/en/database/oracle/oracle-database/19/lnpls/plsql-control-statements.html#GUID-1D6FD34F-F58B-4D0B-B7FC-F7C2C22377C3
-- FORTRAN, COBOL, PASCAL, C�� �����ؼ� ���� ����Ŭ�� '���α׷��� ������ SQL'

if ���� then
ó����
end if;

if ���� then
ó����1
else
ó����2
end if;

-- ������ ������
IF ����1 THEN
ó����1
ELSIF ����2 THEN
ó����2
ELSIF ����2 THEN
ó����3
...���...
ELSE
ó����n
END IF;

-- ��) ���� ==> ������ ���� A���, B���, C���... A����̸� Excellent! ���~

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


-- �ݺ���
-- https://docs.oracle.com/en/database/oracle/oracle-database/19/lnpls/plsql-control-statements.html#GUID-4CD12F11-2DB8-4B0D-9E04-DF983DCF9358
-- Basic LOOP : LOOP ~statements~ END LOOP;
-- FOR LOOP : FOR ������ IN �ּҰ�..�ִ밪 LOOP ~ statements ~ END LOOP;
-- Cursor FOR LOOP
-- WHILE LOOP : WHILE condition LOOP ~ statements(EXIT WHEN condition)~ END LOOP;

--for ������ ���ڰ� ���
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

-- ���� ��(Named Block) <---> ����Ŭ, �������α׷��̶�� ��
-- A PL/SQL subprogram is a named PL/SQL block that can be invoked repeatedly. If the subprogram has parameters, their values can differ for each invocation.
-- https://docs.oracle.com/en/database/oracle/oracle-database/19/lnpls/plsql-subprograms.html#GUID-117C2D94-EB7C-4A9E-A080-99F4829D69B0

-- 1) ���ν��� : ����� ���, �÷��� �޿��� �ְ� �����ϴ� ���ν��� --> DML ���� ������ ������Ʈ
-- ���ν��� ����

-- declare ���
create or replace procedure ���ν����� (�Ķ����1 ������Ÿ��, �Ķ����2 ������Ÿ��,..) is
        -- ���� �����;
        -- raise_salary(���, �÷��� �޿�)
begin
        --���� ó��
        update employees
        set salary = �÷��� �޿�
        where employee_id = ���;
        commit;
end;

--���ν��� ����: exec �޿�����_���ν���(���, ������ salary)
exec raise_salary(120, 18000); -- vs dml�� ó���ϴ� �Ͱ� ��

--���� ������
create or replace procedure update_emp_salary(emp_id number, final_salary number)
is
begin
    update employees
    set salary = final_salary
    where employee_id = emp_id;
    commit;
    exception when others then
    rollback;
    dbms_output.put_line('====error �߻�====');
    dbms_output.put_line('=====procedure success=====');
end;

-- ��� 1���� �����ϰ�, �޿��� �Է� ==> jobs ���̺��� min_sal, max_sal ��������?
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
        dbms_output.put_line('====error �߻�====');
    dbms_output.put_line('=====procedure success=====');
end;

exec add_emp(EMPLOYEES_SEQ.NEXTVAL, '��', 'Jangbogo', sysdate, 2000, 'ST_CLERK');
exec add_emp(EMPLOYEES_SEQ.NEXTVAL, '��', 'Jangbogo', sysdate, 2000, 'ST_CLERK');
exec add_emp(EMPLOYEES_SEQ.NEXTVAL, '��', 'Jangbogo', sysdate, 2000, 'ST_CLERK');

SELECT  *
FROM    employees
WHERE   last_name = '��'
ORDER BY 1 DESC;

commit;
-- �� ���ν����� ��ȯ ��(X) VS �Լ��� ��ȯ ��(O)

-- 2) �Լ� : MAX() ó��, ���ο� �Լ��� ����!


