SELECT USER
FROM DUAL;
--==>> SCOTT

SELECT *
FROM TBL_상품;
/*
H001	바밤바	600	    30
H002	죠스바	500	    20
H003	메로나	500	    30
H004	보석바	600	    70
H005	쌍쌍바	600	    0
H006	수박바	500	    0
H007	빠삐코	500	    0
C001	월드콘	1600	50
C002	빵빠레	1700	10
C003	구구콘	1800	0
C004	메타콘	1500	0
C005	부라보	1500	0
C006	슈퍼콘	1500	0
E001	빵또아	1100	0
E002	셀렉션	1700	0
E003	투게더	2500	0
E004	거북알	1500	0
E005	팥빙수	1500	0
*/
SELECT *
FROM TBL_출고;
/*
1	H001	2022-03-11	20	 600
2	H002	2022-03-11	 5	 500
3	H003	2022-03-11	 5	 500
4	H004	2022-03-11	 5	 600
5	C001	2022-03-11	10	1600
6	C002	2022-03-11	10	1600
*/

-- ○ 생성한 프로시저가 제대로 작동하는지의 여부 확인 → 프로시저 호출
EXEC PRC_출고_UPDATE(6, 20);
--==>> PL/SQL 프로시저가 성공적으로 완료되었습니다.

-- ○ 프로시저 호출 이후 테이블 조회(확인)
SELECT *
FROM TBL_출고;
/*
1	H001	2022-03-11	20	600
2	H002	2022-03-11	5	500
3	H003	2022-03-11	5	500
4	H004	2022-03-11	5	600
5	C001	2022-03-11	10	1600
6	C002	2022-03-11	20	1600    ◀ CHECK ~!!!
*/

SELECT *
FROM TBL_상품;
/*
H001	바밤바	600	    30
H002	죠스바	500	    20
H003	메로나	500	    30
H004	보석바	600	    70
H005	쌍쌍바	600	    0
H006	수박바	500	    0
H007	빠삐코	500	    0
C001	월드콘	1600	50
C002	빵빠레	1700	0       ◀ CHECK~!!!
C003	구구콘	1800	0
C004	메타콘	1500	0
C005	부라보	1500	0
C006	슈퍼콘	1500	0
E001	빵또아	1100	0
E002	셀렉션	1700	0
E003	투게더	2500	0
E004	거북알	1500	0
E005	팥빙수	1500	0
*/

-- ○ 생성한 프로시저가 제대로 작동하는지의 여부 확인 → 프로시저 호출
EXEC PRC_출고_UPDATE(5, 70);
--==>> 에러 발생
--     ORA-20002: 재고부족

-- ○ 프로시저 호출 이후 테이블 조회(확인)
SELECT *
FROM TBL_출고;
/*
1	H001	2022-03-11	20	600
2	H002	2022-03-11	5	500
3	H003	2022-03-11	5	500
4	H004	2022-03-11	5	600
5	C001	2022-03-11	10	1600    ◀ CHECK~!! (변화 X)
6	C002	2022-03-11	20	1600
*/

SELECT *
FROM TBL_상품;
/*
H001	바밤바	600	    30
H002	죠스바	500	    20
H003	메로나	500	    30
H004	보석바	600	    70
H005	쌍쌍바	600	    0
H006	수박바	500	    0
H007	빠삐코	500	    0
C001	월드콘	1600	50  ◀ CHECK~!! 변화 X
C002	빵빠레	1700	0
C003	구구콘	1800	0
C004	메타콘	1500	0
C005	부라보	1500	0
C006	슈퍼콘	1500	0
E001	빵또아	1100	0
E002	셀렉션	1700	0
E003	투게더	2500	0
E004	거북알	1500	0
E005	팥빙수	1500	0
*/

SELECT *
FROM TBL_입고;

SELECT *
FROM TBL_출고;

SELECT *
FROM TBL_상품;

EXEC PRC_입고_UPDATE(3, 1);

EXEC PRC_출고_DELETE(3);
EXEC PRC_입고_DELETE(3);


