Select user
from dual;
--==>>SYS

select '���ڿ�'
from dual;
--==>> ���ڿ�

select 550 + 230
from dual;
--==>>780

select '������' + 'ȫ����'
from dual;
--==>> �����߻�
--     (ORA-01722: invalid number)


-- �� ���� ����Ŭ ������ �����ϴ� ����� ���� ���� ��ȸ
select username, account_status
from DBA_USERS;
/*
SYS 	            OPEN
SYSTEM          	OPEN
ANONYMOUS       	OPEN
HR	OPEN
APEX_PUBLIC_USER	LOCKED
FLOWS_FILES     	LOCKED
APEX_040000	        LOCKED
OUTLN	            EXPIRED & LOCKED
DIP	                EXPIRED & LOCKED
ORACLE_OCM	        EXPIRED & LOCKED
XS$NULL	            EXPIRED & LOCKED
MDSYS	            EXPIRED & LOCKED
CTXSYS	            EXPIRED & LOCKED
DBSNMP	            EXPIRED & LOCKED
XDB	                EXPIRED & LOCKED
APPQOSSYS	        EXPIRED & LOCKED
*/


select *
From dba_users;
/*
APEX_040000	47		LOCKED	2014-05-29	2014-11-25	SYSAUX
OUTLN	9		EXPIRED & LOCKED	2022-02-15	2022-02-15	SYSTEM
DIP	14		EXPIRED & LOCKED	2014-05-29	2014-05-29	SYSTEM
ORACLE_OCM	21		EXPIRED & LOCKED	2014-05-29	2014-05-29	SYSTEM
XS$NULL	2147483638		EXPIRED & LOCKED	2014-05-29	2014-05-29	SYSTEM
MDSYS	42		EXPIRED & LOCKED	2014-05-29	2022-02-15	SYSAUX
CTXSYS	32		EXPIRED & LOCKED	2022-02-15	2022-02-15	SYSAUX
DBSNMP	29		EXPIRED & LOCKED	2014-05-29	2014-05-29	SYSAUX
XDB	34		EXPIRED & LOCKED	2014-05-29	2014-05-29	SYSAUX
APPQOSSYS	30		EXPIRED & LOCKED	2014-05-29	2014-05-29	SYSAUX
*/

select username, created
from dba_users;
/*
SYS	2014-05-29
SYSTEM	2014-05-29
ANONYMOUS	2014-05-29
HR	2014-05-29
APEX_PUBLIC_USER	2014-05-29
FLOWS_FILES	2014-05-29
APEX_040000	2014-05-29
OUTLN	2014-05-29
DIP	2014-05-29
ORACLE_OCM	2014-05-29
XS$NULL	2014-05-29
MDSYS	2014-05-29
CTXSYS	2014-05-29
DBSNMP	2014-05-29
XDB	2014-05-29
APPQOSSYS	2014-05-29
*/
---> ��DBA_���� �����ϴ� Oracle Data Dictionary View
---   ������ ������ �������� �������� ��쿡�� ��ȸ�� �����ϴ�.
---   ���� ������ ��ųʸ� ������ ���� ���ص� ��� ����.

-- �� ��HR�� ����� ������ ��� ���·� ����
Alter user hr account lock;
--==>> User HR��(��) ����Ǿ����ϴ�.

-- �� ��HR�� ����� �������� Ȯ��
select username, account_status
from dba_users;
--==>> HR	LOCKED  


-- �� ��HR�� ����� ������ ��� ����
Alter user HR account unlock;
--==>> User HR��(��) ����Ǿ����ϴ�.

-- ��  ��HR�� ����� �������� Ȯ��.    
select username, account_status
from dba_users;
--==>> HR	OPEN

--------------------------------------------------------

-- �� TABLESPACE ����

-- �� TABLESPACE ��?
-->   ���׸�Ʈ(���̺�, �ε���, ..) �� ��Ƶδ�(����)
-->   ����Ŭ�� ������ ���� ������ �ǹ��Ѵ�.

CREATE TABLESPACE TBS_EDUA            -- �����ϰڴ�. ���̺����̽��� ... TBS_EDUA ��� �̸�����
DATAFILE 'C:\TESTDATA\TBS_EDUA01.DBF' -- ������ ������ ���� ��� �� �̸�
SIZE 4M                               -- ������(�뷮)
EXTENT MANAGEMENT LOCAL               -- ����Ŭ ������ ���׸�Ʈ�� �˾Ƽ� ����
SEGMENT SPACE MANAGEMENT AUTO;        -- ���׸�Ʈ ���� ������ ����Ŭ ������ �ڵ����� ����
--==>> TABLESPACE TBS_EDUA��(��) �����Ǿ����ϴ�.

