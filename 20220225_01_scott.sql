SELECT USER
FROM DUAL;
--==>> SCOTT

-- ���� ROW_NUMBER ���� --

SELECT ENAME "�����", SAL "�޿�", HIREDATE "�Ի���"
FROM EMP;

SELECT ROW_NUMBER() OVER(ORDER BY SAL DESC) "�׽�Ʈ"
       ,ENAME "�����", SAL "�޿�", HIREDATE "�Ի���"
FROM EMP;
/*
1	KING	5000	1981-11-17
2	FORD	3000	1981-12-03
3	SCOTT	3000	1987-07-13
4	JONES	2975	1981-04-02
5	BLAKE	2850	1981-05-01
6	CLARK	2450	1981-06-09
7	ALLEN	1600	1981-02-20
8	TURNER	1500	1981-09-08
9	MILLER	1300	1982-01-23
10	WARD	1250	1981-02-22
11	MARTIN	1250	1981-09-28
12	ADAMS	1100	1987-07-13
13	JAMES	 950	1981-12-03
14	SMITH	 800	1980-12-17
*/

SELECT ROW_NUMBER() OVER(ORDER BY SAL DESC) "�׽�Ʈ"
       ,ENAME "�����", SAL "�޿�", HIREDATE "�Ի���"
FROM EMP
ORDER BY ENAME;
--==>> 
/*
12	ADAMS	1100	1987-07-13
7	ALLEN	1600	1981-02-20
5	BLAKE	2850	1981-05-01
6	CLARK	2450	1981-06-09
2	FORD	3000	1981-12-03
13	JAMES	 950	1981-12-03
4	JONES	2975	1981-04-02
1	KING	5000	1981-11-17
11	MARTIN	1250	1981-09-28
9	MILLER	1300	1982-01-23
3	SCOTT	3000	1987-07-13
14	SMITH	 800	1980-12-17
8	TURNER	1500	1981-09-08
10	WARD	1250	1981-02-22
*/
SELECT ROW_NUMBER() OVER(ORDER BY ENAME) "�׽�Ʈ"
       ,ENAME "�����", SAL "�޿�", HIREDATE "�Ի���"
FROM EMP
ORDER BY ENAME;
/*
 1	ADAMS	1100	1987-07-13
 2	ALLEN	1600	1981-02-20 
 3	BLAKE	2850	1981-05-01
 4	CLARK	2450	1981-06-09
 5	FORD	3000	1981-12-03
 6	JAMES	 950	1981-12-03
 7	JONES	2975	1981-04-02
 8	KING	5000	1981-11-17
 9	MARTIN	1250	1981-09-28
10	MILLER	1300	1982-01-23
11	SCOTT	3000	1987-07-13
12	SMITH	 800	1980-12-17
13	TURNER	1500	1981-09-08
14	WARD	1250	1981-02-22
*/

SELECT ROW_NUMBER() OVER(ORDER BY ENAME) "�׽�Ʈ"
       ,ENAME "�����", SAL "�޿�", HIREDATE "�Ի���"
FROM EMP
WHERE DEPTNO = 20
ORDER BY ENAME;
/*
1	ADAMS	1100	1987-07-13
2	FORD	3000	1981-12-03
3	JONES	2975	1981-04-02
4	SCOTT	3000	1987-07-13
5	SMITH	 800	1980-12-17
*/

-- �� �Խ����� �Խù� ��ȣ�� SEQUENCE �� IDENTITY�� ����ϰ� �Ǹ�
--    �Խ����� �������� ���, ������ �Խù��� �ڸ��� ���� ��ȣ�� ����
--    �Խù��� ��ϵǴ� ��Ȳ�� �߻��ϰ� �ȴ�.
--    �̴�... ���ȼ� �����̳�... �̰��� �ٶ������� ���� ��Ȳ�� �� �ֱ� ������
--    ROW_NUMBER() �� ����� ����� �� �� �ִ�.
--    ������ �������� ����� ������ SEQUENCE�� IDENTITY�� ���������
--    �ܼ��� �Խù��� ���ȭ�Ͽ� ����ڿ��� ����Ʈ �������� ������ ������
--    ������� �ʴ� ���� �ٶ����ϴ�.

-- �� SEQUENCE(������ : �ֹ���ȣ) ����
--    �� �������� �ǹ� : 1.(�Ϸ���) �������� ��ǵ�, 2.(��� �ൿ ����) ����


