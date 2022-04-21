SELECT USER
FROM DUAL;
--==>> HR

-- �� EMPLOYEES ���̺��� ������ SALARY �� 10% �λ��Ѵ�.
--    ��, �μ����� 'IT'�� �����鸸 �����Ѵ�.
--    (����, ���濡 ���� ��� Ȯ�� �� ROLLBACK �����Ѵ�.)

SELECT EMPLOYEE_ID, SALARY, SALARY * 1.1 "�λ�ȱ޿�"
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

-- ���μ���ȣ�� �� 
--  (�μ���ȣ / �μ����̺� / �μ��̸��� IT�� ������) �� ���ٴ� ���Ǹ����
--  ��
UPDATE EMPLOYEES
SET SALARY = SALARY * 1.1
WHERE DEPARTMENT_ID = ( SELECT DEPARTMENT_ID
                        FROM DEPARTMENTS
                        WHERE DEPARTMENT_NAME = 'IT' );
--==>> 5�� �� ��(��) ������Ʈ�Ǿ����ϴ�.


-- Ȯ��
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

-- �ѹ�
ROLLBACK;
�ѹ� �Ϸ�.

-- �ѹ鿩��Ȯ��
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

-- �� EMPLOYEES ���̺��� JOB_TITLE �� ��Sales Manager�� �� �������
--    SALARY �� �ش� ����(����)�� �ְ�޿�(MAX_SALARY)�� �����Ѵ�.
--    ��, �Ի����� 2006�� ����(�ش�⵵����) �Ի��ڿ� ���� ����.
--    (����, ���濡 ���� ��� Ȯ�� �� ROLLBACK ����)

-- ���� �� Sales Manager�� �Ի���, �޿�
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

--  Sales Manager�� �Ի���, �޿� ����
--  ���� 1 : ������ Sales Manager
--  ���� 2 : �ش� �μ����� 2006�� ���� �Ի��ڸ�

--  �����ؾ��� �޿� : �ش�μ� ��ü���� �� ���� ���� �޿��� ����

UPDATE EMPLOYEES
SET SALARY = (SELECT MAX_SALARY
              FROM JOBS
              WHERE JOB_TITLE = 'Sales Manager' )
WHERE JOB_ID = (SELECT JOB_ID
                FROM JOBS
                WHERE JOB_TITLE = 'Sales Manager' )  
  AND EXTRACT (YEAR FROM HIRE_DATE) < 2006;          
--==>> 3�� �� ��(��) ������Ʈ�Ǿ����ϴ�.

-- ���� ��  Sales Manager�� �Ի���, �޿� Ȯ��
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

-- �ѹ�
ROLLBACK;
--==>> �ѹ� �Ϸ�.

-- �ѹ� Ȯ��
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
*/ -- �̻� ����

-- �� EMPLOYEES ���̺��� SALARY��
--    �� �μ��� �̸����� �ٸ� �λ���� �����Ͽ� ������ �� �ֵ��� �Ѵ�.
--    Finance �� 10% �λ�
--    Executive �� 15% �λ�
--    Accounting  �� 20% �λ�
--    ���濡 ���� ��� Ȯ�� �� ROLLBACK
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
----> ��
---- �ش� �������� where �� ���̵� �۵����ϳ�, where �� ���̴�
---- �ӵ��� �ʴ� ������ �߻��Ѵ�
--==>> WHERE �� ���� ��� : 11�� �� ��(��) ������Ʈ�Ǿ����ϴ�.
                 --        ��                     
--==>> WHERE �� ���� ��� : 107�� �� ��(��) ������Ʈ�Ǿ����ϴ�.


-- 'Finance'�� �μ����̵�
SELECT DEPARTMENT_ID
FROM DEPARTMENTS
WHERE DEPARTMENT_NAME = 'Finance';

-- 'Executive'�� �μ����̵�
SELECT DEPARTMENT_ID
FROM DEPARTMENTS
WHERE DEPARTMENT_NAME = 'Executive';

