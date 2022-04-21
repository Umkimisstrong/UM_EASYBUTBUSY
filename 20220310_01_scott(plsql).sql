SELECT USER
FROM DUAL;
--==>> SCOTT


-- ���� FUNCTION (�Լ�) ���� --
-- 1. �Լ��� �ϳ� �̻��� PL/SQL ������ ������ �����ƾ����
--    �ڵ带 �ٽ� ����� �� �ֵ��� ĸ��ȭ �ϴµ� ���ȴ�.
--    ����Ŭ������ ����Ŭ�� ���ǵ� �⺻ ���� �Լ��� ����ϰų�
--    ���� ������ �Լ��� ���� �� �ִ�.(�� ����� ���� �Լ�)
--    �� ����� ���� �Լ��� �ý��� �Լ�ó�� �������� ȣ���ϰų�
--    ���� ���ν���ó�� EXECUTE ���� ���� ������ �� �ִ�.

-- 2. ���� �� ����
/*
CREATE [OR REPLACE] FUNCTION �Լ���
[( �Ű�������1 �ڷ���
 , �Ű�������2 �ڷ���
 )]
RETURN ������Ÿ��
IS
    -- �ַ� ���� ����
BEGIN
    -- ���๮ ;
    ...
    RETURN(��);
    
    [EXCEPTION]
        -- ����ó������;
END;        
*/

-- �� ��������� �Լ�(������ �Լ�)��
--    IN �Ķ����(�Է� �Ű�����)�� ����� �� ������
--    �ݵ�� ��ȯ�� ���� ������Ÿ���� RETURN ���� �����ؾ� �ϰ�,
--    FUNCTION �� �ݵ�� ���� ���� ��ȯ�Ѵ�.

-- �� TBL_INSA ���̺� ���� ���� Ȯ�� �Լ� ����(����)
-- �Լ��� : FN_GENDER()
--                   �� SSN(�ֹε�Ϲ�ȣ) �� '771212-1022432' �� 'YYMMDD-NNNNNNN'

CREATE OR REPLACE FUNCTION FN_GENDER( V_SSN VARCHAR2 )  -- �Ű�����   : �ڸ���(����) ��������
RETURN VARCHAR2                                         -- ��ȯ�ڷ��� : �ڸ���(����) ��������                
IS
    -- �����   �� �ֿ� ���� ����
    V_RESULT    VARCHAR2(20);
BEGIN
    -- �����  �� ���� �� ó��
    IF ( SUBSTR(V_SSN, 8, 1) IN ('1', '3')  )
        THEN V_RESULT := '����';
    ELSIF (  SUBSTR(V_SSN, 8, 1) IN ('2', '4') )    
        THEN V_RESULT := '����';
    ELSE
        V_RESULT := '����Ȯ�κҰ�';
    END IF;
    
    -- ����� ��ȯ   CHECK~!!
    RETURN V_RESULT;
END;
--==>> Function FN_GENDER��(��) �����ϵǾ����ϴ�.

-- �� ������ ���� �� ���� �Ű����� (�Է��Ķ����)�� �Ѱܹ޾� �� (A, B)
--    A �� B ���� ���� ��ȯ�ϴ� ����� ���� �Լ��� �ۼ��Ѵ�.
--    ��, ������ ����Ŭ ���� �Լ��� �̿����� �ʰ�, �ݺ����� Ȱ��
--    �Լ��� : FN_POW()
/*
��� ��)
SELECT FN_POW(10, 3)
FROM DUAL;
--==>> 1000
*/



CREATE OR REPLACE FUNCTION FN_POW(N1 NUMBER, N2 NUMBER)
RETURN NUMBER
IS
    N_RESULT    NUMBER :=1;
    K   NUMBER;
BEGIN
    IF N2 >= 0
        THEN FOR K IN 1.. N2 LOOP
                N_RESULT := N_RESULT * N1;
             END LOOP;
    ELSIF N2 < 0
            THEN FOR K IN -1.. N2 LOOP
                N_RESULT := N1 * 0.1;
             END LOOP;
    ELSE  
        N_RESULT := 0;
    END IF;        
    
    -- ���� ����� ��ȯ
    RETURN N_RESULT;
END;
--==>> Function FN_POW��(��) �����ϵǾ����ϴ�.
--> ���� �������޴�

-- �� TBL_INSA ���̺��� �޿� ��� ���� �Լ��� �����Ѵ�.
--    �޿��� ��(�⺻��*12)+���硻 ������ ������� �����Ѵ�.
--    �Լ��� : FN_PAY(�⺻��, ����)
CREATE OR REPLACE FUNCTION FN_PAY(BP NUMBER, SD NUMBER)
RETURN NUMBER
IS
    N_RESULT NUMBER :=1;
BEGIN
    N_RESULT := (NVL(BP, 0)*12) + NVL(SD, 0);
    RETURN N_RESULT;
END;
--==>> Function FN_PAY��(��) �����ϵǾ����ϴ�.

-- �� TBL_INSA ���̺��� �Ի����� �������� ���������
--    �ٹ������ ��ȯ�ϴ� �Լ��� �����Ѵ�.
--    ��, �ٹ������ �Ҽ��� ���� ���ڸ����� ����Ѵ�.
--    �Լ��� : FN_WORKYEAR(�Ի���)

CREATE OR REPLACE FUNCTION FN_WORKYEAR(WY DATE)
RETURN NUMBER
IS
    N_RESULT NUMBER;
BEGIN
    N_RESULT := TRUNC((MONTHS_BETWEEN(SYSDATE, WY) / 12), 1);
    RETURN N_RESULT;
END;
--==>> Function FN_WORKYEAR��(��) �����ϵǾ����ϴ�.
--------------------------------------------------------------------------------
-- �� ����
-- 1. INSERT, UPDATE, DELETE, (MERGE)
--==>> DML(Data Maniputation Language)
-- COMMIT / ROLLBACK �� �ʿ��ϴ�.

-- 2. CREATE, DROP, ALTER, (TRUNCATE)
--==>> DDL(Data Definition Language)
-- �����ϸ� �ڵ����� COMMIT �ȴ�.

-- 3. GRANT, REVOKE
--==>> DCL(Data Control Language)
-- �����ϸ� �ڵ����� COMMIT �ȴ�.

-- 4. COMMIT, ROLLBACK
--==>> TCL(Transaction Control Language)

-- ���� pl/sql �� �� DML ��, TCL ���� ��� �����ϴ�.
-- ���� pl/sql �� �� DML ��, DDL ��, DCL ��, TCL �� ��� �����ϴ�.

--------------------------------------------------------------------------------

-- ���� PROCEDURE(���ν���) ���� --

-- 1. PL/SQL ���� ���� ��ǥ���� ������ ������ ���ν�����
--    �����ڰ� ���� �ۼ��ؾ� �ϴ� ������ �帧��
--    �̸� �ۼ��Ͽ� �����ͺ��̽� ���� ������ �ξ��ٰ�
--    �ʿ��� �� ���� ȣ���Ͽ� ������ �� �ֵ���  ó���� �ִ� �����̴�.

-- 2. ���� �� ����
/*
CREATE [OR REPLACE] PROCEDURE ���ν�����
[( �Ű����� IN ������Ÿ��
 , �Ű����� OUT ������Ÿ��
 , �Ű����� INOUT ������Ÿ��
)]
IS
    [-- �ֿ� ���� ����]
BEGIN
    -- ���� ����;
    ...
    
    [EXCEPTION
        -- ���� ó�� ����;]
END;
*/

-- �� FUNCTION �� ������ �� ��RETURN ��ȯ�ڷ����� �κ��� �������� ������,
--    ��RETURN���� ��ü�� �������� ������,
--    ���ν��� ���� �� �Ѱ��ְ� �Ǵ� �Ű������� ������
--    IN(�Է�), OUT(���), INOUT(�����) ���� ���еȴ�.
--    
-- 3. ���� (ȣ��)
/*
EXCE[UTE] ���ν�����[(�μ�1, �μ�2, ...)];
*/

-- �� ���ν��� �ǽ��� ���� ���̺� ������
--    ��20220310_02_scott.sql�� ���� ����~!!!

-- �� FUNCTION �� �Է¸Ű������ۿ�����
-- �� PROCEDURE �� �� / ��� �Ű����� ��������
--    ���� IN / OUT ���
CREATE OR REPLACE PROCEDURE PRC_STUDENT_INSERT
( V_ID      IN TBL_IDPW.ID%TYPE
, V_PW      IN TBL_IDPW.PW%TYPE
, V_NAME    IN TBL_STUDENTS.NAME%TYPE
, V_TEL     IN TBL_STUDENTS.TEL%TYPE
, V_ADDR    IN TBL_STUDENTS.ADDR%TYPE
)
IS
BEGIN
    -- TBL_IDPW ���̺� ������ �Է�(INSERT)
    INSERT INTO TBL_IDPW(ID, PW)
    VALUES(V_ID, V_PW);    
    -- TBL_STUDENTS ���̺� ������ �Է�(INSERT)
    INSERT INTO TBL_STUDENTS(ID, NAME, TEL, ADDR)
    VALUES(V_ID, V_NAME, V_TEL, V_ADDR);    
    -- Ŀ��
    COMMIT;
END;

-- �� ���ν��� �ǽ��� ���� ���̺� ������
--    ��20220310_02_scott.sql�� ���� ����!!

-- �� ������ �Է½� Ư�� �׸��� �����͸� �Է��ϸ�
--                  ---------
--                  (�й�, �̸�, ��������, ��������, ��������)
--    ���������� �ٸ� �߰��׸� ���� ó���� �Բ� �̷���� �� �ֵ��� �ϴ�
--                     ------
--                   (����, ���, ���)
--    ���ν����� �ۼ��Ѵ�.(�����Ѵ�.)
--    ���ν��� �� : PRC_SUNGJUK_INSERT()
/*
���� ��)
EXEC PRC_SUNGJUK_INSERT(1, '�ּ���', 90, 80, 70);

���ν��� ȣ��� ó���� ���
�й�  �̸�  ��������    ��������    ��������    ����  ���  ���
  1  �ּ���   90         80          70         240    80    B
*/
CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_INSERT
( V_HAK     IN TBL_SUNGJUK.HAKBUN%TYPE
, V_NAME    IN TBL_SUNGJUK.NAME%TYPE
, V_KOR     IN TBL_SUNGJUK.KOR%TYPE
, V_ENG     IN TBL_SUNGJUK.ENG%TYPE
, V_MAT     IN TBL_SUNGJUK.MAT%TYPE
)
IS
    V_TOT   TBL_SUNGJUK.TOT%TYPE;
    V_AVG   TBL_SUNGJUK.AVG%TYPE;
    V_GRADE   TBL_SUNGJUK.GRADE%TYPE;
BEGIN
    V_TOT := V_KOR + V_ENG + V_MAT;
    V_AVG := V_TOT / 3;
    
    IF V_AVG >= 90
        THEN V_GRADE := 'A';
    ELSIF V_AVG >= 80
        THEN V_GRADE := 'B';
    ELSIF V_AVG >= 70
        THEN V_GRADE := 'C';
    ELSIF V_AVG >= 60
        THEN V_GRADE := 'D';
    ELSE
        V_GRADE := 'F';
    END IF;
    
    
    INSERT INTO TBL_SUNGJUK(HAKBUN, NAME, KOR, ENG, MAT, TOT, AVG, GRADE)
    VALUES (V_HAK, V_NAME, V_KOR, V_ENG, V_MAT, V_TOT, V_AVG, V_GRADE);
    
    COMMIT;
END;
--==>> Procedure PRC_SUNGJUK_INSERT��(��) �����ϵǾ����ϴ�.


-- �� TBL_SUNGJUK ���̺��� Ư�� �л��� ����
--    (�й�, ��������, ��������, ��������) ������ ���� ��
--    ����, ���, ��ޱ��� �Բ� �����Ǵ� ���ν����� �����Ѵ�.
--    ���ν��� �� : PRC_SUNGJUK_UPDATE()
/*
���� ��
EXEC PRC_SUNGJUK_UPDATE(2, 50, 50, 50);
  1  �ּ���   90         80          70         240    80    B
  2  ������   50         50          50         150    50    F
*/

CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_UPDATE
( U_HAK IN TBL_SUNGJUK.HAKBUN%TYPE
, U_KOR IN TBL_SUNGJUK.KOR%TYPE
, U_ENG IN TBL_SUNGJUK.ENG%TYPE
, U_MAT IN TBL_SUNGJUK.MAT%TYPE
)
IS
  U_TOT     TBL_SUNGJUK.TOT%TYPE;
  U_AVG     TBL_SUNGJUK.AVG%TYPE;
  U_GRADE   TBL_SUNGJUK.GRADE%TYPE;
BEGIN
    U_TOT := U_KOR + U_ENG + U_MAT;
    U_AVG := U_TOT /3;
    
    IF U_AVG >= 90
        THEN U_GRADE := 'A';
    ELSIF U_AVG>= 80
        THEN U_GRADE := 'B';
    ELSIF U_AVG>= 70
        THEN U_GRADE := 'C';
    ELSIF U_AVG>= 60
        THEN U_GRADE := 'D';
    ELSE
         U_GRADE := 'F';
    END IF;
    
    -- UPDATE ������
    UPDATE  TBL_SUNGJUK
    SET KOR = U_KOR, ENG = U_ENG, MAT = U_MAT
            , TOT = U_TOT, AVG = U_AVG, GRADE = U_GRADE
    WHERE HAKBUN = U_HAK;
    
    -- Ŀ��
    COMMIT;
END;
--==>> Procedure PRC_SUNGJUK_UPDATE��(��) �����ϵǾ����ϴ�.

-- �� TBL_STUDENTS ���̺��� ��ȭ��ȣ�� �ּ� �����͸� �����ϴ�(�����ϴ�)
--    ���ν����� �ۼ��Ѵ�.
--    ��, ID �� PW �� ��ġ�ϴ� ��쿡�� ������ ������ �� �ֵ��� ó���Ѵ�.

-- ���1. -- FLAG �� ���� ���ǿ� �°� ���̺� ������Ʈ
CREATE OR REPLACE PROCEDURE PRC_STUDENTS_UPDATE
( U_ID IN TBL_IDPW.ID%TYPE 
, U_PW IN TBL_IDPW.PW%TYPE 
, U_TEL IN TBL_STUDENTS.TEL%TYPE
, U_ADDR IN TBL_STUDENTS.ADDR%TYPE
)
IS 
    V_PW    TBL_IDPW.PW%TYPE;
    V_FLAG  NUMBER := 0;
BEGIN

    SELECT PW   INTO V_PW
    FROM TBL_IDPW
    WHERE ID = U_ID;
    
    IF U_PW = V_PW
        THEN V_FLAG :=1;
    ELSE
        V_FLAG :=2;
    END IF;        
    
    UPDATE TBL_STUDENTS
    SET TEL = U_TEL, ADDR = U_ADDR
    WHERE ID = U_ID AND V_FLAG = 1;
    
    -- COMMIT 
    COMMIT;
END;  
--==>> Procedure PRC_STUDENTS_UPDATE��(��) �����ϵǾ����ϴ�.

-- ���2. ���������Ե� ���̺� 2���� �����Ͽ� ������Ʈ.
CREATE OR REPLACE PROCEDURE PRC_STUDENTS_UPDATE
( U_ID IN TBL_IDPW.ID%TYPE 
, U_PW IN TBL_IDPW.PW%TYPE 
, U_TEL IN TBL_STUDENTS.TEL%TYPE
, U_ADDR IN TBL_STUDENTS.ADDR%TYPE
)
IS 
BEGIN
    UPDATE  (SELECT T1.ID, T1.PW, T2.TEL, T2.ADDR
             FROM TBL_IDPW T1 JOIN TBL_STUDENTS T2
             ON T1.ID = T2.ID)T
    SET T.TEL = U_TEL, T.ADDR = U_ADDR
    WHERE T.ID = U_ID
            AND T.PW = U_PW;
    --Ŀ��
    COMMIT;
END;  
--==>> Procedure PRC_STUDENTS_UPDATE��(��) �����ϵǾ����ϴ�.