CREATE SEQUENCE SEQ_BOARD   -- �⺻���� ������ ���� ����
START WITH 1                 -- ���۰�
INCREMENT BY 1                  -- ������
NOMAXVALUE                   -- �ִ밪                          
NOCACHE;                     -- ĳ�� ��뿩��
--==>> Sequence SEQ_BOARD��(��) �����Ǿ����ϴ�.


-- �� �ǽ� ���̺� ����
CREATE TABLE TBL_BOARD              -- TBL_BOARD ���̺� ���� ���� �� �Խ��� ���̺�
( NO        NUMBER                  -- �Խù� ��ȣ         �� 
, TITLE     VARCHAR2(50)            -- �Խù� ����         ��
, CONTENTS  VARCHAR2(1000)          -- �Խù� ����         ��
, NAME      VARCHAR2(20)            -- �Խù� �ۼ���       ��   
, PW        VARCHAR2(20)            -- �Խù� �н�����     ��
, CREATED   DATE DEFAULT SYSDATE    -- �Խù� �ۼ���       ��
);
--==>> Table TBL_BOARD��(��) �����Ǿ����ϴ�.

-- �� ������ �Է� �� �Խ��ǿ� �Խù��� �ۼ��ϴ� �׼�
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, 'Ǯ��', '�� Ǯ���� �־��', '������', 'java006$', DEFAULT);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '���ζ�', '���ϴ� ���׿�', '������', 'java006$', SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '�غ�', '�ٶ��� �γ׿�', '������', 'java006$', SYSDATE);

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '���ͺ�', '���ͺ����ε�, ���̰� �����׿�', '�̽ÿ�', 'java006$', SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '����ּ���', '���� �������', '�ֹ���', 'java006$', SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '���� ���ΰ�', '���� ���� �� ��', '��μ�', 'java006$', SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '��������', '������ �����Ϸ� �Դ�', '������', 'java006$', SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '�翬��', '�ƹ� ���� ����', '�̾Ƹ�', 'java006$', SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session��(��) ����Ǿ����ϴ�.

SELECT * 
FROM TBL_BOARD;
/*
1	Ǯ��	    �� Ǯ���� �־��	            ������	java006$	2022-02-25 10:31:18
2	���ζ�	    ���ϴ� ���׿�	                ������	java006$	2022-02-25 10:31:23
3	�غ�	    �ٶ��� �γ׿�	                ������	java006$	2022-02-25 10:31:27
4	���ͺ�	    ���ͺ����ε�, ���̰� �����׿�	�̽ÿ�	java006$	2022-02-25 10:31:30
5	����ּ���	���� �������	                �ֹ���	java006$	2022-02-25 10:31:34
6	���� ���ΰ�	���� ���� �� ��              	��μ�	java006$	2022-02-25 10:31:37
7	��������	������ �����Ϸ� �Դ�	        ������	java006$	2022-02-25 10:31:40
8	�翬��	    �ƹ� ���� ����	                �̾Ƹ�	java006$	2022-02-25 10:31:52
*/

-- �� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.

-- �� �Ϻ� ������ ����
DELETE
FROM TBL_BOARD
WHERE NO=2;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.

DELETE
FROM TBL_BOARD
WHERE NO=3;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.

DELETE
FROM TBL_BOARD
WHERE NO=5;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.

DELETE
FROM TBL_BOARD
WHERE NO=6;
--==>> 1 �� ��(��) �����Ǿ����ϴ�.

-- �� �ٽ� ��ȸ
SELECT *
FROM TBL_BOARD;
/*
1	Ǯ��	    �� Ǯ���� �־��	            ������	java006$	2022-02-25 10:31:18
4	���ͺ�	    ���ͺ����ε�, ���̰� �����׿�	�̽ÿ�	java006$	2022-02-25 10:31:30
7	��������	������ �����Ϸ� �Դ�	        ������	java006$	2022-02-25 10:31:40
8	�翬��	    �ƹ� ���� ����	                �̾Ƹ�	java006$	2022-02-25 10:31:52
*/

-- �� �Խù� �߰� �ۼ�
INSERT INTO TBL_BOARD VALUES
(SEQ_BOARD.NEXTVAL, '������', '������ ���ƿ�', '�����', 'java006$', SYSDATE);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

