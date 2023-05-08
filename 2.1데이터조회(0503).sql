--µ¥ÀÌÅÍ°¡ ´ã±ä Å×ÀÌºí ±¸Á¶¸¦ Á¶È¸ ¸í·É
--desc Å×ÀÌºí¸í;
--describe Å×ÀÌºí¸í;
--´ë, ¼Ò¹®ÀÚ ±¸ºĞÇÏÁö ¾ÊÀ½.
--¡Ø ¿ŞÂÊ Á¢¼ÓÃ¢ [+] ´©¸£¸é °°Àº ±â´É! (±¸Á¶¸¦ È®ÀÎ)

desc departments;
--³ª¸ÓÁö Å×ÀÌºíÀ» ¸ğµÎ Á¶È¸ÇØº¸¼¼¿ä!
select * from employees;
select * from countries;
select * from departments;
select * from job_history;
select * from jobs;
select * from locations;
select * from regions;
--2. µ¥ÀÌÅÍ¸¦ Á¶È¸ÇÏ´Â select
--select * from Å×ÀÌºí¸í;

--¡Ø ¿ŞÂÊ Á¢¼Ó¿¡¼­ °¢ Å×ÀÌºíÀ» ´õºíÅ¬¸¯ÇÏ°í, [µ¥ÀÌÅÍ] ÄÃ·³À» Å¬¸¯ÇÏ¸é °°Àº ±â´É

/*
HR ½ºÅ°¸¶¿¡ ÀÖ´Â Å×ÀÌºí(=¿À¶óÅ¬ µ¥ÀÌÅÍº£ÀÌ½º °´Ã¼ Áß ÇÏ³ª)
==========================================================
ÀÌ¸§                  Á¤º¸
----------------------------------------------------------

*/

-- 2.1 Å×ÀÌºí ±¸Á¶
-- ¿À¶óÅ¬(=µ¥ÀÌÅÍº£ÀÌ½º °ü¸® ½Ã½ºÅÛ)ÀÌ µ¥ÀÌÅÍ¸¦ 2Â÷¿ø ±¸Á¶(Ç¥, tableÀÇ Çà°ú ¿­·Î)·Î ±âº»ÀûÀ¸·Î ÀúÀå
-- Å×ÀÌºí : ¾î¶² Á¤º¸°¡ ÀÖ´Âµ¥ <--> µ¥ÀÌÅÍº£ÀÌ½º : °ü°è(Relation)
-- ex> (È¸»ç) ºÎ¼­ Á¤º¸ Å×ÀÌºí, »ç¿ø Á¤º¸ Å×ÀÌºí
-- ¡Ø Document : Çà, ¿­ ±¸Á¶°¡ ¾Æ´Ô vs RDBMS : Å×ÀÌºí(Çà, ¿­)

select * from employees where department_id=80;

select * from departments where department_id=80;

select department_id, department_name, location_id from departments where department_id = 80;
select department_id, department_name, location_id from departments where department_name = 'Sales'; --¹®ÀÚ´Â '·Î ÀÛ¼º, ´ë/¼Ò¹®ÀÚ ±¸ºĞ[³¯Â¥µµ]

/*
    where Á¶°ÇÀıÀ» ±¸¼ºÇÏ´Â Ç×¸ñÀÇ ºĞ·ù(p.5)
    1) ÄÃ·³, ¼ıÀÚ, ¹®ÀÚ
    2) »ê¼ú¿¬»êÀÚ(+,-,*,/), ºñ±³¿¬»êÀÚ(=, <=, <, >, >=, <>) --MOD(Á¦¼ö,ÇÇÁ¦¼ö) : % ´ë½Å »ç¿ëÇÏ´Â ÇÔ¼ö
    3) any, some, all
    4) exists
*/


--2.2 ¿¬»êÀÚ
--2.2.1 »ê¼ú¿¬»êÀÚ
--»ê¼ú¿¬»êÀÚ´Â select ¸ñ·Ï°ú Á¶°ÇÀı¿¡ »ç¿ëÇÒ ¼ö ÀÖ½À´Ï´Ù.

select 2+2 as ÇÕ from dual; --½ÇÁ¦ Á¸ÀçÇÏÁö ¾Ê´Â Å×ÀÌºí dual, ´Ü¼øÈ÷ »ê¼ú¿¬»ê, ½Ã½ºÅÛ ³¯Â¥ Ãâ·Â, ÇÔ¼ö¸¦ ½ÇÇà, ¹İÈ¯°ª È®ÀÎ
select 2-1 as Â÷ from dual;
--¼Ò¹®ÀÚ Å×ÀÌºí¸íÀ¸·Î ÀÛ¼ºÇÏ·Á¸é »ı¼ºÇÒ ¶§ "¼Ò¹®ÀÚ"·Î ¸í·ÉÀ» Ã³¸®!

