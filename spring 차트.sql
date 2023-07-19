-- 부서별 사원 수 조회

-- select 절에 group 함수를 사용한 표현이 있는 경우
-- group 함수가 사용되지 않은 모든 표현에 대해서는 group by의 기준으로 명시되어야 한다.

select e.department_id, nvl(d.department_name, '소속없음') department_name, count(*) count
from employees e left outer join departments d on e.department_id = d.department_id
group by e.department_id, department_name
order by e.department_id
;