SELECT  *
FROM TBL_INSA;


-- ■■■ AFTER STATEMENT TRIGGER 상황 실습 ■■■ --
-- ※ DML 작업에 대한 이벤트 기록

-- ○ 실습을 위한 준비 → 테이블 생성
CREATE TABLE TBL_TEST1
( ID    NUMBER
, NAME  VARCHAR2(30)
, TEL   VARCHAR2(60)
, CONSTRAINT TEST1_ID_PK PRIMARY KEY(ID)
);
--==>> Table TBL_TEST1이(가) 생성되었습니다.

-- ○ 실습을 위한 준비 → 테이블 생성
CREATE TABLE TBL_EVENTLOG
( MEMO  VARCHAR2(200)
, ILJA  DATE DEFAULT SYSDATE
);
--==>> Table TBL_EVENTLOG이(가) 생성되었습니다.

SELECT *
FROM TBL_TEST1;

SELECT *
FROM TBL_EVENTLOG;
--==>> 조회 결과 없음

-- ○ 생성한 TRIGGER 작동 여부 확인
--    → TBL_TEST1 테이블을 대상으로 INSERT, UPDATE, DELETE 수행
INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(1, '홍은혜', '010-1111-1111');
--==>> 1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(2, '이호석', '010-2222-2222');
--==>> 1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(3, '임소민', '010-3333-3333');
--==>> 1 행 이(가) 삽입되었습니다.

-- ■■■ AFTER STATEMENT TRIGGER 상황 실습 ■■■ --
-- ※ DML 작업에 대한 이벤트 기록

UPDATE TBL_TEST1
SET NAME = '임대민'
WHERE ID = 3;
--==>> 1 행 이(가) 업데이트되었습니다.

UPDATE TBL_TEST1
SET NAME = '임중민'
WHERE ID = 3;
--==>> 1 행 이(가) 업데이트되었습니다.

DELETE
FROM TBL_TEST1
WHERE ID = 1;
--==>> 1 행 이(가) 삭제되었습니다.

DELETE
FROM TBL_TEST1
WHERE ID = 2;
--==>> 1 행 이(가) 삭제되었습니다.

DELETE
FROM TBL_TEST1
WHERE ID = 3;
--==>> 1 행 이(가) 삭제되었습니다.

-- 커밋
COMMIT;
--==>> 커밋 완료.

-- ○ 확인
SELECT *
FROM TBL_TEST1;
--==>> 조회 결과 없음.

SELECT *
FROM TBL_EVENTLOG;
/*
INSERT 쿼리가 실행되었습니다.	2022-03-14
INSERT 쿼리가 실행되었습니다.	2022-03-14
INSERT 쿼리가 실행되었습니다.	2022-03-14
UPDATE 쿼리가 실행되었습니다.	2022-03-14
UPDATE 쿼리가 실행되었습니다.	2022-03-14
DELETE 쿼리가 실행되었습니다.	2022-03-14
DELETE 쿼리가 실행되었습니다.	2022-03-14
DELETE 쿼리가 실행되었습니다.	2022-03-14
*/

-- ■■■ BEFORE STATEMENT TRIGGER 상황 실습 ■■■ --
-- ※ DML 작업 수행 전에 작업에 대한 가능 여부 확인
INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(4, '한충희', '010-4444-4444');
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(5, '최선하', '010-5555-5555');
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(6, '정은정', '010-6666-6666');
--==>> 1 행 이(가) 삽입되었습니다.

UPDATE TBL_TEST1
SET NAME = '정금정'
WHERE ID = 6;
--==>> 1 행 이(가) 업데이트되었습니다.

DELETE
FROM TBL_TEST1
WHERE ID = 5;
--==>> 1 행 이(가) 삭제되었습니다.

SELECT *
FROM TBL_EVENTLOG;


-----------------------------------오라클 서버의 시스템 시간 변경
-- 16:14 → 19:14
INSERT INTO TBL_TEST1(ID, NAME, TEL)
VALUES(7, '이연주', '010-7777-7777');
--==>> 에러 발생
-- ORA-20003: 작업은 09:00 ~ 18:00 까지만 가능합니다.

