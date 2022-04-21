SELECT USER
FROM DUAL;
--==>> HR

-- �� %TYPE

-- 1. Ư�� ���̺� ���ԵǾ� �ִ� �÷��� ������Ÿ��(�ڷ���) �������ϴ�
--    ������Ÿ��

-- 2. ���� �� ����
--    ������ ���̺��.�÷���%TYPE [:= �ʱⰪ];

-- HR.EMPLOYEES ���̺��� Ư�� �����͸� ������ ����
SET SERVEROUTPUT ON;

DECLARE
    --V_NAME VARCHAR2(20);
    V_NAME EMPLOYEES.FIRST_NAME%TYPE;
BEGIN
    SELECT FIRST_NAME INTO V_NAME
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = 103;
    DBMS_OUTPUT.PUT_LINE(V_NAME);
END;
/*
Alexander
PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/

-- �� EMPLOYEES ���̺��� ������� 108�� ���(Nancy)��
--    SALARY �� ������ ��� ����ϴ� PL/SQL ������ �ۼ��Ѵ�.
DECLARE
    V_SAL EMPLOYEES.SALARY%TYPE;
BEGIN
    
    SELECT SALARY INTO V_SAL
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = 108;
    DBMS_OUTPUT.PUT_LINE(V_SAL);
END;
--==>> 12008

-- �� EMPLOYEES ���̺��� Ư�� ���ڵ� �׸� �������� ������ ����
--    103�� ����� FIRST_NAME, PHONE_NUMBER, EMAIL �׸��� ������ �����Ͽ� ���

DECLARE
    V_NAME  EMPLOYEES.FIRST_NAME%TYPE;
    V_PHONE EMPLOYEES.PHONE_NUMBER%TYPE;
    V_MAIL  EMPLOYEES.EMAIL%TYPE;
BEGIN

    SELECT FIRST_NAME, PHONE_NUMBER, EMAIL 
           INTO V_NAME, V_PHONE, V_MAIL
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = 103;

    DBMS_OUTPUT.PUT_LINE(V_NAME ||' '|| V_PHONE || ' ' || V_MAIL);
END;
/*
Alexander 590.423.4567 AHUNOLD
PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/

-- �� %ROWTYPE

-- 1. ���̺��� ���ڵ�� ���� ������ ����ü ������ ����(���� ���� �÷�)
-- 2. ���� �� ����
-- ������ ���̺��%ROWTYPE;
DECLARE
    --V_NAME  EMPLOYEES.FIRST_NAME%TYPE;
    --V_PHONE EMPLOYEES.PHONE_NUMBER%TYPE;
    --V_MAIL  EMPLOYEES.EMAIL%TYPE;
    V_EMP   EMPLOYEES%ROWTYPE;
BEGIN
    SELECT FIRST_NAME, PHONE_NUMBER, EMAIL 
           INTO V_EMP.FIRST_NAME, V_EMP.PHONE_NUMBER, V_EMP.EMAIL
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = 103;
    -- �� WHERE ���� �ʼ�

    --DBMS_OUTPUT.PUT_LINE(V_NAME ||' '|| V_PHONE || ' ' || V_MAIL);
    DBMS_OUTPUT.PUT_LINE(V_EMP.FIRST_NAME ||' '|| V_EMP.PHONE_NUMBER || ' ' || V_EMP.EMAIL);
END;
/*
Alexander 590.423.4567 AHUNOLD
PL/SQL ���ν����� ���������� �Ϸ�Ǿ����ϴ�.
*/


