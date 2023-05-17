[연습문제6-3]

1. 각 부서에 대해 부서코드, 부서명, 부서가 위치한 도시이름을 조회하는 쿼리문을
스칼라 서브쿼리로 작성한다.

select department_id, department_name,
        ( select city from locations l where l.location_id = d.location_id) as city_name
from departments d;