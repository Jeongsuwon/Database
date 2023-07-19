--������ ����
create table notice(
id          number constraint notice_id_pk primary key,
title       varchar2(300) not null,
content     varchar2(4000) not null,
writer      varchar2(50) not null, /*�ۼ����� id*/
writedate   date default sysdate /*�ۼ�����*/,
readcnt     number default 0 /*��ȸ��*/,
filename    varchar2(300),
filepath    varchar2(600),
root        number /*��� ������ ���� id*/,
step        number /*�ۼ���*/,
indent      number   /*�鿩����*/,
rid         number constraint notice_rid_fk references notice(id) on delete cascade,

constraint notice_writer_fk foreign key(writer)
                            references member(userid) on delete cascade
                            
);





alter table notice add(
rid         number constraint notice_rid_fk references notice(id) on delete cascade
);

alter table notice add(
root number /*��� ������ ���� id*/,
step number default 0 /*�ۼ���*/,
indent number default 0   /*�鿩����*/
);

select (select count(*) from board_file where b.id=board_id) filecnt,b.* from (select row_number() 
over(order by id) no, b.*, name from board b inner join member m on b.writer = m.userid where 
title like '%' || '���û' || '%' or content like '%' || '���û' || '%' or writer in(select userid 
from member where name like '%' || '���û' || '%') )b;

select count(*) from board where title like '%' || '���û' || '%' or content like '%' || '���û' 
|| '%' or writer in(select userid from member where name like '%' || '���û' || '%');

select id, root, step, indent, rid from notice
order by id desc;

update notice set root = id;

commit;

drop table notice;

PK�� id �÷��� ������ ������ ����


create sequence seq_notice
start with 1 increment by 1 nocache;



insert into notice(id, title, content, writer)
values (seq_notice.nextval, '�׽�Ʈ ������', '�� ���� �׽�Ʈ �������Դϴ�.', '1');

insert into notice(id, title, content, writer)
values (seq_notice.nextval, '�ι� ° ������', '�� ���� �� ��° �������Դϴ�.', '2');

select * from notice;

notice�� pk�� id�� �������� �ڵ� �����ų Ʈ���� ����
create or replace trigger trg_notice /*Ʈ���� �������Ϸ��� */
    before insert on notice
    for each row
begin
    select seq_notice.nextval into :new.id from dual;
    
        /*������ ��� root�� ���� �ֱ� ���� ó��*/
    if( :new.root is null) then
    select seq_notice.currval into :new.root from dual;
    else
        /*����� ��� ������ ���� step����ó��*/
        update notice set step = step + 1
        where root = :new.root and step >= :new.step;

    end if;
    
end;
/

select * from board_file

--���� ������ ��۵� ����ó��
create or replace trigger trg_notice_delete
        after delete on notice
        for each row
begin
    --������ ���� root�� ���� root�� �������� ����
    delete from notice where root = :old.root;
end;
/

alter trigger trg_notice_delete disable; --disable/enable

commit;

select *
from (select row_number() over(order by id) no, n.*, name
        from notice n inner join member m on n.writer = m.
        where title like '%%') n
where no between 1 and 7
order by no desc
;

select count(*) from notice
where title = '�׽�Ʈ';

������, ���
select count(*) from notice
where writer ;


select count(*) from notice;

delete from notice where mod(id, 5) = 0;

select * from member;

select * from notice;


insert into notice(title, content, writer)
select title, content, writer from notice;

1. null ���� constraint �ɼ� ����: on delete set null
2. null ����� constraint �ɼ� ����: on delete cascade