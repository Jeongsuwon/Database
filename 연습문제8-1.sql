[연습문제8-1]

1. EMP 테이블에 (교재의) 데이터 행을 저장하시오

desc emp;

insert into emp(emp_id, fname, lname, hire_date, salary)
values (400, 'Johns', 'Hopkins', to_date('2008/10/15', 'YYYY/MM/DD'), 5000);

insert into emp(emp_id, fname, lname, hire_date, salary)
values (401, 'Abraham', 'Lincoln', to_date('2010/03/03', 'YYYY/MM/DD'), 12500);

insert into emp(emp_id, fname, lname, hire_date, salary)
values (402, 'Tomas', 'Edison', to_date('2013/06/21', 'YYYY/MM/DD'), 7000);

2. EMP 테이블의 사번 401번 사원의 부서코드를 90으로, 업무코드를 SA_MAN으로 변경 후
   데이터 행의 저장을 확정
select * from emp;   

update emp set job_id = 'SA_MAN' where emp_id=401; 

commit;

3. EMP 테이블의 급여가 8000 미만인 모든 사원의 부서코드를 80번을 변경 후, 급여는 employees 
    테이블의 80번 부서의 평균 급여를 가져와 변경(단, 평균급여는 반올림된 정수 사용)
   
update emp set dept_id = 80, salary = (select round(avg(salary),0) from employees where department_id=80)
where salary < 8000;    

4. emp 테이블의 2010년 이전 입사한 사원의 정보를 삭제
--to_char(hire_date, 'YYYY')
delete from emp where to_char(hire_date, 'YYYY') < '2010-01-01'; 