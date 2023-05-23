--10장. 제약조건

--무결성 제약조건: 데이터의 정확성을 보장하기 위해 두는 제약/제한 조건
--1) 테이블 생성 시 정의
--2) 테이블 생성 후 추가

--10.1 not null 
--테이블 생성시 컬럼 레벨에서 정의
[예제10-1] null_test라는 테이블을 생성하되 컬럼은 col1 문자타입 5바이트 길이,
          null 허용하지 않고, col2 문자타입 5바이트 길이로 정의

create table null_test(
    col1 varchar2(5) not null, --컬럼레벨
    col2 varchar2(5)
);

[예제10-2]
insert into null_test(col1)
values('AA');

[예제10-3]
insert into null_test(col2)
values('BB');

select * from null_test;
--col1은 not null이라 값을 줘야함

--========사용자 계정으로 생성된(테이블의) 제약조건이 모두 기록된 별도의 테이블 객체==============
select*
from user_constraints
where table_name='NULL_TEST';

update null_test
set col2 = 'BB';

[예제10-4]
alter table null_test
modify (col2 not null);

[예제10-5]
alter table null_test
modify (col2 null);

update null_test
set col2 = 'bb';
commit;

--10.2 check - 값의 범위(p.80)
--조건에 맞는 데이터만 저장할 수 있도록 하는 제약조건
--컬럼 레벨, 테이블 레벨에서 정의
--컬럼 레벨
--테이블 레벨

--I.테이블 생성 전 제약조건 추가/지정

[예제10-6]
create table check_test(
    name varchar2(10) not null,
    gender varchar2(10) not null check(gender IN('남성','여성','male','female','man','woman')),
    salary number(8),
    dept_id number(4),
    constraint check_salary_ck check(salary>2000) --테이블 레벨
);

select*
from user_constraints
where table_name = 'CHECK_TEST';


--테이블명_컬럼명_제약조건 약어(NN: NOT NULL, CK: CHECK, PK: PRIMARY KEY, FK: FOREIGN, UK(UNIQUE KEY)

[예제10-7] 데이터를 check_test 테이블에 삽입해보시오

insert into check_test
values('홍길동', '남성', 3000, 10);

[예제10-9]
update check_test
set salary=2000
where name='홍길동'; --ORA-02290: 체크 제약조건(HANUL.CHECK_SALARY_CK)이 위배되었습니다

--II.테이블 생성 후 제약조건 추가/지정
--제거
[예제10-10]
alter table check_test
drop constraint check_salary_ck;

--다시 추가
[예제10-11]
alter table check_test
add constraint check_salary_dept_ck check (salary between 2000 and 10000 and dept_id in(10,20,30));

[예제10-12]
update check_test
set salary = 12000
where name='홍길동'; --체크 제약조건(HANUL.CHECK_SALARY_DEPT_CK)이 위배되었습니다

--10.3 unique - 중복방지
--데이터가 중복되지 않도록 유일성을 보장하는 제약조건
--컬럼 레벨, 테이블 레벨에서 정의
--복합키(Composite Key)를 생성할 수 있다. 예)보통 사번 vs 사번+이름
--primary key: unique + not null
--테이블 생성시 unique 지정
--I.컬럼레벨 정의
[예제10-13]
create table unique_test(
    col1    varchar2(5) unique not null,
    col2    varchar2(5),
    col3    varchar2(5) not null,
    col4    varchar2(5) not null,
    constraint uni_col2_uk unique(col2),
    constraint uni_col34_uk unique(col3, col4)
);

[예제10-14]중복 값을 제한하는지 입력 테스트
insert into unique_test (col1, col2, col3, col4)
values('A1','B1','C1','D1');

insert into unique_test (col1, col2, col3, col4)
values('A2','B2','C2','D2');

SELECT * from unique_test;

[예제10-15]업데이트 테스트
update unique_test
set col1='A1'
where col1='A2'; --무결성 제약 조건(HANUL.SYS_C008375)에 위배됩니다

desc unique_test;

[예제10-16]데이터 입력 테스트
insert into unique_test
values('A3', '', 'C3', 'D3');

insert into unique_test
values('A4', 'null', 'C4', 'D4');

--데이터정의
select constraint_name, constraint_type
from user_constraints
where table_name = 'UNIQUE_TEST';

[예제10-18] UNI-COL34_UK 제약조건을 삭제하고 col2,col3,col4를 UNIQUE 복합키로 지정하는↓
alter table unique_test
drop constraint uni_col34_uk;

[예제10-19] UNI-COL234_UK 제약조건 추가
alter table unique_test
add constraint uni_col234_uk unique(col2,col3,col4);

select *
from unique_test;

[예제10-20]
insert into unique_test
values ('A7', null, 'C4', 'D4');

--10.4 primary key 
--데이터 행을 대표하도록 유일하게 식별하기 위한 제약조건
--unique + not null의 형태
--컬럼레벨, 테이블 레벨에서 정의 ★복합키★를 생성할 수 있다.

--I. 컬럼레벨 정의
컬럼명 데이터 타입 primary key : 약식 --> sys_c008xxx
컬럼명 데이터 타입 constraint 제약조건명 primary key --> 테이블명_컬럼명_제약조건약어

--II. 테이블레벨 정의
constraint 테이블명_컬럼명_제약조건약어 primary key(컬럼명)

[예제10-21] dept_test 테이블을 생성하고 dept_id, dept_name 컬럼 각각 숫자 4바이트, 가변문자 30바이트
구조를 갖게하되 dept_name은 null을 허용하지 않고, dept_id를 기본키로 지정하는 쿼리를 작성