-- 'Accounting'�� �μ����̵�
SELECT DEPARTMENT_ID
FROM DEPARTMENTS
WHERE DEPARTMENT_NAME = 'Accounting';

--------------------------------------------------------------------------------

-- ���� DELETE ���� --

-- 1. ���̺��� ������ ��(���ڵ�)�� �����ϴµ� ����ϴ� ����
-- 2. ���� �� ����
-- DELETE [FROM] ���̺��
-- [WHERE ������];

-- ���̺� ����(������ ����)
CREATE TABLE TBL_EMPLOYEES
AS
SELECT *
FROM EMPLOYEES;
--==> Table TBL_EMPLOYEES��(��) �����Ǿ����ϴ�.

SELECT *
FROM TBL_EMPLOYEES
WHERE EMPLOYEE_ID = 198;
--==>>  198	Donald	OConnell	DOCONNEL	650.507.9833	2007-06-21	SH_CLERK	2600		124	50
-- ��
DELETE 
FROM TBL_EMPLOYEES
WHERE EMPLOYEE_ID = 198;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.

ROLLBACK;
--==>> �ѹ� �Ϸ�.

-- �� EMPLOYEES ���̺��� �������� �����͸� �����Ѵ�.
--    ��, �μ����� 'IT' �� ���� �����Ѵ�.

-- �� �����δ� EMPLOYEES ���̺��� �����Ͱ�(�����ϰ��� �ϴ� ��� ������)
--    �ٸ� ���ڵ忡���� �������ϰ� �ִ� ���
--    �������� ���� �� �ִٴ� ����� �����ؾ� �ϸ�...
--    �׿� ���� ������ �˾ƾ� �Ѵ�.
DELETE
FROM  EMPLOYEES
WHERE DEPARTMENT_ID = ( SELECT DEPARTMENT_ID
                        FROM DEPARTMENTS
                        WHERE DEPARTMENT_NAME = 'IT' );
--==>> ���� �߻�
--     ORA-02292: integrity constraint (HR.DEPT_MGR_FK) violated - child record found

--------------------------------------------------------------------------------
-- ���� ��(VIEW) ���� --

-- 1. ��(VIEW)�� �̹� Ư���� �����ͺ��̽� ���� �����ϴ�
--    �ϳ� �̻��� ���̺��� ����ڰ� ��� ���ϴ� �����͵鸸��
--    ��Ȯ�ϰ� ���ϰ� �������� ���Ͽ� ������ ���ϴ� �÷��鸸�� ��Ƽ�
--    �������� ������ ���̺�� ���Ǽ� �� ���ȿ� ������ �ִ�.

-- ������ ���̺��̶�.. �䰡 ������ �����ϴ� ���̺�(��ü)�� �ƴ϶�
-- �ϳ� �̻��� ���̺��� �Ļ��� �� �ٸ� ������ �� �� �ִ� ����̶�� �ǹ��̸�,
-- �� ������ �����س��� SQL �����̶�� �� �� �ִ�.

-- 2. ���� �� ����
-- CREATE [OR REPLACE] VIEW ���̸�
-- [(ALIAS[, ALIAS, ...])]
-- AS
-- ��������(SUBQUERY)
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
--==>> View VIEW_EMPLOYEES��(��) �����Ǿ����ϴ�.

-- �� ��(VIEW) ��ȸ
SELECT *
FROM VIEW_EMPLOYEES;

DESC VIEW_EMPLOYEES;
/*
�̸�              ��?       ����           
--------------- -------- ------------ 
FIRST_NAME               VARCHAR2(20) 
LAST_NAME       NOT NULL VARCHAR2(25) 
DEPARTMENT_NAME          VARCHAR2(30) 
CITY            NOT NULL VARCHAR2(30) 
COUNTRY_NAME             VARCHAR2(40) 
REGION_NAME              VARCHAR2(25)
*/

-- ����������
-- �� ��(VIEW) �ҽ� Ȯ�� CHECK~!!!

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