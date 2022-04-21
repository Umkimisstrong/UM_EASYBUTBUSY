SELECT USER
FROM DUAL;
--==>> SCOTT

SELECT DEPTNO, SAL
FROM EMP
ORDER BY 1;
/*
10	2450��
10	5000�� 8750
10	1300��   
20	29750��
20	3000 ��
20	1100 �� 10875
20	800  ��
20	3000 ��   
30	12500��
30	1500 ��
30	1600 ��
30	950  �� 9400
30	2850 ��
30	1250 ��   
*/

SELECT DEPTNO, SUM(SAL)
FROM EMP
GROUP BY DEPTNO
ORDER BY 1;
/*
10	8750
20	10875
30	9400
*/

-- �� ������ �����ص� TBL_EMP ���̺� ����
DROP TABLE TBL_EMP;
--==>> Table TBL_EMP��(��) �����Ǿ����ϴ�.


-- �� �ٽ� EMP ���̺� �����Ͽ� TBL_EMP ���̺� ����
CREATE TABLE TBL_EMP
AS
SELECT *
FROM EMP;
--==>> Table TBL_EMP��(��) �����Ǿ����ϴ�.

-- �� �ǽ� ������ �߰� �Է�(TBL_EMP)
INSERT INTO TBL_EMP VALUES
(8001, 'ȫ����', 'CLERK', 7566, SYSDATE, 1500, 10, NULL);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_EMP VALUES
(8002, '����', 'CLERK', 7566, SYSDATE, 2000, 10, NULL);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_EMP VALUES
(8003, '��ȣ��', 'SALESMAN', 7698, SYSDATE, 1700, NULL, NULL);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_EMP VALUES
(8004, '�Ž���', 'SALESMAN', 7698, SYSDATE, 2500, NULL, NULL);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

INSERT INTO TBL_EMP VALUES
(8005, '������', 'SALESMAN', 7698, SYSDATE, 1000, NULL, NULL);
--==>> 1 �� ��(��) ���ԵǾ����ϴ�.

SELECT *
FROM TBL_EMP;
/*
7369	SMITH	CLERK	    7902	1980-12-17	800		(null)  20
7499	ALLEN	SALESMAN	7698	1981-02-20	1600	300	    30
7521	WARD	SALESMAN	7698	1981-02-22	1250	500	    30
7566	JONES	MANAGER	    7839	1981-04-02	2975	(null) 	20
7654	MARTIN	SALESMAN	7698	1981-09-28	1250	1400	30
7698	BLAKE	MANAGER	    7839	1981-05-01	2850	(null)  30
7782	CLARK	MANAGER	    7839	1981-06-09	2450	(null)  10
7788	SCOTT	ANALYST	    7566	1987-07-13	3000	(null)  20
7839	KING	PRESIDENT	(null)	1981-11-17	5000	(null)  10
7844	TURNER	SALESMAN	7698	1981-09-08	1500	  0	    30
7876	ADAMS	CLERK	    7788	1987-07-13	1100	(null)  20
7900	JAMES	CLERK	    7698	1981-12-03	950		(null)  30
7902	FORD	ANALYST	    7566	1981-12-03	3000	(null)	20
7934	MILLER	CLERK	    7782	1982-01-23	1300	(null)  10
8001	ȫ����	CLERK	    7566	2022-02-24	1500	10	    (null)
8002	����	CLERK	    7566	2022-02-24	2000	10	    (null)
8003	��ȣ��	SALESMAN	7698	2022-02-24	1700	(null)	(null)
8004	�Ž���	SALESMAN	7698	2022-02-24	2500	(null)	(null)
8005	������	SALESMAN	7698	2022-02-24	1000	(null)	(null)
*/

-- �� Ŀ��
COMMIT;
--==>> Ŀ�� �Ϸ�.

SELECT DEPTNO, SAL, COMM
FROM TBL_EMP
ORDER BY COMM DESC;
/*
20	800	    (null)
	1700    (null)	
	1000	(null)
10	1300	(null)
20	2975	(null)
30	2850	(null)
10	2450	(null)
20	3000	(null)
10	5000	(null)
	2500	(null)
20	1100	(null)
30	950	    (null)
20	3000	(null)
30	1250	1400
30	1250	500
30	1600	300
	1500	10
	2000	10
30	1500	0
*/

-- �� ����Ŭ������ NULL �� ���� ū ���� ���·� �����Ѵ�.
--    (ORACLE 9i ���������� NULL �� ���� ���� ���� ���·� �����߾���.)
--    MSSQL �� NULL �� ���� ���� ���� ���·� �����Ѵ�.

-- �� TMP_EMP ���̺��� ������� �μ��� �޿��� ��ȸ
--    �μ���ȣ, �޿��� �׸� ��ȸ
SELECT DEPTNO, SUM(SAL)
FROM TBL_EMP
GROUP BY DEPTNO
ORDER BY DEPTNO; 
/*
    10	8750
    20	10875
    30	9400
(null)  8700
*/

-- �� ROLLUP ���
SELECT DEPTNO, SUM(SAL)
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
/*
    10	8750
    20	10875
    30	9400
(null)	8700    -- �μ���ȣ�� ���� ���� �������� �޿� ��
(null)	37725   -- ���μ� �������� �޿���
*/

SELECT DEPTNO "�μ���ȣ", SUM(SAL) "�޿���"
FROM EMP
GROUP BY ROLLUP(DEPTNO);
/*
    10	8750
    20	10875
    30	9400
(null)	29025
*/

/*
-------  -------
�μ���ȣ �޿���
-------  -------
      10	8750
      20	10875
      30	9400
���μ�	29025
*/

SELECT NVL(TO_CHAR(DEPTNO), '���μ�') "�μ���ȣ", SUM(SAL) "�޿���"
FROM EMP
GROUP BY ROLLUP(DEPTNO);
/*
      10	8750
      20 	10875
      30 	9400
���μ�	29025
*/

SELECT GROUPING(DEPTNO) "GROUPING", DEPTNO "�μ���ȣ", SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
/*
GROUPING �μ���ȣ   �޿���
-------- --------- -------
     0	    10	     8750
     0	    20	    10875
     0	    30	     9400
     0	 (null)      8700   -- ����
     1	 (null)     37725   -- ���μ�
*/

SELECT DEPTNO "�μ���ȣ", SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);

-- �� ������ ��ȸ�� �ش� ������
/*
     10	    8750
     20 	10875
     30 	9400
   ����     8700
���μ�	37725
*/
-- �̿Ͱ��� ��ȸ�� �� �ֵ��� �������� �����Ѵ�.

SELECT CASE GROUPING(DEPTNO)
       WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '����')
       ELSE '���μ�'
       END "�μ���ȣ"
       , SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO);
/*
10  	     8750
20	        10875
30	         9400
����  	     8700
���μ�	37725
*/

-- �� TBL_SAWON ���̺��� �������
--    ������ ���� ��ȸ�� �� �ֵ��� �������� �����Ѵ�.
/*
-------------------------------
    ����            �޿���
-------------------------------
     ��             XXXXX
     ��             XXXXX 
     �����       XXXXX
-------------------------------     
*/

SELECT CASE GROUPING(T.����) WHEN 0 THEN  T.����
                             ELSE '�����'
       END "����1"

       , NVL(TO_CHAR(T.����), '�����') "����2"
       
       , SUM(T.�޿�) "�޿���"      
FROM
(
SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '3') THEN '��'
            WHEN SUBSTR(JUBUN, 7, 1) IN ('2', '4') THEN '��'
            ELSE '����Ȯ�� �Ұ�'
            END "����"
       , SAL "�޿�"
FROM TBL_SAWON
)T
GROUP BY ROLLUP(T.����);
/*
-------     ----------
 ����         �޿���
-------     ----------
��            21900
��            33100
�����      55000
*/

SELECT *
FROM VIEW_SAWON;

-- �� TBL_SAWON ���̺��� �������
--    ������ ���� ��ȸ�� �� �ֵ��� ���ɴ뺰 �ο�����
--    Ȯ���� �� �ִ� �������� �����Ѵ�.
/*
--------------------
   ���ɴ�   �ο���
--------------------
   10       X
   20       X
   40       X
   50       X
   ��ü     XX
--------------------
*/

-- ���� ��� ��
SELECT CASE GROUPING(Y.���ɴ�) WHEN 0 THEN TO_CHAR(Y.���ɴ�)
                               ELSE '��ü'
       END "���ɴ�"
       , COUNT(Y.���ɴ�) "�ο���"
FROM
(
SELECT CASE WHEN T.���� >= 50 THEN 50
            WHEN T.���� >= 40 THEN 40
            WHEN T.���� >= 20 THEN 20
            WHEN T.���� >= 10 THEN 10
            ELSE 10000
            END "���ɴ�"
FROM 
(
SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2')
            THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2))+1899)
            WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4')
            THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2))+1999)
            ELSE 0
       END "����"
FROM TBL_SAWON
)T
)Y
GROUP BY ROLLUP(Y.���ɴ�)
ORDER BY Y.���ɴ�;

/*
--------------------
���ɴ�   �ο���
--------------------
10	        2
20	       12
40	        1
50	        3
��ü	   18
*/

-- ���� ��� �� (VIEW �ι�����)
CREATE OR REPLACE VIEW MYVIEW_TBL_SAWON
AS
SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2')
            THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2))+1899)
            WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4')
            THEN EXTRACT(YEAR FROM SYSDATE) - (TO_NUMBER(SUBSTR(JUBUN, 1, 2))+1999)
            ELSE 0
       END "����"
FROM TBL_SAWON;

-- 1��° VIEW �� ����  2��° VIEW ����
CREATE OR REPLACE VIEW MYVIEW_TBL_SAWON2
AS
SELECT CASE WHEN K.���� >= 50 THEN 50
            WHEN K.���� >= 40 THEN 40
            WHEN K.���� >= 20 THEN 20
            WHEN K.���� >= 10 THEN 10
            ELSE -1
            END "���ɴ�"
FROM
(
SELECT *
FROM MYVIEW_TBL_SAWON
)K;

-- 2��° VIEW�� ���� ��� ��ȸ
SELECT NVL(TO_CHAR(G.���ɴ�), '��ü')    "���ɴ�"
     , COUNT(G.���ɴ�)                   "�ο���"
FROM
(
SELECT *
FROM MYVIEW_TBL_SAWON2
)G
GROUP BY ROLLUP(G.���ɴ�);
/*
10	     2
20	    12
40	     1
50	     3
��ü	18
*/

-- ������ ��� 1. �� INLINE VIEW �� �� �� ��ø(���� 1��������)

SELECT NVL(TO_CHAR(T2.���ɴ�), '��ü') "���ɴ�"
     , COUNT(*) "�ο���"
FROM
(
  -- ���ɴ�
SELECT CASE WHEN T1.���� >= 50 THEN 50
            WHEN T1.���� >= 40 THEN 40
            WHEN T1.���� >= 30 THEN 30
            WHEN T1.���� >= 20 THEN 20
            WHEN T1.���� >= 10 THEN 10
            ELSE -123456789
            END "���ɴ�"
FROM
(
-- ����
SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2')
            THEN EXTRACT(YEAR FROM SYSDATE)-(TO_NUMBER(SUBSTR(JUBUN, 1, 2))+1899)
            WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4')
            THEN EXTRACT(YEAR FROM SYSDATE)-(TO_NUMBER(SUBSTR(JUBUN, 1, 2))+1999)
            ELSE -123123123
       END "����"
FROM TBL_SAWON
)T1
)T2
GROUP BY ROLLUP(T2.���ɴ�);
/*
10	     2
20	    12
40	     1
50	     3
��ü	18
*/

SELECT CASE GROUPING(T2.���ɴ�) WHEN 0 THEN TO_CHAR(T2.���ɴ�)
                                ELSE '��ü'
       END "���ɴ�"
       
     , COUNT(*) "�ο���"
FROM
(
  -- ���ɴ�
SELECT CASE WHEN T1.���� >= 50 THEN 50
            WHEN T1.���� >= 40 THEN 40
            WHEN T1.���� >= 30 THEN 30
            WHEN T1.���� >= 20 THEN 20
            WHEN T1.���� >= 10 THEN 10
            ELSE -123456789
            END "���ɴ�"
FROM
(
-- ����
SELECT CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2')
            THEN EXTRACT(YEAR FROM SYSDATE)-(TO_NUMBER(SUBSTR(JUBUN, 1, 2))+1899)
            WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4')
            THEN EXTRACT(YEAR FROM SYSDATE)-(TO_NUMBER(SUBSTR(JUBUN, 1, 2))+1999)
            ELSE -123123123
       END "����"
FROM TBL_SAWON
)T1
)T2
GROUP BY ROLLUP(T2.���ɴ�);
/*
10	     2
20	    12
40	     1
50	     3
��ü	18
*/



-- ������ ��� 2. �� INLINE VIEW �� �� ���� ���
--  �ٽ� : ���̿� ���ɴ��� ��꿡��, ������ ���ϴ� ���̾ƴ�, 10���ڸ���
--         Ȯ���ؼ� �����ϴ� ��.
SELECT TRUNC(21, -1) "RESULT"
FROM DUAL;
--==>> 20

SELECT CASE GROUPING(T.���ɴ� )WHEN 0  THEN TO_CHAR(T.���ɴ�)
                               ELSE '��ü'
       END "���ɴ�"
     , COUNT(*) "�ο���"
FROM
(
    -- ���ɴ�
SELECT TRUNC(CASE WHEN SUBSTR(JUBUN, 7, 1) IN ('1', '2')
            THEN EXTRACT(YEAR FROM SYSDATE)-(TO_NUMBER(SUBSTR(JUBUN, 1, 2))+1899)
            WHEN SUBSTR(JUBUN, 7, 1) IN ('3', '4')
            THEN EXTRACT(YEAR FROM SYSDATE)-(TO_NUMBER(SUBSTR(JUBUN, 1, 2))+1999)
            ELSE -123123123
       END, -1) "���ɴ�"
FROM TBL_SAWON
)T
GROUP BY ROLLUP(T.���ɴ�);
/*
10	     2
20	    12
40	     1
50	     3
��ü	18
*/

SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY DEPTNO, JOB
ORDER BY 1, 2;
/*
10	CLERK	    1300
10	MANAGER	    2450
10	PRESIDENT	5000
20	ANALYST	    6000
20	CLERK	    1900
20	MANAGER	    2975
30	CLERK	    950
30	MANAGER	    2850
30	SALESMAN	5600
*/


SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY ROLLUP(DEPTNO, JOB)
ORDER BY 1, 2;
/*
10	    CLERK	    1300    -- 10�μ� CLERK ������ �޿���
10	    MANAGER	    2450    -- 10�μ� MANAGER ������ �޿���
10	    PRESIDENT	5000    -- 10�μ� PRESIDENT ������ �޿���
10	    (null)	    8750    -- 10�μ� ��� ������ �޿���
20	    ANALYST	    6000    -- 20�μ� ANALYST ������ �޿���
20	    CLERK	    1900    -- 20�μ� CLERK ������ �޿���
20	    MANAGER	    2975    -- 20�μ� MANAGER ������ �޿���
20	    (null)  	10875   -- 20�μ� ��� ������ �޿���
30	    CLERK	    950     -- 30�μ� CLERK ������ �޿���
30	    MANAGER	    2850    -- 30�μ� MANAGER ������ �޿���
30	    SALESMAN	5600    -- 30�μ� SALESMAN ������ �޿���
30	    (null)  	9400    -- 30�μ� ��� ������ �޿���
(null)	(null)  	29025   -- ���μ� ��� ������ �޿���
*/

-- �� CUBE() �� ROLLUP()���� �� �ڼ���  ����� ��ȯ�޴´�.
SELECT DEPTNO, JOB, SUM(SAL)
FROM EMP
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY 1, 2;
/*
10	    CLERK	    1300
10	    MANAGER	    2450
10	    PRESIDENT	5000
10	    (null)	    8750
20	    ANALYST	    6000
20	    CLERK	    1900
20	    MANAGER	    2975
20		(null)      10875
30	    CLERK   	950
30	    MANAGER	    2850
30	    SALESMAN	5600
30		(null)      9400
(null)	ANALYST	    6000    -- ��� �μ� ANALYST ������ �޿���
(null)	CLERK	    4150    -- ��� �μ� CLERK ������ �޿���
(null)	MANAGER	    8275    -- ��� �μ� MANAGER ������ �޿���
(null)	PRESIDENT	5000    -- ��� �μ� PRESIDENT ������ �޿���
(null)	SALESMAN	5600    -- ��� �μ� SALESMAN ������ �޿���
(null)  (null)  	29025
*/