select employee_id, last_name, salary ,salary*12 as ¿¬ºÀ, department_id 
from employees 
where salary*12>=200000; 

[¿¹Á¦2-4] 80¹ø ºÎ¼­ »ç¿øÀÇ ÇÑ ÇØ µ¿¾È ¹ŞÀº ±Ş¿©¸¦ Á¶È¸ÇÑ´Ù.
select employee_id as »ç¹ø, last_name as ¼º, salary * 12 as ¿¬ºÀ
from employees
where department_id=80;

--2.3.2 ¿¬°á¿¬»êÀÚ

[¿¹Á¦2-5] ÇÑ ÇØ µ¿¾È ¹ŞÀº ±Ş¿©°¡ 120000ÀÎ »ç¿øÁ¤º¸¸¦ Á¶È¸ÇÑ´Ù.
select employee_id, last_name, salary*12 || '$'  -- ¹®ÀÚ¿­ ¿¬°á ¿¬»êÀÚ : || , ¹®ÀÚ¿­ ¿¬°á ÇÔ¼ö -> CONCAT()
from employees                                   -- ¹®ÀÚ µ¥ÀÌÅÍ, ¼ıÀÚ µ¥ÀÌÅÍ : '·Î ¹­À½
where salary*12=120000;

[¿¹Á¦2-6] »ç¹øÀÌ 101¹øÀÎ »ç¿øÀÇ ¼º¸íÀ» Á¶È¸ÇÑ´Ù.
select employee_id, last_name ||''|| first_name 
from employees 
where employee_id = 101;
--ºÎ¼­ ¹øÈ£°¡ 90ÀÎ ºÎ¼­
select department_name 
from departments 
where department_id=90;

[¿¹Á¦2-8] »ç¹øÀÌ 101¹øÀÎ »ç¿øÀÇ ¼º°ú ÇÑ ÇØ µ¿¾È ¹ŞÀº ±Ş¿©¸¦ Á¶È¸ÇÑ´Ù.
select employee_id as »ç¹ø, last_name ¼º, salary * 12 as "ANNUAL SALARY"
from employees
where employee_id=101;

--2.3.3 ºñ±³¿¬»êÀÚ (p.6)
--°ªÀÇ Å©±â ºñ±³
[¿¹Á¦2-9] ±Ş¿©°¡ 3000ÀÌÇÏÀÎ »ç¿øÀÇ Á¤º¸¸¦ Á¶È¸ÇÑ´Ù.
select employee_id, last_name, salary, department_id
from employees
where salary<=3000;

[¿¹Á¦2-10] ºÎ¼­ÄÚµå°¡ 80¹ø ÃÊ°úÀÎ »ç¿øÀÇ Á¤º¸¸¦ Á¶È¸ÇÑ´Ù.
--ºÎ¼­ÄÚµå : deparment_id
--»ç¿øÄÚµå : employee_id
--¾÷¹«ÄÚµå : job_id
--ºÎ¼­¯•ÄÚµå : manager_id

select *
from employees
where department_id>80;

-- ¹®ÀÚ µ¥ÀÌÅÍ, ¼ıÀÚ µ¥ÀÌÅÍ : '·Î ¹­À½ / ´ë¼Ò¹®ÀÚ ±¸ºĞ
select *
from employees
where last_name = 'Chen'; --'chen' ¿À·ù

select employee_id, last_name, hire_date
from employees
where hire_date>'05/09/28';

[¿¹Á¦2-11] ¼ºÀÌ KingÀÎ »ç¿øÀÇ Á¤º¸¸¦ Á¶È¸ÇÑ´Ù.
select employee_id,last_name, email, phone_number, hire_date 
from employees
where last_name='King';

[¿¹Á¦2-12] ÀÔ»çÀÏÀÌ 2004³â 1¿ù 1ÀÏ ÀÌÀüÀÎ »ç¿øÀÇ Á¤º¸¸¦ Á¶È¸
select *
from employees
where hire_date<='04/01/01';

