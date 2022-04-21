SELECT USER
FROM DUAL;
--==>> SCOTT

-- ���� PL/SQL ���� --
-- 1. PL/SQL (Procedural Language extension to SQL) ��
--    ���α׷��� ����� Ư���� ������ SQL�� Ȯ���̸�
--    ������ ���۰� ���� ������ PL/SQL ������ �ڵ� �ȿ� ���Եȴ�.
--    ����. PL/SQL �� ����ϸ� SQL�� �� �� ���� ������ �۾��� �����ϴ�.
--    ���⿡�� ���������� �̶�� �ܾ ������ �ǹ̴�
--    � ���� � ������ ���ļ� ��� �Ϸ�Ǵ���
--    �� ����� ��Ȯ�ϰ� �ڵ忡 ����Ѵٴ� ���� �ǹ��Ѵ�.

-- 2. PL/SQL�� ���������� ǥ���ϱ� ����
--    ������ ������ �� �ִ� ���,
--    ���� ������ ������ �� �ִ� ���,
--    ���� �帧�� ��Ʈ�� �� �� �ִ� ��� ���� �����Ѵ�.

-- 3. PL/SQL�� �� ������ �Ǿ� ������
--    ���� ���� �κ�, ���� �κ�, ���� ó�� �κ���
--    �� �κ����� �����Ǿ� �ִ�.
--    ����, �ݵ�� ���� �κ��� �����ؾ� �ϸ�, ������ ������ ����.

-- 4. ���� �� ����
/*
[DECLARE]
    -- ����(DECLARATIONS)
BEGIN
    -- ���๮(STATEMENTS)
    
    [EXCEPTION]
        -- ����ó����(EXCEPTION HANDLERS)
END;        
*/

-- 5. ���� ����
/*
DECLARE
    ������ �ڷ���;
    ������ �ڷ��� := �ʱⰪ;
BEGIN
END;
*/

-- �� ���� ��� ����~!!

-- �ء�DMBS_OUTPUT.PUT_LINE()���� ����
--    ȭ�鿡 ����� ����ϱ� ���� ȯ�溯�� ����
SET SERVEROUTPUT ON;
--==>> �۾��� �Ϸ�Ǿ����ϴ�(~��)

-- �� ������ ������ ���� �����ϰ� ����ϴ� ���� �ۼ�
-- := �� ���Կ�����(�������� �������� ����)
DECLARE
    -- �����
    V1  NUMBER := 10;
    V2  VARCHAR2(30) := 'HELLO';
    V3  VARCHAR2(30) := 'Oracle';
    
BEGIN
    -- �����
    DBMS_OUTPUT.PUT_LINE(V1);
    DBMS_OUTPUT.PUT_LINE(V2);
    DBMS_OUTPUT.PUT_LINE(V3);
END;
/*
10
HELLO
Oracle
*/

-- ��  ������ ������ ���� �����ϰ� ����ϴ� ���� �ۼ�
DECLARE
   -- �����
    V1 NUMBER := 10;
    V2 VARCHAR2(30) := 'HELLO';
    V3 VARCHAR2(30) := 'ORACLE';
BEGIN
    -- �����
    -- ���� �� ó��
    V1 := V1 + 20;
    V2 := V2 || ' �Ž���';
    V3 := V3 || ' World~!!!';
    
    -- (��� ���)
    DBMS_OUTPUT.PUT_LINE(V1);
    DBMS_OUTPUT.PUT_LINE(V2);
    DBMS_OUTPUT.PUT_LINE(V3);
END;
/*
30
HELLO �Ž���
ORACLE World~!!!


PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/
-- �� PL/SQL ���ǹ����� �̾ ����

