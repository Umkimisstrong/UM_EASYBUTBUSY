-- ��� ����Ŭ���ϸ� �� ��ʰ� ����ȭ���� �ȴ�.(���ư��� : ����Ŭ��)

-- 1�� �ּ��� ó��(������ �ּ��� ó��) : "--"

/*
������
(������)
�ּ���
ó��
*/

-- �� ���� ����Ŭ ������ ������ �ڽ��� ���� ��ȸ
show user
--==>> USER��(��) "SYS"�Դϴ�.
--> sqlplus ������ �� ����ϴ� ��ɾ�

select user
from dual;
--==>> SYS

-- ���� ������ ��ҹ��� ���� x 
-- �䱸�ϴ� ���� ��ҹ��� ���� o
SELECT USER
FROM DUAL;
--==>> SYS

-- > from dual : �ǹ� ����(���� �־��ִ� ������ �ؼ��غ���??)

select 1+2
from dual;
--==>> 3 


SELECT                        2 + 4
From                         DUAL;
--==>> 6 ���� �ǹ̾���

--select 1+5 fromdual
--==>> ���� �߻� ( from�� dual�� �ٿ����� )
--(ORA-00923: FROM keyword not found where expected)


--select �ֿ밭�ϱ������� F������
--From dual
--==>> ���� �߻�
--(ORA-00904: "�ֿ밭�ϱ�������": invalid identifier)


--select "�ֿ밭�ϱ������� F������"
--From dual;
--==>> �����߻�
--(ORA-00972: identifier is too long)

-- ���ڿ��� ' ~ ' �� ������
select '�ֿ밭�ϱ������� F������'
from dual;
--==>> �ֿ밭�ϱ������� F������

select '�� �� �� �� ���ܿ� ����Ŭ ����'
from dual;
--==>> �� �� �� �� ���ܿ� ����Ŭ ����

select 3.14 + 3.14
from dual;
--==>> 6.28

select 10*5
from dual;
--==>> 50

select 10*5.0
from dual;
--==>> 50

select 4 / 2
from dual;
--==>> 2

select 4.0 / 2
from dual;
--==>> 2

select 4.0/2.0
from dual;
--==>> 2

select 5/2
from dual;
--==>> 2.5

select 100-23
from dual;
--==>> 77

select 123123123123*2131231231234
from dual;
--==>> 262403845286806665223782
