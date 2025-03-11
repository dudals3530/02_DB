SELECT * FROM TB_DEPARTMENT;
SELECT * FROM TB_CLASS;
SELECT  FROM TB_PROFESSOR

SELECT * FROM TB_STUDENT;
SELECT * FROM TB_GRADE;

SELECT STUDENT_SSN
FROM TB_STUDENT ts ;

/*
 * 1. 춘 기술 대학교의 학과 이름과 계열을 표시하시오. 단, 출력 헤더는 "학과명","계열"
 * 으로 표시하도록한다
 * 
 * EX)
 * 학과 명                   계열
 * --------------------   ---------------------
 * 국어국문학과               인문사회
 * 영어영문학과               인문사회
 * ....
 * ....
 * 체육학과                  예체능
 * 
 * */

SELECT DEPARTMENT_NAME "학과 명" , CATEGORY "계열"
FROM TB_DEPARTMENT;

/*
 * 2. 학과의 학과 정원을 다음과 같은 형태로 화면에 출력한다.
 * 학과별 정원
 * -------------------------------
 * 국어국문학과의 정원은 20명 입니다.
 * 영어영문학과의 정원은 36명 입니다.
 * 
 * 
 * */

SELECT  (DEPARTMENT_NAME || '의 정원은'|| TO_CHAR (CAPACITY) ||'명 입니다.') "학과별 정원"
FROM TB_DEPARTMENT td ;

/*
 *3. "국어국문학과" 에 다니는 여학생 중 현재 휴학중인 여학생을 찾아달란 요청이 들어왔다. 누구인가?
 * (국문학과의 '학과코드'는 학과테이블 TB_DEPARTMENT)을 조회해서 찾아내도록하자 
 * */

SELECT STUDENT_NAME 
FROM TB_STUDENT
WHERE (SUBSTR(STUDENT_SSN, 8, 1)) = '2'
-- 주민등록번호에서 8번째 위치부터 1개의 문자를 추출하는 함수
AND ABSENCE_YN = 'Y'
AND DEPARTMENT_NO =  (SELECT DEPARTMENT_NO
FROM TB_DEPARTMENT
WHERE DEPARTMENT_NAME = '국어국문학과');

/*
 * 4. 도서관에서 대출 도서 장기 연체자 들을 찾아 이름을 게시하고자 한다. 그대상자들의 학번이
 * 다음과 같을 때 대상자들을 찾는 적절한 SQL 구문을 작성하시오
 * A513079,A513090,A513091,A513110,A513119
 * 
 * STUDENT_NAME
 * --------------------
 	홍경희
 	최경희
 	정경훈
 	정경환
 	이경환
 
 * */

SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE STUDENT_NO ='A513079'
OR STUDENT_NO = 'A513090'
OR STUDENT_NO = 'A513091'
OR STUDENT_NO = 'A513110'
OR STUDENT_NO = 'A513119'
ORDER BY STUDENT_NAME DESC;

/*
 * 5. 입학정원이 20명 이상 30명 이하인 학과들의 학과 이름과 계열을 출력하시오
 * 
 * 
 * 
 * 
 * */

SELECT DEPARTMENT_NAME , CATEGORY
FROM TB_DEPARTMENT
WHERE CAPACITY >= 20 AND CAPACITY <= 30;
 
/*
 * 6.춘 기술 대학교는 총장을 제외하고 모든 교수들이 소속 학과를 가지고 있다.
 *  그럼 춘기술대학교 총장의 이름을 알아낼수 있는 SQL문장을 작성하시오
 * PROFESSOR_NO = NULL
 * */

SELECT PROFESSOR_NAME
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO IS NULL;

/*
 * 7. 혹시 전산상의 착오로 학과가 지정되어 있지 않은 학생이 있는지 확인하고자 한다.
 * 어떠한 SQL 문장을 사용하면 될 것인지 작성하시오.
 * */

SELECT STUDENT_NAME ,DEPARTMENT_NO
FROM TB_STUDENT
WHERE DEPARTMENT_NO IS NULL;

/*
 * 8. 수강신청을 하려고 한다. 선수과목 여부를 확인해야 하는데, 선수과목이 존재하는
 * 과목들은 어떤 과목인지 과목번호를 조회해보시오
 * */

