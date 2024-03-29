--공지글 관리
create table notice(
id          number constraint notice_id_pk primary key,
title       varchar2(300) not null,
content     varchar2(4000) not null,
writer      varchar2(50) not null, /*작성자의 id*/
writedate   date default sysdate /*작성일자*/,
readcnt     number default 0 /*조회수*/,
filename    varchar2(300),
filepath    varchar2(600),
root        number /*답글 관리를 위한 id*/,
step        number /*글순서*/,
indent      number   /*들여쓰기*/,
rid         number constraint notice_rid_fk references notice(id) on delete cascade,

constraint notice_writer_fk foreign key(writer)
                            references member(userid) on delete cascade
                            
);





alter table notice add(
rid         number constraint notice_rid_fk references notice(id) on delete cascade
);

alter table notice add(
root number /*답글 관리를 위한 id*/,
step number default 0 /*글순서*/,
indent number default 0   /*들여쓰기*/
);

select (select count(*) from board_file where b.id=board_id) filecnt,b.* from (select row_number() 
over(order by id) no, b.*, name from board b inner join member m on b.writer = m.userid where 
title like '%' || '김심청' || '%' or content like '%' || '김심청' || '%' or writer in(select userid 
from member where name like '%' || '김심청' || '%') )b;

select count(*) from board where title like '%' || '김심청' || '%' or content like '%' || '김심청' 
|| '%' or writer in(select userid from member where name like '%' || '김심청' || '%');

select id, root, step, indent, rid from notice
order by id desc;

update notice set root = id;

commit;

drop table notice;

PK인 id 컬럼에 적용할 시퀀스 생성


create sequence seq_notice
start with 1 increment by 1 nocache;



insert into notice(id, title, content, writer)
values (seq_notice.nextval, '테스트 공지글', '이 글은 테스트 공지글입니다.', '1');

insert into notice(id, title, content, writer)
values (seq_notice.nextval, '두번 째 공지글', '이 글은 두 번째 공지글입니다.', '2');

select * from notice;

notice의 pk인 id에 시퀀스를 자동 적용시킬 트리거 생성
create or replace trigger trg_notice /*트리거 재컴파일러시 */
    before insert on notice
    for each row
begin
    select seq_notice.nextval into :new.id from dual;
    
        /*원글인 경우 root에 값을 넣기 위한 처리*/
    if( :new.root is null) then
    select seq_notice.currval into :new.root from dual;
    else
        /*답글인 경우 순서를 위한 step변경처리*/
        update notice set step = step + 1
        where root = :new.root and step >= :new.step;

    end if;
    
end;
/

select * from board_file

--원글 삭제시 답글들 삭제처리
create or replace trigger trg_notice_delete
        after delete on notice
        for each row
begin
    --삭제한 글의 root와 같은 root인 데이터행 삭제
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
where title = '테스트';

관리자, 운영자
select count(*) from notice
where writer ;


select count(*) from notice;

delete from notice where mod(id, 5) = 0;

select * from member;

select * from notice;


insert into notice(title, content, writer)
select title, content, writer from notice;

1. null 허용시 constraint 옵션 지정: on delete set null
2. null 불허시 constraint 옵션 지정: on delete cascade