UPDATE TBL_TEST1
SET NAME = '정은정'
WHERE ID = 6;
--==>> 에러 발생
-- ORA-20003: 작업은 09:00 ~ 18:00 까지만 가능합니다.

DELETE
FROM TBL_TEST1
WHERE ID = 4;
--==>> 에러 발생
-- ORA-20003: 작업은 09:00 ~ 18:00 까지만 가능합니다.

-- ■■■ BEFORE ROW TRIGGER 상황 실습 ■■■ --
-- ※ 참조 관계가 설정된 데이터(자식) 삭제를 먼저 수행하는 모델

-- ○ 실습 환경 구성을 위한 테이블 생성 → TBL_TEST2
CREATE TABLE TBL_TEST2
( CODE NUMBER
, NAME VARCHAR2(40)
, CONSTRAINT TEST2_CODE_PK PRIMARY KEY(CODE)
);
--==>> Table TBL_TEST2이(가) 생성되었습니다.


-- ○ 실습 환경 구성을 위한 테이블 생성 → TBL_TEST3
CREATE TABLE TBL_TEST3
( SID   NUMBER
, CODE  NUMBER
, SU    NUMBER
, CONSTRAINT TEST3_SID_PK PRIMARY KEY(SID)
, CONSTRAINT TEST3_CODE_FK FOREIGN KEY(CODE)
                            REFERENCES TBL_TEST2(CODE)
);
--==>> Table TBL_TEST3이(가) 생성되었습니다.

-- ○ 실습 관련 데이터 입력
INSERT INTO TBL_TEST2(CODE, NAME) VALUES(1, '텔레비전');
INSERT INTO TBL_TEST2(CODE, NAME) VALUES(2, '냉장고');
INSERT INTO TBL_TEST2(CODE, NAME) VALUES(3, '세탁기');
INSERT INTO TBL_TEST2(CODE, NAME) VALUES(4, '건조기');
--==>>1 행 이(가) 삽입되었습니다. * 4

SELECT *
FROM TBL_TEST2;
/*
1	텔레비전
2	냉장고
3	세탁기
4	건조기
*/

COMMIT;
--==>> 커밋 완료.

-- ○ 실습 관련 데이터 입력
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(1, 1, 30);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(2, 1, 50);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(3, 1, 60);

INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(4, 1, 30);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(5, 2, 20);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(6, 3, 30);

INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(7, 2, 30);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(8, 2, 20);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(9, 2, 30);

INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(10, 3, 30);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(11, 3, 20);
INSERT INTO TBL_TEST3(SID, CODE, SU) VALUES(12, 3, 30);
--==>>  1 행 이(가) 삽입되었습니다. * 12

SELECT *
FROM TBL_TEST3;
/*
1	1	30
2	1	50
3	1	60
4	1	30
5	2	20
6	3	30
7	2	30
8	2	20
9	2	30
10	3	30
11	3	20
12	3	30
*/

-- ○ 부모테이블(TBL_TEST2)의 데이터 삭제 시도
DELETE
FROM TBL_TEST2
WHERE CODE = 1;
--==>> 에러 발생
-- ORA-02292: integrity constraint (SCOTT.TEST3_CODE_FK) violated - child record found

DELETE
FROM TBL_TEST2
WHERE CODE = 2;
--==>> 에러 발생
-- ORA-02292: integrity constraint (SCOTT.TEST3_CODE_FK) violated - child record found

DELETE
FROM TBL_TEST2
WHERE CODE = 3;
--==>> 에러 발생
-- ORA-02292: integrity constraint (SCOTT.TEST3_CODE_FK) violated - child record found

DELETE
FROM TBL_TEST2
WHERE CODE = 4;
--==>> 1 행 이(가) 삭제되었습니다.

-- ○ TRIGGER(트리거) 생성 이후 실습

