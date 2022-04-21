SELECT USER
FROM DUAL;
--==>> SCOTT
SET SERVEROUTPUT ON;

-- �� TBL_INSA ���̺��� �������� ������ ���� ���� ������ �����Ͽ� ���
--    (�ݺ��� Ȱ��)

DECLARE
    V_INSA  TBL_INSA%ROWTYPE;
    V_NUM TBL_INSA.NUM%TYPE := 1001;
BEGIN
    LOOP
        SELECT NAME, TEL, BUSEO
            INTO V_INSA.NAME, V_INSA.TEL, V_INSA.BUSEO
        FROM TBL_INSA
        WHERE NUM = V_NUM;
        
        DBMS_OUTPUT.PUT_LINE(V_INSA.NAME || '-' || V_INSA.TEL || '-' || V_INSA.BUSEO);
        
        V_NUM := V_NUM + 1;
        EXIT WHEN V_NUM > 1060;
    END LOOP;
END;


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
--> �̰� �ݸ� ����ž�.. �����ΰ�쵵 �����ؾ���
--> ���� �������޴�

