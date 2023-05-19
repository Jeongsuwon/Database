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
--10.2 check - 값의 범위
--10.3 unique - 중복방지
--10.4 primary key - unique + not null
--10.5 foreign key - 외래키



