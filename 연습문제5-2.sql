[연습문제5-2]

1. 사번이 110, 130, 150에 해당하는 사원의 사번, 이름, 부서명을 조회하는 쿼리문을 ansi join으로 작성
select e.employee_id, e.first_name, d.department_name
from employees e inner join departments d
on e.department_id = d.department_id
and e.employee_id in(110, 130, 150);

2. 모든 사원의 사번, 이름, 부서명, 업무코드, 업무제목을 조회하여 사번 순서로 정렬하는 쿼리

select e.employee_id, e.first_name, d.department_name, j.job_title
from employees e inner join departments d
on e.department_id = d.department_id
inner join jobs j
on e.job_id = j.job_id
order by employee_id;