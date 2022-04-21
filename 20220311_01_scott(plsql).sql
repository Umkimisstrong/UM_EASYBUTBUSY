SELECT USER
FROM DUAL;
--==>> SCOTT

DESC TBL_INSA;

-- �� TBL_INSA ���̺��� ������� �ű� ������ �Է� ���ν����� �ۼ��Ѵ�.
--    NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG
--    ���� ������ �÷� �� NUM�� ������
--     NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG
--     ������ �Է� ��
--     NUM �÷�(�����ȣ)�� ����
--     ���� �ο��� ��� ��ȣ�� ������ ��ȣ �� ���� ��ȣ�� �ڵ����� �Է� ó���� �� �ִ�
--     ���ν����� �����Ѵ�.
--     ���ν��� �� : PRC_INSA_INSERT()
/*
���� ��)
EXEC PRC_INSA_INSERT('������', '970131-2234567', SYSDATE, '����', '010-8624-4533', '���ߺ�', '�븮', 2000000, 2000000);

���ν��� ȣ��� ó���� ���
1061 ������ 970131-2234567 SYSDATE ���� 010-8624-4533 ���ߺ� �븮 2000000 2000000
�� �Էµ� ��

*/
SELECT *
FROM TBL_INSA;

CREATE OR REPLACE PROCEDURE PRC_INSA_INSERT
( I_NAME        IN TBL_INSA.NAME%TYPE
, I_SSN         IN TBL_INSA.SSN%TYPE
, I_IBSADATE    IN TBL_INSA.IBSADATE%TYPE
, I_CITY        IN TBL_INSA.CITY%TYPE
, I_TEL         IN TBL_INSA.TEL%TYPE
, I_BUSEO       IN TBL_INSA.BUSEO%TYPE
, I_JIKWI       IN TBL_INSA.JIKWI%TYPE
, I_BASICPAY    IN TBL_INSA.BASICPAY%TYPE
, I_SUDANG      IN TBL_INSA.SUDANG%TYPE
)
IS
    I_NUM     TBL_INSA.NUM%TYPE;
