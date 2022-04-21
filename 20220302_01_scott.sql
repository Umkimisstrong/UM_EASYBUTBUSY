SELECT USER
FROM DUAL;
--==>>SCOTT

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
INSERT INTO TBL_JUMUN VALUES
(9, '포카칩', 20, TO_DATE('2001-11-08 19:42:53', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(10, '포카칩', 20, TO_DATE('2001-11-09 11:12:23', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(11, '고래밥', 50, TO_DATE('2001-11-10 12:12:23', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(12, '고래밥', 40, TO_DATE('2001-11-11 08:09:10', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(13, '홈런볼', 60, TO_DATE('2001-11-12 09:10:11', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(14, '나아쵸', 20, TO_DATE('2001-11-13 10:11:12', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(15, '홈런볼', 70, TO_DATE('2001-11-14 11:12:13', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(16, '홈런볼', 80, TO_DATE('2001-11-15 12:13:14', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(17, '홈런볼', 90, TO_DATE('2001-11-16 13:14:15', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(18, '빼빼로', 10, TO_DATE('2001-11-17 14:15:16', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(19, '빼빼로', 20, TO_DATE('2001-11-19 15:16:17', 'YYYY-MM-DD HH24:MI:SS'));
INSERT INTO TBL_JUMUN VALUES
(20, '빼빼로', 30, TO_DATE('2001-11-20 16:17:18', 'YYYY-MM-DD HH24:MI:SS'));
--==>> 1 행 이(가) 삽입되었습니다. * 20

-- 날짜에 대한 세션 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>>1 행 이(가) 삽입되었습니다.

SELECT *
FROM TBL_JUMUN;
/*
1	빼빼로	20	2001-11-01 09:10:12
2	거언빵	10	2001-11-01 10:20:30
3	모옹쉘	30	2001-11-01 11:10:05
4	눈감자	10	2001-11-02 13:20:11
5	나아쵸	20	2001-11-05 07:30:22
6	홈런볼	70	2001-11-06 15:20:34
7	고래밥	50	2001-11-07 11:10:13
8	포카칩	20	2001-11-07 19:42:53
9	포카칩	20	2001-11-08 19:42:53
10	포카칩	20	2001-11-09 11:12:23
11	고래밥	50	2001-11-10 12:12:23
12	고래밥	40	2001-11-11 08:09:10
13	홈런볼	60	2001-11-12 09:10:11
14	나아쵸	20	2001-11-13 10:11:12
15	홈런볼	70	2001-11-14 11:12:13
16	홈런볼	80	2001-11-15 12:13:14
17	홈런볼	90	2001-11-16 13:14:15
18	빼빼로	10	2001-11-17 14:15:16
19	빼빼로	20	2001-11-19 15:16:17
20	빼빼로	30	2001-11-20 16:17:18
*/

--○ 커밋
COMMIT;
--==>> 커밋 완료.

-- ○ 추가 데이터 입력 → 2001년 부터 시작된 주문이 현재(2022년)까지 계속 발생~!
INSERT INTO TBL_JUMUN VALUES(98764, '고래밥', 10, SYSDATE);
--==>>1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_JUMUN VALUES(98765, '빼빼로', 20, SYSDATE);
--==>>1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_JUMUN VALUES(98766, '맛동산', 30, SYSDATE);
--==>>1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_JUMUN VALUES(98767, '홈런볼', 40, SYSDATE);
--==>>1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_JUMUN VALUES(98768, '오감자', 50, SYSDATE);
--==>>1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_JUMUN VALUES(98769, '웨하스', 30, SYSDATE);
--==>>1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_JUMUN VALUES(98770, '고래밥', 20, SYSDATE);
--==>>1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_JUMUN VALUES(98771, '맛동산', 20, SYSDATE);
--==>>1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_JUMUN VALUES(98772, '웨하스', 20, SYSDATE);
--==>>1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_JUMUN VALUES(98773, '빼빼로', 90, SYSDATE);
--==>>1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_JUMUN VALUES(98774, '에이스', 20, SYSDATE);
--==>>1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_JUMUN VALUES(98775, '꼬북칩', 30, SYSDATE);
--==>>1 행 이(가) 삽입되었습니다.

-- ○ 확인
SELECT *
FROM TBL_JUMUN;
/*
    1	빼빼로	20	2001-11-01 09:10:12
    2	거언빵	10	2001-11-01 10:20:30
    3	모옹쉘	30	2001-11-01 11:10:05
    4	눈감자	10	2001-11-02 13:20:11
    5	나아쵸	20	2001-11-05 07:30:22
    6	홈런볼	70	2001-11-06 15:20:34
    7	고래밥	50	2001-11-07 11:10:13
    8	포카칩	20	2001-11-07 19:42:53
    9	포카칩	20	2001-11-08 19:42:53
   10	포카칩	20	2001-11-09 11:12:23
   11	고래밥	50	2001-11-10 12:12:23
   12	고래밥	40	2001-11-11 08:09:10
   13	홈런볼	60	2001-11-12 09:10:11
   14	나아쵸	20	2001-11-13 10:11:12
   15	홈런볼	70	2001-11-14 11:12:13
   16	홈런볼	80	2001-11-15 12:13:14
   17	홈런볼	90	2001-11-16 13:14:15
   18	빼빼로	10	2001-11-17 14:15:16
   19	빼빼로	20	2001-11-19 15:16:17
   20	빼빼로	30	2001-11-20 16:17:18
98764	고래밥	10	2022-03-02 09:30:02
98765	빼빼로	20	2022-03-02 09:30:31
98766	맛동산	30	2022-03-02 09:31:12
98767	홈런볼	40	2022-03-02 09:31:32
98768	오감자	50	2022-03-02 09:32:21
98769	웨하스	30	2022-03-02 09:32:35
98770	고래밥	20	2022-03-02 09:33:09
98771	맛동산	20	2022-03-02 09:33:54
98772	웨하스	20	2022-03-02 09:34:08
98773	빼빼로	90	2022-03-02 09:34:20
98774	에이스	20	2022-03-02 09:34:43
98775	꼬북칩	30	2022-03-02 09:34:58
*/

-- ○ 커밋
COMMIT;
--==>> 커밋 완료.

-- ※ 상기가 과자 쇼핑몰 운영 중....
-- TBL_JUMUN 테이블이 너무 무거워진 상황
-- 어플리케이션과의 연동으로 인해 주문 내역을 다른 테이블에
-- 저장될 수 있도록 만드는 것은 불가능한 상황
-- 기존의 모든 데이터를 덮어놓고 지우는 것도 불가능한 상황
-- → 결과적으로...
--    현재까지 누적된 주문 데이터들 중
--    금일 발생한 주문 내역을 제외하고
--    나머지 데이터를 다른 테이블(TBL_JUMUNBACKUP)로 데이터 이관을 수행할 계획
CREATE TABLE TBL_JUMUNBACKUP
AS
SELECT *
FROM TBL_JUMUN
WHERE TO_CHAR(JUDAY, 'YYYY-MM-DD') != TO_CHAR(SYSDATE, 'YYYY-MM-DD');
--                                          ---------------------
--                                            2022-03-02
--==>> Table TBL_JUMUNBACKUP이(가) 생성되었습니다.
SELECT *
FROM TBL_JUMUNBACKUP;
/*
1	빼빼로	20	2001-11-01 09:10:12
2	거언빵	10	2001-11-01 10:20:30
3	모옹쉘	30	2001-11-01 11:10:05
4	눈감자	10	2001-11-02 13:20:11
5	나아쵸	20	2001-11-05 07:30:22
6	홈런볼	70	2001-11-06 15:20:34
7	고래밥	50	2001-11-07 11:10:13
8	포카칩	20	2001-11-07 19:42:53
9	포카칩	20	2001-11-08 19:42:53
10	포카칩	20	2001-11-09 11:12:23
11	고래밥	50	2001-11-10 12:12:23
12	고래밥	40	2001-11-11 08:09:10
13	홈런볼	60	2001-11-12 09:10:11
14	나아쵸	20	2001-11-13 10:11:12
15	홈런볼	70	2001-11-14 11:12:13
16	홈런볼	80	2001-11-15 12:13:14
17	홈런볼	90	2001-11-16 13:14:15
18	빼빼로	10	2001-11-17 14:15:16
19	빼빼로	20	2001-11-19 15:16:17
20	빼빼로	30	2001-11-20 16:17:18
*/

--> TBL_JUMUN 테이블의 데이터들 중
--  금일 주문 내역 이외의 데이터는 모두 TBL_JUMUNBACKUP 테이블에
--  백업을 마친 상태

-- TBL_JUMUN 테이블의 데이터들 중
-- 백업을 마친 데이터들 삭제 → 즉, 금일 발생한 주문 내역이 아닌 데이터들 제거


DELETE
FROM TBL_JUMUN
WHERE TO_CHAR(JUDAY, 'YYYY-MM-DD') != TO_CHAR(SYSDATE, 'YYYY-MM-DD');
--==>> 20개 행 이(가) 삭제되었습니다.

SELECT *
FROM TBL_JUMUN;
/*
98764	고래밥	10	2022-03-02 09:30:02
98765	빼빼로	20	2022-03-02 09:30:31
98766	맛동산	30	2022-03-02 09:31:12
98767	홈런볼	40	2022-03-02 09:31:32
98768	오감자	50	2022-03-02 09:32:21
98769	웨하스	30	2022-03-02 09:32:35
98770	고래밥	20	2022-03-02 09:33:09
98771	맛동산	20	2022-03-02 09:33:54
98772	웨하스	20	2022-03-02 09:34:08
98773	빼빼로	90	2022-03-02 09:34:20
98774	에이스	20	2022-03-02 09:34:43
98775	꼬북칩	30	2022-03-02 09:34:58
*/

-- ○ 커밋
COMMIT;
--==>> 커밋 완료.

-- ※ 아직 제품 발송이 이루어지지않은 금일 주문 데이터를 제외하고
--    이전의 모든 주문 데이터들이 삭제된 상황이므로
--    테이블은 행(레코드)의 갯수가 줄어들어 매우 가벼워진 상황이다.

-- ○ UNION 사용.. 나눠진 테이블을 한번에조회하기
SELECT *
FROM TBL_JUMUNBACKUP
UNION
SELECT *
FROM TBL_JUMUN;

-- 그런데, 지금까지 주문받은 내역에 대한 정보를
-- 제품별 총 주문량으로 나타내어야 할 상황이 발생하게 되었다.
-- 그렇다면,TBL_JUMUNBACKUP 테이블의 레코드(행)와
-- TBL_JUMUN 테이블의 레코드(행)을 합쳐서
-- 하나의 테이블을 조회하는 것과 같은 결과를 확인할 수 있도록
-- 조회가 이루어져야 한다.

-- ※ 컬럼과 컬럼의 관계를 고려하여 테이블을 결합하고자 하는 경우
--    JOIN 을 사용하지만
--    레코드와 레코드를 결합하고자 하는 경우
--    UNION / UNION ALL 을 사용할 수 있다.
SELECT *
FROM TBL_JUMUN
UNION
SELECT *
FROM TBL_JUMUNBACKUP;

SELECT *
FROM TBL_JUMUN
UNION ALL
SELECT *
FROM TBL_JUMUNBACKUP;

SELECT *
FROM TBL_JUMUNBACKUP
UNION ALL
SELECT *
FROM TBL_JUMUN;

SELECT *
FROM TBL_JUMUNBACKUP
UNION
SELECT *
FROM TBL_JUMUN;

-- ※ UNION 은 항상 결과물의 첫 번째 컬럼을 기준으로
--    오름차순 정렬을 수행한다.
--    UNION ALL은 결합된 순서대로(테이블을 쿼리문에서 명시한 순서대로)
--    조회한 결과를 반환한다.(즉, 정렬 기능 없음)
--    이로 인해 UNION이 부하가 더 크다.(리소스 소모가 더 크다.)
--    또한, UNION은 결과물에 중복된 행이 존재할 경우
--    중복을 제거하고 1개 행만 조회된 결과를 반환하게 한다.

-- ○ 지금까지 주문받은 데이터를 통해
--    제품별 총 주문량을 조회할 수 있는 쿼리문을 구성한다.
SELECT T.제품명, SUM(T.주문량) "주문량합계"
FROM
(
SELECT JECODE "제품명", SUM(JUSU) "주문량"
FROM TBL_JUMUN
GROUP BY JECODE
UNION ALL
SELECT JECODE "제품명", SUM(JUSU) "주문량"
FROM TBL_JUMUNBACKUP
GROUP BY JECODE
)T
GROUP BY T.제품명
ORDER BY 1,2;
/*
거언빵	10
고래밥	170
꼬북칩	30
나아쵸	40
눈감자	10
맛동산	50
모옹쉘	30
빼빼로	190
에이스	20
오감자	50
웨하스	50
포카칩	60
홈런볼	410
*/

-- ○ 데이터 추가 입력
INSERT INTO TBL_JUMUN VALUES (98776, '모옹쉘', 30, SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.

-- ○ 확인
SELECT *
FROM TBL_JUMUN;
--==>>
/*
98764	고래밥	10	2022-03-02 09:30:02
98765	빼빼로	20	2022-03-02 09:30:31
98766	맛동산	30	2022-03-02 09:31:12
98767	홈런볼	40	2022-03-02 09:31:32
98768	오감자	50	2022-03-02 09:32:21
98769	웨하스	30	2022-03-02 09:32:35
98770	고래밥	20	2022-03-02 09:33:09
98771	맛동산	20	2022-03-02 09:33:54
98772	웨하스	20	2022-03-02 09:34:08
98773	빼빼로	90	2022-03-02 09:34:20
98774	에이스	20	2022-03-02 09:34:43
98775	꼬북칩	30	2022-03-02 09:34:58
98776	모옹쉘	30	2022-03-02 11:28:15
*/

-- ○ 커밋
COMMIT;
--==>> 커밋 완료.

-- ○ INTERSECT / MINUS (→ 교집합과 차집합)

-- TBL_JUMUNBACKUP 테이블과 TBL_JUMUN 테이블에서
-- 제품코드와 주문수량의 값이 똑같은 행만 추출하고자 한다.

SELECT JECODE, JUSU
FROM TBL_JUMUNBACKUP
INTERSECT
SELECT JECODE, JUSU
FROM TBL_JUMUN;
--==>>
/*
모옹쉘	30
빼빼로	20
*/
SELECT *
FROM TBL_JUMUN;

-- ○ TBL_JUMUNBACKUP 테이블과 TBL_JUMUN 테이블을 대상으로
--    제품코드와 주문량의 값이 똑같은 행의 정보를
--    주문번호, 제품코드, 주문량, 주문일자 항목으로 조회한다.

-- ① 인터넷 검색
--    엄청게 난해한 서브상관커리
SELECT S.JUNO, S.JECODE, S.JUSU, S.JUDAY
FROM
(
    SELECT  T.JUNO
          , T.JECODE
          , T.JUSU
          , T.JUDAY
          , (SELECT COUNT(*)
             FROM (SELECT JECODE, JUSU
                   FROM TBL_JUMUNBACKUP
                   INTERSECT
                   SELECT JECODE, JUSU
                   FROM TBL_JUMUN)A
             WHERE T.JECODE = A.JECODE AND T.JUSU = A.JUSU) "SAME_JECODE_JUSU" 
     FROM (SELECT *
           FROM TBL_JUMUNBACKUP
           UNION ALL
           SELECT *
           FROM TBL_JUMUN
          )T
)S
WHERE S.SAME_JECODE_JUSU=1;
/*
    1	빼빼로	20	2001-11-01 09:10:12
    3	모옹쉘	30	2001-11-01 11:10:05
   19	빼빼로	20	2001-11-19 15:16:17
   20	빼빼로	30	2001-11-20 16:17:18
98781	빼빼로	30	2022-03-02 14:13:46
98765	빼빼로	20	2022-03-02 09:30:31
98776	모옹쉘	30	2022-03-02 11:28:15
*/
-- ② 간단한 EQUI JOIN 
--    인터섹트와 유니온을 조인시키기
SELECT T1.JUNO "제품번호", T1.JECODE "제품코드", T1.JUSU "주문수량", T1.JUDAY "주문일자"
FROM 
(SELECT JUNO, JECODE, JUSU, JUDAY
 FROM TBL_JUMUNBACKUP
 UNION ALL
 SELECT JUNO, JECODE, JUSU, JUDAY
 FROM TBL_JUMUN
) T1 
 JOIN
(SELECT JECODE, JUSU
 FROM TBL_JUMUNBACKUP
 INTERSECT
 SELECT JECODE, JUSU
 FROM TBL_JUMUN
) T2
ON T1.JECODE = T2.JECODE AND T1.JUSU = T2.JUSU;
/*
    1	빼빼로	20	2001-11-01 09:10:12
    3	모옹쉘	30	2001-11-01 11:10:05
   19	빼빼로	20	2001-11-19 15:16:17
   20	빼빼로	30	2001-11-20 16:17:18
98781	빼빼로	30	2022-03-02 14:13:46
98765	빼빼로	20	2022-03-02 09:30:31
98776	모옹쉘	30	2022-03-02 11:28:15
*/
-- ③ WHERE 절을 이용한 조건식 조회
--    2개의 컬럼을 묶어 CONCAT으로 확인하면
--    가능.. 여러개는 아마 CONCAT(CONCAT 해야할듯)
SELECT *
FROM 
(
 SELECT JUNO, JECODE, JUSU, JUDAY
 FROM TBL_JUMUNBACKUP
 UNION ALL
 SELECT JUNO, JECODE, JUSU, JUDAY
 FROM TBL_JUMUN
)T
WHERE CONCAT(JECODE, JUSU) = ANY 
                             (
                              SELECT CONCAT(JECODE, JUSU)
                              FROM TBL_JUMUNBACKUP
                              INTERSECT
                              SELECT CONCAT(JECODE, JUSU)
                              FROM TBL_JUMUN
                             );
/*
    1	빼빼로	20	2001-11-01 09:10:12
    3	모옹쉘	30	2001-11-01 11:10:05
   19	빼빼로	20	2001-11-19 15:16:17
   20	빼빼로	30	2001-11-20 16:17:18
98781	빼빼로	30	2022-03-02 14:13:46
98765	빼빼로	20	2022-03-02 09:30:31
98776	모옹쉘	30	2022-03-02 11:28:15
*/                             


-- ○ 데이터 추가 입력
INSERT INTO TBL_JUMUN VALUES(98777, '모옹쉘', 10, SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_JUMUN VALUES(98778, '빼배로', 40, SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_JUMUN VALUES(98779, '맛동산', 20, SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_JUMUN VALUES(98780, '모옹쉘', 20, SYSDATE);
--==>> 1 행 이(가) 삽입되었습니다.
INSERT INTO TBL_JUMUN VALUES(98781, '빼빼로', 30, SYSDATE);

-- ○ 확인
SELECT *
FROM TBL_JUMUN;
/*
98777	모옹쉘	10	2022-03-02 14:08:11
98778	빼배로	40	2022-03-02 14:08:48
98779	맛동산	20	2022-03-02 14:09:15
98780	모옹쉘	20	2022-03-02 14:13:46
98781	빼빼로	30	2022-03-02 14:13:46
98764	고래밥	10	2022-03-02 09:30:02
98765	빼빼로	20	2022-03-02 09:30:31
98766	맛동산	30	2022-03-02 09:31:12
98767	홈런볼	40	2022-03-02 09:31:32
98768	오감자	50	2022-03-02 09:32:21
98769	웨하스	30	2022-03-02 09:32:35
98770	고래밥	20	2022-03-02 09:33:09
98771	맛동산	20	2022-03-02 09:33:54
98772	웨하스	20	2022-03-02 09:34:08
98773	빼빼로	90	2022-03-02 09:34:20
98774	에이스	20	2022-03-02 09:34:43
98775	꼬북칩	30	2022-03-02 09:34:58
98776	모옹쉘	30	2022-03-02 11:28:15
*/

-- ○ 커밋
COMMIT;
--==>> 커밋 완료.

SELECT *
FROM 
(
 SELECT JUNO, JECODE, JUSU, JUDAY
 FROM TBL_JUMUNBACKUP
 UNION ALL
 SELECT JUNO, JECODE, JUSU, JUDAY
 FROM TBL_JUMUN
)T
WHERE JECODE IN('모옹쉘', '빼빼로')
      AND JUSU IN(20, 30);

--------------------------------------------------------------------------------
-- ♧ TBL_JUMUN_scott 파일을 통해 데이터 갱신 ♣ --
--------------------------------------------------------------------------------

-- ○ INTERSECT 확인
SELECT JECODE, JUSU
FROM TBL_JUMUN
INTERSECT
SELECT JECODE, JUSU
FROM TBL_JUMUNBACKUP;
/*
모옹쉘	30
빼빼로	20
빼빼로	30
*/

-- 방법 1. JOIN하기

SELECT T1.JUNO "제품번호", T1.JECODE "제품코드", T1.JUSU "주문수량", T1.JUDAY "주문일자"
FROM 
(SELECT JUNO, JECODE, JUSU, JUDAY
 FROM TBL_JUMUNBACKUP
 UNION ALL
 SELECT JUNO, JECODE, JUSU, JUDAY
 FROM TBL_JUMUN
) T1 
 JOIN
(SELECT JECODE, JUSU
 FROM TBL_JUMUNBACKUP
 INTERSECT
 SELECT JECODE, JUSU
 FROM TBL_JUMUN
) T2
ON T1.JECODE = T2.JECODE AND T1.JUSU = T2.JUSU;
/*
    1	빼빼로	20	2001-11-01 09:10:12
    3	모옹쉘	30	2001-11-01 11:10:05
   19	빼빼로	20	2001-11-19 15:16:17
   20	빼빼로	30	2001-11-20 16:17:18
98781	빼빼로	30	2022-03-02 14:13:47
98765	빼빼로	20	2022-03-02 09:30:30
98776	모옹쉘	30	2022-03-02 11:28:12
*/

-- 방법 2. WHERE 절 이용
SELECT *
FROM 
(
 SELECT JUNO, JECODE, JUSU, JUDAY
 FROM TBL_JUMUNBACKUP
 UNION ALL
 SELECT JUNO, JECODE, JUSU, JUDAY
 FROM TBL_JUMUN
)T
WHERE CONCAT (T.JECODE, T.JUSU) IN ('모옹쉘30', '빼빼로20', '빼빼로30');
/*
    1	빼빼로	20	2001-11-01 09:10:12
    3	모옹쉘	30	2001-11-01 11:10:05
   19	빼빼로	20	2001-11-19 15:16:17
   20	빼빼로	30	2001-11-20 16:17:18
98780	모옹쉘	20	2022-03-02 14:13:43 ◀ CHECK ~!! 왜 나왔을까? 교집합이아닌데
98781	빼빼로	30	2022-03-02 14:13:47
98765	빼빼로	20	2022-03-02 09:30:30
98776	모옹쉘	30	2022-03-02 11:28:12
*/

-- ↓↓↓↓
/*
    1	빼빼로	20	2001-11-01 09:10:12
    3	모옹쉘	30	2001-11-01 11:10:05
   19	빼빼로	20	2001-11-19 15:16:17
   20	빼빼로	30	2001-11-20 16:17:18
98781	빼빼로	30	2022-03-02 14:13:47
98765	빼빼로	20	2022-03-02 09:30:30
98776	모옹쉘	30	2022-03-02 11:28:12
*/
-- ↓↓↓↓↓
SELECT *
FROM 
(
 SELECT JUNO, JECODE, JUSU, JUDAY
 FROM TBL_JUMUNBACKUP
 UNION ALL
 SELECT JUNO, JECODE, JUSU, JUDAY
 FROM TBL_JUMUN
)T
WHERE CONCAT (T.JECODE, T.JUSU) 
      IN ( 
            SELECT CONCAT(JECODE, JUSU) 
            FROM TBL_JUMUN
            INTERSECT
            SELECT CONCAT(JECODE, JUSU)
            FROM TBL_JUMUNBACKUP          
         );
/*
    1	빼빼로	20	2001-11-01 09:10:12
    3	모옹쉘	30	2001-11-01 11:10:05
   19	빼빼로	20	2001-11-19 15:16:17
   20	빼빼로	30	2001-11-20 16:17:18
98781	빼빼로	30	2022-03-02 14:13:47
98765	빼빼로	20	2022-03-02 09:30:30
98776	모옹쉘	30	2022-03-02 11:28:12
*/

--------------------------------------------------------------------------------


--- ○ TBL_EMP 테이블에서 급여가 가장 많은 사원의
---   사원번호, 사원명, 직종명, 급여 항목을 조회하는 쿼리문을 작성한다.
SELECT *
FROM
(
SELECT EMPNO, ENAME, JOB, SAL + NVL(COMM, 0) "급여"
FROM TBL_EMP
)T
WHERE T.급여 = ( SELECT MAX(SAL+NVL(COMM, 0))
                 FROM TBL_EMP
               );
--==>> 7839	KING	PRESIDENT	5000

SELECT *
FROM
(
SELECT EMPNO, ENAME, JOB, SAL + NVL(COMM, 0) "급여"
FROM TBL_EMP
)T
WHERE T.급여 >= ALL(800, 1600, 1250, 2975, 1250, 2850, 2450, 3000, 5000
                    , 950, 3000, 1300, 1500, 2000, 1700, 2500, 1000);
--==>> 7839	KING	PRESIDENT	5000

SELECT *
FROM
(
SELECT EMPNO, ENAME, JOB, SAL + NVL(COMM, 0) "급여"
FROM TBL_EMP
)T
WHERE T.급여 >= ALL(SELECT  SAL+(NVL(COMM, 0))
                    FROM TBL_EMP);
--==>>  7839	KING	PRESIDENT	5000          


-- ○ TBL_EMP 테이블에서 20번 부서에근무하는 사원 중
--    급여가 가장 많은 사원의
--    사원번호, 사원명, 직종명, 급여 항목을 조회하는 쿼리문을 구성한다.

SELECT EMPNO 사원번호, ENAME 사원명, JOB 직종명, SAL 급여
FROM TBL_EMP
WHERE DEPTNO = 20 AND SAL >= ALL( SELECT SAL
                                  FROM TBL_EMP
                                  WHERE DEPTNO = 20);
/*
7902	FORD	ANALYST	3000
7788	SCOTT	ANALYST	3000
*/

-- ○  TBL_EMP 테이블에서 수당(커미션:COMM) 이 가장 많은 사원의
--     사원번호, 사원명, 부서번호, 직종명, 커미션 항목을 조회한다.

SELECT EMPNO "사원번호"
     , ENAME "사원명", DEPTNO "부서번호"
     , JOB "직종명", NVL(COMM, 0) "커미션"
FROM TBL_EMP
WHERE NVL(COMM, 0) > = ( SELECT MAX(NVL(COMM, 0))
                         FROM TBL_EMP);
--==>> 7654	MARTIN	30	SALESMAN	1400                         

SELECT EMPNO "사원번호"
     , ENAME "사원명", DEPTNO "부서번호"
     , JOB "직종명", NVL(COMM, 0) "커미션"
FROM TBL_EMP
WHERE NVL(COMM, 0) > = ALL( SELECT (NVL(COMM, 0))
                            FROM TBL_EMP);
--==>> 7654	MARTIN	30	SALESMAN	1400   
-- ※ 참고 : NULL 이 연산에 포함되면 비교 데이터 안뜬다.
                            
SELECT EMPNO "사원번호"
     , ENAME "사원명", DEPTNO "부서번호"
     , JOB "직종명", NVL(COMM, 0) "커미션"
FROM TBL_EMP
WHERE COMM >= ALL(SELECT COMM
                  FROM TBL_EMP
                  WHERE COMM IS NOT NULL)
--==>> 7654	MARTIN	30	SALESMAN	1400                

-- ○ DISTINCT() 중복 행(레코드)을 제거하는 함수
SELECT EMPNO, ENAME, JOB
FROM EMP
WHERE EMPNO = (관리자로 등록된 번호);

SELECT EMPNO, ENAME, JOB
FROM EMP
WHERE EMPNO IN (SELECT MGR
               FROM EMP);
               
SELECT EMPNO, ENAME, JOB
FROM EMP
WHERE EMPNO IN (7902, 7698, 7698, 7839, 7698, 7839, 
                7839, 7566, null, 7698, 7788, 7698, 7566, 7782);               
               
SELECT EMPNO, ENAME, JOB
FROM EMP
WHERE EMPNO IN (SELECT DISTINCT(MGR)
                FROM EMP);      
/*
7566	JONES	MANAGER
7698	BLAKE	MANAGER
7782	CLARK	MANAGER
7788	SCOTT	ANALYST
7839	KING	PRESIDENT
7902	FORD	ANALYST
*/          

SELECT DISTINCT(JOB)
FROM EMP;
/*
CLERK
SALESMAN
PRESIDENT
MANAGER
ANALYST
*/    
--------------------------------------------------------------------------------
-- ※ JOIN 추가 → NATURAL JOIN
SELECT D.DEPTNO, D.DNAME, E.ENAME, E.SAL
FROM EMP E JOIN DEPT D
ON E.DEPTNO = D.DEPTNO;
/*
10	ACCOUNTING	CLARK	2450
10	ACCOUNTING	KING	5000
10	ACCOUNTING	MILLER	1300
20	RESEARCH	JONES	2975
20	RESEARCH	FORD	3000
20	RESEARCH	ADAMS	1100
20	RESEARCH	SMITH	800
20	RESEARCH	SCOTT	3000
30	SALES	    WARD	1250
30	SALES	    TURNER	1500
30	SALES   	ALLEN	1600
30	SALES	    JAMES	950
30	SALES	    BLAKE	2850
30	SALES	    MARTIN	1250
*/

SELECT DEPTNO, DNAME, ENAME, SAL
FROM EMP JOIN DEPT;
--==>> 에러 발생
--     ORA-00905: missing keyword  

SELECT DEPTNO, DNAME, ENAME, SAL
FROM EMP NATURAL JOIN DEPT;
/*
10	ACCOUNTING	CLARK	2450
10	ACCOUNTING	KING	5000
10	ACCOUNTING	MILLER	1300
20	RESEARCH	JONES	2975
20	RESEARCH	FORD	3000
20	RESEARCH	ADAMS	1100
20	RESEARCH	SMITH	800
20	RESEARCH	SCOTT	3000
30	SALES	    WARD	1250
30	SALES	    TURNER	1500
30	SALES	    ALLEN	1600
30	SALES	    JAMES	950
30	SALES	    BLAKE	2850
30	SALES	    MARTIN	1250
*/

SELECT DEPTNO, DNAME, ENAME, SAL
FROM EMP JOIN DEPT
USING(DEPTNO);
/*
10	ACCOUNTING	CLARK	2450
10	ACCOUNTING	KING	5000
10	ACCOUNTING	MILLER	1300
20	RESEARCH	JONES	2975
20	RESEARCH	FORD	3000
20	RESEARCH	ADAMS	1100
20	RESEARCH	SMITH	800
20	RESEARCH	SCOTT	3000
30	SALES	    WARD	1250
30	SALES	    TURNER	1500
30	SALES	    ALLEN	1600
30	SALES	    JAMES	950
30	SALES	    BLAKE	2850
30	SALES	    MARTIN	1250
*/

-- ○ 날짜에 대한 세션 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session이(가) 변경되었습니다.

-- ○ TBL_SAWON 테이블 백업(데이터 위주) → 각 테이블 간의 관계나 제약조건 등은 제외
CREATE TABLE TBL_SAWONBACKUP
AS
SELECT SANO, SANAME, JUBUN, HIREDATE, SAL
FROM TBL_SAWON;
--==>> Table TBL_SAWONBACKUP이(가) 생성되었습니다.
/*
1017	이호석	9611121234567	2022-02-23	5000
1018	신시은	9910312234567	2022-02-23	6000
1001	김민성	9707251234567	2005-01-03	3000
1002	서민지	9505152234567	1999-11-23	4000
1003	이지연	9905192234567	2006-08-10	3000
1004	이연주	9508162234567	2007-10-10	4000
1005	오이삭	9805161234567	2007-10-10	4000
1006	이현이	8005132234567	1999-10-10	1000
1007	박한이	0204053234567	2010-10-10	1000
1008	선동렬	6803171234567	1998-10-10	1500
1009	선우용녀6912232234567	1998-10-10	1300
1010	선우선	0303044234567	2010-10-10	1600
1011	남주혁	0506073234567	2012-10-10	2600
1012	남궁민	0208073234567	2012-10-10	2600
1013	남진	6712121234567	1998-10-10	2200
1014	홍수민	0005044234567	2015-10-10	5200
1015	임소민	9711232234567	2007-10-10	5500
1016	이이경	0603194234567	2015-01-20	1500
*/

-- ○  데이터 활용.. 관리.. 여러 형태로 운용..
-- ○  데이터 수정

-- 데이터 복원 (UPDATE) → 불완전 복구