-- �� ROLLUP() �� CUBE()��
--    �׷��� �����ִ� ����� �ٸ���.(����)

-- EX)
-- ROLLUP(A, B, C)
-- ��(A, B, C)/(A, B) /(A) / ()

-- CUBE(A, B, C)
-- ��(A, B, C)/(A, B)/(A, C) / (B, C) / (A) / (B) / (C)/ ()

--==>> ������ ����� �� ROLLUP() �� ���� ����� �ټ� ���ڶ��
--     �Ʒ����� ����� �� CUBE() �� ���� ����� �ټ� ����ġ�� ������
--     ������ ���� ����� ���� ���¸� �� ���� ����Ѵ�.
--     ���� �ۼ��ϴ� ������ ��ȸ�ϰ��� �ϴ� �׷츸 ��GROUPING SETS��
--     �� �̿��Ͽ� �����ִ� ����̴�.

SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '����')
                             ELSE '��ü�μ�'
        END "�μ���ȣ"
     , CASE GROUPING(JOB)WHEN 0 THEN JOB ELSE '��ü����'END "����"
     , SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY ROLLUP(DEPTNO, JOB)
ORDER BY 1, 2;
/*
10	        CLERK	    1300
10	        MANAGER	    2450
10	        PRESIDENT	5000
10	        ��ü����	8750
20	        ANALYST	    6000
20	        CLERK	    1900
20	        MANAGER	    2975
20	        ��ü����	10875
30	        CLERK	    950
30	        MANAGER	    2850
30	        SALESMAN	5600
30	        ��ü����	9400
����	    CLERK	    3500
����	    SALESMAN	5200
����	    ��ü����	8700
��ü�μ�	��ü����	37725
*/

SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '����')
                             ELSE '��ü�μ�'
        END "�μ���ȣ"
     , CASE GROUPING(JOB)WHEN 0 THEN JOB ELSE '��ü����'END "����"
     , SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY CUBE(DEPTNO, JOB)
ORDER BY 1, 2;
/*
10	        CLERK	    1300
10	        MANAGER 	2450
10	        PRESIDENT	5000
10	        ��ü����	8750
20	        ANALYST	    6000
20	        CLERK	    1900
20	        MANAGER	    2975
20	        ��ü����	10875
30	        CLERK	    950
30	        MANAGER	    2850
30	        SALESMAN	5600
30	        ��ü����	9400
����	    CLERK	    3500
����	    SALESMAN	5200
����	    ��ü����	8700
��ü�μ�	ANALYST	    6000
��ü�μ�	CLERK	    7650
��ü�μ�	MANAGER	    8275
��ü�μ�	PRESIDENT	5000
��ü�μ�	SALESMAN	10800
��ü�μ�	��ü����	37725
*/

SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '����')
                             ELSE '��ü�μ�'
        END "�μ���ȣ"
     , CASE GROUPING(JOB)WHEN 0 THEN JOB ELSE '��ü����'END "����"
     , SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY GROUPING SETS((DEPTNO, JOB), (DEPTNO), (JOB), ())
ORDER BY 1, 2;
/*
10	        CLERK	    1300
10	        MANAGER	    2450
10	        PRESIDENT	5000
10	        ��ü����	8750
20	        ANALYST	    6000
20	        CLERK	    1900
20	        MANAGER	    2975
20	        ��ü����	10875
30	        CLERK	    950
30	        MANAGER	    2850
30	        SALESMAN	5600
30	        ��ü����	9400
����	    CLERK	    3500
����	    SALESMAN	5200
����	    ��ü����	8700
��ü�μ�	ANALYST	    6000
��ü�μ�	CLERK	    7650
��ü�μ�	MANAGER	    8275
��ü�μ�	PRESIDENT	5000
��ü�μ�	SALESMAN	10800
��ü�μ�	��ü����	37725
*/

SELECT CASE GROUPING(DEPTNO) WHEN 0 THEN NVL(TO_CHAR(DEPTNO), '����')
                             ELSE '��ü�μ�'
        END "�μ���ȣ"
     , CASE GROUPING(JOB)WHEN 0 THEN JOB ELSE '��ü����'END "����"
     , SUM(SAL) "�޿���"
