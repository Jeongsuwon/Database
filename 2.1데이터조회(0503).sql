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









