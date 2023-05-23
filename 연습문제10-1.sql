--[연습문제10-1]
--hanul계정으로 풀이

--1~3. 다음의 테이블을 생성

create table star_wars(
    episode_id number(5) primary key,
    episode_name varchar2(50),
    open_year number(4)
);

select *
from user_constraints
where table_name = 'STAR_WARS';

--추가 지정 : nn 제약조건 추가 x --> 컬럼 정의 수정
alter table star_wars
modify episode_name not null;

create table characters(
    character_id number(5) primary key,
    character_name varchar2(30) not null,
    master_id number(5),
    role_id number(4),
    email varchar2(40)
);

create table casting(
    episode_id number(5),
    character_id number(5),
    real_name varchar2(30),
    constraint casting_episode_id_pk primary key(episode_id, character_id) --복합키
);
commit;

-- 4. star_wars 테이블에 데이터 입력

insert into star_wars
values (4, '새로운 희망', 1977);

insert into star_wars
values (5, '제국의 역습', 1980);

insert into star_wars
values (6, '제다이의 귀환', 1983);

insert into star_wars
values (1, '보이지 않는 위험', 1999);

insert into star_wars
values (2, '클론의 습격', 2002);

insert into star_wars
values (3, '시스의 복수', 2005);

select *
from star_wars;

commit;

-- 5. characters 테이블에 데이터 저장
INSERT INTO characters (character_id, character_name, email)
VALUES (1, '루크 스카이워커', 'luke@jedai.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (2, '한 솔로', 'solo@alliance.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (3, '레이아 공주', 'leia@alliance.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (4, '오비완 케노비', 'Obi-Wan@jedai.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (5, '다쓰 베이더', 'vader@sith.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (6, '다쓰 베이더(목소리)', 'vader_voice@sith.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (7, 'C-3PO', 'c3po@alliance.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (8, 'R2-D2', 'r2d2@alliance.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (9, '츄바카', 'Chewbacca@alliance.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (10, '랜도 칼리시안', NULL);
INSERT INTO characters (character_id, character_name, email)
VALUES (11, '요다', 'yoda@jedai.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (12, '다쓰 시디어스', 'sidious@sith.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (13, '아나킨 스카이워커', 'Anakin@jedai.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (14, '콰이곤 진', NULL);
INSERT INTO characters (character_id, character_name, email)
VALUES (15, '아미달라 여왕', NULL);
INSERT INTO characters (character_id, character_name, email)
VALUES (16, '아나킨 어머니', NULL);
INSERT INTO characters (character_id, character_name, email)
VALUES (17, '자자빙크스(목소리)',NULL);
INSERT INTO characters (character_id, character_name, email)
VALUES (18, '다쓰 몰', 'maul@sith.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (19, '장고 펫', NULL);
INSERT INTO characters (character_id, character_name, email)
VALUES (20, '마스터 윈두', 'windu@jedai.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (21, '두쿠 백작', 'dooku@jedai.com');

-- 컬럼명 오타
ALTER TABLE characters
RENAME COLUMN charater_name TO character_name;

-- 확인
SELECT *
FROM    characters;

-- 커밋
COMMIT;


-- 6. roles 테이블 생성 , 데이터 삽입
CREATE TABLE roles (
    role_id NUMBER(4),
    role_name VARCHAR2(20)
);

INSERT INTO roles
VALUES (1001, '제다이');
INSERT INTO roles
VALUES (1002, '시스');
INSERT INTO roles
VALUES (1003, '반란군');

SELECT *
FROM    roles;

COMMIT;


-- 7. characters 테이블의 role_id 컬럼의 데이터가 roles 테이블의 role_id 컬럼의 데이터를
-- 참조하도록 charaters 테이블에 참조키(=외래키, FK)를 생성하시오

-- 7.1 roles 테이블의 ROLE_ID를 기본키 지정
ALTER TABLE roles
ADD CONSTRAINT roles_id_pk PRIMARY KEY (role_id); -- Table ROLES이(가) 변경되었습니다.

-- 7.2 테이블 생성된 후 제약조건 지정 : characters 테이블의 role_id를 roles 테이블의 role_id 외래키 지정
ALTER TABLE characters
ADD CONSTRAINT characters_role_id_fk FOREIGN KEY (role_id) REFERENCES roles (role_id);
-- Table CHARACTERS이(가) 변경되었습니다.

-- 7.3 확인 [각자 알아서..필요하면]
INSERT INTO characters (character_id, character_name, role_id, email)
VALUES (22, '완전 악당', 1004 ,'dooku@jedai.com');
-- ORA-02291: 무결성 제약조건(HANUL.CHARACTERS_ROLE_ID_FK)이 위배되었습니다- 부모 키가 없습니다

INSERT INTO characters (character_id, character_name, role_id, email)
VALUES (22, '완전 악당', 1003 ,'real_devil@jedai.com');

rollback;

SELECT *
FROM    characters;

-- 8. DML : UPDATE - 변경해서 데이터를 저장
UPDATE characters
SET role_id = 1002
WHERE   email LIKE '%sith%'; -- 4rows

UPDATE characters
SET role_id = 1003
WHERE   email LIKE '%alliance%'; -- 5rows

UPDATE characters
SET role_id = 1001
WHERE   character_name IN ('루크 스카이워커', '오비완 케노비', '요다', '아나킨 스카이워커', '콰이곤 진', '마스터 윈두', '두쿠 백작');
-- 7rows


SELECT *
FROM    characters;

-- 알아서 커밋
COMMIT;