SELECT PREATTENDING_CLASS_NO
FROM TB_CLASS
WHERE PREATTENDING_CLASS_NO IS NOT NULL;

/*
 * 9. 춘 대학에는 어떤 계열(CATEGORY) 들이 있는지 조회해보시오
 * 
 * */

SELECT DISTINCT CATEGORY
FROM TB_DEPARTMENT
ORDER BY CATEGORY;

/*
 * 10. 02학번 전주 거주자들의 모임을 만들려고 한다. 휴학한 사람들은
 * 제외한 재학중인 학생들의 학번, 이름, 주민번호를 출력하는 구문을 작성하시오
 * */

SELECT STUDENT_NO,STUDENT_NAME,STUDENT_SSN,ABSENCE_YN ,STUDENT_ADDRESS
FROM TB_STUDENT
WHERE ABSENCE_YN ='N'
AND  SUBSTR(STUDENT_ADDRESS,1,2) = '전주'
AND SUBSTR(STUDENT_NO,2,1) = '2';




/*FUNTION
 * 1.
 * 영어 영문학과 (학과코드 002) 학생들의 학번과 이름, 입학 년도를 입학 년도가 빠른
 * 순으로 표시하는 SQL 문장을 작성하시오 (단, 헤더는 "학번","이름","입학년도"가 표시되도록한다)
 * 
 * */
SELECT STUDENT_NO "학번" , STUDENT_NAME "이름", ENTRANCE_DATE "입학년도"
FROM TB_STUDENT
WHERE DEPARTMENT_NO = '002'
ORDER BY ENTRANCE_DATE ;

SELECT * FROM TB_PROFESSOR;
/*
 * 2. 춘 기술 대학교의 교수중이름이 세글자가 아닌 교수가 한명 있다고한다. 그교수의 이름과
 * 주민번호를 화면에 출력하는 SQL 문장을 작성해보자(*이때 올바르게 작성한 SQL 문장의 결과값이
 * 예상과 다르게 나올수 있다. 원인이 무엇일지 생각해볼것)
 * */
SELECT PROFESSOR_NAME ,PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE PROFESSOR_NAME LIKE '__'
OR PROFESSOR_NAME LIKE '____';

/*3. 춘 기술대학교의 남자 교수들의 이름과 나이를 출력하는 SQL 문장을 작성하시오. 단
 * 이때 나이가 적은 사람에서 많은 사람 순서로 화면에 출력되도록 만드시오.(단, 교수중 
 * 2000년 이후 출생자는 없으며 출력 헤더는 "교수이름","나이"로 한다. 나이는'만'으로 계산한다
 * 
 * */
SELECT PROFESSOR_NAME "교수이름", '124'-SUBSTR( PROFESSOR_SSN,1,2)   "나이"
FROM TB_PROFESSOR
ORDER BY "나이";

/*
 * 4. 교수들의 이름중 성을 제외한 이름만 출력하는 SQL문장을 작성하시오. 출력헤더는
 * "이름"이 찍히도록한다.(성이 2자인 경우는 교수가 없다고 가정하시오)
 * */

SELECT SUBSTR(PROFESSOR_NAME,2,2)
FROM TB_PROFESSOR;

/*
 * 5.춘 기술대학교의 재수생 입학자를 구하려고한다. 어떻게 찾아낼 것인가? 이떄,
 * 19살에 입학하면 재수를 하지 않은것으로 간주한다.
 * 
 * 
 */
SELECT 
    STUDENT_NO,
    STUDENT_NAME
   
FROM 
    TB_STUDENT
WHERE 
    (EXTRACT(YEAR FROM ENTRANCE_DATE) - (TO_NUMBER(SUBSTR(STUDENT_SSN, 1, 2)) + 1900)) <19;

/*
 * 6. 2020년 크리스마스는 무슨요일인가?
 * */

SELECT TO_CHAR(TO_DATE('2020-12-25','YYYY-MM-DD'),'DY') "무슨요일?"  
FROM DUAL; --금

/*
 * 7.TO_DATE('99/10/11',YY/MM/DD), TO_DATE('49/10/11,'YY/MM/DD')
 * */
