[연습문제3-4]

1. 사원의 사번, 이름, 부서, 매니저번호를 조회하는 쿼리문을 작성한다
(단, 매니저가 있는 사원은 매니저, 매니저가 없는 사원은 No Manager라 표시하도록 한다)

select employee_id, first_name, job_id, 
        nvl2(manager_id, to_char(manager_id), 'no manager') 매니저번호       
from employees;

select * from employees;