FROM TBL_EMP
GROUP BY GROUPING SETS((DEPTNO, JOB), (DEPTNO), ())
ORDER BY 1, 2;
/*
10	        CLERK   	1300
10	        MANAGER 	2450
10	        PRESIDENT	5000
10	        ��ü����	8750
20	        ANALYST	    6000
20	        CLERK	    1900
20	        MANAGER	    2975
20	        ��ü����	10875
30	        CLERK	    950
30	        MANAGER	    2850
30	        SALESMAN	5600
30	        ��ü����	9400
����	    CLERK	    3500
����	    SALESMAN	5200
����	    ��ü����	8700
��ü�μ�	��ü����	37725
*/

SELECT *
FROM TBL_EMP
ORDER BY HIREDATE;

-- �� TBL_EMP ���̺��� �������
--    �Ի�⵵�� �ο��� �ο��� ���� �� ��ȸ�Ѵ�.

SELECT NVL(T.�Ի�⵵, '��ü') "�Ի�⵵"
     , COUNT(T.�Ի�⵵) "�ο���"
FROM
(
SELECT TO_CHAR(HIREDATE, 'YYYY') "�Ի�⵵"
FROM TBL_EMP
)T
GROUP BY ROLLUP(T.�Ի�⵵)
ORDER BY 1, 2;


SELECT EXTRACT(YEAR FROM HIREDATE) "�Ի�⵵"
      , COUNT(*)"�ο���"
FROM TBL_EMP
GROUP BY ROLLUP(EXTRACT(YEAR FROM HIREDATE))
ORDER BY 1;
/*
1980	1
1981	10
1982	1
1987	2
2022	5
(null)  19
*/


SELECT EXTRACT(YEAR FROM HIREDATE) "�Ի�⵵"
      , COUNT(*)"�ο���"
FROM TBL_EMP
GROUP BY ROLLUP(TO_CHAR(HIREDATE, 'YYYY'))
ORDER BY 1;
--==>> ���� �߻�
--     ORA-00979: not a GROUP BY expression


SELECT TO_CHAR(HIREDATE, 'YYYY') "�Ի�⵵"
      , COUNT(*)"�ο���"
FROM TBL_EMP
GROUP BY ROLLUP(TO_CHAR(HIREDATE, 'YYYY'))
ORDER BY 1;
/*
1980	1
1981	10
1982	1
1987	2
2022	5
(null)	19
*/

SELECT TO_CHAR(HIREDATE, 'YYYY') "�Ի�⵵"
      , COUNT(*)"�ο���"
FROM TBL_EMP
GROUP BY ROLLUP(EXTRACT(YEAR FROM HIREDATE))
ORDER BY 1;
--==>> ���� �߻�
--     ORA-00979: not a GROUP BY expression

SELECT CASE GROUPING (TO_CHAR(HIREDATE, 'YYYY'))WHEN 0
            THEN TO_CHAR(HIREDATE, 'YYYY')
            ELSE '��ü'
            END "�Ի�⵵"
     , COUNT(*)
FROM TBL_EMP
GROUP BY CUBE(TO_CHAR(HIREDATE, 'YYYY'))
ORDER BY 1;
/*
1980	1
1981	10
1982	1
1987	2
2022	5
��ü	19
*/

SELECT CASE GROUPING (EXTRACT(YEAR FROM HIREDATE))WHEN 0
            THEN TO_CHAR(EXTRACT(YEAR FROM HIREDATE))
            ELSE '��ü'
            END "�Ի�⵵"
     , COUNT(*)
FROM TBL_EMP
GROUP BY CUBE(EXTRACT(YEAR FROM HIREDATE))
ORDER BY 1;
/*
-1	    19
1980	1
1981	10
1982	1
1987	2
2022	5
*/

--------------------------------------------------------------------------------

-- ���� HAVING ���� --
-- �� EMP ���̺��� �μ���ȣ�� 20, 30 �� �μ��� �������
--    �μ��� �� �޿��� 10000 ���� ���� ��츸 �μ��� �� �޿��� ��ȸ�Ѵ�.

SELECT NVL(TO_CHAR(DEPTNO), '���μ�') "�μ���ȣ", SUM(SAL) "�޿�"
FROM TBL_EMP
WHERE DEPTNO IN(20, 30)
GROUP BY ROLLUP(DEPTNO)
HAVING SUM(SAL) < 10000
ORDER BY 1;
--==>> 30	9400