SELECT TO_CHAR(TO_DATE('99/10/11','YY/MM/DD'),'YYYY/MM/DD')"첫번째",
TO_CHAR(TO_DATE('49/10/11','YY/MM/DD'),'YYYY/MM/DD')"두번째",
TO_CHAR(TO_DATE('99/10/11','RR/MM/DD'),'YYYY/MM/DD')"세번째",
TO_CHAR(TO_DATE('49/10/11','RR/MM/DD'),'YYYY/MM/DD')"네번째"

FROM DUAL;

/*
 * 8. 춘기술 대학교의 2000년도 이후 입학자들은 학번이 A로 시작하게 되어있다. 2000년도
 * 이전 학번을 받은 학생들의 학번과 이름을 보여주는 SQL 문장을 작성하시오
 * */

SELECT  STUDENT_NO,STUDENT_NAME
FROM  TB_STUDENT
WHERE SUBSTR(STUDENT_NO,1,1) != 'A';
  


/*
 * 9. 학번이 A517178 인 한아름 학생의 학점 총 평점을 구하는 SQL 문을 작성하시오 단.
 * 이때 출력 화면의 헤더는 "평점" 이라고 찍히게 하고, 점수는 반올림하여 소수점 이하 한자리까지만 
 * 표시한다.
 * */
SELECT STUDENT_NO ,ROUND(AVG(POINT),1) "평점"
FROM TB_GRADE
GROUP BY STUDENT_NO
HAVING STUDENT_NO ='A517178';


/*
 * 10. 학과별 학생수를 구하여 "학과번호","학생수(명)" 의 형태로 헤더를 만들어 결과값이 출력되도록
 * 하시오.
 * 
 * */

SELECT DEPARTMENT_NO "학과번호", COUNT(STUDENT_NO) "학생수"
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY DEPARTMENT_NO;

/*
 * 11. 지도 교수를 배정받지 못한 학생의 수는 몇명정도 되는 알아내는 SQL 문을 작성하시오
 * 
 * */
SELECT COUNT(*) - COUNT(COACH_PROFESSOR_NO) "COUNT(*)"

FROM TB_STUDENT;

/*
 * 12. 학번이 A112113인 김고운 학생의 년도 별 평점을 구하는 SQL 문을 작성하시오.단,
 * 이때 출력 화면의 헤더는 "년도","년도별평점" 이라고 찍히게하고 ,점수는 반올림하여 소수점이하
 * 한자리까지만 표시한다.
 * */

SELECT  SUBSTR(TERM_NO,1,4) "년도", ROUND(AVG(POINT),1)"년도별 평점"
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY SUBSTR(TERM_NO,1,4)
ORDER BY "년도";

/*
 *13. 학과 별 휴학생 수를 파악하고자 한다. 학과 번호와 휴학생 수를 표시하는 SQL 문장을
 * 작성하시오
 * 
 * */


--CASE WHEN 조건식 THEN 결과값
--     WHEN 조건식 THEN 결과값
--     ELSE 결과값
--END

SELECT  DEPARTMENT_NO "학과코드명", 
    COUNT(CASE WHEN ABSENCE_YN = 'Y' 
    THEN 1 
    END) "휴학생 수"
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY DEPARTMENT_NO;
  
   
   
   

/**14.춘 대학교에 다니는 동명이인 학생들의 이름을 찾고자 한다. 어떤 SQUL 문장을 사용하면가능하겠는가
 * 
 * 
 */

SELECT STUDENT_NAME "동명이인이름", COUNT(*)
FROM TB_STUDENT
GROUP BY STUDENT_NAME
HAVING COUNT(*) > 1
ORDER BY STUDENT_NAME;


/*
 * 15. 학번이 A112113 인 김고운 학생의 년도, 학기별평점과 년도별 누적 평점, 총평점을
 * 구하는 SQL 문을 작성하시오 . 단, 평점은 소수점 1자리깢미나 반올림하여 표시
 * */

SELECT SUBSTR(TERM_NO,1,4)"년도", SUBSTR(TERM_NO,5,2)"학기", ROUND(AVG(POINT),1)"평점"
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY ROLLUP (SUBSTR(TERM_NO,1,4),SUBSTR(TERM_NO,5,2))
ORDER BY "년도","학기";


