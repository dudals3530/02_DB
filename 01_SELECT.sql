-- SQL(Structured Query Language, 구조적 질의 언어)
-- 데이터 베이스와 상호작용을 하기위해 사용하는 표준언어
-- 데이터의 조회, 삽입 ,수정 ,삭제 등

/*
 * SELECT (DML 또는 DQL) : 조회
 *
 * -데이터를 조회 (SELECT) 하면 조건에 맞는 행들이 조회됨.
 * 이때 , 조회된 행들의 집합을 "RESULT SET" 이라고한다.
 * 
 * - RESULT SET 은 0개 이상의 행을 포함할 수있다.
 * 왜 0개 ? 조건에 맞는행이 없을 수 도있어서. 
 * 
 * */

-- [작성법] 
-- SELECT 컬럼명 FROM 테이블명;
--> 테이블의 특정 컬럼을 조회하겠다.

SELECT * FROM EMPLOYEE;
-- * 은 전부라는 의미
-- "*" : ALL, 전부 ,모두
-- EMPLOYEE 테이블의 모든 컬럼을 조회하겠다.

-- EMPLOYEE 테이블에서 사번, 직원이름, 휴대전화번호 컬럼만 조회
SELECT( EMP_ID, EMP_NAME, PHONE )FROM EMPLOYEE;

-----------------------------------------------------------

