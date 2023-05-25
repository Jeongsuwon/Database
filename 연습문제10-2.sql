--1. 이메일 정보가 없는 배역들의 모든 정보 조회
select *
from characters
where email is null;


--2. 역할이 시스에 해당하는 등장인물을 조회
select *
from characters
where role_id = (select role_id
                from roles
                where role_name='시스');

--3. 에피소드 4에 출연한 배우들의 실제이름을 조회
select real_name
from casting
where episode_id = (select episode_id
                    from star_wars
                    where episode_id = 4);
                    
select * from star_wars;

--4. 에피소드 5에 출연한 배우들의 배역이름과 실제이름 조회
select ch.character_name, c.real_name
from casting c, characters ch
where c.character_id = ch.character_id and episode_id = 5;

commit;

--5. 에피소드2에 출연한 모든 배우들의 배역이름, 실제이름, 역할 조회
-- ansi조인: inner join, outer join
-- on절 : where 조건절 대신
-- using: 컬럼의 별칭/약어 사용x
-- (+): 오라클 아우터 조인 <-----> [left|right|full] outer join

select c.character_name, p.real_name, r.role_name
from characters c full outer join casting p
on c.character_id = p.character_id
right outer join roles r
on c.role_id = r.role_id
and p.episode_id = 2;

--characters 데이터와 casting 데이터간 불일치: 교재vs직접 수집

--6. characters 테이블에서 배역이름, 이메일, 이메일 아이디 조회(이메일아이디는 @ 앞)
select character_name, email, substr(email,1 ,instr(email,'@')-1) as email_id
from characters;

--7. 역할이 제다이에 해당하는 배역들의 배역이름, 마스터이름을 조회
select c.character_name, nvl(m.character_name, '다른값1' ) as masters
from characters c, roles r, characters m
where c.role_id = r.role_id
and r.role_name = '제다이'
and c.master_id = m.character_id(+)
order by 1;

select master_id from characters;