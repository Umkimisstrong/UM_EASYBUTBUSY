SELECT USER
FROM DUAL;
--==>> HR

-- ○ EMPLOYEES 테이블의 직원들 SALARY 를 10% 인상한다.
--    단, 부서명이 'IT'인 직원들만 한정한다.
--    (또한, 변경에 대한 결과 확인 후 ROLLBACK 수행한다.)

SELECT EMPLOYEE_ID, SALARY, SALARY * 1.1 "인상된급여"
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 60;
/*
103	9000	9900
104	6000	6600
105	4800	5280
106	4800	5280
107	4200	4620
*/
SELECT *
FROM DEPARTMENTS;

-- 『부서번호』 가 
--  (부서번호 / 부서테이블 / 부서이름이 IT인 곳에서) 와 같다는 조건만들기
--  ↓
UPDATE EMPLOYEES
SET SALARY = SALARY * 1.1
WHERE DEPARTMENT_ID = ( SELECT DEPARTMENT_ID
                        FROM DEPARTMENTS
                        WHERE DEPARTMENT_NAME = 'IT' );
--==>> 5개 행 이(가) 업데이트되었습니다.


-- 확인
SELECT SALARY
FROM EMPLOYEES
WHERE DEPARTMENT_ID = ( SELECT DEPARTMENT_ID
                        FROM DEPARTMENTS
                        WHERE DEPARTMENT_NAME = 'IT' );
/*
9900
6600
5280
5280
4620
*/

-- 롤백
ROLLBACK;
롤백 완료.

-- 롤백여부확인
SELECT SALARY
FROM EMPLOYEES
WHERE DEPARTMENT_ID = ( SELECT DEPARTMENT_ID
                        FROM DEPARTMENTS
                        WHERE DEPARTMENT_NAME = 'IT' );
/*
9000
6000
4800
4800
4200
*/

-- ○ EMPLOYEES 테이블에서 JOB_TITLE 이 『Sales Manager』 인 사원들의
--    SALARY 를 해당 직무(직종)의 최고급여(MAX_SALARY)로 수정한다.
--    단, 입사일이 2006년 이전(해당년도제외) 입사자에 한해 적용.
--    (또한, 변경에 대한 결과 확인 후 ROLLBACK 수행)

-- 변경 전 Sales Manager의 입사일, 급여
SELECT *
FROM JOBS;

SELECT HIRE_DATE, SALARY
FROM EMPLOYEES
WHERE JOB_ID = (SELECT JOB_ID
                FROM JOBS
                WHERE JOB_TITLE = 'Sales Manager' );
/*
2004-10-01	14000
2005-01-05	13500
2005-03-10	12000
2007-10-15	11000
2008-01-29	10500
*/

--  Sales Manager의 입사일, 급여 조장
--  조건 1 : 직종이 Sales Manager
--  조건 2 : 해당 부서에서 2006년 이전 입사자만

--  변경해야할 급여 : 해당부서 전체직원 중 가장 높은 급여로 변경

UPDATE EMPLOYEES
SET SALARY = (SELECT MAX_SALARY
              FROM JOBS
              WHERE JOB_TITLE = 'Sales Manager' )
WHERE JOB_ID = (SELECT JOB_ID
                FROM JOBS
                WHERE JOB_TITLE = 'Sales Manager' )  
  AND EXTRACT (YEAR FROM HIRE_DATE) < 2006;          
--==>> 3개 행 이(가) 업데이트되었습니다.

-- 변경 후  Sales Manager의 입사일, 급여 확인
SELECT HIRE_DATE, SALARY
FROM EMPLOYEES
WHERE JOB_ID = (SELECT JOB_ID
                FROM JOBS
                WHERE JOB_TITLE = 'Sales Manager' );
/*
2004-10-01	20080
2005-01-05	20080
2005-03-10	20080
2007-10-15	11000
2008-01-29	10500
*/         

-- 롤백
ROLLBACK;
--==>> 롤백 완료.

-- 롤백 확인
SELECT HIRE_DATE, SALARY
FROM EMPLOYEES
WHERE JOB_ID = (SELECT JOB_ID
                FROM JOBS
                WHERE JOB_TITLE = 'Sales Manager' );
/*
2004-10-01	14000  
2005-01-05	13500
2005-03-10	12000
2007-10-15	11000
2008-01-29	10500
*/ -- 이상 없음

-- ○ EMPLOYEES 테이블에서 SALARY를
--    각 부서의 이름별로 다른 인상률을 적용하여 수정할 수 있도록 한다.
--    Finance → 10% 인상
--    Executive → 15% 인상
--    Accounting  → 20% 인상
--    변경에 대한 결과 확인 후 ROLLBACK
SELECT DEPARTMENT_ID
FROM DEPARTMENTS
WHERE DEPARTMENT_NAME IN ('Accounting', 'Finance', 'Executive');




UPDATE EMPLOYEES
SET SALARY = CASE DEPARTMENT_ID WHEN (SELECT DEPARTMENT_ID
                                        FROM DEPARTMENTS
                                        WHERE DEPARTMENT_NAME = 'Finance')
                                THEN (SALARY / 1.1)
                                WHEN (SELECT DEPARTMENT_ID
                                        FROM DEPARTMENTS
                                        WHERE DEPARTMENT_NAME = 'Executive')
                                THEN (SALARY / 1.15)
                                WHEN (SELECT DEPARTMENT_ID
                                        FROM DEPARTMENTS
                                        WHERE DEPARTMENT_NAME = 'Accounting')
                                THEN (SALARY / 1.2)
                                ELSE SALARY
             END                                
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
                        FROM DEPARTMENTS
                        WHERE DEPARTMENT_NAME IN ('Accounting', 'Finance', 'Executive'));
