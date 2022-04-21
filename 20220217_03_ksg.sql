select user
from dual;
--> KSG


-- �� ���̺� ����(TBL_ORAUSERTEST)
CREATE TABLE TBL_ORAUSERTEST
( NO        NUMBER(10)
, NAME      VARCHAR2(30)   
);
--==>> ���� �߻�
--     (ORA-01031: insufficient privileges)
--> ���� ������ �̸� ������ CREATE SESSION ���Ѹ� ���� ������
--  ���̺� ���� ������ ���� ���� ���� �����̴�.
--  �׷��Ƿ� �����ڷκ��� ���̺��� ������ �� �ִ� ������ �ο��޾ƾ� �Ѵ�.

--------------------------------------------------
--          �������

-- �� SYS�� ���� ���̺� �������� �ο����� ��
--    �ٽ� ���̺� ����(TBL_ORAUSERTEST)
CREATE TABLE TBL_ORAUSERTEST
( NO        NUMBER(10)
, NAME      VARCHAR2(30)   
);
--==>> ���� �߻�
--     (ORA-01950: no privileges on tablespace 'TBS_EDUA')
--  �Ҵ緮 �����.. �ش� ���̺� �����̽�(TBS_EDUA)�� ����
--  �Ҵ緮�� �ο��޾ƾ� �ϴ� ��Ȳ�̴�.. �Ҵ緮�� ALTER ��,
--  ���� �Ҵ緮���� �����ϴ� �������� �ο��� ��� �Ѵ�.

--------------------------------------------------
--            ������

-- �� SYS�κ��� ���̺� �����̽�(TBS_EDUA)�� ���� �Ҵ緮 �ο����� �� 
--    �ٽ� ���̺� ���� (TBL_ORAUSERTEST)
CREATE TABLE TBL_ORAUSERTEST
( NO        NUMBER(10)
, NAME      VARCHAR2(30)   
);
--==>> Table TBL_ORAUSERTEST��(��) �����Ǿ����ϴ�.

-- �� ������ ���̺� ��ȸ
SELECT *
FROM TBL_ORAUSERTEST;
--> ���̺��� ������ Ȯ���� �� �ִ� ����
--  ��, ��ȸ ����� ����

-- �� �ڽſ��� �ο��� �Ҵ緮 ��ȸ
SELECT *
FROM USER_TS_QUOTAS;
--==>> TBS_EDUA	65536	-1	8	-1	NO
-- �� -��1�� �� �������� �ǹ�

-- �� ������ ���̺�(TBL_ORAUSERTEST)��
--    � ���̺� �����̽��� ����Ǿ� �ִ��� ��ȸ
SELECT TABLE_NAME, TABLESPACE_NAME
FROM USER_TABLES;
--==>> TBL_ORAUSERTEST	TBS_EDUA