-- �� ���̺����̽� ���� ������ �����ϱ� ����
--    �ش� ����� �������� ���͸� ������ �ʿ��ϴ�.
--     C:\TESTDATA

-- �� ������ ���̺����̽� ��ȸ
SELECT *
FROM DBA_TABLESPACES;
/*
SYSTEM	8192	65536		1	2147483645	2147483645		65536	ONLINE	PERMANENT
SYSAUX	8192	65536		1	2147483645	2147483645		65536	ONLINE	PERMANENT
UNDOTBS1	8192	65536		1	2147483645	2147483645		65536	ONLINE	UNDO
TEMP	8192	1048576	1048576	1		2147483645	0	1048576	ONLINE	TEMPORARY
USERS	8192	65536		1	2147483645	2147483645		65536	ONLINE	PERMANENT
TBS_EDUA	8192	65536		1	2147483645	2147483645		65536	ONLINE	PERMANENT
*/

-- �� ���� �뷮 ���� ��ȸ(�������� ���� �̸� ��ȸ)
SELECT *
FROM DBA_DATA_FILES;
/*
  :
C:\TESTDATA\TBS_EDUA01.DBF	5	TBS_EDUA	4194304	512	AVAILABLE	5	NO	0	0	0	3145728	384	ONLINE
*/

--�ۿ���Ŭ ����� ���� ����
CREATE USER ksg IDENTIFIED BY java006$
DEFAULT TABLESPACE TBS_EDUA;
--==>> User KSG��(��) �����Ǿ����ϴ�.
--> ksg ��� ����� ������ �����ϰڴ�.(����ڴ�.)
--  �� ����� ������ �н������ java006$ �� �ϰڴ�.
--  �� ������ ���� �����ϴ� ����Ŭ ���׸�Ʈ��
--  �⺻������ TBS_EDUA ��� ���̺� �����̽��� ������ �� �ֵ��� �����ϰڴ�.

-- �� ������ ����Ŭ ����� ����(���� ���� �̸� �̴ϼ� ����)�� ���� ���� �õ�
--    �� ���� �Ұ�(����)
--    ��create session�� ������ ���� ������ ���� �Ұ�.

-- �� ������ ����Ŭ ����� ����(���� ���� �̸� �̴ϼ� ����)��
--    ����Ŭ ���� ������ �����ϵ��� CREATE SESSION ���� �ο�

GRANT CREATE SESSION TO KSG;
--==>> Grant��(��) �����߽��ϴ�.

-- �� ���� ������ ����Ŭ ����� ������ �ý��� ���� ���� ��ȸ
SELECT *
FROM DBA_SYS_PRIVS;
/*
        :
KSG	CREATE SESSION	NO
        :
*/

DROP USER KSK CASCADE;  -- �Ʊ� �߸������� KSK ���� ����

-- �� ���� ������ ����Ŭ ����� ������ ���̺� ������ �����ϵ���
--    ���̺� ������ �����ϵ��� CREATE TABLE ���� �ο�
GRANT CREATE TABLE TO KSG;
--==>> Grant��(��) �����߽��ϴ�.

-- �� ���� ������ ����Ŭ ����� ������
--    ���̺� �����̽�(TBS_EDUA)���� ����� �� �ִ� ����(�Ҵ緮) ����.
ALTER USER KSG
QUOTA UNLIMITED ON TBS_EDUA;
--==>> User KSG��(��) ����Ǿ����ϴ�.
-------------------------------------------------------------
CREATE USER scott
IDENTIFIED BY tiger;
--==>> User SCOTT��(��) �����Ǿ����ϴ�.

GRANT CONNECT,RESOURCE,UNLIMITED TABLESPACE TO SCOTT;
--==>> Grant��(��) �����߽��ϴ�.

ALTER USER SCOTT DEFAULT TABLESPACE USERS;
--==>> User SCOTT��(��) ����Ǿ����ϴ�.

-- Temporary : �ӽ���
ALTER USER SCOTT TEMPORARY TABLESPACE TEMP;
--==>> User SCOTT��(��) ����Ǿ����ϴ�.