create table dept_test(
    컬럼명 데이터 타입 컬럼레벨-제약조건,
    컬럼명 데이터 타입,
    테이블레벨-제약조건
);

create table dept_test(
    dept_id number(4),
    dept_name varchar(30) not null,
    constraint dept_test_dept_id_pk primary key(dept_id)
);

[예제10-22]
insert into dept_test values(10,'영업부');
insert into dept_test values(10,'개발부');

[예제10-23]
alter table dept_test
drop constraint dept_test_id_pk;

--10.5 foreign key - 외래키(p.85)
--부모 테이블의 컬럼을 참조하는 자식 테이블의 컬럼에, 데이터의 무결성을 보장하기 위해 지정
--null 허용
--참조키, 외래키, FK
--컬럼레벨, 테이블레벨에서 정의, ★복합키★를 생성할 수 있다.
--컬럼명 데이터 타입 references 부모테이블 (참조되는 컬럼명)
--컬럼명 데이터 타입 constranit 제약조건명 references 부모테이블(참조되는 컬럼명)

--테이블레벨에서 정의
--constraint 테이블명_제약조건명_제약조건약어 foreign key (참조하는 컬럼명) references 부모테이블 (참조되는 컬럼명)
--사원 정보 테이블 <---> 부서 정보 테이블
--사원은 부서에 소속된다(=관계) N:1 [1:다] 관계 : RDBMS에서 가장 기본적인
--부서는 사원을 포함한다(=관계) 1:N [다:다] 관계 : 관계해소
--HR 스키마 -> 작은 규모의 데이터베이스 -> 기초에 충실한 테이블 설계

--데이터 모델링: 모델러 -> 테이블 설계, 컬럼, 제약조건 설정
--사원테이블
--부서테이블 <--> 어떤 회사의 업무를 파악, 분석 --> 데이터베이스 시스템 구축 : 개념 설계->논리설계->물리설계
--그 밖에...

--쇼핑몰 구축: 쇼핑몰 업무 파악(고객-상품 주문, 결제, 회사-상품 포장, 발송..)
--개념설계: 업무 관련 중요 키워드를 도출 -> 엔티티(=테이블), 컬럼(=특성)....
--논리설계: 그림으로 개체, 특성, 관계를 표시하는 과정
--물리설계: CREATE TABLE ~ ALTER TABLE~ INSERT INTO ~


--(사원-부서) I.개념설계
--고객 정보를 담는 테이블 : CUSTOMERS(고객ID, 고객명, 연락처...)
--상품 정보를 담는 테이블 : ITEMS(상품ID, 상품명, 가격)

--II.논리설계
--고객정보
---------------------------------------
고객ID    고객명    연락처..
PK         NN
---------------------------------------
0001     홍길동     010-1234-5645
0002     이길동
0003     박길동

--III.물리설계: SQL
CREATE TABLE CUSTOMERS(
    id number(4),
    name varchar2(20) not null,
    phone varchar2(11),
    constraint customers_id_pk primary key(id)
);

create table items(
    p_id number(4),
    p_type char(2) not null,
    p_born char(2) not null,
    regdate date,
    constraint items_p_id_pk primary key(p_id)
);

[예제10-26] emp_test: employees 테이블을 생성하고, 제약조건 거시오.
create table emp_test(
    emp_id number(4) primary key,
    ename varchar2(30) not null,
    dept_id number(4),
    job_id varchar2(10),
    constraint emp_test_dept_fk foreign key (dept_id)
    references dept_test (dept_id)
);

--hanul 게정의 권한(ROLE)이 hr 계정에 있는 테이블에 접근할 수 없는 상태라면, 에러가 발생
--권한을 부여(DCL)가 필요함.

select *
from dept_test;

[예제10-27]
insert into emp_test (emp_id, ename, dept_id, job_id)
values (100, 'King', 10, 'ST_MAN');

insert into emp_test (emp_id, ename, dept_id, job_id) 
values (101, 'Kong', 30, 'AC_MG'); --부서테이블 30번 부서는 존재하지 않는데, 입력 시도
--ORA-02291: 무결성 제약조건(HANUL.EMP_TEST_DEPT_FK)이 위배되었습니다- 부모 키가 없습니다
--30번 부서정보를 dept_test에 입력 후 사원정보를 재입력 -> 성공

insert into dept_test(dept_id, dept_name)
values (30, '판매부');

--테이블 생성 후 FK 추가지정
--일단 먼저 지우자 --> 제약 조건 이름을 알자
SELECT constraint_name, constraint_type
from user_constraints
where table_name = 'EMP_TEST';

--EMP_TEST_DEPT_ID_FK을 삭제
ALTER TABLE emp_test
DROP CONSTRAINT EMP_TEST_DEPT_ID_FK;

--다시 지정: 원래 없었다 가정하고(시험용)
ALTER TABLE emp_test
add constraint emp_test_dept_id_fk foreign key (dept_id) references dept_test (dept_id);

--default
--컬럼단위로 지정되는 속성, 데이터를 입력하지 않아도 지정된 값이 기본 입력되도록 한다.
--제약조건은 아니지만, 컬럼 레벨에서 작성

[예제10-30]
create table default_test(
    name varchar2(10) not null,
    hire_date date default sysdate not null,
    salary number(8) default 2500
);

insert into default_test (name, hire_date, salary)
values ('홍길동', to_date('2023-05-22', 'YYYY-MM-DD'), 3000); 

insert into default_test (name)
values ('김길동');

select *
from default_test;

commit;