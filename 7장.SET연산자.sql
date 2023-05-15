-- 7장. SET 연산자(p.63)

-- 5장 JOIN연산. 테이블(의 컬럼)을 가로로 연결하는 연산
-- 7장 SET연산자. 테이블(의 데이터/행)을 세로로 연결하는 연산
-- ※ SET 연산자로 묶이는 두 SELECT 절은 (1) 컬럼의 수 , (2) 데이터 타입이 일치해야한다.
-- 조회되는 컬럼명은 첫 번째 쿼리문의 컬럼명이 사용된다.
-- ORDER BY 모든 쿼리문의 가장 마지막에 사용한다.


-- 7.1 UNION: 합집합
-- 집합에서 합집합에 해당하는 연산자, 중복을 제거한 행의 결과 반환.
[예제7-1]
SELECT 1, 3, 4, 5, 7, 8, 'A' AS FIRST -- 조회되는 컬럼명은 첫 번째 쿼리문의 컬럼명이 사용된다.
FROM dual
UNION
SELECT 2, 4, 5, 6, 8, NULL, 'B' AS SECOND
FROM dual
UNION
SELECT 1, 3, 4, 5, 7, 8, 'A' AS THIRD -- 조회되는 컬럼명은 첫 번째 쿼리문의 컬럼명이 사용된다.
FROM dual;

[예제7-2] 관리되고 있는 부서, 관리되고 있는 도시 정보를 조회한다.
select department_id as code, department_name as name
from departments
union
select location_id, city
from locations;


-- 7.2 UNION ALL: 합집합
--UNION : 중복제거 / UNION ALL : 중복포함
[예제7-4]
SELECT 1, 3, 4, 5, 7, 8, 'A' AS FIRST -- 조회되는 컬럼명은 첫 번째 쿼리문의 컬럼명이 사용된다.
FROM dual
UNION all
SELECT 2, 4, 5, 6, 8, NULL, 'B' AS SECOND
FROM dual
UNION all
SELECT 1, 3, 4, 5, 7, 8, 'A' AS THIRD -- 조회되는 컬럼명은 첫 번째 쿼리문의 컬럼명이 사용된다.
FROM dual;


-- 7.3 INTERSECT: 교집합
[예제7-7] 80번 부서와 50번 부서에 공통으로 있는 사원의 이름 조회
select first_name as name
from employees
where department_id = 80
intersect
select first_name as name
from employees
where department_id = 50;


-- 7.4 MINUS: 차집합
[예제7-9] 80번 부서원의 이름에서 50번 부서원의 이름을 제외
--순수하게 80번 부서에만 존재하는 이름 조회

select first_name
from employees
where department_id = 80
minus
select first_name
from employees
where department_id = 50;
