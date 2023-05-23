--[��������10-1]
--hanul�������� Ǯ��

--1~3. ������ ���̺��� ����

create table star_wars(
    episode_id number(5) primary key,
    episode_name varchar2(50),
    open_year number(4)
);

select *
from user_constraints
where table_name = 'STAR_WARS';

--�߰� ���� : nn �������� �߰� x --> �÷� ���� ����
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
    constraint casting_episode_id_pk primary key(episode_id, character_id) --����Ű
);
commit;

-- 4. star_wars ���̺� ������ �Է�

insert into star_wars
values (4, '���ο� ���', 1977);

insert into star_wars
values (5, '������ ����', 1980);

insert into star_wars
values (6, '�������� ��ȯ', 1983);

insert into star_wars
values (1, '������ �ʴ� ����', 1999);

insert into star_wars
values (2, 'Ŭ���� ����', 2002);

insert into star_wars
values (3, '�ý��� ����', 2005);

select *
from star_wars;

commit;

-- 5. characters ���̺� ������ ����
INSERT INTO characters (character_id, character_name, email)
VALUES (1, '��ũ ��ī�̿�Ŀ', 'luke@jedai.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (2, '�� �ַ�', 'solo@alliance.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (3, '���̾� ����', 'leia@alliance.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (4, '����� �ɳ��', 'Obi-Wan@jedai.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (5, '�پ� ���̴�', 'vader@sith.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (6, '�پ� ���̴�(��Ҹ�)', 'vader_voice@sith.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (7, 'C-3PO', 'c3po@alliance.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (8, 'R2-D2', 'r2d2@alliance.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (9, '���ī', 'Chewbacca@alliance.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (10, '���� Į���þ�', NULL);
INSERT INTO characters (character_id, character_name, email)
VALUES (11, '���', 'yoda@jedai.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (12, '�پ� �õ�', 'sidious@sith.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (13, '�Ƴ�Ų ��ī�̿�Ŀ', 'Anakin@jedai.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (14, '���̰� ��', NULL);
INSERT INTO characters (character_id, character_name, email)
VALUES (15, '�ƹ̴޶� ����', NULL);
INSERT INTO characters (character_id, character_name, email)
VALUES (16, '�Ƴ�Ų ��Ӵ�', NULL);
INSERT INTO characters (character_id, character_name, email)
VALUES (17, '���ں�ũ��(��Ҹ�)',NULL);
INSERT INTO characters (character_id, character_name, email)
VALUES (18, '�پ� ��', 'maul@sith.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (19, '��� ��', NULL);
INSERT INTO characters (character_id, character_name, email)
VALUES (20, '������ ����', 'windu@jedai.com');
INSERT INTO characters (character_id, character_name, email)
VALUES (21, '���� ����', 'dooku@jedai.com');

-- �÷��� ��Ÿ
ALTER TABLE characters
RENAME COLUMN charater_name TO character_name;

-- Ȯ��
SELECT *
FROM    characters;

-- Ŀ��
COMMIT;


-- 6. roles ���̺� ���� , ������ ����
CREATE TABLE roles (
    role_id NUMBER(4),
    role_name VARCHAR2(20)
);

INSERT INTO roles
VALUES (1001, '������');
INSERT INTO roles
VALUES (1002, '�ý�');
INSERT INTO roles
VALUES (1003, '�ݶ���');

SELECT *
FROM    roles;

COMMIT;


-- 7. characters ���̺��� role_id �÷��� �����Ͱ� roles ���̺��� role_id �÷��� �����͸�
-- �����ϵ��� charaters ���̺� ����Ű(=�ܷ�Ű, FK)�� �����Ͻÿ�

-- 7.1 roles ���̺��� ROLE_ID�� �⺻Ű ����
ALTER TABLE roles
ADD CONSTRAINT roles_id_pk PRIMARY KEY (role_id); -- Table ROLES��(��) ����Ǿ����ϴ�.

-- 7.2 ���̺� ������ �� �������� ���� : characters ���̺��� role_id�� roles ���̺��� role_id �ܷ�Ű ����
ALTER TABLE characters
ADD CONSTRAINT characters_role_id_fk FOREIGN KEY (role_id) REFERENCES roles (role_id);
-- Table CHARACTERS��(��) ����Ǿ����ϴ�.

-- 7.3 Ȯ�� [���� �˾Ƽ�..�ʿ��ϸ�]
INSERT INTO characters (character_id, character_name, role_id, email)
VALUES (22, '���� �Ǵ�', 1004 ,'dooku@jedai.com');
-- ORA-02291: ���Ἲ ��������(HANUL.CHARACTERS_ROLE_ID_FK)�� ����Ǿ����ϴ�- �θ� Ű�� �����ϴ�

INSERT INTO characters (character_id, character_name, role_id, email)
VALUES (22, '���� �Ǵ�', 1003 ,'real_devil@jedai.com');

rollback;

SELECT *
FROM    characters;

-- 8. DML : UPDATE - �����ؼ� �����͸� ����
UPDATE characters
SET role_id = 1002
WHERE   email LIKE '%sith%'; -- 4rows

UPDATE characters
SET role_id = 1003
WHERE   email LIKE '%alliance%'; -- 5rows

UPDATE characters
SET role_id = 1001
WHERE   character_name IN ('��ũ ��ī�̿�Ŀ', '����� �ɳ��', '���', '�Ƴ�Ų ��ī�̿�Ŀ', '���̰� ��', '������ ����', '���� ����');
-- 7rows


SELECT *
FROM    characters;

-- �˾Ƽ� Ŀ��
COMMIT;