-- �� Ȯ��
SELECT *
FROM TBL_BOARD;
/*
1	Ǯ��	    �� Ǯ���� �־��	            ������	java006$	2022-02-25 10:31:18
4	���ͺ�	    ���ͺ����ε�, ���̰� �����׿�	�̽ÿ�	java006$	2022-02-25 10:31:30
7	��������	������ �����Ϸ� �Դ�	        ������	java006$	2022-02-25 10:31:40
8	�翬��	    �ƹ� ���� ����	                �̾Ƹ�	java006$	2022-02-25 10:31:52
9	������	    ������ ���ƿ�	                �����	java006$	2022-02-25 10:40:31
*/
-- �� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.

SELECT ROW_NUMBER() OVER(ORDER BY CREATED) "�۹�ȣ"
     , TITLE "����", NAME "�ۼ���", CREATED "�ۼ���"
FROM TBL_BOARD
ORDER BY 4 DESC;
/*
5	������	    �����	2022-02-25 10:40:31
4	�翬��	    �̾Ƹ�	2022-02-25 10:31:52
3	��������	������	2022-02-25 10:31:40
2	���ͺ�	    �̽ÿ�	2022-02-25 10:31:30
1	Ǯ��	    ������	2022-02-25 10:31:18
*/

CREATE OR REPLACE VIEW VIEW_BOARDLIST
AS
SELECT ROW_NUMBER() OVER(ORDER BY CREATED) "�۹�ȣ"
     , TITLE "����", NAME "�ۼ���", CREATED "�ۼ���"
FROM TBL_BOARD
ORDER BY 4 DESC;
--==>> View VIEW_BOARDLIST��(��) �����Ǿ����ϴ�.

-- �� ��(VIEW)��ȸ

SELECT *
FROM VIEW_BOARDLIST;
/*
5	������	    �����	2022-02-25 10:40:31
4	�翬��	    �̾Ƹ�	2022-02-25 10:31:52
3	��������	������	2022-02-25 10:31:40
2	���ͺ�	    �̽ÿ�	2022-02-25 10:31:30
1	Ǯ��	    ������	2022-02-25 10:31:18
*/

-- ���� JOIN(����) ���� --
SELECT *
FROM EMP;

SELECT ENAME
FROM EMP;

SELECT EMPNO, ENAME, JOB, SAL, HIREDATE, DEPTNO
FROM EMP;

SELECT *
FROM SALGRADE;
-- 1. SQL 1992 CODE

-- CROSS JOIN
SELECT *
FROM EMP, DEPT;
--> ���п��� ���ϴ� ��ī��Ʈ ��(CARTESIAN PRODUCT)
--  �� ���̺��� ������ ��� ����� ��

-- EQUI JOIN : ���� ��Ȯ�� ��ġ�ϴ� �͵鳢�� �����Ͽ� ���ս�Ű�� ���� ���
-- ��������� ���� ���� ���δ�.
SELECT *
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO;

SELECT *
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;

--  NON EQUI JOIN : ���� �ȿ� ������ �͵鳢�� �����Ͽ� ���ս�Ű�� ���� ���

SELECT *
FROM EMP;

SELECT *
FROM SALGRADE;

SELECT *
FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL;

-- EQUI JOIN �� (+)�� Ȱ���� ���� ���
SELECT *
FROM TBL_EMP;
--> 19���� ��� �� �μ���ȣ�� ���� ���� ������� 5��

SELECT *
FROM TBL_DEPT;
--> 5���� �μ� �� �Ҽӻ���� ���� ���� �μ��� 2

SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--> �� 14���� �����Ͱ� ���յǾ� ��ȸ�� ��Ȳ
--  ��, �μ���ȣ ���� ���� ���(5��)����
--  ���� �Ҽ� ��� �������� �μ�(2��)����

SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO = D.DEPTNO(+);
--> �� 19���� �����Ͱ� ���յǾ� ��ȸ�� ��Ȳ

SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO;
--> �� 16���� �����Ͱ� ���յǾ� ��ȸ�� ��Ȳ

-- �� (+) �� ���� �� ���̺��� �����͸� ��� �޸𸮿� ���� ������ ��
--    (+) �� �ִ� �� ���̺��� �����͸� �ϳ��ϳ� Ȯ���Ͽ� ���ս�Ű�� ���·�
--    JOIN �� �̷������ �ȴ�.

--    �̿� ���� ������...
SELECT *
FROM TBL_EMP E, TBL_DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO(+); 
-- �̷� ������ �������� ����
-- WHY? �޸���, +�� �����̻� ÷���� / ��÷������ ������ ����⶧��
-- ORA-01468: a predicate may reference only one outer-joined table