BEGIN
    SELECT MAX(NVL(NUM, 0)) + 1 INTO I_NUM
    FROM TBL_INSA;

    INSERT INTO TBL_INSA(NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
    VALUES (I_NUM, I_NAME, I_SSN, I_IBSADATE, I_CITY, I_TEL, I_BUSEO, I_JIKWI, I_BASICPAY, I_SUDANG);
        
    COMMIT;
END;
--==>> Procedure PRC_INSA_INSERT��(��) �����ϵǾ����ϴ�.

-- �� TBL_��ǰ, TBL_�԰� ���̺��� �������
--    TBL_�԰� ���̺� ������ �Է� ��(��, �԰� �̺�Ʈ �߻� ��)
--    TBL_��ǰ ���̺��� �������� �Բ� ������ �� �ִ� ����� ����
--    ���ν����� �ۼ��Ѵ�.
--    ��, �� �������� �԰��ȣ�� �ڵ� ���� ó���Ѵ�. (������ ��� ��)
--    TBL_�԰� ���̺� ���� �÷�
--    : �԰��ȣ, ��ǰ�ڵ�, �԰�����, �԰����, �԰�ܰ�
--    ���ν��� �� : PRC_�԰�_INSERT(��ǰ�ڵ�, �԰����, �԰�ܰ�)
--    

-- 'H001', 30, 400
--  �� �԰����̺��� ������ �Է�(���ν��� �Ű������� ���޹��� ���� ������ �� �� �ڵ� �Է�)
--  �� ��ǰ���̺��� �ٹ�� ������ 30��
CREATE OR REPLACE PROCEDURE  PRC_�԰�_INSERT
( V_��ǰ�ڵ�    IN  TBL_�԰�.��ǰ�ڵ�%TYPE
, V_�԰����    IN  TBL_�԰�.�԰����%TYPE
, V_�԰�ܰ�    IN  TBL_�԰�.�԰�ܰ�%TYPE
)
IS
    V_�԰��ȣ  TBL_�԰�.�԰��ȣ%TYPE;
    
BEGIN
    SELECT NVL(MAX(�԰��ȣ), 0) +1 INTO V_�԰��ȣ
    FROM TBL_�԰�;
    
    INSERT INTO TBL_�԰� (�԰��ȣ, ��ǰ�ڵ�, �԰����, �԰�ܰ�)
    VALUES(V_�԰��ȣ, V_��ǰ�ڵ�, V_�԰����, V_�԰�ܰ�);
    
    UPDATE TBL_��ǰ
    SET ������ = ������ + V_�԰����
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    -- ���� ó��(Ʈ����� �⺻..)
    EXCEPTION
        WHEN OTHERS THEN ROLLBACK;

    -- Ŀ��        
    COMMIT;
END;
--==>> Procedure PRC_�԰�_INSERT��(��) �����ϵǾ����ϴ�.

-- ���� PROCEDURE �������� ����ó�� ���� -- 
-- �� TBL_MEMBER ���̺� �����͸� �Է��ϴ� ���ν����� �ۼ�
--    ��, �� ���ν����� ���� �����͸� �Է��� ���
--    CITY(����) �׸� '����', '���', '����' �� �Է��� �����ϵ��� �����Ѵ�.
--    �� ���� ���� �ٸ� ������ ���ν��� ȣ���� ���� �Է��ϰ��� �ϴ� ���
--    (��, �Է��� �õ��ϴ� ���)
--    ���ܿ� ���� ó���� �Ϸ��� �Ѵ�.
--    ���ν��� �� : PRC_MEMBER_INSERT()
/*
EXEC PRC_MEMBER_INSERT('�Ӽҹ�', '010-1111-1111', '����');
--==>> ������ �Է� ��
EXEC PRC_MEMBER_INSERT('�̿���', '010-2222-2222', '�λ�');
--==>> ������ �Է� ��
*/

CREATE OR REPLACE PROCEDURE PRC_MEMBER_INSERT
( V_NAME    IN  TBL_MEMBER.NAME%TYPE
, V_TEL     IN  TBL_MEMBER.TEL%TYPE
, V_CITY    IN  TBL_MEMBER.CITY%TYPE
)
IS
    -- �����(�ֿ� ���� ����) "���ܵ� ������"
    -- ���� ������ ������ ������ ���� �ʿ��� ���� ����
    V_NUM   TBL_MEMBER.NUM%TYPE;
    
    -- ����� ���� ���ܿ� ���� ���� ���� CHECK~!~!
    -- EXCEPTION Ÿ���� USER_DEFINE_ERROR ����
    USER_DEFINE_ERROR   EXCEPTION;
    
BEGIN
    -- ���ν����� ���� �Է� ó���� ���������� �����ؾ� �� ���������� �ƴ����� ���θ�
    -- ���� ���� Ȯ���� �� �ֵ��� �ڵ� ����
    IF  ( V_CITY NOT IN ('����', '���', '����') )  
        -- ����, ���, ���� �� ���ٸ� ���� �߻� CHECK~!!
        -- ���� �߻���Ű�°� �� ���ܸ� ����Ű�°�(RAISE)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    SELECT NVL(MAX(NUM), 0) + 1 INTO V_NUM
    FROM TBL_MEMBER;
    
    -- ������ ���� �� INSERT
    INSERT INTO TBL_MEMBER(NUM, NAME, TEL, CITY)
    VALUES(V_NUM, V_NAME, V_TEL, V_CITY);
    
    -- ���� ó�� ����
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20001, '����,���,������ �Է��� �����մϴ�.');
                ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;

    -- Ŀ��
    COMMIT;
END;
--==>> Procedure PRC_MEMBER_INSERT��(��) �����ϵǾ����ϴ�.

-- �� TBL_��� ���̺� ������ �Է� ��(��, ��� �̺�Ʈ �߻� ��)
--    TBL_��ǰ ���̺��� �������� �����Ǵ� ���ν����� �ۼ��Ѵ�.
--    ��, ����ȣ�� �԰��ȣ�� ���������� �ڵ�����
--    ����, �������� ���������� ���� ���
--    ��� �׼��� ����� �� �ֵ��� ó���Ѵ�.(��� �̷�������ʵ���.. ����)

/*
���� ��)
EXEC PRC_���_INSERT('H001', 10, 600);

-- ���� ��ǰ ���̺��� �ٹ�� ������ 50��
EXEC PRC_���_INSERT('H001', 60, 600);
--==>> ���� �߻�
--     ��� ����
*/


CREATE OR REPLACE PROCEDURE PRC_���_INSERT
( V_��ǰ�ڵ�    IN  TBL_���.��ǰ�ڵ�%TYPE 
, V_������    IN  TBL_���.������%TYPE 
, V_���ܰ�    IN  TBL_���.���ܰ�%TYPE 
)
IS
    V_����ȣ   TBL_���.����ȣ%TYPE;
    V_������   TBL_��ǰ.������%TYPE;
    USER_INSERT_ERROR   EXCEPTION;
