SELECT USER
FROM DUAL;
--==>> HR

-- �� �� �� �̻��� ���̺� ����(JOIN)

-- ���� 1. (SQL 1992 CODE)

SELECT ���̺��1.�÷���, ���̺��2.�÷���, ���̺��3.�÷���
FROM ���̺��1, ���̺��2, ���̺��3
WHERE ���̺��1.�÷���1 = ���̺��2.�÷���1
      AND ���̺��2.�÷���2 = ���̺��3.�÷���2;
      
      
      
-- ���� 2. (SQL 1999 CODE)
SELECT ���̺��1. �÷���, ���̺��2.�÷���, ���̺��3.�÷���
FROM ���̺��1 JOIN ���̺��2
ON ���̺��1.�÷���1 = ���̺��2.�÷���2
             JOIN ���̺��3
             ON ���̺��2.�÷���2 = ���̺��3.�÷���2;
             
-- �� HR���� ������ ���̺� �Ǵ� �� ��� ��ȸ
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

-- �� HR.JOBS, HR.EMPLOYEES, HR.DEPARTMENTS ���̺��� �������
--    �������� �����͸� FIRST_NAME, LAST_NAME, JOB_TITLE, DEPARTMENT_NAME �׸�����
--    ��ȸ�Ѵ�.

-- ����� ��ȸ~~
SELECT *
FROM JOBS;
-- �����÷� JOB_ID
SELECT *
FROM EMPLOYEES;
-- �����÷� DEPARTMENT_ID
SELECT *
FROM DEPARTMENTS;

SELECT COUNT(*)
FROM EMPLOYEES;
-- 107

-- ���1
SELECT E.FIRST_NAME, E.LAST_NAME, J.JOB_TITLE, D.DEPARTMENT_NAME
FROM JOBS J, EMPLOYEES E, DEPARTMENTS D
WHERE J.JOB_ID = E.JOB_ID
      AND E.DEPARTMENT_ID = D.DEPARTMENT_ID(+);

-- ���2
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

-- �� EMPLOYEES, DEPARTMENTS, JOBS, LOCATIONS, COUNTRIES, REGIONS ���̺��� �������
--    �������� �����͸� ������ ���� ��ȸ�� �� �ֵ��� �������� ����
--    FIRST_NAME, LAST_NAME. JOB_TIOTLE, DEPARTMENT_NAME, CITY, COUNTRY_NAME, REGION_NAME

-- 1. 1992 CODE
SELECT E.FIRST_NAME      "��"
     , E.LAST_NAME       "�̸�"
     , J.JOB_TITLE       "����"
     , D.DEPARTMENT_NAME "�μ�"
     , L.CITY            "����"
     , C.COUNTRY_NAME    "����"
     , R.REGION_NAME     "����"
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