-- 2. SQL 1999 CODE �� ��JOIN�� Ű���� ���� �� ��JOIN��(����)�� ���� ���
--                     ��ON�� Ű���� ����   �� ���� ������ WHERE ��� ON

-- CROSS JOIN
SELECT *
FROM EMP CROSS JOIN DEPT;

-- INNER JOIN(= EQUI JOIN)
SELECT *
FROM EMP INNER JOIN DEPT        --> , ��� INNER JOIN
ON EMP.DEPTNO = DEPT.DEPTNO;    --> WHERE ��� ON

SELECT *
FROM EMP E INNER JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;

SELECT *
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;     
-- INNER ���� ����

-- OUTER JOIN -> (+) �� ����� ����, ����� �ݴ�������
SELECT *
FROM TBL_EMP LEFT OUTER JOIN TBL_DEPT
ON TBL_EMP.DEPTNO = TBL_DEPT.DEPTNO;

SELECT *
FROM TBL_EMP RIGHT OUTER JOIN TBL_DEPT
ON TBL_EMP.DEPTNO = TBL_DEPT.DEPTNO;

SELECT *
FROM TBL_EMP FULL JOIN TBL_DEPT  -- FULL �� LEFT AND RIGHT�� �ǹ�
ON TBL_EMP.DEPTNO = TBL_DEPT.DEPTNO;
-- OUTER ���� ����
--------------------------------------------------------------------------------

SELECT *
FROM TBL_EMP E JOIN TBL_DEPT D 
ON E.DEPTNO = D.DEPTNO
AND JOB = 'CLERK';
--> �̿� ���� ������� �������� �����ص�
--  ��ȸ ����� ��� ������ ������ ����.

SELECT *
FROM TBL_EMP E JOIN TBL_DEPT D 
ON E.DEPTNO = D.DEPTNO
WHERE JOB = 'CLERK';
-- ������ �̿Ͱ��� �����Ͽ� ��ȸ�ϴ� ���� �����Ѵ�!!
/*
SMITH	CLERK	7902	1980-12-17 00:00:00	800		    20	20	RESEARCH	DALLAS
ADAMS	CLERK	7788	1987-07-13 00:00:00	1100		20	20	RESEARCH	DALLAS
JAMES	CLERK	7698	1981-12-03 00:00:00	950		    30	30	SALES	    CHICAGO
MILLER	CLERK	7782	1982-01-23 00:00:00	1300		10	10	ACCOUNTING	NEW YORK
*/

-- �� EMP ���̺�� DEPT ���̺��� �������
--    ������ MANAGER �� CLERK �� ����鸸 ��ȸ�Ѵ�.
--    �μ���ȣ, �μ���, �����, ������, �޿� �׸��� ��ȸ�Ѵ�.

SELECT  E.DEPTNO, D.DNAME, ENAME, JOB, SAL
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO
WHERE JOB IN ('CLERK', 'MANAGER')
ORDER BY JOB;
/*
10	ACCOUNTING	MILLER	CLERK	1300
20	RESEARCH	SMITH	CLERK	800
20	RESEARCH	ADAMS	CLERK	1100
30	SALES	    JAMES	CLERK	950
30	SALES	    BLAKE	MANAGER	2850
10	ACCOUNTING	CLARK	MANAGER	2450
20	RESEARCH	JONES	MANAGER	2975
*/

SELECT DNAME, ENAME, JOB, SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;
/*
ACCOUNTING	CLARK	MANAGER	    2450
ACCOUNTING	KING	PRESIDENT	5000
ACCOUNTING	MILLER	CLERK	    1300
RESEARCH	JONES	MANAGER	    2975
RESEARCH	FORD	ANALYST	    3000
RESEARCH	ADAMS	CLERK	    1100
RESEARCH	SMITH	CLERK	    800
RESEARCH	SCOTT	ANALYST	    3000
SALES	    WARD	SALESMAN	1250
SALES	    TURNER	SALESMAN	1500
SALES	    ALLEN	SALESMAN	1600
SALES	    JAMES	CLERK	    950
SALES	    BLAKE	MANAGER 	2850
SALES	    MARTIN	SALESMAN	1250
*/