SELECT *
FROM TBL_TEST2;
--==>> 
/*
1	텔레비전
2	냉장고
3	세탁기
*/

SELECT *
FROM TBL_TEST3;
/*
1	1	30
2	1	50
3	1	60
4	1	30
5	2	20  ◀ 냉장고
6	3	30
7	2	30  ◀ 냉장고
8	2	20  ◀ 냉장고
9	2	30  ◀ 냉장고
10	3	30
11	3	20 
12	3	30
*/

DELETE
FROM TBL_TEST2
WHERE CODE = 2;
--==>> 1 행 이(가) 삭제되었습니다.

SELECT *
FROM TBL_TEST2;
/*
1	텔레비전
3	세탁기
*/
-- ↕ 냉장고 없어짐
SELECT *
FROM TBL_TEST3;
/*
1	1	30
2	1	50
3	1	60
4	1	30
6	3	30
10	3	30
11	3	20
12	3	30
*/

 -- ※ UPDATE 의 특징
 -- UPDATE 는 사실 DELETE - INSERT 이다.
 
--------------------------------------------------------------------------------
-- ■■■ AFTER ROW TRIGGER 상황 실습 ■■■ --
-- ※ 참조테이블 관련 트랜잭션 처리 

UPDATE TBL_상품
SET 재고수량 = 0;
--==>> 18개 행 이(가) 업데이트되었습니다.

TRUNCATE TABLE TBL_입고;
--==>> Table TBL_입고이(가) 잘렸습니다.

TRUNCATE TABLE TBL_출고;
--==>> Table TBL_출고이(가) 잘렸습니다.

SELECT *
FROM TBL_상품;
/*
H001	바밤바	600	    0
H002	죠스바	500	    0
H003	메로나	500	    0
H004	보석바	600	    0
H005	쌍쌍바	600	    0
H006	수박바	500	    0
H007	빠삐코	500	    0
C001	월드콘	1600	0
C002	빵빠레	1700	0
C003	구구콘	1800	0
C004	메타콘	1500	0
C005	부라보	1500	0
C006	슈퍼콘	1500	0
E001	빵또아	1100	0
E002	셀렉션	1700	0
E003	투게더	2500	0
E004	거북알	1500	0
E005	팥빙수	1500	0
*/

SELECT *
FROM TBL_입고;
--==>> 조회 결과 없음.
SELECT *
FROM TBL_출고;
--==>> 조회 결과 없음.

-- ○ 트리거 (TRIGGER) 생성 이후 실습 테스트
INSERT INTO TBL_입고(입고번호, 상품코드, 입고일자, 입고수량, 입고단가)
VALUES(1, 'H001', SYSDATE, 40, 1000);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_입고(입고번호, 상품코드, 입고일자, 입고수량, 입고단가)
VALUES(2, 'H001', SYSDATE, 60, 1000);
--==>> 1 행 이(가) 삽입되었습니다.

INSERT INTO TBL_입고(입고번호, 상품코드, 입고일자, 입고수량, 입고단가)
VALUES(3, 'H002', SYSDATE, 50, 1000);
--==>> 1 행 이(가) 삽입되었습니다.

SELECT *
FROM TBL_입고;
/*
1	H001	2022-03-14	40	1000        ◀ 바밤바 40
2	H001	2022-03-14	60	1000        ◀ 바밤바 60
3	H002	2022-03-14	50	1000        ◀ 죠스바 50
*/

SELECT *
FROM TBL_상품;
/*
H001	바밤바	600	    100
H002	죠스바	500	    50
H003	메로나	500	    0
H004	보석바	600	    0
H005	쌍쌍바	600	    0
H006	수박바	500	    0
H007	빠삐코	500	    0
C001	월드콘	1600	0
C002	빵빠레	1700	0
C003	구구콘	1800	0
C004	메타콘	1500	0
C005	부라보	1500	0
C006	슈퍼콘	1500	0
E001	빵또아	1100	0
E002	셀렉션	1700	0
E003	투게더	2500	0
E004	거북알	1500	0
E005	팥빙수	1500	0
*/