--------------------------------------------------------------------------------

-- ���� ��ø �׷��Լ� / �м��Լ� ���� --
-- �׷��Լ��� 2 LEVEL ������ ��ø�ؼ� ����� �� �ִ�. = ��ø�� �ѹ����ȴ�.
-- MSSQL�� �̸����� �Ұ����ϴ�.

SELECT SUM(SAL)
FROM EMP
GROUP BY DEPTNO;
--==>>
/*
9400
10875
8750
*/

SELECT MAX(SUM(SAL))
FROM EMP
GROUP BY DEPTNO;
--==>>10875

SELECT MIN(SUM(SAL))
FROM EMP
GROUP BY DEPTNO;
--==>> 8750

-- �� RANK()
--    DENSE_RANK()
-->   ORACLE 9i ���� ����.. MSSQL 2005���� ����...

-- ���� ���������� RANK()�� DENSE_RANK()�� ����� �� ���� ������
-- ���� ���... �޿� ������ ���ϰ��� �Ѵٸ�..
-- �ش� ����� �޿����� �� ū ���� �� �� ���� Ȯ���� ��
-- Ȯ���� ���� +1 �� �߰������� �ָ�...
-- �� ���� �� �ش� ����� �޿� ����� �ȴ�.

SELECT ENAME, SAL
FROM EMP;
/*
SMITH	800
ALLEN	1600
WARD	1250
JONES	2975
MARTIN	1250
BLAKE	2850
CLARK	2450
SCOTT	3000
KING	5000
TURNER	1500
ADAMS	1100
JAMES	950
FORD	3000
MILLER	1300
*/

-- �� SMITH �� �޿� ��� Ȯ��
SELECT COUNT (*) + 1 -- : ���
FROM EMP
WHERE SAL > 800;  -- SMITH �� �޿�
--==>> SMITH �� �޿���� : 14

-- �� ALLEN �� �޿���� Ȯ��

SELECT COUNT(*) +1
FROM EMP
WHERE SAL >1600;
--==>> ALLEN �� �޿���� : 7

-- �� ���� ��� ����(��� ���� ����)
--    ���� ������ �ִ� ���̺��� �÷���
--    ���� ������ ������(WHERE, HAVING)�� ���Ǵ� ���
--    �츮�� �� �������� ���� ��� ����(��� ���� ����)��� �θ���.

SELECT ENAME "�����", SAL "�޿�"
     , (SELECT COUNT (*) + 1 
        FROM EMP 
        WHERE SAL > E.SAL) "�޿����"
FROM EMP E;
/*
WARD	1250	10
JONES	2975	4
MARTIN	1250	10
BLAKE	2850	5
CLARK	2450	6
SCOTT	3000	2
KING	5000	1
TURNER	1500	8
ADAMS	1100	12
JAMES	 950	13
FORD	3000	2
MILLER	1300	9
*/

-- �� EMP ���̺��� �������
--    �����, �޿�, �μ���ȣ, �μ��� �޿����, ��ü�޿���� �׸��� ��ȸ
--    ��, RANK()�Լ��� ������� �ʰ� ������������ Ȱ���� �� �ֵ����Ѵ�.

   SELECT DEPTNO "�μ���ȣ", SAL "�޿�"
           , (SELECT COUNT (*)+ 1
              FROM EMP
              WHERE SAL > K.SAL AND DEPTNO = 20)"�޿�����"
    FROM EMP K
    WHERE DEPTNO = 20;


SELECT ENAME "�����", SAL "�޿�", DEPTNO "�μ���ȣ"
     , CASE WHEN K.DEPTNO = 10 THEN (SELECT COUNT (*)+ 1
                                     FROM EMP
                                     WHERE SAL > K.SAL AND DEPTNO = 10)
            WHEN K.DEPTNO = 20 THEN (SELECT COUNT (*)+ 1
                                     FROM EMP
                                     WHERE SAL > K.SAL AND DEPTNO = 20)
            WHEN K.DEPTNO = 30 THEN (SELECT COUNT (*)+ 1
                                     FROM EMP
                                     WHERE SAL > K.SAL AND DEPTNO = 30)
            ELSE 0
            END "�μ��� �޿����"
     , (SELECT COUNT(*) +1 
        FROM EMP
        WHERE SAL > K.SAL) "��ü�޿����"
FROM EMP K
ORDER BY DEPTNO;

------------------------------------------------------

SELECT E.ENAME "�����", E.SAL "�޿�", E.DEPTNO "�μ���ȣ"
      , (SELECT COUNT (*) + 1 
        FROM EMP 
        WHERE SAL > E.SAL AND DEPTNO = E.DEPTNO) "�μ����޿����"
        
      , (SELECT COUNT (*) + 1 
        FROM EMP 
        WHERE SAL > E.SAL) "��ü�޿����"
FROM EMP E
ORDER BY DEPTNO;
/*
CLARK	2450	10	2	6
KING	5000	10	1	1
MILLER	1300	10	3	9
JONES	2975	20	3	4
FORD	3000	20	1	2
ADAMS	1100	20	4	12
SMITH	 800	20	5	14
SCOTT	3000	20	1	2
WARD	1250	30	4	10
TURNER	1500	30	3	8
ALLEN	1600	30	2	7
JAMES	 950	30	6	13
BLAKE	2850	30	1	5
MARTIN	1250	30	4	10
*/

SELECT ENAME, SAL
FROM EMP
WHERE DEPTNO = 20;
-- �� EMP ���̺��� ������� ������ ���� ��ȸ�� �� �ֵ��� �������� ����
---------------------------------------------------------------------------
--  �����  �μ���ȣ    �Ի���       �޿�    �μ����Ի纰�޿�����
---------------------------------------------------------------------------
--                                   :
--  SMITH     20        1980-12-17    800                    800
--  JONES     20        1981-04-02   2975                   3775
--  FORD      20        1981-12-03   3000                   6775
--                           :

---------------------------------------------------------------------------

SELECT ENAME "�����"
     , DEPTNO "�μ���ȣ"
     , HIREDATE "�Ի���"
     , SAL "�޿�"
     , (SELECT SUM(SAL)
        FROM EMP
        WHERE DEPTNO = E.DEPTNO
        AND E.HIREDATE >= HIREDATE) "�μ����Ի纰�޿�����"
FROM EMP E
ORDER BY DEPTNO, HIREDATE
;
-------- �質   �鼱���� ------------

SELECT E1.ENAME "�����", E1.DEPTNO "�μ���ȣ"
       , E1.HIREDATE "�Ի���", E1.SAL "�޿�"
       , (SELECT SUM(E2.SAL)
          FROM EMP E2
          WHERE E2.DEPTNO = E1.DEPTNO
          AND E1.HIREDATE >= E2.HIREDATE) "�μ����Ի纰�޿�����"
FROM EMP E1
ORDER BY 2, 3;
/*
CLARK	10	1981-06-09	2450	2450
KING	10	1981-11-17	5000	7450
MILLER	10	1982-01-23	1300	8750
SMITH	20	1980-12-17	 800	800
JONES	20	1981-04-02	2975	3775
FORD	20	1981-12-03	3000	6775
SCOTT	20	1987-07-13	3000	10875
ADAMS	20	1987-07-13	1100	10875
ALLEN	30	1981-02-20	1600	1600
WARD	30	1981-02-22	1250	2850
BLAKE	30	1981-05-01	2850	5700
TURNER	30	1981-09-08	1500	7200
MARTIN	30	1981-09-28	1250	8450
JAMES	30	1981-12-03	 950	9400
*/

-- �� EMP���̺��� �������
--    �Ի��� ����� ���� ���� ������ ����
--    �Ի����� �ο����� ��ȸ�� �� �ֵ��� �������� �����Ѵ�.
SELECT *
FROM EMP;

------------------------------
---- �Ի���      �ο���
------------------------------

SELECT "�Ի���"
     , "�ο���"
FROM TBL_EMP;


SELECT TO_CHAR(HIREDATE, 'YYYY-MM') "�Ի���"
     , COUNT(*) "�ο���"
FROM EMP S
GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM')
HAVING COUNT(*) = (SELECT MAX(COUNT(*))
                   FROM EMP
                   GROUP BY TO_CHAR(HIREDATE, 'YYYY-MM')); 












