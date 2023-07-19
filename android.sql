insert into customer
select * from
customer;

select * from customer order by id desc;

delete from customer where id=1;

insert into customer (name, email, phone) values ('�߰�', 'choo@hanul.com', 01088883333 );

select seq_cu.nextval from dual;

rollback;

commit;

update customer set name=1, email=1, phone=1 where id=1;

select * from employees;


--email

select
e.employee_id,
e.first_name || ' ' || e.last_name as emp_name,
case 
when mod(employee_id, 2)=0 then replace(email, instr(email ,'@', 1)+1, 'naver.com')
else replace(email, instr(email ,'@', 1)+1, 'gmail.com')
end as email, replace(phone_number, '.', '-') as phone_number,
to_char(hire_date, 'YYYY-MM-dd') hire_date,
case when commission_pct is not null 
then to_char(salary * 1289 + nvl2(commission_pct, (salary * 1289) * commission_pct, 0), '999,999,999') || '��' ||
'(' || to_char(commission_pct * (salary * 1289), '999,999,999') || ')' ELSE to_char(salary * 1289, '999,999,999') ||'��' END as salary,
j.job_title,
d.department_name
from employees e left join jobs j on e.job_id = j.job_id
left join departments d on e.department_id = d.department_id;

--phone number
select replace(phone_number, '.', '-') as phone_number from employees;

--date
select to_char(hire_date, 'YYYY-MM-dd') hire_date from employees;

select to_char(salary * 1289, '999,999,999') as salary from employees order by employee_id; 

--salary
SELECT
case when commission_pct is not null 
then to_char(salary * 1289 + nvl2(commission_pct, (salary * 1289) * commission_pct, 0), '999,999,999') || '��' ||
'(' || to_char(commission_pct * (salary * 1289), '999,999,999') || ')' ELSE to_char(salary * 1289, '999,999,999') ||'��' END FROM employees;

--[Inner or Outer or Full ] [Join] on key=key, ���� = ����
select e.*
from employees e left outer join departments d on e.department_id = d.department_id;

--Ű�� ��ӹ޾Ƽ� ����ϴ� ��
--Ű�� ��ӹ��� �� �� ���Ѿ��ϴ� ��Ģ (���� ���) : �θ� ���� �⺻Ű�� ��� ��ӹ޾ƾ��Ѵ�.
--�Խ���. �Խ����� ������ �Ȱ���
--�Խ��� ����(key), �Խñ� ��ȣ (key), �Խñ� ����, �Խñ� ����, ��Ÿ�Ӽ�(��¥, �۾��� ���)�� ��
--�Խ����� ���� �� �ִٸ� ���̺��� �������� �Ǿ���ұ�?

create table and_board(
    board_category varchar2(10) not null, --�Խ��� ����(������ Ű)
    board_no number not null, --�ڵ� ���� �Ұ��� �������� Ʈ���� �̿�
    board_title varchar2(200),
    board_content varchar2(2000),
    create_date date,
    create_by varchar2(100),
    update_date date,
    
    constraint and_board_pk primary key
    (
        board_category,
        board_no
    )
    enable,
    constraint and_board_fk foreign key(create_by) references andmember(id)
);


insert into and_board(board_category, board_no, board_title, board_content, create_date, create_by)
values('b', 3, 'title', 'b', sysdate, 'dev');


select * from and_board;
select * from andmember;
 


create table and_board_reply(
    board_category  varchar2(10) not null, --�θ� ���̺��� Ű�� �����ϱ� ���� �÷�1
    board_no        number not null, --�θ� ���̺��� Ű�� �����ϱ� ���� �÷�2
    board_title varchar2(200),
    create_date date,
    create_by varchar2(100),
    update_date date,
    reply_no        number not null constraint and_board_reply_pk primary key,  
    reply_content   varchar2(1000),
    
    constraint and_board_reply_writer_fk foreign key (create_by) references andmember(id),
    constraint and_board_reply_category_fk foreign key (board_category, board_no) references and_board(board_category, board_no)
    );
    
    drop table and_board_reply;
    
    select * from and_board_reply;
    
    insert into and_board_reply(BOARD_CATEGORY, BOARD_NO, BOARD_TITLE, CREATE_DATE, CREATE_BY, REPLY_NO, REPLY_CONTENT)
    values ('b', 1, 'b', sysdate, 'dev', 1, 'b');
    
    select * from and_board;
    
    
    insert into and_board (BOARD_CATEGORY, BOARD_NO, BOARD_TITLE, BOARD_CONTENT, CREATE_DATE, CREATE_BY)
    values ('b', seq_and_board.nextval, 'test', 'test1234', sysdate, 'dev');
    
    create SEQUENCE seq_test start WITH 1 increment by 1 NOCACHE;
    
    create sequence seq_and_board increment by 1;
    
    rollback;
    
    -- TRIGGER �� �⺻����.
    --CREATE [ OR REPLACE ] TRIGGER [ schema.] trigger
    --BEFORE | AFTER
    --DML EVENT ( INSERT [OR] UPDATE [OR} DELETE )
    --ON [SCHEMA.] DATABASE TABLE
    --WHEN ( ����)
    --PL/SQL_BLOCK | CALL_PROCEDURE_STATEMENT ; 
    
    --Ʈ���� : Ʈ������� �߻��ϴ� �۾��� �ϱ� �� �Ǵ� �Ŀ� � ������ �����ϰ� ����� ��.
    --����        new(�ű�)         /        old(����)
    --insert   ���ε��µ�����(��)  null: ������ ���� ���� �߰��� ������ ����(old)�����ʹ� ����    
    --update   �ٲ� ������(��)      /    �ٲ�� �� ������(��)
    --delete    null                /    ���� �Ǵ� ������(����)
    --for each row : insert, update, delete�� ���� ���� �� ���� �۾��Ǵ� ��찡 �����Ѵ�.
    
    
    create table and_board_history(
    board_category varchar2(10) not null, --�Խ��� ����(������ Ű)
    board_no number not null, --�ڵ� ���� �Ұ��� �������� Ʈ���� �̿�
    board_title varchar2(200),
    board_content varchar2(2000),
    create_date date,
    status_value varchar2(50)
);
    
    create or replace trigger trg_and_board
    AFTER update or delete on and_board
    for each row
    begin 
        if updating then
        insert into and_board_history
        values (:old.board_category, :old.board_no, :old.board_title, :old.board_content, sysdate, 'update');
        elsif deleting then
        insert into and_board_history
        values (:old.board_category, :old.board_no, :old.board_title, :old.board_content, sysdate, 'delete');
        end if;
        
    end;
    /
    
    create or replace trigger trg_and_board_pk
    before insert on and_board
    for each row
    begin 
        :new.board_no := seq_and_board.nextval;
    end;
    /
    
    select * from and_board_history;
    select * from and_board;
    
    
    create table crud_retrofit(
    col_no number primary key not null,
    col1 varchar2(1000),
    col2 varchar2(1000)
    );
    
    create SEQUENCE seq_crud_retrofit increment by 1;
    
    create or replace trigger trg_crud_retrofit_pk
    before insert on crud_retrofit
    for each row
    begin 
        :new.col_no := seq_crud_retrofit.nextval;
    end;
    /
    
    insert into crud_retrofit(col1, col2) values('test', 'test');
    
    commit;
    
    update crud_retrofit set col1 = 'testCol1';
    
    select * from crud_retrofit;
    
    drop table crud_retrofit;
    