----> 끝
---- 해당 쿼리문은 where 절 없이도 작동은하나, where 절 없이는
---- 속도가 늦는 현상이 발생한다
--==>> WHERE 절 없는 경우 : 11개 행 이(가) 업데이트되었습니다.
                 --        ↕                     
--==>> WHERE 절 없는 경우 : 107개 행 이(가) 업데이트되었습니다.


-- 'Finance'의 부서아이디
SELECT DEPARTMENT_ID
FROM DEPARTMENTS
WHERE DEPARTMENT_NAME = 'Finance';

-- 'Executive'의 부서아이디
SELECT DEPARTMENT_ID
FROM DEPARTMENTS
WHERE DEPARTMENT_NAME = 'Executive';

-- 'Accounting'의 부서아이디
SELECT DEPARTMENT_ID
FROM DEPARTMENTS
WHERE DEPARTMENT_NAME = 'Accounting';

--------------------------------------------------------------------------------

-- ■■■ DELETE ■■■ --

-- 1. 테이블에서 지정된 행(레코드)을 삭제하는데 사용하는 구문
-- 2. 형식 및 구조
-- DELETE [FROM] 테이블명
-- [WHERE 조건절];

-- 테이블 복사(데이터 위주)
CREATE TABLE TBL_EMPLOYEES
AS
SELECT *
FROM EMPLOYEES;
--==> Table TBL_EMPLOYEES이(가) 생성되었습니다.

SELECT *
FROM TBL_EMPLOYEES
WHERE EMPLOYEE_ID = 198;
--==>>  198	Donald	OConnell	DOCONNEL	650.507.9833	2007-06-21	SH_CLERK	2600		124	50
-- ↓
DELETE 
FROM TBL_EMPLOYEES
WHERE EMPLOYEE_ID = 198;
--==>> 1 행 이(가) 삭제되었습니다.

ROLLBACK;
--==>> 롤백 완료.

-- ○ EMPLOYEES 테이블에서 직원들의 데이터를 삭제한다.
--    단, 부서명이 'IT' 인 경우로 한정한다.

-- ※ 실제로는 EMPLOYEES 테이블의 데이터가(삭제하고자 하는 대상 데이터)
--    다른 레코드에의해 참조당하고 있는 경우
--    삭제되지 않을 수 있다는 사실을 염두해야 하며...
--    그에 대한 이유도 알아야 한다.
DELETE
FROM  EMPLOYEES
WHERE DEPARTMENT_ID = ( SELECT DEPARTMENT_ID
                        FROM DEPARTMENTS
                        WHERE DEPARTMENT_NAME = 'IT' );
--==>> 에러 발생
--     ORA-02292: integrity constraint (HR.DEPT_MGR_FK) violated - child record found

--------------------------------------------------------------------------------
-- ■■■ 뷰(VIEW) ■■■ --

-- 1. 뷰(VIEW)란 이미 특정한 데이터베이스 내에 존재하는
--    하나 이상의 테이블에서 사용자가 얻기 원하는 데이터들만을
--    정확하고 편하게 가져오기 위하여 사전에 원하는 컬럼들만을 모아서
--    만들어놓은 가상의 테이블로 편의성 및 보안에 목적이 있다.

-- 가상의 테이블이란.. 뷰가 실제로 존재하는 테이블(객체)이 아니라
-- 하나 이상의 테이블에서 파생된 또 다른 정보를 볼 수 있는 방법이라는 의미이며,
-- 그 정보를 추출해내는 SQL 문장이라고 볼 수 있다.

-- 2. 형식 및 구조
-- CREATE [OR REPLACE] VIEW 뷰이름
-- [(ALIAS[, ALIAS, ...])]
-- AS
-- 서브쿼리(SUBQUERY)
-- WITH CHECK OPTION
-- WITH READ ONLY

CREATE OR REPLACE VIEW VIEW_EMPLOYEES
AS
SELECT E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME, L.CITY, C.COUNTRY_NAME
     , R.REGION_NAME
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L, COUNTRIES C, REGIONS R
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+)
  AND D.LOCATION_ID = L.LOCATION_ID
  AND L.COUNTRY_ID = C.COUNTRY_ID
  AND C.REGION_ID = R.REGION_ID;
--==>> View VIEW_EMPLOYEES이(가) 생성되었습니다.

-- ○ 뷰(VIEW) 조회
SELECT *
FROM VIEW_EMPLOYEES;

DESC VIEW_EMPLOYEES;
/*
이름              널?       유형           
--------------- -------- ------------ 
FIRST_NAME               VARCHAR2(20) 
LAST_NAME       NOT NULL VARCHAR2(25) 
DEPARTMENT_NAME          VARCHAR2(30) 
CITY            NOT NULL VARCHAR2(30) 
COUNTRY_NAME             VARCHAR2(40) 
REGION_NAME              VARCHAR2(25)
*/

-- 유용한정보
-- ○ 뷰(VIEW) 소스 확인 CHECK~!!!

SELECT VIEW_NAME, TEXT
FROM USER_VIEWS
WHERE VIEW_NAME = 'VIEW_EMPLOYEES';
--==>> 
/*
VIEW_EMPLOYEES
" SELECT E.FIRST_NAME, E.LAST_NAME, D.DEPARTMENT_NAME, L.CITY, C.COUNTRY_NAME
         , R.REGION_NAME
  FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L, COUNTRIES C, REGIONS R
  WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+)
    AND D.LOCATION_ID = L.LOCATION_ID
    AND L.COUNTRY_ID = C.COUNTRY_ID
    AND C.REGION_ID = R.REGION_ID "
*/