BEGIN
    -- ������ ���
    -- ������ ���� ������ ���� ���θ� Ȯ���ϴ� ��������
    -- ������ �ľ� �� ���� ��� Ȯ���ϴ� ������ ����Ǿ�� �Ѵ�.
    -- �׷��� ���ν��� ȣ�� �� �Ѱܹ޴� �������� �� �����ϱ� �����̴�.
    SELECT ������ INTO V_������
    FROM TBL_��ǰ
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    -- ���ǹ�
    -- ��� ���������� ������ �� �������� ���� ���� Ȯ��
    -- ������ �ľ��� ���������� ���� ���ν������� �Ѱܹ��� �������� ������
    -- ���ܹ߻� !!
    IF  (V_������ > V_������)
        THEN  RAISE USER_INSERT_ERROR;
    END IF;
    
    ------------------- ������ ���� INSERT (TBL_���) ------------
    -- ����ȣ ���
    SELECT NVL(MAX(����ȣ), 0) + 1 INTO V_����ȣ
    FROM TBL_���;
    
    -- ������ �Է�
    INSERT INTO TBL_��� (����ȣ, ��ǰ�ڵ�, ������, ���ܰ�)
    VALUES(V_����ȣ, V_��ǰ�ڵ�, V_������, V_���ܰ�);
    
    ------------------- ������ ���� UPDATE (TBL_��ǰ) ------------
    -- �����
    UPDATE  TBL_��ǰ
    SET ������ = ������ - V_������
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    -- ����ó��
    EXCEPTION
        WHEN USER_INSERT_ERROR
            THEN RAISE_APPLICATION_ERROR(-20002, '������');
                ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
          
    -- Ŀ��  
    COMMIT;
END;

-- �� TBL_��� ���̺��� �������� ����(����)�ϴ� ���ν����� �ۼ��Ѵ�.
--    ���ν��� �� PRC_���_UPDATE()
/*
���� ��)
EXEC PRC_���_UPDATE(����ȣ, �����Ҽ���);
*/
--> ���� ��� ������ 3���� ���
--> TBL_��� ���̺��� ��� ������ 3���� �ԷµǴ� ������ �Էµ��հ�
--> TBL_��ǰ ���̺��� 3��ŭ ������ ���������̴�.

--> ��� ������ 5�� �����Ѵٴ� �ǹ̴� :
--  TBL_��� ���̺� �Էµ� 3�̶�� ������ 5�� �ٲٰ�
--  TBL_��ǰ ���̺��� (5-3) ��ŭ �� ����� �Ѵٴ� ���̴�.


CREATE OR REPLACE PROCEDURE PRC_���_UPDATE
( V_����ȣ    IN TBL_���.����ȣ%TYPE
, V_�����Ҽ���  IN TBL_���.������%TYPE 
)
IS
    USER_INSERT_ERROR   EXCEPTION;
    V_����������    TBL_���.������%TYPE;
    V_��ǰ�ڵ�        TBL_��ǰ.��ǰ�ڵ�%TYPE;
    V_������        TBL_��ǰ.������%TYPE;
BEGIN
    -- �ش� ��ǰ�ڵ� ����
    SELECT ��ǰ�ڵ� INTO V_��ǰ�ڵ�
    FROM TBL_���
    WHERE ����ȣ = V_����ȣ;
    
    -- ������ ����
    SELECT ������ INTO V_������
    FROM TBL_��ǰ
    WHERE ��ǰ�ڵ� = V_��ǰ�ڵ�;
    
    -- ���ǹ�(��� ����� ������� �����߻�)
    IF (V_������ < V_�����Ҽ���)
        THEN RAISE USER_INSERT_ERROR;
    END IF;
    
    
    -- ���������� ����
    SELECT ������ INTO V_����������
    FROM  TBL_���
    WHERE ����ȣ = V_����ȣ;
    
   
    -- ������̺� ������Ʈ
    UPDATE TBL_���
    SET ������ = V_�����Ҽ���
    WHERE ����ȣ = V_����ȣ;
    
    -- ��ǰ���̺� ������Ʈ
    UPDATE TBL_��ǰ
    SET ������ = (������) - (V_�����Ҽ��� - V_����������)
    WHERE ��ǰ�ڵ� = (SELECT ��ǰ�ڵ�
                      FROM TBL_���
                      WHERE ����ȣ = V_����ȣ);
    
    -- ����ó��
    EXCEPTION
        WHEN USER_INSERT_ERROR
            THEN RAISE_APPLICATION_ERROR(-20003, '�����Ҽ����� ���������� �����ϴ�.');
                ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
            
    COMMIT;
    
END;
--==>> Procedure PRC_���_UPDATE��(��) �����ϵǾ����ϴ�.

