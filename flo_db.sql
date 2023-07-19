create table flo(
id            number constraint flo_id_pk primary key,
user_id       varchar2(300) not null,
pw            varchar2(300) not null,
name          varchar2(50) not null,
phone         varchar2(100) not null

);

drop table flo;

create SEQUENCE seq_flo increment by 1 start with 1 NOCACHE;


select * from flo where user_id = 'test' and pw = 'test1';

insert into flo(user_id, pw, name, phone) values('test', 'test1', 'ев╫╨ем', '010-7777-7777');

select * from flo;

create or replace trigger trg_flo
     before insert on flo
     for each row
begin
    select seq_flo.nextval into :new.id from dual;
end;
/