--2.3.4 ³í¸®Á¶°Ç ¿¬»êÀÚ(p.8)
--Á¶°ÇÀÇ °¹¼ö´Â ¿©·¯ °³°¡ ¿Ã ¼ö ÀÖ´Ù.
--¿©·¯ Á¶°ÇÀÌ ÀÖÀ» °æ¿ì °¢°¢ÀÇ Á¶°ÇµéÀ» AND, OR ¿¬»êÀÚ¸¦ ÀÌ¿ëÇØ ¿¬°áÇÑ´Ù.

[¿¹Á¦2-13] 30¹ø ºÎ¼­ »ç¿ø Áß ±Ş¿©°¡ 10000ÀÌÇÏÀÎ »ç¿øÀÇ Á¤º¸¸¦ Á¶È¸ÇÑ´Ù.
--»ç¿øÀÇ Á¤º¸´Â : employees 
--employee_id ~ department_id : °¢Á¾ »ç¿øµéÀÇ Á¤º¸ Áß ¾î¶² Æ¯Á¤ ÄÃ·³µéÀÌ Á¸Àç
--ºÎ¼­ Á¤º¸´Â departments¿¡ ÀÖÀ¸³ª, »ç¿øµéÀº ºÎ¼­ 10~110¹ø±îÁö ¼Ò¼ÓµÇ¾î ÀÖÀ½

select employee_id, first_name ||' ' || last_name as name, salary,department_id
from employees
where department_id = 30 and salary<=10000;

[¿¹Á¦2-14] 30¹ø ºÎ¼­ »ç¿ø Áß ±Ş¿©°¡ 10000ÀÌÇÏÀÌ°í, ÀÔ»ç ÀÏÀÚ°¡ 2005³â ÀÌÀüÀÎ »ç¿øÀÇ Á¤º¸¸¦ Á¶È¸ÇÑ´Ù.
select employee_id, first_name ||' ' || last_name as name, salary,department_id
from employees
where department_id = 30 and salary<=10000 and hire_date<'2005-01-01';

[¿¹Á¦2-15] 30¹ø ºÎ¼­³ª 60¹ø ºÎ¼­¿¡ ¼ÓÇÑ »ç¿øÀÇ Á¤º¸¸¦ Á¶È¸ÇÏ½Ã¿À.
select first_name||' '|| last_name as name, salary, department_id as dept_id, hire_date
from employees
where (department_id = 30 or department_id = 60)and hire_date<'2005-01-01';

select first_name||' '|| last_name as name
from employees
where department_id=60 and hire_date<'2005-01-01';

--2.3.5 ¹üÀ§ Á¶°Ç ¿¬»êÀÚ between ÃÊ±â°ª(ÀÌ»ó) and ¸¶Áö¸·°ª(ÀÌÇÏ)
[¿¹Á¦ 2-18] »ç¹ø 110¹øºÎÅÍ 120¹ø±îÁöÀÇ »ç¿ø Á¤º¸¸¦ Á¶È¸ÇÑ´Ù.
select employee_id as emp_id, first_name ||' '|| last_name as name, salary, department_id as dept_id
from employees
where employee_id between 110 and 120;

[¿¹Á¦ 2-18] »ç¹ø 110¹øºÎÅÍ 120¹ø±îÁö¸¦ Á¦¿ÜÇÑ »ç¿ø Á¤º¸¸¦ Á¶È¸ÇÑ´Ù.
select employee_id as emp_id, first_name ||' '|| last_name as name, salary, department_id as dept_id
from employees
where not employee_id between 110 and 120;

--betweenÀÌ³ª °ü°è¿¬»êÀÚ·Î ºñ±³ÇÒ ¼ö ÀÖ´Â °ªÀº ¼ıÀÚ, ¹®ÀÚ, ³¯Â¥ µ¥ÀÌÅÍÀÌ´Ù.

--³¯Â¥ Çü½ÄÀ¸·Î º¯È¯ÇÏ´Â ÇÔ¼ö : TO_DATE('³¯Â¥µ¥ÀÌÅÍ');
--RR/MM/DD ¶Ç´Â TO_DATE('³¯Â¥µ¥ÀÌÅÍ', 'ÁöÁ¤Çü½Ä YY-MM-DD HH:MI:SS')
--3Àå. ÇÔ¼ö - º¯È¯ÇÔ¼ö ÆÄÆ®(p.27)

--2.3.7 IN Á¶°Ç¿¬»êÀÚ(p.11)
--OR ¿¬»êÀÚ ´ë½Å IN¿¬»êÀÚ ==> °¡µ¶¼º, °£°á¼º

