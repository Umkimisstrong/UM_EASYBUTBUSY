SELECT USER
FROM DUAL;
--==>> SCOTT


-- �� ROUND() �ݿø��� ó���� �ִ� �Լ�
SELECT 48.678 "COL1"
    , ROUND(48.678, 2) "COL2" -- �Ҽ������� ��°�ڸ����� ǥ��
    , ROUND(48.674, 2) "COL3" -- �Ҽ������� ��°�ڸ����� ǥ��
    , ROUND(48.674, 1) "COL4" -- �Ҽ������� ù°�ڸ����� ǥ��
    , ROUND(48.674, 0) "COL5" -- 1���ڸ����� ǥ��
    , ROUND(48.674) "COL6"    -- 1���ڸ����� ǥ��(0����Ʈ)
    , ROUND(48.674, -1) "COL7"-- 10���ڸ����� ǥ��
    , ROUND(48.674, -2) "COL8"-- 100���ڸ����� ǥ��
    , ROUND(48.674, -3) "COL9"-- 1000���ڸ����� ǥ��
    , ROUND(1234.1234, -1) "COL10"
    , ROUND(1234.1234, -2) "COL11"
FROM DUAL;

-- �� TRUNC() ������ ó���� �ִ� �Լ�

SELECT 48.678 "COL1"
    , TRUNC(48.678, 2) "COL2" -- �Ҽ������� ��°�ڸ����� ǥ��
    , TRUNC(48.674, 2) "COL3" -- �Ҽ������� ��°�ڸ����� ǥ��
    , TRUNC(48.674, 1) "COL4" -- �Ҽ������� ù°�ڸ����� ǥ��
    , TRUNC(48.674, 0) "COL5" -- 1���ڸ����� ǥ��
    , TRUNC(48.674) "COL6"    -- 1���ڸ����� ǥ��(0����Ʈ)
    , TRUNC(48.674, -1) "COL7"-- 10���ڸ����� ǥ��
    , TRUNC(48.674, -2) "COL8"-- 100���ڸ����� ǥ��
    , TRUNC(48.674, -3) "COL9"-- 1000���ڸ����� ǥ��
FROM DUAL;

-- �� MOD()  �������� ��ȯ�ϴ� �Լ�
SELECT MOD(5, 2) "RESULT"
FROM DUAL;
--==>> 1 

-- �� POWER() ������ ����� ��ȯ�ϴ� �Լ�
SELECT POWER(5, 3) "RESULT"
FROM DUAL;
--==>> 125

-- �� SQRT() ��Ʈ ������� ��ȯ�ϴ� �Լ�
SELECT SQRT(2) "RESULT"
FROM DUAL;
--==>> 1.41421356237309504880168872420969807857

-- �� LOG() �α� �Լ�
--    ����Ŭ�� ���α׸� �����ϴ� �ݸ� MSSQL�� ���αפ��ڿ��α� ��� ����)
SELECT LOG(10, 100) "COL1"
     , LOG(10, 20) "COL2"
FROM DUAL;
--==>> 2	1.30102999566398119521373889472449302677

-- �� �ﰢ�Լ�
SELECT SIN(1), COS(1), TAN(1)
FROM DUAL;
/*
0.8414709848078965066525023216302989996233  ����
0.5403023058681397174009366074429766037354  �ڽ���
1.55740772465490223050697480745836017308    ź��Ʈ

*/
-- �� �ﰢ�Լ��� ���Լ�(���� : -1 ~ 1)
SELECT ASIN(0.5), ACOS(0.5), ATAN(0.5)
FROM DUAL;
/*
0.52359877559829887307710723054658381405	 �����
1.04719755119659774615421446109316762805	 ���ڽ���
0.4636476090008061162142562314612144020295   ��ź��Ʈ
*/

-- �� SIGN() ���� ��ȣ Ư¡
--    ���� ������� ����̸� 1, 0�̸� 0, �����̸� -1 ��ȯ
SELECT SIGN(5-2) "COL1", SIGN(5-5) "COL2", SIGN(5-8) "COL3"
FROM DUAL;
--==>> 1	0	-1 
--> �����̳� ������ �����Ͽ� ���� �� ������ ������ ��Ÿ���� ���

-- �� ASCII(), CHR() �� ���� ����(����)�ϴ� �Լ�
SELECT ASCII('A') "COL1"
     , CHR(65) "COL2"
FROM DUAL;
--==>> 65	A
--> �� ASCII() �� : �Ű������� �Ѱܹ��� ������ �ƽ�Ű�ڵ尪�� ��ȯ
--> �� CHR() ��   : �Ű������� �Ѱܹ��� �ƽ�Ű�ڵ尪���� �ش� ���ڸ� ��ȯ�Ѵ�.


-- �� ��¥���� ���� ���� ����
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session��(��) ����Ǿ����ϴ�.
SELECT SYSDATE "COL1"      -- 2022-02-22 09:44:11
      , SYSDATE + 1 "COL2" -- 2022-02-23 09:44:11	
      , SYSDATE - 2 "COL3" -- 2022-02-20 09:44:11
      , SYSDATE - 30 "COL4"-- 2022-01-23 09:44:11
FROM DUAL;
--==>>

-- �� �ð� ���� ����
SELECT  SYSDATE   "COL1"           
      , SYSDATE + 1/24 "COL2"  -- 1�ð� ��
      , SYSDATE - 2/24 "COL3"  -- 2�ð� ��
FROM DUAL;
/*
2022-02-22 09:48:02	
2022-02-22 10:48:02	
2022-02-22 07:48:02
*/
-- �� ���� �ð���.. ����ð� ���� 1�� 2�ð� 3�� 4�� �ĸ� ��ȸ�ϴ� ������ ����
-- ��� 1.
SELECT SYSDATE "����ð�" 
    , SYSDATE + 1 + (2/24) + ((1/24)/20) + ((1/24)/900) "���� �� �ð�"
FROM DUAL;
/*
===================     ===================
     ���� �ð�             ���� �� �ð�
===================     ===================
2022-02-22 10:05:12	    2022-02-23 12:08:16
*/

-- ���2.
SELECT SYSDATE "����ð�"
     , SYSDATE + ((1*24*60*60) + (2*60*60) + (3*60) + 4) / (24*60*60) "���� �� �ð�"
FROM DUAL;
/*
===================     ===================
     ���� �ð�             ���� �� �ð�
===================     ===================
2022-02-22 10:19:49	    2022-02-23 12:22:53
*/

-- ��¥ - ��¥ : ���갡��
SELECT TO_DATE('2022-06-20', 'YYYY-MM-DD')
       - TO_DATE('2022-02-22', 'YYYY-MM-DD') "RESULT"
FROM DUAL;
--==>> 118

-- �� ������ Ÿ���� ��ȯ
SELECT TO_DATE('2022-06-20', 'YYYY-MM-DD') "RESULT"
FROM DUAL;
--==>> 2022-06-20 00:00:00

SELECT TO_DATE('2022-06-35', 'YYYY-MM-DD') "RESULT"
FROM DUAL;
--==>> ���� �߻�
--     ORA-01847: day of month must be between 1 and last day of month

SELECT TO_DATE('2022-02-29', 'YYYY-MM-DD') "RESULT"
FROM DUAL;
--==>> ���� �߻�
--     ORA-01839: date not valid for month specified

SELECT TO_DATE('2022-13-29', 'YYYY-MM-DD') "RESULT"
FROM DUAL;
--==>> ���� �߻�
--     ORA-01843: not a valid month

-- �� TO_DATE() �Լ��� ���� ���� Ÿ���� ��¥ Ÿ������ ��ȯ�ϴ� ��������
--    ���������� �ش� ��¥�� ���� ��ȿ�� �˻簡 �̷������.

-- �� ADD_MONTHS() ���� ���� �����ִ� �Լ�
SELECT SYSDATE "COL1"
     , ADD_MONTHS(SYSDATE, 2) "COL2"
     , ADD_MONTHS(SYSDATE, 3) "COL3"
     , ADD_MONTHS(SYSDATE, -2) "COL4"
     , ADD_MONTHS(SYSDATE, -3) "COL5"
