-- 서브쿼리 실습문제 --

-- 1. 전지연 사원이 속해있는 부서원들을 조회하시오 (단, 전지연은 제외)
--    사번, 사원명, 전화번호, 고용일, 부서명
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '전지연';

SELECT EMP_ID, EMP_NAME,PHONE, HIRE_DATE, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPARTMENT.DEPT_ID =EMPLOYEE.DEPT_CODE )
WHERE DEPT_CODE = (SELECT DEPT_CODE
                     FROM EMPLOYEE
                     WHERE EMP_NAME = '전지연')
AND EMP_NAME != '전지연';                     


-- 2. 고용일이 2000년도 이후인 사원들 중 급여가 가장 높은 사원의 
--    사번, 사원명, 전화번호, 급여, 직급명을 조회하시오.

SELECT MAX(SALARY)
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '2000-01-01' AND SYSDATE;

SELECT EMP_ID,EMP_NAME,PHONE,SALARY,JOB_NAME
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
WHERE SALARY = ( SELECT MAX(SALARY)
                     FROM EMPLOYEE
                    WHERE HIRE_DATE BETWEEN '2000-01-01' AND SYSDATE );






-- 3. 노옹철 사원과 같은 부서, 같은 직급인 사원을 조회하시오. (단, 노옹철 사원은 제외)
--    사번, 이름, 부서코드, 직급코드, 부서명, 직급명
-- 단일행 다중열 서브쿼리

SELECT DEPT_CODE , JOB_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '노옹철';

SELECT EMP_ID, EMP_NAME, DEPT_CODE , JOB_CODE , DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE= DEPARTMENT.DEPT_ID )
JOIN JOB USING(JOB_CODE)
WHERE (DEPT_CODE, JOB_CODE) = ( SELECT DEPT_CODE , JOB_CODE
                            FROM EMPLOYEE
                                WHERE EMP_NAME = '노옹철')
AND EMP_NAME !='노옹철';                                




-- 4. 2000년도에 입사한 사원의 부서와 직급이 같은 사원을 조회하시오
--    사번, 이름, 부서코드, 직급코드, 고용일

SELECT DEPT_CODE , JOB_CODE
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN'2000-01-01' AND '2000-12-31';

SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE , JOB_CODE) = ( SELECT DEPT_CODE , JOB_CODE
                     FROM EMPLOYEE
                     WHERE HIRE_DATE BETWEEN'2000-01-01' AND '2000-12-31'
);








-- 5. 77년생 여자 사원과 동일한 부서이면서 동일한 사수를 가지고 있는 사원을 조회하시오
--    사번, 이름, 부서코드, 사수번호, 주민번호, 고용일 
  SELECT EMP_ID , EMP_NAME, SALARY
  FROM EMPLOYEE
  WHERE SALARY BETWEEN 1000000 AND 3000000
  ORDER BY SALARY ;


	SELECT EMP_ID , EMP_NAME, DEPT_TITLE, JOB_NAME
	FROM EMPLOYEE
	JOIN JOB USING (JOB_CODE)
	JOIN DEPARTMENT ON (DEPT_CODE = DEPT_CODE)
	WHERE DEPT_TITLE = '총무부'
  ORDER BY JOB_CODE;
SELECT * FROM EMPLOYEE;


 SELECT EMP_ID , EMP_NAME, DECODE(SUBSTR(EMP_NO,8,1),'1','M','2','F' )"성별" ,SALARY, JOB_NAME, 
 NVL(DEPT_TITLE, '없음') DEPT_TITLE
 FROM EMPLOYEE
 JOIN JOB USING (JOB_CODE)
 LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
 WHERE DECODE(SUBSTR(EMP_NO,8,1),'1','M','2','F' ) = 'M'
 AND SALARY BETWEEN 1000000 AND 3000000
 ORDER BY SALARY ;



SELECT * FROM EMPlOYEE
WHERE DEPT_CODE = 'D8'
ORDER BY DEPT_CODE;




-- 6. 부서별 입사일이 가장 빠른 사원의
-- 사번, 이름, 부서명(NULL이면 '소속없음'), 직급명, 입사일을 조회하고
-- 입사일이 빠른 순으로 조회하시오
-- 단, 퇴사한 직원은 제외하고 조회.
 
 -- 6. 부서별 입사일이 가장 빠른 사원의
SELECT NVL(DEPT_CODE,'소속없음'), MIN(HIRE_DATE)
FROM EMPLOYEE
WHERE ENT_YN = 'N'
GROUP BY DEPT_CODE;


SELECT * FROM JOB;
-- 메인쿼리
SELECT EMP_ID , EMP_NAME , NVL(DEPT_CODE,'소속없음'),
JOB_NAME, HIRE_DATE
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
WHERE (DEPT_CODE,HIRE_DATE) IN (SELECT NVL(DEPT_CODE,'소속없음'), MIN(HIRE_DATE)
                                FROM EMPLOYEE
                                WHERE ENT_YN = 'N'
                                GROUP BY DEPT_CODE);

SELECT EMP_ID , EMP_NAME ,NVL(DEPT_CODE,'소속없음'),DEPT_TITLE
JOB_NAME, HIRE_DATE
FROM EMPLOYEE
JOIN JOB USING (JOB_CODE)
LEFT JOIN DEPARTMENT ON (DEPARTMENT.DEPT_ID =EMPLOYEE.DEPT_CODE )
WHERE (NVL(DEPT_CODE,'소속없음'),HIRE_DATE) IN (SELECT  NVL(DEPT_CODE,'소속없음') ,MIN(HIRE_DATE)
                                FROM EMPLOYEE
                                GROUP BY DEPT_CODE)
                               
AND ENT_YN = 'N'
ORDER BY HIRE_DATE;

 
 SELECT * FROM EMPLOYEE;
 
 
 


-- 7. 직급별 나이가 가장 어린 직원의
-- 사번, 이름, 직급명, 나이, 보너스 포함 연봉을 조회하고
-- 나이순으로 내림차순 정렬하세요
-- 단 연봉은 \124,800,000 으로 출력되게 하세요. (\ : 원 단위 기호)

SELECT TRUNC ('1234875456',-5) FROM DUAL;

SELECT FLOOR((SYSDATE-TO_DATE(SUBSTR('630709-2054321',1,6),'RRMMDD'))/365)"나이" FROM DUAL;



-------------------------------------------------------------------------
