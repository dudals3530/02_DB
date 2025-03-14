/*
 * DCL (Data Control Language) : 데이터를 다루기 위한 권한을 다루는 언어
 * 
 * - 계정에 DB, DB객체에 대한 접근 권한을
 * 	 부여(GRANT)하고 회수(REVOKE)하는 언어
 * 
 * * 권한의 종류
 * 
 * 1) 시스템 권한 : DB접속, 객체 생성 권한
 * 		
 * 
 * 		CREATE SESSION   : 데이터베이스 접속 권한
 * 		CREATE TABLE     : 테이블 생성 권한
 * 		CREATE VIEW      : 뷰 생성 권한
 *    	CREATE SEQUENCE  : 시퀀스 생성권한
 * 		CREATE PROCEDURE : 함수(프로시져) 생성 권한
 * 		CREATE USER		 : 사용자(계정) 생성 권한
 * 		
 * 		DROP USER 		 : 사용자(계정) 삭제 권한
 * 
 * 2) 객체 권한 : 특정 객체를 조작할 수 있는 권한
 * 
 * 		권한 종류 			설정 객체
 * 
 * 		SELECT           TABLE, VIEW, SEQUENCE
 *   	INSERT           TABLE, VIEW
 * 		UPDATE			     TABLE, VIEW
 * 		DELETE			     TABLE, VIEW
 * 		ALTER			       TABLE, SEQUENCE(수정 권한 - 구조변경)
 * 		REFERENCES 		   TABLE           (참조 권한- 외래키(FK)설정할 권한)
 * 		INDEX			       TABLE           (INDEX 생성권한)
 * 		EXECUTE			     PROCEDURE       (함수 실행 권한)
 * 
 * */


/*
 * USER - 계정 (사용자) -> 이것도 오라클에선 객체라고함
 * 
 * * 관리자 계정 : 데이터베이스의 생성과 관리를 담당하는 계정.
 * 					모든 권한과 책임을 가지는 계정.
 * 					ex) sys(최고관리자), system(sys에서 권한 몇개가 제외된 관리자)
 * 
 * 
 * * 사용자 계정 : 데이터베이스에 대하여 질의, 갱신, 보고서 작성 등의
 * 					작업을 수행할 수 있는 계정으로
 * 					업무에 필요한 최소한의 권한만을 가지는것을 원칙으로 한다.
 * 					ex) kh, workbook 등
 
 * 
 * */

-- 1. (sys) 사용자 계정 생성
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;
-- 예전 SQL 방식 허용 (계정명을 간단히 작성 가능 하도록 만들어주는 문법)

--[작성법]
--CREATE USER 사용자명 IDENTIFIED BY 비밀번호;
CREATE USER kym_sample IDENTIFIED BY 1234;

--2. 새 연결(접속) 추가
-- kym_sample 은 CREATE SESSION 구너한을 가지고 있찌 않음
--> 접속권한

--3. 접속권한부여 (SYS - > 사용자 계정)
 -- [권한 부여 작성법]
-- GRANT 권한, 권한, 권한 ,... TO 사용자명;
GRANT CREATE SESSION TO kym_sample;

--4. 다시 연결 --> 성공!

-- 5.(sample) 테이블 생성
CREATE TABLE TB_TEST(
 PK_COL NUMBER PRIMARY KEY
 CONTENT VARCHAR2(100)
);

-- CREATE TABE : 테이블 생성권한 
-- + 데이터를 저장할 수 있는 공간 (TABLESPACE) 할당


--6. (SYS) 테이블 생성권한부여 + TABELSPACE 할당
GRANT CREATE TABLE TO kym_sample;

ALTER USER kym_sample DEFAULT TABLESPACE SYSTEM QUOTA UNLIMITED ON SYSTEM;
-- 기본 테이블스페이스를 시스템으로 변경하고 쿼터 = 할당량 

--7. 테이블 다시생성 해보자
CREATE TABLE TB_TEST(
 PK_COL NUMBER PRIMARY KEY,
 CONTENT VARCHAR2(100)
);

--------------------------------------------------------------------------

-- ROLE (역할) : 권한 묶음
-- > 묶어둔 권한 (ROLE) 특정 계정에 부여
-- > 해당 계정은 지정된 권한을 이용해서 특정 역할을 갖게된다.

-- CONNET / RESOURCE : 사용자에게 부여 할 수 있는 기본적인 시스템 역할.

-- CONNET : DB 접속관련ㄴ 권한을 묶어둔 ROLE
--> CREATE SESSION , ALTER SESSION .......

-- RESOURCE : DB 사용을 위한 기본 객체 생성 권한 을 묶어둔 ROLE 
--> CREATE TABLE , CREATE SEQUENCE, ..  PROCEDURE 만드는것들 ..

-- (SYS) SAMPLE 계정에 CONNECT , RESOURCE ROLE 부여
GRANT CONNECT, RESOURCE TO kym_sample;

---------------------------------------------------------------------

-- /*객체 권한*/

-- kh / sample 사용자 계정 끼리 서로 객체 접근 권한부여

--1 . (sample) kh 계정의 EMPLOYEE 테이블 조회
SELECT * FROM EMPLOYEE;
-- > 접근권한이 없어서 조회불가

--2 . (KH) SAMPLE 계정에 EMPLOYEE 테이블 조회 권한부여
-- [객체 권한 부여방법]
-- GRANT 객체권한 ON 객체명 TO 사용자명;
GRANT SELECT ON EMPLOYEE TO kym_sample;


--3. (sample)
SELECT * FROM kh.EMPLOYEE; --> 조회 잘된다! 
SELECT * FROM kh.DEPARTMENT; --> 조회 안된다
--> 위에서 KH가 EMPLOYEE 조회 하는 권한만 주었기 때문에...


--4. (KH) SAMPLE 계정에 부여 했떤 EMPLOYEE 테이블 조회 권한 회수

--[권한 회수 작성법]
--REVOKE 객체권한 ON 객체명 FROM 사용자명 ;

REVOKE SELECT ON EMPLOYEE FROM kym_sample; 


-- 5. (sample) EMPLOYEE 조회해보기
-- 권한 뺏김 ㅠㅠ 
SELECT * FROM EMPLOYEE;










