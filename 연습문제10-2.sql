--1. �̸��� ������ ���� �迪���� ��� ���� ��ȸ
select *
from characters
where email is null;


--2. ������ �ý��� �ش��ϴ� �����ι��� ��ȸ
select *
from characters
where role_id = (select role_id
                from roles
                where role_name='�ý�');

--3. ���Ǽҵ� 4�� �⿬�� ������ �����̸��� ��ȸ
select real_name
from casting
where episode_id = (select episode_id
                    from star_wars
                    where episode_id = 4);
                    
select * from star_wars;

--4. ���Ǽҵ� 5�� �⿬�� ������ �迪�̸��� �����̸� ��ȸ
select ch.character_name, c.real_name
from casting c, characters ch
where c.character_id = ch.character_id and episode_id = 5;

commit;

--5. ���Ǽҵ�2�� �⿬�� ��� ������ �迪�̸�, �����̸�, ���� ��ȸ
-- ansi����: inner join, outer join
-- on�� : where ������ ���
-- using: �÷��� ��Ī/��� ���x
-- (+): ����Ŭ �ƿ��� ���� <-----> [left|right|full] outer join

select c.character_name, p.real_name, r.role_name
from characters c full outer join casting p
on c.character_id = p.character_id
right outer join roles r
on c.role_id = r.role_id
and p.episode_id = 2;

--characters �����Ϳ� casting �����Ͱ� ����ġ: ����vs���� ����

--6. characters ���̺��� �迪�̸�, �̸���, �̸��� ���̵� ��ȸ(�̸��Ͼ��̵�� @ ��)
select character_name, email, substr(email,1 ,instr(email,'@')-1) as email_id
from characters;

--7. ������ �����̿� �ش��ϴ� �迪���� �迪�̸�, �������̸��� ��ȸ
select c.character_name, nvl(m.character_name, '�ٸ���1' ) as masters
from characters c, roles r, characters m
where c.role_id = r.role_id
and r.role_name = '������'
and c.master_id = m.character_id(+)
order by 1;

select master_id from characters;