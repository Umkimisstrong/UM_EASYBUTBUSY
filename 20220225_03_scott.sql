SELECT USER
FROM DUAL;
--==>> SCOTT


-- ■■■ UNION / UNION ALL ■■■ --

-- ○ 실습 테이블 생성(TBL_JUMUN)
CREATE TABLE TBL_JUMUN
( JUNO      NUMBER                  -- 주문번호
, JECODE    VARCHAR2(30)            -- 주문된 제품 코드
, JUSU      NUMBER                  -- 주문수량
, JUDAY     DATE DEFAULT SYSDATE    -- 주문일자
);
--==>> Table TBL_JUMUN이(가) 생성되었습니다.
-->   고객의 주문이 발생(접수)되었을 경우
--    주문 내용에 대한 데이터가 입력될 수 있는 테이블

-- ○ 데이터 입력 → 고객의 주문 발생(접수)
INSERT INTO TBL_JUMUN VALUES
(1, '빼빼로', 20, TO_DATE('2001-11-01 09:10:12', 'YYYY-MM-DD HH24:MI:SS'));
--==>> 내가 먼저 행 삽입함


INSERT INTO TBL_JUMUN VALUES
(2, '거언빵', 10, TO_DATE('2001-11-01 10:20:30', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(3, '모옹쉘', 30, TO_DATE('2001-11-01 11:10:05', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(4, '눈감자', 10, TO_DATE('2001-11-02 13:20:11', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(5, '나아쵸', 20, TO_DATE('2001-11-05 07:30:22', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(6, '홈런볼', 70, TO_DATE('2001-11-06 15:20:34', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(7, '고래밥', 50, TO_DATE('2001-11-07 11:10:13', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(8, '포카칩', 20, TO_DATE('2001-11-07 19:42:53', 'YYYY-MM-DD HH24:MI:SS'));