SELECT DEPTNO, DNAME, ENAME, JOB, SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;
--==>> ���� �߻�
--     ORA-00918: column ambiguously defined
--    �� ���̺� �� �ߺ��Ǵ� �÷�(DEPTNO)�� ����
--    �Ҽ� ���̺��� �������(��������)�Ѵ�.

SELECT E.DEPTNO, DNAME, ENAME, JOB, SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO;   -- �� ����и� �Ǵ� �÷��� ���̺�� ���
/*
10	ACCOUNTING	CLARK	MANAGER	    2450
10	ACCOUNTING	KING	PRESIDENT	5000
10	ACCOUNTING	MILLER	CLERK	    1300
20	RESEARCH	JONES	MANAGER	    2975
20	RESEARCH	FORD	ANALYST	    3000
20	RESEARCH	ADAMS	CLERK	    1100
20	RESEARCH	SMITH	CLERK	    800
20	RESEARCH	SCOTT	ANALYST	    3000
30	SALES	    WARD	SALESMAN	1250
30	SALES	    TURNER	SALESMAN	1500
30	SALES	    ALLEN	SALESMAN	1600
30	SALES	    JAMES	CLERK	    950
30	SALES	    BLAKE	MANAGER	    2850
30	SALES	    MARTIN	SALESMAN	1250
*/

-- �� �� ���̺� �� �ߺ��Ǵ� �÷��� ���� �Ҽ� ���̺��� ����ϴ� ���
--    �θ� ���̺��� �÷��� ������ �� �ֵ��� ó���ؾ� �Ѵ�.

SELECT *
FROM EMP; -- �ڽ����̺�

SELECT * -- �θ����̺�
FROM DEPT;

SELECT D.DEPTNO, D.DNAME, E.ENAME, E.JOB, E.SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO;
-- ��� ������ : �θ����̺� �� DEPTNO �� �� ���ϴ�..?
SELECT E.DEPTNO, DNAME, ENAME, JOB, SAL
FROM EMP E, DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO;

-- �� �� ���̺� ��� ���ԵǾ� �ִ� �ߺ��� �÷��� �ƴϴ���
--    �����ϴ� �������� �÷��� �Ҽ� ���̺��� ����� �� �� �ֵ��� ����.
--    �����ڰ� ������ ���ŷο� ���� �� ������ ����.

-- �� SELF JOIN(�ڱ� ����)

-- EMP ���̺��� �����͸� ������ ���� ��ȸ�� �� �ֵ��� 
-- �������� �����Ѵ�.
------------------------------------------------------------------
-- �����ȣ ����� ������ �����ڹ�ȣ �����ڸ� ������������
------------------------------------------------------------------
-- 7369     SMITH  CLERK   7092      FORD       ANALYST
SELECT *
FROM EMP;

-- ���� Ǯ��
SELECT E.EMPNO "�����ȣ"
     , E.ENAME "�����"
     , E.JOB "������"
     , E.MGR "�����ڹ�ȣ"
     , S.ENAME "�������̸�"
     , S.JOB "������������"
FROM EMP E, EMP S
WHERE E.MGR = S.EMPNO(+);

-- ������ Ǯ��
SELECT E.EMPNO "�����ȣ"
     , E.ENAME "�����"
     , E.JOB "������"
     , E.MGR "�����ڹ�ȣ"
     , S.ENAME "�������̸�"
     , S.JOB "������������"
FROM EMP E LEFT JOIN EMP S      -- �� KING�� ���� ó��
ON E.MGR = S.EMPNO ;
/*
7902	FORD	ANALYST	    7566	JONES	MANAGER
7788	SCOTT	ANALYST 	7566	JONES	MANAGER
7900	JAMES	CLERK	    7698	BLAKE	MANAGER
7844	TURNER	SALESMAN	7698	BLAKE	MANAGER
7654	MARTIN	SALESMAN	7698	BLAKE	MANAGER
7521	WARD	SALESMAN	7698	BLAKE	MANAGER
7499	ALLEN	SALESMAN	7698	BLAKE	MANAGER
7934	MILLER	CLERK	    7782	CLARK	MANAGER
7876	ADAMS	CLERK	    7788	SCOTT	ANALYST
7782	CLARK	MANAGER	    7839	KING	PRESIDENT
7698	BLAKE	MANAGER	    7839	KING	PRESIDENT
7566	JONES	MANAGER	    7839	KING	PRESIDENT
7369	SMITH	CLERK	    7902	FORD	ANALYST
7839	KING	PRESIDENT (null)  (null)   (null)	
*/