FROM DUAL;

/*
2022-02-22 10:30:09
2022-04-22 10:30:09
2022-05-22 10:30:09	
2021-12-22 10:30:09	
2021-11-22 10:30:09
*/

-- �� MONTHS_BETWEEN()
--    ù ��° ���ڰ����� �� ��° ���ڰ��� �� ���� ���� ��ȯ�Ѵ�.
SELECT MONTHS_BETWEEN(SYSDATE, TO_DATE('2002-05-31', 'YYYY-MM-DD')) "RESULT"
FROM DUAL;
--==>> 236.723869847670250896057347670250896057

--> ���� ���� ���̸� ��ȯ�ϴ� �Լ�
--  ������� ��ȣ�� ��-���� ��ȯ�Ǿ��� ��쿡��
--  ù ��° ���ڰ��� �ش��ϴ� ��¥����
--  �� ��° ���ڰ��� �ش��ϴ� ��¥�� ���̷��� ��� �ǹ̷� Ȯ���� �� �ִ�.

-- �� NEXT_DAY()
SELECT NEXT_DAY(SYSDATE, '��') "COL1"
FROM DUAL;
--==>> 2022-02-26 10:37:47

-- �� ���� ���� ����  (�� ������ : �ѱ��̾�����)
ALTER SESSION SET NLS_DATE_LANGUAGE = 'ENGLISH';
--==>> Session��(��) ����Ǿ����ϴ�.

SELECT NEXT_DAY(SYSDATE, '��') "COL1"
FROM DUAL;
--==>> ���� �߻�
--     ORA-01846: not a valid day of the week

SELECT NEXT_DAY(SYSDATE, 'SAT') "COL1"
FROM DUAL;
--==>> 2022-02-26 10:40:38

ALTER SESSION SET NLS_DATE_LANGUAGE = 'KOREAN';
--==>> Session��(��) ����Ǿ����ϴ�.

SELECT NEXT_DAY(SYSDATE, 'SAT') "COL1"
FROM DUAL;
--==>> ORA-01846: not a valid day of the week

SELECT NEXT_DAY(SYSDATE, '��') "COL1"
FROM DUAL;
--==>> 2022-02-26 10:43:04

-- �� LAST_DAY()
-- �ش� ��¥�� ���ԵǾ��ִ� �� ���� ������ ���� ��ȯ�Ѵ�.
SELECT LAST_DAY(SYSDATE) "COL1"
     , LAST_DAY(TO_DATE('2020-02-10', 'YYYY-MM-DD')) "COL2"
FROM DUAL;
/*
2022-02-28 10:44:37	
2020-02-29 00:00:00
*/

-- �� ���� ���� ����
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session��(��) ����Ǿ����ϴ�.

-- �� ���úη�... ��Ⱑ ���뿡 �ٽ� ����(?)����...
--    ���� �Ⱓ�� 22������ �Ѵ�.

--   1. ���� ���ڸ� ���Ѵ�.

--   2. �Ϸ� ���ڲ��� 3�� �Ļ縦 �Ѵٰ� �����ϸ�
--      ��Ⱑ �� ���� �Ծ�� ���� �����ٱ�...

SELECT SYSDATE "���� ��¥"
     , ADD_MONTHS(SYSDATE, 22) "����� ���� ��¥"
     , 3*TRUNC(((TO_DATE('2023-12-22', 'YYYY-MM-DD')-SYSDATE)), 0)||'��' "����� �Ļ緮"
FROM DUAL;
/*
2022-02-22
2023-12-22
2001��
*/
-- �� ���� ��¥ �� �ð����κ���...
--    ������(2022-06-20 18:00:00)����
--    ���� �Ⱓ��... ������ ���� ���·� ��ȸ�� �� �ֵ��� �������� �����Ѵ�.
/*
--------------------------------------------------------------------------------
����ð�             | ������                |  ��   | �ð� |  �� | ��
--------------------------------------------------------------------------------
2022-02-22 11:34:35  | 2022-06-20 18:00:00  |  117  |   7  |  15  | 15
*/
-- �� ���Ǽ��� ����
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session��(��) ����Ǿ����ϴ�.

