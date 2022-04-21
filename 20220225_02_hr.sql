SELECT USER
FROM DUAL;
--==>> HR

-- ○ 세 개 이상의 테이블 조인(JOIN)

-- 형식 1. (SQL 1992 CODE)

SELECT 테이블명1.컬럼명, 테이블명2.컬럼명, 테이블명3.컬럼명
FROM 테이블명1, 테이블명2, 테이블명3
WHERE 테이블명1.컬럼명1 = 테이블명2.컬럼명1
      AND 테이블명2.컬럼명2 = 테이블명3.컬럼명2;
      
      
      
-- 형식 2. (SQL 1999 CODE)
SELECT 테이블명1. 컬럼명, 테이블명2.컬럼명, 테이블명3.컬럼명
FROM 테이블명1 JOIN 테이블명2
ON 테이블명1.컬럼명1 = 테이블명2.컬럼명2
             JOIN 테이블명3
             ON 테이블명2.컬럼명2 = 테이블명3.컬럼명2;
             
-- ○ HR계정 소유의 테이블 또는 뷰 목록 조회
SELECT *
FROM TAB;
/*
COUNTRIES	        TABLE	
DEPARTMENTS	        TABLE	
EMPLOYEES	        TABLE	
EMP_DETAILS_VIEW	VIEW	
JOBS	            TABLE	
JOB_HISTORY	        TABLE	
LOCATIONS	        TABLE	
REGIONS	            TABLE	
*/

-- ○ HR.JOBS, HR.EMPLOYEES, HR.DEPARTMENTS 테이블을 대상으로
--    직원들의 데이터를 FIRST_NAME, LAST_NAME, JOB_TITLE, DEPARTMENT_NAME 항목으로
--    조회한다.

-- 연결고리 조회~~
SELECT *
FROM JOBS;
-- 관계컬럼 JOB_ID
SELECT *
FROM EMPLOYEES;
-- 관계컬럼 DEPARTMENT_ID
SELECT *
FROM DEPARTMENTS;

SELECT COUNT(*)
FROM EMPLOYEES;
-- 107

-- 방법1
SELECT E.FIRST_NAME, E.LAST_NAME, J.JOB_TITLE, D.DEPARTMENT_NAME
FROM JOBS J, EMPLOYEES E, DEPARTMENTS D
WHERE J.JOB_ID = E.JOB_ID
      AND E.DEPARTMENT_ID = D.DEPARTMENT_ID(+);

-- 방법2
SELECT E.FIRST_NAME, E.LAST_NAME, J.JOB_TITLE, D.DEPARTMENT_NAME
FROM JOBS J
     JOIN EMPLOYEES E ON J.JOB_ID = E.JOB_ID
     LEFT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;
/*
Jennifer	Whalen	Administration Assistant	Administration
Pat	        Fay	    Marketing Representative	Marketing
                      :
William	    Gietz	Public Accountant	        Accounting
Kimberely	Grant	Sales Representative	    (null)
*/

-- ○ EMPLOYEES, DEPARTMENTS, JOBS, LOCATIONS, COUNTRIES, REGIONS 테이블을 대상으로
--    직원들의 데이터를 다음과 같이 조회할 수 있도록 쿼리문을 구성
--    FIRST_NAME, LAST_NAME. JOB_TIOTLE, DEPARTMENT_NAME, CITY, COUNTRY_NAME, REGION_NAME

-- 1. 1992 CODE
SELECT E.FIRST_NAME      "성"
     , E.LAST_NAME       "이름"
     , J.JOB_TITLE       "직종"
     , D.DEPARTMENT_NAME "부서"
     , L.CITY            "도시"
     , C.COUNTRY_NAME    "국가"
     , R.REGION_NAME     "지역"
FROM EMPLOYEES E, DEPARTMENTS D, JOBS J
   , LOCATIONS L, COUNTRIES C, REGIONS R
WHERE J.JOB_ID = E.JOB_ID
  AND E.DEPARTMENT_ID = D.DEPARTMENT_ID(+)
  AND D.LOCATION_ID = L.LOCATION_ID(+)
  AND L.COUNTRY_ID = C.COUNTRY_ID(+)
  AND C.REGION_ID = R.REGION_ID(+);
  
-- 1999 CODE
SELECT E.FIRST_NAME
     , E.LAST_NAME
     , J.JOB_TITLE
     , D.DEPARTMENT_NAME
     , L.CITY
     , C.COUNTRY_NAME
     , R.REGION_NAME
FROM EMPLOYEES E 
     LEFT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID 
     LEFT JOIN JOBS J ON J.JOB_ID = E.JOB_ID
     LEFT JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
     LEFT JOIN COUNTRIES C ON L.COUNTRY_ID = C.COUNTRY_ID
     LEFT JOIN REGIONS R ON C.REGION_ID = R.REGION_ID;

SELECT *
FROM EMPLOYEES;  -- F_NAME / L_NAME

SELECT *
FROM JOBS;  -- J_TITLE

SELECT *
FROM DEPARTMENTS; -- DEPARTMENT_NAME

SELECT *
FROM LOCATIONS;  -- CITY

SELECT *
FROM COUNTRIES; -- COUNTRY_NAME

SELECT *
FROM REGIONS; -- REGION_NAME

SELECT *
FROM TAB;
