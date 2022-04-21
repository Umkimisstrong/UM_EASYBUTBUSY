SELECT USER
FROM DUAL;
--==>> SCOTT

-- �� TBL_�԰� ���̺��� ������ �Է�, ����, ���� ��
--    TBL_��ǰ ���̺��� ������ ���� Ʈ���� �ۼ�
--    Ʈ���� �� : TRG_IBGO

CREATE OR REPLACE TRIGGER TRG_IBGO
    AFTER
    INSERT OR UPDATE OR DELETE ON TBL_�԰�
    FOR EACH ROW
BEGIN
    IF (INSERTING)
        THEN UPDATE TBL_��ǰ
             SET ������ = ������ + :NEW.�԰����
             WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
    ELSIF (UPDATING)
        THEN UPDATE TBL_��ǰ
             SET ������ = ������ - :OLD.�԰���� + :NEW.�԰����
             WHERE ��ǰ�ڵ� = :OLD.��ǰ�ڵ�;             
    ELSIF (DELETING)             
        THEN UPDATE TBL_��ǰ
             SET ������ = ������ - :OLD.�԰����
             WHERE ��ǰ�ڵ� = :OLD.��ǰ�ڵ�;                 
    END IF;
END;
--==>> Trigger TRG_IBGO��(��) �����ϵǾ����ϴ�.

-- �� TBL_��� ���̺��� ������ �Է�, ����, ���� ��
--    TBL_��ǰ ���̺��� ������ ���� Ʈ���� �ۼ�
--    Ʈ���� �� : TRG_CHULGO

-- ������̺� �����Ͱ� �ԷµǸ�,
-- �ԷµǴ� ������ŭ(NEW) ��ǰ���̺��� ������ ����

-- ������̺� �����Ͱ� �����Ǹ�
-- ���� ���������� ���� �����ߴ� ��ŭ(OLD) �����ְ�, 
-- ���ο� �Է°� ��ŭ(NEW) ����

-- ������̺� �����Ͱ� �����Ǹ�
-- ���� ���������� ���� �����ߴ� ��ŭ(OLD) �����ش�.
CREATE OR REPLACE TRIGGER TRG_IBGO
        AFTER
        INSERT OR UPDATE OR DELETE ON TBL_���
        FOR EACH ROW
DECLARE
BEGIN
    -- ���ǹ� ����
    -- ( ������ �Է� )
    IF ( INSERTING )
        THEN UPDATE TBL_��ǰ
             SET ������ = ������ - :NEW.������
             WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
    -- ( ������ ���� )  
    ELSIF (UPDATING)   
        THEN UPDATE TBL_��ǰ
             SET ������ = ������ + :OLD.������ - :NEW.������
             WHERE ��ǰ�ڵ� = :OLD.��ǰ�ڵ�;
    -- ( ������ ���� )    
    ELSIF ( DELETING )
        THEN UPDATE TBL_��ǰ
             SET ������ = ������ + :OLD.������
             WHERE ��ǰ�ڵ� = :OLD.��ǰ�ڵ�;
    END IF;
    -- ���ǹ� ����
END;

--------------------------------------------------------------------------------

-- ���� PACKAGE(��Ű��) ���� --

-- 1. PL/SQL�� ��Ű���� ����Ǵ� Ÿ��, ���α׷� ��ü,
--    �������α׷�(PROCEDURE, FUNCTION ��)��
--    �������� ������� ������ ����Ŭ���� �����ϴ�
--    ��Ű�� �� �ϳ��� �ٷ� ��DBMS_OUTPUT�� �̴�.

-- 2. ��Ű���� ���� ������ ������ ���Ǵ� �������� ���ν�����
--    �Լ��� �ϳ��� ��Ű���� ����� ���������ν� ���� ���������� ��
--    �ϰ� ��ü ���α׷��� ���ȭ �� �� �ִٴ� ������ �ִ�.

-- 3. ��Ű���� ����(PACKAGE SPECIFICATION)��
--    ��ü��(PACKAGE BODY)�� �����Ǿ� ������
--    �� �κп��� TYPE, CONSTRAINT, VARIBLE, EXCEPTION, CURSOR,
--    SUBPROGRAM �� ����ǰ�
--    ��ü �κп��� �̵��� ���� ������ �����Ѵ�.
--    �׸���, ȣ���� ������ ����Ű����.���ν����������� ������ �̿��ؾ� �Ѵ�.

-- 4. ���� �� ����(����)
/*
CREATE [OR REPLACE] PACKAGE ��Ű����
IS
    ������������;
    Ŀ������;
    ���ܼ���;
    �Լ�����;
    ���ν�������;
        :
END ��Ű����;
*/

-- 5. ���� �� ����(��ü��)
/*
CREATE [OR REPLACE] PACKAGE BODY ��Ű����
IS
    FUNCTION �Լ���[�μ� ,...]
    RETURN �ڷ���
    IS 
        ��������;
    BEGIN
        �Լ� ��ü ���� �ڵ�;
        RETURN ��;
    END;
    
    PROCEDURE ���ν�����[�μ�, ...]
    IS
        ���� ����;
    BEGIN
        ���ν��� ��ü ���� �ڵ�;
    END;
*/

-- ��Ű�� ��� �ǽ�
-- �� ���� �ۼ�
CREATE OR REPLACE PACKAGE INSA_PACK
IS
    FUNCTION FN_GENDER(V_SSN VARCHAR2)
    RETURN VARCHAR2;
END INSA_PACK;
--==>> Package INSA_PACK��(��) �����ϵǾ����ϴ�.

-- �� ��ü�� �ۼ�(����Ȯ�ο���)
CREATE OR REPLACE PACKAGE BODY INSA_PACK
IS
    FUNCTION FN_GENDER(V_SSN VARCHAR2)
    RETURN VARCHAR2
    IS
        V_RESULT VARCHAR2(20);
    BEGIN
        IF( SUBSTR(V_SSN, 8, 1) IN ('1', '3')    )
            THEN V_RESULT := '����';
        ELSIF(  SUBSTR(V_SSN, 8, 1) IN ('2', '4')  )    
            THEN V_RESULT := '����';
        ELSE
            V_RESULT := 'Ȯ�κҰ�';
        END IF;
        
        RETURN V_RESULT;
    END;
    
END INSA_PACK;