SELECT SYSDATE "����ð�"

     , TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS') "������"
     
     , TRUNC(TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS')
       - SYSDATE) "���� �ϼ�(DAY)"
       
     , TRUNC(((TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS')
       - SYSDATE)-TRUNC(TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS')
       - SYSDATE))*24) "���� �ð�(HOUR)"
       
     , TRUNC(((((TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS')
       - SYSDATE)-TRUNC(TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS')
       - SYSDATE))*24) - 
       (TRUNC(((TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS')
       - SYSDATE)-TRUNC(TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS')
       - SYSDATE))*24)))*60) "���� ��(MIN)"
       
     , ROUND(((((((TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS')
       - SYSDATE)-TRUNC(TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS')
       - SYSDATE))*24) - 
       (TRUNC(((TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS')
       - SYSDATE)-TRUNC(TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS')
       - SYSDATE))*24)))*60)-
       TRUNC(((((TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS')
       - SYSDATE)-TRUNC(TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS')
       - SYSDATE))*24) - 
       (TRUNC(((TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS')
       - SYSDATE)-TRUNC(TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS')
       - SYSDATE))*24)))*60))*60) "���� ��(SEC)"       
FROM DUAL;
/*
����ð�              ������               ��   �ð�  ��   ��
====================  ==================== ===  ====  ==   ==
2022-02-22 12:08:21  2022-06-20 18:00:00  118   5    51   39
*/

-- ��1�� 2�ð� 3�� 4�ʡ��� ... ���ʡ� �� ȯ���ϸ�....
SELECT (1��) + (2�ð�) + (3��) + (4��)
FROM DUAL;

SELECT (1*24*60*60) + (2*60*60) + (3*60) + (4)
FROM DUAL;
--==>> 93784

-- ��93784�ʡ���... �ٽ� ���� �ð� �� �ʡ��� ȯ��...
SELECT  TRUNC(TRUNC(TRUNC(93784/60)/60)/24) "��"
      , MOD(TRUNC(TRUNC(93784/60)/60), 24) "�ð�"
      , MOD(TRUNC(93784/60), 60) "��"
      , MOD(93784, 60)  "��"
FROM DUAL;
---> 1	2	3	4


SELECT �������� - ��������
FROM DUAL;

SELECT TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS')-SYSDATE
FROM DUAL;
--==>> 118.13244212962962962962962962962962963

