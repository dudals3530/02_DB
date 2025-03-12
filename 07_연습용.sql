


--- 부서코드가 노옹철 사원과 같은 소속의 직원의
-- 이름, 부서코드 조회 -> 이걸 메인쿼리로 처리해야함

SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME ='노옹철';

SELECT EMP_NAME , DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME ='노옹철');

-- 전직원의 평균 급여보다 많은 급여를 받고있는 직원의
-- 사번, 이름, 직급코드 , 급여조회


SELECT CEIL(AVG(SALARY))
FROM EMPLOYEE;

SELECT EMP_NO, EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > (SELECT AVG(SALARY)
                 FROM EMPLOYEE);




--전 직원의 급여 평균보다 많은 (초과) 급여를 받는 직원의
-- 이름, 직급명, 부서명, 급여를 직급순으로 정렬하여 조회

SELECT EMP_NAME, JOB_NAME, DEPT_TITLE,SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
JOIN DEPARTMENT ON (DEPARTMENT.DEPT_ID =EMPLOYEE.DEPT_CODE )
WHERE SALARY > (SELECT CEIL(AVG(SALARY))
                FROM EMPLOYEE)
ORDER BY JOB_CODE;



-- 가장 적은 급여를 받는 직원의
-- 사번, 이름, 직급명, 부서코드,급여,입사일 조회

SELECT MIN(SALARY)
FROM EMPLOYEE ;

SELECT EMP_NO , EMP_NAME, DEPT_TITLE, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPARTMENT.DEPT_ID  = EMPLOYEE.DEPT_CODE )
WHERE SALARY = (SELECT MIN(SALARY)
                FROM EMPLOYEE );  --방명수 흑..






-- 노옹철 사원의 급여보다 많이 (초과) 받는 직원의 
-- 사번 , 이름 , 부서명, 직급명, 급여조회

 SELECT SALARY
 FROM EMPLOYEE
 WHERE EMP_NAME ='노옹철';
                
 SELECT EMP_NO , EMP_NAME, DEPT_TITLE, JOB_NAME, SALARY
 FROM EMPLOYEE
 JOIN DEPARTMENT ON (EMPLOYEE.DEPT_CODE =DEPARTMENT.DEPT_ID )
 JOIN JOB USING (JOB_CODE)
 WHERE SALARY > (SELECT SALARY
                 FROM EMPLOYEE
                 WHERE EMP_NAME ='노옹철');
                
                
-- 부서별 (부서가 없는 사람 포함) 급여의 합계중
-- 가장 큰 부서의 부서명, 급여 합계
SELECT MAX(SUM(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE;   -- 17,700,000

SELECT DEPT_TITLE, SUM(SALARY)
FROM EMPLOYEE
LEFT JOIN DEPARTMENT ON (DEPT_CODE=DEPARTMENT.DEPT_ID )
GROUP BY DEPT_TITLE
HAVING SUM(SALARY) =(SELECT MAX(SUM(SALARY))
                     FROM EMPLOYEE
                     GROUP BY DEPT_CODE);


-- 부서별 최고 급여를 받는 직원의
-- 이름, 직급, 부서, 급여를
-- 부서순으로 정렬 하여 조회

SELECT MAX(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

SELECT EMP_NAME, JOB_CODE,DEPT_CODE, SALARY
FROM EMPLOYEE 

WHERE SALARY IN (SELECT MAX(SALARY)
                FROM EMPLOYEE
                GROUP BY DEPT_CODE)
ORDER BY DEPT_CODE;


 
-- 사수에 해당하는 직원에 대해 조회
-- 사번, 이름, 부서명, 직급명, 구분(사수/사원) 조회

SELECT DISTINCT MANAGER_ID
FROM EMPLOYEE 
WHERE MANAGER_ID IS NOT NULL;  --> 사수

SELECT EMP_ID ,EMP_NAME , DEPT_TITLE, JOB_NAME,  '사수'구분
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPARTMENT.DEPT_ID =EMPLOYEE.DEPT_CODE )
JOIN JOB USING(JOB_CODE)
WHERE EMP_ID IN ( SELECT DISTINCT MANAGER_ID
                     FROM EMPLOYEE 
                     WHERE MANAGER_ID IS NOT NULL); --사수

SELECT EMP_ID ,EMP_NAME , DEPT_TITLE, JOB_NAME,  '사원'구분
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPARTMENT.DEPT_ID =EMPLOYEE.DEPT_CODE )
JOIN JOB USING(JOB_CODE)
WHERE EMP_ID NOT IN ( SELECT DISTINCT MANAGER_ID
                     FROM EMPLOYEE 
                     WHERE MANAGER_ID IS NOT NULL); --사원
                     
                     
SELECT EMP_ID ,EMP_NAME , DEPT_TITLE, JOB_NAME,  '사수'구분
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPARTMENT.DEPT_ID =EMPLOYEE.DEPT_CODE )
JOIN JOB USING(JOB_CODE)
WHERE EMP_ID IN ( SELECT DISTINCT MANAGER_ID
                     FROM EMPLOYEE 
                     WHERE MANAGER_ID IS NOT NULL)
UNION
SELECT EMP_ID ,EMP_NAME , DEPT_TITLE, JOB_NAME,  '사원'구분
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPARTMENT.DEPT_ID =EMPLOYEE.DEPT_CODE )
JOIN JOB USING(JOB_CODE)
WHERE EMP_ID NOT IN ( SELECT DISTINCT MANAGER_ID
                     FROM EMPLOYEE 
                     WHERE MANAGER_ID IS NOT NULL)
ORDER BY 구분;
                     
                     
 -- 대리 직급의 직원들 중에서
-- 과장 직급의 최소 급여보다
-- 많이 받는 직원의
-- 사번, 이름 ,직급명, 급여조회

SELECT SALARY
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
WHERE JOB_NAME = '과장';   --과장 급여

SELECT EMP_ID, EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE 
JOIN JOB USING (JOB_CODE)
WHERE JOB_NAME = '대리'
AND SALARY > ANY ( SELECT SALARY
                  FROM EMPLOYEE
                  JOIN JOB USING (JOB_CODE)
                  WHERE JOB_NAME = '과장');


-- 3)대리 직급의 직원들 중에서
-- 과장 직급의 최소 급여보다
-- 많이 받는 직원의
-- 사번, 이름 ,직급명, 급여조회

-- 차장 직급의 급여중 가장 큰값 보다 많이 받는 과장 직급의 직원
-- 사번 ,이름, 직급 , 급여조회

-- LOCATION 테이블에서 NATIONAL_CDOE 가 KO인 경우의 LCAL_CODE와
-- DEPARTMENT 테이블의 LOCATION_ID 와 동일한 DEPT_ID가 
-- EMPLOYEE 테이블의 DEPT_CODE 와 동일한 사원 조회히라.


-- 퇴사한 여직원 과 같은부서, 같은직급에 해당하는 
-- 사원의 이름, 직급코드,부서코드,입사일 조회


--1. 노옹철 사원과 같은 부서 , 같은 직급인 사원을 조회 (단,노옹철 제외)
--사번,이름,부서코드,직급코드,부서명, 직급명


--2. 2000년도에 입사한 사원의 부서와 직급이 같은 사원을 조회
-- 사번, 이름, 부서코드, 직급코드, 입사일

--3. 77년생 여자사원과 동일한 부서이면서 동일한 사수를 가지고 있는 사원조회
-- 사원, 이름,부서코드, 사수번호, 주민번호, 입사일


--본인이 소속된 직급의 평균 급여를 받고 있는 직원의
--사번,이름,직급코드,급여 조회
-- 단, 급여와 급여평균은 만원단위로 조회 TRUNC(컬럼명,-4)
                       -- 직급별 평균급여와 현재받고있는 급여와 같은 직원이있는지조회