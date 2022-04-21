SELECT USER
FROM DUAL;
--==>> SCOTT


-- ���� UNION / UNION ALL ���� --

-- �� �ǽ� ���̺� ����(TBL_JUMUN)
CREATE TABLE TBL_JUMUN
( JUNO      NUMBER                  -- �ֹ���ȣ
, JECODE    VARCHAR2(30)            -- �ֹ��� ��ǰ �ڵ�
, JUSU      NUMBER                  -- �ֹ�����
, JUDAY     DATE DEFAULT SYSDATE    -- �ֹ�����
);
--==>> Table TBL_JUMUN��(��) �����Ǿ����ϴ�.
-->   ���� �ֹ��� �߻�(����)�Ǿ��� ���
--    �ֹ� ���뿡 ���� �����Ͱ� �Էµ� �� �ִ� ���̺�

-- �� ������ �Է� �� ���� �ֹ� �߻�(����)
INSERT INTO TBL_JUMUN VALUES
(1, '������', 20, TO_DATE('2001-11-01 09:10:12', 'YYYY-MM-DD HH24:MI:SS'));
--==>> ���� ���� �� ������


INSERT INTO TBL_JUMUN VALUES
(2, '�ž�', 10, TO_DATE('2001-11-01 10:20:30', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(3, '��˽�', 30, TO_DATE('2001-11-01 11:10:05', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(4, '������', 10, TO_DATE('2001-11-02 13:20:11', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(5, '������', 20, TO_DATE('2001-11-05 07:30:22', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(6, 'Ȩ����', 70, TO_DATE('2001-11-06 15:20:34', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(7, '����', 50, TO_DATE('2001-11-07 11:10:13', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(8, '��īĨ', 20, TO_DATE('2001-11-07 19:42:53', 'YYYY-MM-DD HH24:MI:SS'));