[¿¹Á¦2-25] 30¹ø ºÎ¼­¿ø ¶Ç´Â 60¹ø ºÎ¼­¿ø ¶Ç´Â 90¹ø ºÎ¼­¿øÀÇ Á¤º¸¸¦ Á¶È¸
select *
from employees
where department_id in(30,60,90);

--2.3.8 like ¿¬»êÀÚ(p.11)
--ÄÃ·³°ª Áß Æ¯Á¤ ÆĞÅÏ¿¡ ¼ÓÇÏ´Â °ªÀ» Á¶È¸ÇÒ ¶§ »ç¿ëÇÏ´Â ¹®ÀÚ¿­ ÆĞÅÏ ¿¬»êÀÚ
-- 1) % : ¿©·¯ °³ÀÇ ¹®ÀÚ¿­À» ³ªÅ¸³½´Ù.
-- 2) _ : ÇÏ³ªÀÇ ¹®ÀÚ¿­À» ³ªÅ¸³½´Ù.

[¿¹Á¦2-28] ÀÌ¸§ÀÌ K·Î ½ÃÀÛµÇ´Â »ç¿ø Á¤º¸¸¦ Á¶È¸ÇÑ´Ù.
select *
from employees
where first_name like 'K%';

[¿¹Á¦2-28] ¼ºÀÌ s·Î ³¡³ª´Â »ç¿ø Á¤º¸¸¦ Á¶È¸ÇÑ´Ù.
select *
from employees
where last_name like '%s';

desc employees;
--varchar2(±æÀÌ) : ¹®ÀÚ µ¥ÀÌÅÍ
--varchar(±æÀÌ) : ÀÏ¹İÀûÀÎ ¸ñÀûÀ¸·Î »ç¿ë x, ¿À¶óÅ¬¿¡¼­ »ç¿ëÇÒ ¿¹Á¤ÀÎ Å¸ÀÔ -> ¿ì¸®´Â »ç¿ë x
--number(±æÀÌ) : Á¤¼ö
--number(ÃÑ ±æÀÌ, ¼Ò¼ıÁ¡ÀÌÇÏ ±æÀÌ) : ½Ç¼ö
--date : ³¯Â¥

[¿¹Á¦2-31] ÀÌ¸ŞÀÏÀÇ ¼¼¹ø Â° ¹®ÀÚ°¡ BÀÎ »ç¿øÁ¤º¸¸¦ Á¶È¸ÇÑ´Ù.
select *
from employees
where email like '__B%';

[¿¹Á¦2-31] ÀÌ¸ŞÀÏÀÇ µÚ¿¡¼­ ¼¼¹ø Â° ¹®ÀÚ°¡ BÀÎ »ç¿øÁ¤º¸¸¦ Á¶È¸ÇÑ´Ù.
select *
from employees
where email like '%B__';

--like ¿ª½Ã in, between °ú °°ÀÌ not ¿¬»êÀÚ¿Í ÇÔ²² »ç¿ë °¡´É(p.14)

[¿¹Á¦2-33] ÀüÈ­¹øÈ£°¡ 6À¸·Î ½ÃÀÛµÇÁö ¾Ê´Â »ç¿øÀÇ Á¤º¸¸¦ Á¶È¸ÇÑ´Ù.
select *
from employees
where phone_number not like '6%';

--Q. %³ª _ ÀÚÃ¼¸¦ ¹®ÀÚ¿­·Î Ç¥ÇöÇÏ°íÀÚ ÇÏ¸é?
[¿¹Á¦2-34] job_id¿¡ _A°¡ µé¾î°£ »ç¿ø Á¤º¸¸¦ Á¶È¸
select *
from employees
where job_id like '%_A%';

--2.3.9 NULL Á¶°Ç Ã³¸®
select *
from locations
where state_province is null;

select *
from locations
where state_province is not null;

--is null : nullÀÎ µ¥ÀÌÅÍ¸¦ Á¶È¸
--is not null : nullÀÌ ¾Æ´Ñ µ¥ÀÌÅÍ¸¦ Á¶È¸


--commission_pct : (°Å·¡¿¡ µû¸¥) ¼ö¼ö·áÀ²
--commission_pct°¡ not nullÀÎ ÀÌÀ¯! ±âº»±Ş ³·µÇ, ¼ö¼ö·á¸¦ Ã¥Á¤ÇØ¼­ Áö±ŞÇÏ´Â ±¸Á¶
--                     nullÀÎ ÀÌÀ¯! ÆÇ¸ÅºÎ¼­°¡ ¾Æ´Ô, ±âº» ±Ş¿©°¡ ³ô°Å³ª