-- �����ϱ��� �����Ⱓ Ȯ��(���� : ��)
SELECT (TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS')-SYSDATE)
        * (24*60*60)
FROM DUAL;
--==>> 10205687.00000000000000000000000000000002

SELECT  SYSDATE "����ð�"
      , TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS') "������"
      , TRUNC(TRUNC(TRUNC((TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS')-SYSDATE)
        * (24*60*60)/60)/60)/24) "��"
      , MOD(TRUNC(TRUNC((TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS')-SYSDATE)
        * (24*60*60)/60)/60), 24) "�ð�"
      , MOD(TRUNC((TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS')-SYSDATE)
        * (24*60*60)/60), 60) "��"
      , ROUND(MOD((TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS')-SYSDATE)
        * (24*60*60), 60))  "��"
FROM DUAL;

-- �� ���� �¾ ��¥ �� �ð����κ���... �������
--    �󸶸�ŭ�� �ð��� ��� �ִ���...
--    ������ ���� ���·� ��ȸ�� �� �ֵ��� �������� �����Ѵ�.
/*
-------------------------------------------------------------------------------
����ð�             | �������              |  ��   | �ð� |  �� | ��
--------------------------------------------------------------------------------
2022-02-22 11:34:35  | 1996-10-04 01:00:00  |   ??   |   7  |  15  | 15
*/
-- ����ü �ϼ��� �� ���� �� �� �ʡ��� ������ ����

SELECT SYSDATE "����ð�"
      , TO_DATE('1996-10-04 01:00:00', 'YYYY-MM-DD HH24:MI:SS')  "�������"
      , TRUNC((SYSDATE) -  TO_DATE('1996-10-04 01:00:00', 'YYYY-MM-DD HH24:MI:SS'))   "��ƿ� �ϼ�"
      
      , TRUNC(((SYSDATE) -  TO_DATE('1996-10-04 01:00:00', 'YYYY-MM-DD HH24:MI:SS')
        - TRUNC((SYSDATE) -  TO_DATE('1996-10-04 01:00:00', 'YYYY-MM-DD HH24:MI:SS')))*24)   "��ƿ� �ð�"
        
      , TRUNC(((((SYSDATE) -  TO_DATE('1996-10-04 01:00:00', 'YYYY-MM-DD HH24:MI:SS')
        - TRUNC((SYSDATE) -  TO_DATE('1996-10-04 01:00:00', 'YYYY-MM-DD HH24:MI:SS')))*24)
        - (TRUNC(((SYSDATE) -  TO_DATE('1996-10-04 01:00:00', 'YYYY-MM-DD HH24:MI:SS')
        - TRUNC((SYSDATE) -  TO_DATE('1996-10-04 01:00:00', 'YYYY-MM-DD HH24:MI:SS')))*24))) * 60)   "��ƿ� ��"
        
      , ROUND(((((((SYSDATE) -  TO_DATE('1996-10-04 01:00:00', 'YYYY-MM-DD HH24:MI:SS')
        - TRUNC((SYSDATE) -  TO_DATE('1996-10-04 01:00:00', 'YYYY-MM-DD HH24:MI:SS')))*24)
        - (TRUNC(((SYSDATE) -  TO_DATE('1996-10-04 01:00:00', 'YYYY-MM-DD HH24:MI:SS')
        - TRUNC((SYSDATE) -  TO_DATE('1996-10-04 01:00:00', 'YYYY-MM-DD HH24:MI:SS')))*24))) * 60)
        -TRUNC(((((SYSDATE) -  TO_DATE('1996-10-04 01:00:00', 'YYYY-MM-DD HH24:MI:SS')
        - TRUNC((SYSDATE) -  TO_DATE('1996-10-04 01:00:00', 'YYYY-MM-DD HH24:MI:SS')))*24)
        - (TRUNC(((SYSDATE) -  TO_DATE('1996-10-04 01:00:00', 'YYYY-MM-DD HH24:MI:SS')
        - TRUNC((SYSDATE) -  TO_DATE('1996-10-04 01:00:00', 'YYYY-MM-DD HH24:MI:SS')))*24))) * 60))*60)  "��ƿ� ��"
FROM DUAL;


SELECT (SYSDATE - TO_DATE('1996-10-04 01:00:00', 'YYYY-MM-DD HH24:MI:SS'))
FROM DUAL;


-- ���±��� ��ƿ� ���� �ʷ� ȯ��

SELECT (SYSDATE - TO_DATE('1996-10-04 01:00:00', 'YYYY-MM-DD HH24:MI:SS'))
       * (24*60*60)
FROM DUAL;

-- ���ʡ��� ����, ��, ��, �ʡ� �� ������ ����

SELECT SYSDATE "����ð�"
      , TO_DATE('1996-10-04 01:00:00', 'YYYY-MM-DD HH24:MI:SS')   "�������"
      , TRUNC(TRUNC(TRUNC((SYSDATE - TO_DATE('1996-10-04 01:00:00', 'YYYY-MM-DD HH24:MI:SS'))  * (24*60*60) / 60) / 60)/24)   "��"
      , MOD(TRUNC(TRUNC((SYSDATE - TO_DATE('1996-10-04 01:00:00', 'YYYY-MM-DD HH24:MI:SS')) * (24*60*60) / 60) / 60), 24) "��"
      , MOD(TRUNC((SYSDATE - TO_DATE('1996-10-04 01:00:00', 'YYYY-MM-DD HH24:MI:SS'))  * (24*60*60)/60), 60)  "��"
      , MOD((SYSDATE - TO_DATE('1996-10-04 01:00:00', 'YYYY-MM-DD HH24:MI:SS'))  * (24*60*60), 60)  "��"
FROM DUAL;

-- �ۼ��� ���� ����
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session��(��) ����Ǿ����ϴ�.
-- �� ��¥ �����͸� ������� �ݿø�, ���� ���� ������ ������ �� �ִ�.

-- �� ��¥ �ݿø�
SELECT SYSDATE "COL1"                  -- 2022-02-22 �� �⺻ ���� ��¥
     , ROUND(SYSDATE, 'YEAR') "COL2"   -- 2022-01-01 �� �⵵���� ��ȿ�� ������(��ݱ�/�Ϲݱ� ����)
     , ROUND(SYSDATE, 'MONTH') "COL3"  -- 2022-03-01 �� ������ ��ȿ�� ������(15�ϱ���)
     , ROUND(SYSDATE, 'DD') "COL4"     -- 2022-02-23 �� �ϱ��� ��ȿ�� ������(���� ����)
     , ROUND(SYSDATE, 'DAY') "COL5"    -- 2022-02-20 �� �ϱ��� ��ȿ�� ������(������ ��������)
     , ROUND(SYSDATE) "COL6"    
FROM DUAL;     

-- �� ��¥ ����
SELECT SYSDATE "COL1"                  -- 2022-02-22 �� �⺻ ���� ��¥
     , TRUNC(SYSDATE, 'YEAR') "COL2"   -- 2022-01-01 �� �⵵���� ��ȿ�� ������
     , TRUNC(SYSDATE, 'MONTH') "COL3"  -- 2022-02-01 �� ������ ��ȿ�� ������
     , TRUNC(SYSDATE, 'DD') "COL4"     -- 2022-02-22 �� �ϱ��� ��ȿ�� ������
     , TRUNC(SYSDATE, 'DAY') "COL5"    -- 2022-02-20 �� �� �� �ֿ� �ش��ϴ� �Ͽ���
     , TRUNC(SYSDATE) "COL6"  
FROM DUAL;     


-- ���� ��ȯ �Լ� ���� --

-- TO_CHAR()    : ���ڳ� ��¥ �����͸� ���� Ÿ������ ��ȯ�����ִ� �Լ�
-- TO_DATE()    : ���� �����͸� ��¥ Ÿ������ ��ȯ�����ִ� �Լ�
-- TO_NUMBER()  : ���� �����͸� ���� Ÿ������ ��ȯ�����ִ� �Լ�

-- �� ��¥�� ��ȭ ������ ���� ���� ���..
--    �������� ���� ������ �����Ͽ� ����� �� �ִ�.
ALTER SESSION SET NLS_LANGUAGE = 'KOREAN';
ALTER SESSION SET NLS_DATE_LANGUAGE = 'KOREAN';
ALTER SESSION SET NLS_CURRENCY = '\';
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';

-- �� ��¥�� �� ������
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') "COL1"    --2022-02-22
     , TO_CHAR(SYSDATE, 'YYYY') "COL2"          --2022
     , TO_CHAR(SYSDATE, 'YEAR') "COL3"          --TWENTY TWENTY-TWO
     , TO_CHAR(SYSDATE, 'MM') "COL4"            --02
     , TO_CHAR(SYSDATE, 'MONTH') "COL5"         --2�� 
     , TO_CHAR(SYSDATE, 'MON') "COL6"           --2�� 
     , TO_CHAR(SYSDATE, 'DD') "COL7"            --22
     , TO_CHAR(SYSDATE, 'MM-DD') "COL8"         --02-22
     , TO_CHAR(SYSDATE, 'DAY') "COL9"           --ȭ����
     , TO_CHAR(SYSDATE, 'DY') "COL10"           --ȭ
     , TO_CHAR(SYSDATE, 'HH24') "COL11"         --16
     , TO_CHAR(SYSDATE, 'HH') "COL12"           --04
     , TO_CHAR(SYSDATE, 'HH AM') "COL13"        --04 ����
     , TO_CHAR(SYSDATE, 'HH PM') "COL14"        --04 ����
     , TO_CHAR(SYSDATE, 'MI') "COL15"           --19
     , TO_CHAR(SYSDATE, 'SS') "COL16"           --49
     , TO_CHAR(SYSDATE, 'SSSSS') "COL17"        --58789
     , TO_CHAR(SYSDATE, 'Q') "COL18"            --1(�б�)
FROM DUAL;

-- ���ڿ� ������ ���� : ������ ��� ��������, ������ ��� �������ĵ�

SELECT 7    "CO1"
      , '7' "COL2"
      , TO_CHAR(7) "COL3"
FROM DUAL;
--==>> 7 7	7

SELECT '4' "COL1"
      , TO_NUMBER('4') "COL2"
      , 4 "COL3"
      , TO_NUMBER('04') "COL4"
FROM DUAL;
--==>> 4	4	4	4

SELECT TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY'))
FROM DUAL;
--==>> 2022

-- �� EXTRACT()
SELECT TO_CHAR(SYSDATE, 'YYYY') "COL1"     -- 2022(������) �� ������ �����Ͽ� ���� Ÿ������ ��ȯ
     , TO_CHAR(SYSDATE, 'MM') "COL2"       -- 02(������) �� ���� �����Ͽ� ���� Ÿ������ ��ȯ
     , TO_CHAR(SYSDATE, 'DD') "COL3"       -- 22(������) �� ���� �����Ͽ� ���� Ÿ������ ��ȯ
     , EXTRACT(YEAR FROM SYSDATE) "COL4"   -- 2022(������)  �� ������ �����Ͽ� ���� Ÿ������ ��ȯ
     , EXTRACT(MONTH FROM SYSDATE) "COL5"   -- 2(������)  �� ���� �����Ͽ� ���� Ÿ������ ��ȯ
     , EXTRACT(DAY FROM SYSDATE) "COL6"   -- 22(������)  �� ���� �����Ͽ� ���� Ÿ������ ��ȯ
FROM DUAL;
--==>> ��,��,�� ���� �׸��� �Ұ�

-- �� TO_CHAR() Ȱ�� �� ���� ���� ǥ�� ����� ��ȯ
SELECT 60000 "COL1"
     , TO_CHAR(60000, '99,999') "COL2"
     , TO_CHAR(60000, '$99,999') "COL3"
     , TO_CHAR(60000, 'L99,999') "COL4"
     , LTRIM(TO_CHAR(60000, 'L99,999')) "COL5"
FROM DUAL;
--> ��ȭ�� ��� ������ �������� ǥ�����̰� �ٸ��� ������
   -- ����Ŭ ������ ������ ���� Ȯ������ ����(LTRIM ����ؼ� �����ָ�����)

-- �� ���� ���� ����
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session��(��) ����Ǿ����ϴ�.

-- �� ���� �ð��� �������� 1�� 2�ð� 3�� 4�� �ĸ� ��ȸ�Ѵ�.

SELECT SYSDATE "���� �ð�"
     , SYSDATE + 1+ (2/24) + (3/(24*60)) + (4/(24*60*60)) "1�� 2�ð� 3�� 4�� ��"
FROM DUAL;
/*
2022-02-22 16:48:22	
2022-02-23 18:51:26
*/

-- �� ���� �ð��� �������� 1�� 2���� 3�� 4�ð� 5�� 6�� �ĸ� ��ȸ�Ѵ�.
-- TO_YMINTERVAL(), TO_DSINTERVAL()

SELECT SYSDATE "����ð�"
     , SYSDATE + TO_YMINTERVAL('01-02') + TO_DSINTERVAL('003 04:05:06')
FROM DUAL;

--------------------------------------------------------------------------------
-- �� CASE ����(���ǹ�, �б⹮)
/*
CASE
WHEN
THEN
ELSE
END
*/
SELECT CASE 5+2 WHEN 4 THEN '5+2=4' ELSE '5+2�� �����' END
FROM DUAL;
--==>> 5+2�� �����

SELECT CASE 5+2 WHEN 7 THEN '5+2=7' ELSE '5+2=6' END
FROM DUAL;
--==>> 5+2=7

SELECT CASE 1+1 WHEN 2 THEN '1+1=2' 
                WHEN 3 THEN '1+1=3'
                WHEN 4 THEN '1+1=4'
                ELSE '������Ⱦ�'
        END "RESULT"
FROM DUAL;
--==>> 1+1=2

SELECT CASE WHEN 5+2=4 THEN '5+2=4'
            WHEN 6-3=2 THEN '6-3=2'
            WHEN 7*1=8 THEN '7*1=8'
            WHEN 6/2=3 THEN '6/2=3'
            ELSE '�𸣰ڳ�'
            END "RESULT"
FROM DUAL;
--==> 6/2=3

-- �� DECODE()

SELECT DECODE(5-2, 1, '5-2=1', 2, '5-2=2', 3, '5-2=3', '5-2�� �����') "RESULT"
FROM DUAL;
--==>> 5-2=3

-- �� CASE WHEN THEN ELSE END Ȱ��
SELECT CASE WHEN 5<2 THEN '5<2'
            WHEN 5>2 THEN '5>2'
            ELSE '5��2�� �񱳺Ұ�'
         END  "RESULT"
FROM DUAL;
--==>> 5>2

SELECT CASE WHEN 5<2 OR 3>1 AND 2=2 THEN '��������'
            WHEN 5>2 OR 2=3 THEN '��������'
            ELSE 'ȣ������'
         END  "RESULT"
FROM DUAL;
--==>> ��������

-- �� ����
SELECT CASE WHEN F OR 3>1 AND 2=2 THEN '��������'
            WHEN 5>2 OR 2=3 THEN '��������'
            ELSE 'ȣ������'
         END  "RESULT"
FROM DUAL;

SELECT CASE WHEN F OR T AND 2=2 THEN '��������'
            WHEN 5>2 OR 2=3 THEN '��������'
            ELSE 'ȣ������'
         END  "RESULT"
FROM DUAL;

SELECT CASE T AND 2=2 THEN '��������'
            WHEN 5>2 OR 2=3 THEN '��������'
            ELSE 'ȣ������'
         END  "RESULT"
FROM DUAL;

SELECT CASE T AND T THEN '��������'
            WHEN 5>2 OR 2=3 THEN '��������'
            ELSE 'ȣ������'
         END  "RESULT"
FROM DUAL;

SELECT CASE T THEN '��������'
            WHEN 5>2 OR 2=3 THEN '��������'
            ELSE 'ȣ������'
         END  "RESULT"
FROM DUAL;
-----------------------------------------------------------
SELECT CASE WHEN 3<1 AND 5<2 OR 3>1 AND 2=2 THEN '��������'
            WHEN 5<2 AND 2=3 THEN '�̻踸��'
            ELSE '��������'
    END "RESULT"
FROM DUAL;
--==>> ��������

SELECT CASE WHEN 3<1 AND (5<2 OR 3>1) AND 2=2 THEN '��������'
            WHEN 5<2 AND 2=3 THEN '�̻踸��'
            ELSE '��������'
    END "RESULT"
FROM DUAL;
--==>> ��������

SELECT *
FROM TBL_SAWON;

-- �� TBL_SAWON ���̺��� Ȱ���Ͽ� ������ ���� �׸���� ��ȸ�� �� �ֵ���
--    �������� �����Ѵ�.
--    �����ȣ, �����, �ֹι�ȣ, ����, �Ի���

SELECT SANO "�����ȣ"
     , SANAME "�����"
     , JUBUN "�ֹι�ȣ"
     , CASE WHEN SUBSTR(JUBUN, 7, 1) = '1' OR SUBSTR(JUBUN, 7, 1) = '3' THEN '����'
            WHEN SUBSTR(JUBUN, 7, 1) = '2' OR SUBSTR(JUBUN, 7, 1) = '4' THEN '����'
            ELSE '�ܰ���'
            END "����"
     , HIREDATE "�Ի���"
FROM TBL_SAWON;




-- ��
-- ��
-- ��









