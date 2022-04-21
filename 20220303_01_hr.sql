SELECT USER
FROM DUAL;
--==>> HR

-- ■■■ 정규화(Normalization) ■■■ --
-- ○ 정규화란?
-- 한 마디로 데이터베이스 서버의 메모리 낭비를 막기 위해
-- 어떤 하나의 테이블을... 식별자를 가지는 여러개의 테이블로 나누는 과정
-- 을 말한다

-- ex) 호석이가 옥장판을 판매한다
--     고객 리스트 → 거래처 직원 명단이 적혀있는 수첩의 정보를
--                    데이터베이스화 하려고 한다.
--     테이블명 : 거래처직원
/*
--------------------------------------------------------------------------------
거래처회사명    회사주소    회사전화  거래처직원명   직급    이메일     휴대폰
--------------------------------------------------------------------------------
  LG          서울여의도  02-345-6789   양윤정        부장   YYJ@NA.. 010-1234-1..
  LG          서울여의도  02-345-6789   최선화        과장   CSH@DA.. 010-2345-2..
  LG          서울여의도  02-345-6789   최문정        대리   CMJ@DA.. 010-3456-3..
  LG          서울여의도  02-345-6789   홍은혜        부장   HEH@GM.. 010-5678-5..
  SK          서울소공동  02-987-6543   박현수        부장   PHS@NA.. 010-8585-8..
  LG          부산동래구  051-5511-5511 오이삭        대리   OYS@TE.. 010-9900-9..
  SK          서울소공동  02-987-6543   정은정        대리   JEJ@NA.. 010-2450-8..
                                :
                                :
--------------------------------------------------------------------------------

가정) 서울 여의도 LG라는 회사에 근무하는 거래처 직원 명단이
    총 100만명 이라고 가정한다. (한 행(레코드)은 70 Byte 이다.) → 컬럼당 10Byte
    
    어느날 ... 『서울여의도』에 위치한 LG 본사가 『경기분당』 으로
    사옥을 이전하게 되었다.
    회사 주소는 『경기분당』 으로 바뀌고,
    회사 전화는 『031-1111-2222』로 바뀌게 되었다.
    
    그러면... 100만명의 회사 주소와 회사 전화를 변경해야 한다.
    
    -- 이 때 수행되어야 할 쿼리문 → UPDATE
    
    UPDATE 거래처직원
    SET   회사주소 = '경기분당', 회사전화 = '031-1111-2222'
    WHERE 거래처회사명 = 'LG'
          AND 회사주소 = '서울여의도';
          
    -- 100만 개 행을 하드디스크 상에서 읽어다가
       메모리에 로드시켜 주어야 한다.
       즉, 100만 * 70Byte를 모두
       하드디스크상에서 읽어다가 메모리에 로드시켜 주어야 한다는 말이다.
       
       --> 이는 테이블의 설계가 잘못되었으므로
           DB 서버는 조만간 메모리 고갈로 인해 다운될 것이다.
           
           --> 그러므로 정규화 과정을 수행하여 테이블의 잘못된 설계를 바로잡아야 한다.
           
*/


-- 제 1 정규화
--> 어떤 하나의 테이블에 반복되는 컬럼 값들이 존재한다면
--  값들이 반복되어 나오는 컬럼을 분리하여
--  새로운 테이블을 만들어준다.
    -- ↓ 테이블 두 개로 분리
    
--> 제1 정규화를 수행하는 과정에서 분리된 테이블은
--  반드시 부모 테이블과 자식 테이블의 관계를 갖게된다.
--  또한 부모 테이블의 『PRIMARY KEY』는 항상
--  자식 테이블의 「FOREIGN KEY」로 전인된다.

-- ★ 부모 테이블 → 참조받는 컬럼 → 'PRIMARY KEY'
--    반드시 고유한 값(데이터)만 들어와야 한다.
--    중복된 값(데이터)이 없어야 한다.
--    NULL 이 있어서는 안된다. (NOT NULL 이어야 한다.)  
--    ∵ 문법적인 제한사항을 갖게된다는 의미..
-- ★ 자식 테이블 → 참조하는 컬럼 → 'FOREIGN KEY'

   
/* 테이블 ①
--------------------------------------
거래처회사명    회사주소    회사전화 
---------------------------------------
  LG          서울여의도  02-345-6789 
  LG          서울여의도  02-345-6789 
  LG          서울여의도  02-345-6789 
  LG          서울여의도  02-345-6789 
  SK          서울소공동  02-987-6543 
  LG          부산동래구  051-5511-5511
  SK          서울소공동  02-987-6543 
                                :
                                :
----------------------------------------
*/

/* 테이블 ②
--------------------------------------------
거래처직원명   직급    이메일     휴대폰
--------------------------------------------
  양윤정        부장   YYJ@NA.. 010-1234-1..
  최선화        과장   CSH@DA.. 010-2345-2..
  최문정        대리   CMJ@DA.. 010-3456-3..
  홍은혜        부장   HEH@GM.. 010-5678-5..
  박현수        부장   PHS@NA.. 010-8585-8..
  오이삭        대리   OYS@TE.. 010-9900-9..
  정은정        대리   JEJ@NA.. 010-2450-8..
                                :
                                :
--------------------------------------------
*/
    
/*
① 테이블에서 사실상 필요한 데이터는 3개이다.
   다만 테이블 2와 결합되기 위해서는 『식별자』를 가져야 한다.
   『식별자』는 통상 ID로 정한다.
    - 테이블명 : 회사 → 부모 테이블
-----------------------------------------------------
 회사ID   거래처회사명    회사주소    회사전화 
 ======
 참조받는 컬럼 → P.K
-----------------------------------------------------
   10         LG          서울여의도  02-345-6789 
   20         SK          서울소공동  02-987-6543 
   30         LG          부산동래구  051-5511-5511
-----------------------------------------------------
*/

/*
② 테이블도 마찬가지로 ① 테이블과 결합하기 위한
   회사 ID를 『식별자』로 추가한다.
   - 테이블명 : 직원 → 자식 테이블
-----------------------------------------------------
거래처직원명   직급    이메일     휴대폰      회사ID
                                              ======
                                              참조하는 컬럼 → F.K
-----------------------------------------------------
  양윤정        부장   YYJ@NA.. 010-1234-1..   10
  최선화        과장   CSH@DA.. 010-2345-2..   10
  최문정        대리   CMJ@DA.. 010-3456-3..   10
  홍은혜        부장   HEH@GM.. 010-5678-5..   10
  박현수        부장   PHS@NA.. 010-8585-8..   20
  오이삭        대리   OYS@TE.. 010-9900-9..   30
  정은정        대리   JEJ@NA.. 010-2450-8..   20
-----------------------------------------------------  
*/

/*
-- 테이블을 나눈 뒤에 분리(분할) 되기 이전 상태(합쳐진)로 조회(JOIN)


SELECT A.거래처회사명, A.회사주소, A.회사전화
     , B.거래처직원명, B.직급, B.이메일, B.휴대폰
FROM 회사 A, 직원 B
WHERE A.회사ID = B.회사ID;

가정) 서울 여의도 LG라는 회사에 근무하는 거래처 직원 명단이
    총 100만명 이라고 가정한다.
    
    어느날 ... 『서울여의도』에 위치한 LG 본사가 『경기분당』 으로
    사옥을 이전하게 되었다.
    회사 주소는 『경기분당』 으로 바뀌고,
    회사 전화는 『031-1111-2222』로 바뀌게 되었다.
    
    그러면... 회사테이블에서 1건의 회사주소와 회사전화를 변경해야한다.
    
    -- 이 때 수행되어야 할 쿼리문 → UPDATE
    
    UPDATE 회사
    SET    회사주소 = '경기분당', 회사전화 = '031-1111-2222'
    WHERE  회사ID = 10
          
    -- 1개 행을 하드디스크 상에서 읽어다가
       메모리에 로드시켜 주어야 한다.
       즉, 1 * 40Byte를 하드디스크상에서 읽어다가 메모리에 로드시켜 주어야 한다는 말이다.
       
       --> 정규화 이전에는 100만 건을 처리해야 할 업무에서
           1 건만 처리하면 되는 업무로 바뀐 상황이기 때문에
           DB 서버는 메모리 고갈이 일어나지 않고 아주 빠르게 처리될 것이다.
           
*/

-- 거래처회사명, 회사전화              (제 1 정규화 전)
SELECT 거래처회사명, 회사전화        |  SELECT 거래처회사명, 회사전화
FROM 회사;                           |  FROM 거래처직원;
--> 3 * 40 Byte                      |  200만 * 70Byte

-- 거래처직원명, 직급
SELECT 거래처직원명, 직급            |  SELECT 거래처회사명, 회사전화
FROM 직원;                           |  FROM 거래처직원;
--> 200만 * 50Byte                   |  200만 * 70Byte

-- 거래처회사명, 거래처직원명
SELECT A.거래처회사명, B.거래처직원명 | SELECT 거래처회사명, 거래처직원명
FROM 회사 A JOIN 직원 B               | FROM 거래처직원;
ON A.회사ID = B.회사ID;               | 
--> (3*40Byte) + (200만*50Byte)       | 200만 * 70Byte

-- 테이블명 : 주문
/*
--------------------------------------------------------------------------------
  고객ID            제품코드             주문일자                   주문수량
  ++++++++++++++++++++++++++++++++++++++++++++++++
--------------------------------------------------------------------------------
 HEH1217(홍은혜)  P-KKBK(꿀꽈배기)      2202-03-01 13:50:23           10 
 CMJ8335(최문정)  P-KKDS(쿠크다스)      2202-03-01 14:15:11           24 
 LHS3235(이호석)  P-CCPI(초코파이)      2202-03-01 16:14:36           12 
 PHS5834(박현수)  P-MGRT(마가레트)      2202-03-02 10:20:54           20 
 LSM1124(임소민)  P-KSTD(카스타드)      2202-03-02 11:32:47           30 
                     :
--------------------------------------------------------------------------------
*/

-- ※ 하나의 테이블에 존재하는 PRIMARY KEY 의 최대 갯수는 1개이다.
--    하지만, PRIMARY KEY를 이루는(구성하는) 컬럼의 갯수는 복수(여러개)인 것이 가능하다.
--    컬럼 1개로만 구성된 PRIMARY KEY 를 SINGLE PRIMARY KEY 라고 부른다.
--    (단일 프라이머리 키)
--    두 개 이상의 컬럼으로 구성된 PRIMARY KEY 를 COMPOSITE PRIMARY KEY 라고 부른다.
--    (복합 프라이머리 키)


-- 제 2 정규화
--> 제 1 정규화를 마친 결과물에서 PRIMARY KEY 가 SINGLE COLUMN 이라면
--  제 2 정규화는 수행하지 않는다.
-- 하지만, PRIMARY KEY 가 COMPOSITE COLUMN 이라면
-- 반 드 시 제 2 정규화를 수행해야 한다.

--> 식별자가 아닌 컬럼은 식별자 전체 컬럼에 대해 의존적이어야 하는데
--  식별자 전체 컬럼이 아닌 일부 식별자 컬럼에 대해서만 의존적이라면
--  이를 분리하여 새로운 테이블을 생성해준다.
--  이 과정을 제 2 정규화라 한다.

/*
-- 테이블명 : 과목 → 부모 테이블
-----------------------------------------------------------------------------
과목번호  과목명   교수번호   교수자명  강의실코드  강의실설명
++++++++           ++++++++
            P.K
-----------------------------------------------------------------------------
  J0101   자바기초    21      슈바이처    A301      전산실습관 3층 40석 규모
  J0102   자바중급    22      테슬라      T502      전자공학관 5층 60석 규모
  O1123   오라클중급  22      테슬라      A201      전산실습관 2층 30석 규모
  O1150   오라클심화  10      장영실      T502      전자공학관 5층 60석 규모
  J3342   JSP응용     20      맥스웰      K101      인문과학관 1층 90석 규모
  
-----------------------------------------------------------------------------


-- 테이블명 : 점수 → 자식 테이블
-----------------------------------------------------
 과목번호   교수번호    학번               점수
 ===================
         F.K
 +++++++++            ++++++++++
              P.K 
-----------------------------------------------------
 O1123       22         2212316(우수정)     80 
 O1123       22         2212318(김정용)     92 
 O1123       22         2212319(양윤정)     76 
 O1123       22         2212323(한충희)     88 
 J0101       21         2212316(우수정)     99
                          :
-----------------------------------------------------
*/

-- 제 3 정규화
--> 식별자가 아닌 컬럼이 식별자가 아닌 컬럼에 의존적인 상황이라면
--  이를 분리하여 새로운 테이블을 생성해 주어야 한다.
--  이 과정을 제 3 정규형이라 한다.

--※ 관계(Relation)의 종류

-- 1 : many 관계      (일 대 다)
--> 제 1 정규화를 마친 데이터에서 나타나는 바람직한 관계.
--  관계형 데이터베이스를 활용하는 과정에서 추구해야하는 관계.

-- 1 : 1 관계         (일 대 일)
--> 논리적, 물리적으로 존재할 수 있는 관계이긴 하지만
--  관계형 데이터베이스 설계 과정에서 가급적이면 피해야 할 관계.

-- 학생                         -- 점수
---------------------              ----------------------------------------
-- 학번 이름 전화 주소             학번 국어점수 영어점수 수학점수 과학점수
---------------------              ----------------------------------------
-- 7369 홍길동 ......              7369 ....                       ........


-- many : many 관계   (다 대 다)
--> 논리적인 모델링에서는 존재할 수 있지만
--  실제 물리적인 모델링에서는 존재할 수 없는 관계.
/*
-- 테이블명 : 고객                           -- 테이블명 : 제품
-------------------------------              -----------------------------------
고객번호 고객명 이메일 전화번호              제품번호 제품명 제품단가 제품설명
-------------------------------              -----------------------------------
 1001    최선하 csh@t.. 010..                pkdlek   새우깡   600    새우가...
 1002    김상기 ksk@t.. 010..                wkfkfc   자갈치   500    자갈이...
 1003    박현지 phj@t.. 010..                rkawkr   감자깡   400    감자가..
 1004    한충희 hch@t.. 010..                rhrnak   고구마깡 400    고구마가..
                               ↘         ↙
 
                        - 테이블명 : 주문접수(판매)
                        --------------------------------------
                        고객번호  제품번호  주문일자  주문수량
                        --------------------------------------
                        1001      rhrnak   2022-03-..  10
                        1001      qkdlek   2022-03-..  20
                        1002      rhrnak   2022-03-..  20
                                        :
                        --------------------------------------
*/

-- 제 4 정규화
--> 위에서 확인한 내용과 같이 『many(다)』 : 『many(다)』 관계를
--  『1(일)』 : 『many(다)』 관계로 깨뜨리는과정이 바로 제 4 정규화 수행 과정이다.

-- 역정규화(비정규화) → 메모리사용여부에따라 할지 안할지 업무상 판단하여
--                       정한다.

-- A 경우(역정규화 한 것이 더 많은 메모리를 사용할때)
/*
-- 테이블명 : 부서          -- 테이블명 : 사원
  10        10       10     10          10      10    10     10     10           10
------------------------    -------------------------------------------------  + -----
부서번호   부서명   주소    사원번호   사원명   직급  급여  입사일  부서번호    부서명
------------------------    -------------------------------------------------    -----
   10개 행                           1,000,000 개 행
------------------------    -------------------------------------------------    -----

--> 다음과 같이 조회하려면
--------------------------
부서명 사원명  직급  급여
--------------------------
 : 부서 테이블과 사원 테이블을 JOIN 했을 때의 크기
   = (10*30Byte) + (1000000*60Byte)
 
 : 사원 테이블을 역정규화 한 후 이 테이블만 읽어올 때의 크기
   = (1000000*70Byte)
*/

-- B 경우(역정규화 한 것이 더 적은 메모리를 사용할때)

/*
-- 테이블명 : 부서          -- 테이블명 : 사원
  10        10       10     10          10      10    10     10     10           10
------------------------    -------------------------------------------------  + -----
부서번호   부서명   주소    사원번호   사원명   직급  급여  입사일  부서번호    부서명
------------------------    -------------------------------------------------    -----
   500,000개 행                           1,000,000 개 행
------------------------    -------------------------------------------------    -----

--> 다음과 같이 조회하려면
--------------------------
부서명 사원명  직급  급여
--------------------------
 : 부서 테이블과 사원 테이블을 JOIN 했을 때의 크기
   = (500000*30Byte) + (1000000*60Byte) = 15000000 + 60000000 = 75,000,000
 
 : 사원 테이블을 역정규화 한 후 이 테이블만 읽어올 때의 크기
   = (1000000*70Byte) = 70,000,000
*/
-- ※ 참고
/*
1. 관계 (relationship, relation)
   - 모든 엔트리 는 단일값을 가진다
   - 각 열은 유일한 이름을 가지며 순서는 무의미하다.
   - 테이블의 모든 행은 통일하지 않으며 순서는 무의미하다.
   
2. 속성(attribute)
   - 테이블의 열을 나타낸다
   - 자료의 이름을 가진 최소 논리적 단위 : 객체의 성질, 상태 기술
   - 일반 파일의 항목에 해당한다
   - 엔티티의 특성과 상태를 기술
   - 속성의 이름은 모두 달라야 한다.
   
3. 튜플==tuple==엔티티==entity
   - 테이블의 행(row)
   - 연관된 몇 개의 속성으로 구성
   - 개념 정보 단위
   - 일반 파일의 레코드에 해당한다.
   - 튜플 변수(tuple variable)
     : 튜플을 가리키는 변수, 모든 튜플 집합을 도메인으로 하는 변수
     
4. 도메인(domain)
   - 각 속성이 가질 수 있도록 허용된 값들의 집합
   - 속성 명과 도메인 명이 반드시 동일할 필요는 없음
   - 모든 릴레이션에서 모든 속성들의 도메인은 원자적(atomic)이어야 함.
   - 원자적 도메인
     : 도메인의 원소가 더 이상 나누어 질 수 없는 단일체일 때를 나타냄.
     
5. 릴레이션(relation)
   - 파일 시스템에서 파일과 같은 개념
   - 중복된 튜플(tuple==entity==엔티티)을 포함하지 않는다. → 모두 상이함(튜플의유일성)
   - 릴레이션==튜플(엔티티)의 집합. 따라서 튜플의 순서는 무의미하다.
   - 속성(attribute)간에는 순서가 없다.
*/

-- ■■■ 무결성(Integrity) ■■■ --
/*
1. 무결성에는 개체 무결성(Entity Integrity)
              참조 무결성(Relational Integrity)
              도메인 무결성(Domain Integrity)이 있다.
2. 개체 무결성(Entity Integrity)
   개체 무결성은 릴레이션에서 저장되는 튜플(tuple)의
   유일성을 보장하기 위한 제약조건이다.

3. 참조 무결성(Relational Integrity)
   참조 무결성은 릴레이션 간의 데이터 일관성을
   보장하기 위한 제약조건이다.
   
4. 도메인 무결성(Domain Integrity)
   도메인 무결성은 허용 가능한 값의 범위를
   지정하기 위한 제약조건이다.
   
5. 제약조건의 종류
   
   - PRIMARY KEY(PK:P)  → 기본키, 고유키
     해당 컬럼의 값은 반드시 존재해야 하며, 유일해야 한다.
     (NOT NULL 과 UNIQUE 가 결합된 형태)
     
   - FOREIGN KEY(FK:F:R) → 외래키, 왜부키, 참조키
     해당 컬럼의 값은 참조되는 테이블의 컬럼 데이터들 중 하나와
     일치하거나 NULL을 가진다.
     
   - UNIQUE(UK:U)
     테이블 내에서 해당 컬럼의 값은 항상 유일해야 한다.
     
   - NOT NULL(NN:CK:C)
     해당 컬럼은 NULL을 포함할 수 없다.
     
   - CHECK(CK:C)
      해당 컬럼에 저장 가능한 데이터의 값의 범위나 조건을 지정한다.
*/

--------------------------------------------------------------------------------
-- ■■■ PRIMARY KEY ■■■ --
-- 1. 테이블에 대한 기본 키를 생성한다.
-- 2. 테이블에서 각 행을 유일하게 식별하는 컬럼 또는 컬럼의 집합이다.
--    기본 키는 테이블 당 최대 하나만 존재한다.
--    그러나 반드시 하나의 컬럼으로만 구성되는 것은 아니다.
--    NULL 일 수 없고, 이미 테이블에 존재하고 있는 데이터를
--    다시 입력할 수 없도록 처리한다.
--    UNIQUE INDEX 가 자동으로 생성된다. (오라클이 자체적으로 만든다.)

-- 3. 형식 및 구조
-- ① 컬럼 레벨의 형식
--    컬럼명 데이터타입 [CONSTRAINT CONSTRAINT 명] PRIMARY KEY [(컬럼명, ...)]

-- ② 테이블 레벨의 형식
--    컬럼명 데이터타입,
--    컬럼명 데이터타입,
--    CONSTRAINT CONSTRAINT 명 PRIMARY KEY(컬럼명, ...)

-- 4. CONSTRAINT 추가 시 CONSTRAINT 명을 생략하면
--    오라클 서버가 자동적으로 CONSTRAINT 명을 부여한다.
--    일반적으로 CONSTRAINT 명은 『테이블명_컬럼명_CONSTRAINT약자』
--    형식으로 기술한다.

-- ○ PK 지정 실습(① 컬럼 레벨의 형식)

DROP TABLE TBL_TEST1;

-- 테이블 생성
CREATE TABLE TBL_TEST1
( COL1  NUMBER(5)        PRIMARY KEY
, COL2  VARCHAR2(30)
);
--==>> Table TBL_TEST1이(가) 생성되었습니다.

-- 데이터 입력
INSERT INTO TBL_TEST1(COL1, COL2) VALUES(1, 'TEST');
INSERT INTO TBL_TEST1(COL1, COL2) VALUES(1, 'TEST'); -- ORA-00001: unique constraint (HR.SYS_C007047) violated
INSERT INTO TBL_TEST1(COL1, COL2) VALUES(1, 'ABCD'); -- ORA-00001: unique constraint (HR.SYS_C007047) violated
INSERT INTO TBL_TEST1(COL1, COL2) VALUES(2, 'ABCD');
INSERT INTO TBL_TEST1(COL1, COL2) VALUES(3, NULL);
INSERT INTO TBL_TEST1(COL1) VALUES(4);
INSERT INTO TBL_TEST1(COL1) VALUES(4); --ORA-00001: unique constraint (HR.SYS_C007047) violated
INSERT INTO TBL_TEST1(COL1, COL2) VALUES(5, 'ABCD');
INSERT INTO TBL_TEST1(COL1, COL2) VALUES(NULL, NULL); -- ORA-01400: cannot insert NULL into ("HR"."TBL_TEST1"."COL1")

-- 커밋
COMMIT;
--==>> 커밋 완료.

SELECT *
FROM TBL_TEST1;
/*
1	TEST
2	ABCD
3	
4	
5	ABCD
*/

DESC TBL_TEST1;
/*
이름   널?       유형           
---- -------- ------------ 
COL1 NOT NULL NUMBER(5)      → PK 제약조건 확인 불가
COL2          VARCHAR2(30) 
*/

-- ※ 제약조건 확인
SELECT *
FROM USER_CONSTRAINTS;
/*
HR	REGION_ID_NN	C	REGIONS	"REGION_ID" IS NOT NULL				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	REG_ID_PK	P	REGIONS					ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29	HR	REG_ID_PK		
HR	COUNTRY_ID_NN	C	COUNTRIES	"COUNTRY_ID" IS NOT NULL				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	COUNTRY_C_ID_PK	P	COUNTRIES					ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29	HR	COUNTRY_C_ID_PK		
HR	COUNTR_REG_FK	R	COUNTRIES		HR	REG_ID_PK	NO ACTION	ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	LOC_CITY_NN	C	LOCATIONS	"CITY" IS NOT NULL				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	LOC_ID_PK	P	LOCATIONS					ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29	HR	LOC_ID_PK		
HR	LOC_C_ID_FK	R	LOCATIONS		HR	COUNTRY_C_ID_PK	NO ACTION	ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	DEPT_NAME_NN	C	DEPARTMENTS	"DEPARTMENT_NAME" IS NOT NULL				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	DEPT_ID_PK	P	DEPARTMENTS					ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29	HR	DEPT_ID_PK		
HR	DEPT_LOC_FK	R	DEPARTMENTS		HR	LOC_ID_PK	NO ACTION	ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	JOB_TITLE_NN	C	JOBS	"JOB_TITLE" IS NOT NULL				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	JOB_ID_PK	P	JOBS					ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29	HR	JOB_ID_PK		
HR	EMP_LAST_NAME_NN	C	EMPLOYEES	"LAST_NAME" IS NOT NULL				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	EMP_EMAIL_NN	C	EMPLOYEES	"EMAIL" IS NOT NULL				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	EMP_HIRE_DATE_NN	C	EMPLOYEES	"HIRE_DATE" IS NOT NULL				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	EMP_JOB_NN	C	EMPLOYEES	"JOB_ID" IS NOT NULL				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	EMP_SALARY_MIN	C	EMPLOYEES	salary > 0				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	EMP_EMAIL_UK	U	EMPLOYEES					ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29	HR	EMP_EMAIL_UK		
HR	EMP_EMP_ID_PK	P	EMPLOYEES					ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29	HR	EMP_EMP_ID_PK		
HR	EMP_DEPT_FK	R	EMPLOYEES		HR	DEPT_ID_PK	NO ACTION	ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	EMP_JOB_FK	R	EMPLOYEES		HR	JOB_ID_PK	NO ACTION	ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	EMP_MANAGER_FK	R	EMPLOYEES		HR	EMP_EMP_ID_PK	NO ACTION	ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	DEPT_MGR_FK	R	DEPARTMENTS		HR	EMP_EMP_ID_PK	NO ACTION	ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	JHIST_EMPLOYEE_NN	C	JOB_HISTORY	"EMPLOYEE_ID" IS NOT NULL				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	JHIST_START_DATE_NN	C	JOB_HISTORY	"START_DATE" IS NOT NULL				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	JHIST_END_DATE_NN	C	JOB_HISTORY	"END_DATE" IS NOT NULL				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	JHIST_JOB_NN	C	JOB_HISTORY	"JOB_ID" IS NOT NULL				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	JHIST_DATE_INTERVAL	C	JOB_HISTORY	end_date > start_date				ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	JHIST_EMP_ID_ST_DATE_PK	P	JOB_HISTORY					ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29	HR	JHIST_EMP_ID_ST_DATE_PK		
HR	JHIST_JOB_FK	R	JOB_HISTORY		HR	JOB_ID_PK	NO ACTION	ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	JHIST_EMP_FK	R	JOB_HISTORY		HR	EMP_EMP_ID_PK	NO ACTION	ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	JHIST_DEPT_FK	R	JOB_HISTORY		HR	DEPT_ID_PK	NO ACTION	ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	USER NAME			2014-05-29				
HR	SYS_C004102	O	EMP_DETAILS_VIEW					ENABLED	NOT DEFERRABLE	IMMEDIATE	NOT VALIDATED	GENERATED NAME			2014-05-29				
HR	BIN$O4O0NZrqQ2usamR4qlzAlA==$0	P	BIN$tjV5mOVqRVuHfUygg6N8XA==$0					ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	GENERATED NAME			2022-03-03	HR	BIN$xlvzlSPdQ2CQ4co4IEQu7A==$0		
HR	SYS_C007048	P	TBL_TEST1					ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	GENERATED NAME			2022-03-03	HR	SYS_C007048		
*/

SELECT *
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'TBL_TEST1';
--==>> HR	SYS_C007048	P	TBL_TEST1					ENABLED	NOT DEFERRABLE	IMMEDIATE	VALIDATED	GENERATED NAME			2022-03-03	HR	SYS_C007048		
            -------------
--           제약조건이름(명)        
-- ※ 제약조건이 지정된 컬럼 확인(조회)
SELECT *
FROM USER_CONS_COLUMNS
WHERE TABLE_NAME = 'TBL_TEST1';
--==>> HR	SYS_C007048	TBL_TEST1	COL1	1
--          ------------            ----
--           제약조건 명           대상컬럼

-- ※ USER_CONSTRAINTS 와 USER_CONS_COLUMNS 를 대상으로
--    제약조건이 설정된 소유주, 제약조건명, 테이블명, 제약조건종류, 컬럼명
--    항목을조회한다.

SELECT U.OWNER "소유주"
     , U.CONSTRAINT_NAME "제약조건명"
     , U.TABLE_NAME "테이블명"
     , U.CONSTRAINT_TYPE "제약조건종류"
     , S.COLUMN_NAME "컬럼명"
FROM USER_CONSTRAINTS U, USER_CONS_COLUMNS S
WHERE U.CONSTRAINT_NAME = S.CONSTRAINT_NAME
  AND U.TABLE_NAME = 'TBL_TEST1';
--==>> HR	SYS_C007048	TBL_TEST1	P	COL1

-- ○ PK 지정 실습(② 테이블 레벨의 형식)
-- 테이블 생성
CREATE TABLE TBL_TEST2
( COL1  NUMBER(5)
, COL2  VARCHAR2(30)
, CONSTRAINT TEST2_COL1_PK PRIMARY KEY(COL1)
);
--==>> Table TBL_TEST2이(가) 생성되었습니다.

-- 데이터 입력
INSERT INTO TBL_TEST2(COL1, COL2) VALUES(1, 'TEST');
INSERT INTO TBL_TEST2(COL1, COL2) VALUES(1, 'TEST'); --> 에러 발생
INSERT INTO TBL_TEST2(COL1, COL2) VALUES(1, 'ABCD'); --> 에러 발생
INSERT INTO TBL_TEST2(COL1, COL2) VALUES(2, 'ABCD'); 
INSERT INTO TBL_TEST2(COL1, COL2) VALUES(3, NULL);
INSERT INTO TBL_TEST2(COL1) VALUES(4); 
INSERT INTO TBL_TEST2(COL1) VALUES(4);                --> 에러 발생
INSERT INTO TBL_TEST2(COL1, COL2) VALUES(5, 'ABCD');
INSERT INTO TBL_TEST2(COL1, COL2) VALUES(NULL, NULL); --> 에러 발생

COMMIT;
--==>> 커밋 완료.

SELECT *
FROM TBL_TEST2;
/*
1	TEST
2	ABCD
3	
4	
5	ABCD
*/

-- ○ USER_COSTRAINTS 와 USER_CONS_COLUMNS를 대상으로
--    제약조건이 설정된 소유주, 제약조건명, 테이블명, 제약조건종류, 컬럼명
--    항목을조회한다.
SELECT U.OWNER "소유주"
     , U.CONSTRAINT_NAME "제약조건명"
     , U.TABLE_NAME "테이블명"
     , U.CONSTRAINT_TYPE "제약조건종류"
     , S.COLUMN_NAME "컬럼명"
FROM USER_CONSTRAINTS U, USER_CONS_COLUMNS S
WHERE U.CONSTRAINT_NAME = S.CONSTRAINT_NAME
  AND U.TABLE_NAME = 'TBL_TEST2';
--==>> HR	TEST2_COL1_PK	TBL_TEST2	P	COL1  
--            제약조건명

-- ○ PK 지정 실습(③ 다중 컬럼 PK 지정)
-- 테이블 생성
CREATE TABLE TBL_TEST3
( COL1  NUMBER(5)
, COL2  VARCHAR2(30)
, CONSTRAINT TEST3_COL1_COL2_PK PRIMARY KEY(COL1, COL2)
);
--==>> Table TBL_TEST3이(가) 생성되었습니다.

-- 데이터 입력
INSERT INTO TBL_TEST3(COL1, COL2) VALUES(1, 'TEST');
INSERT INTO TBL_TEST3(COL1, COL2) VALUES(1, 'TEST'); -- 에러
INSERT INTO TBL_TEST3(COL1, COL2) VALUES(1, 'ABCD');
INSERT INTO TBL_TEST3(COL1, COL2) VALUES(2, 'ABCD');
INSERT INTO TBL_TEST3(COL1, COL2) VALUES(3, NULL);   -- 에러
INSERT INTO TBL_TEST3(COL1) VALUES(4);               -- 에러
INSERT INTO TBL_TEST3(COL1, COL2) VALUES(5, 'ABCD');
INSERT INTO TBL_TEST3(COL1, COL2) VALUES(NULL, NULL); -- 에러

COMMIT;
--==>> 커밋 완료.

SELECT *
FROM TBL_TEST3;
/*
1	ABCD
1	TEST
2	ABCD
5	ABCD
*/

-- ○ PK 지정 실습(④ 테이블 생성 이후 제약조건 추가 설정)
-- 테이블 생성
CREATE TABLE TBL_TEST4
( COL1  NUMBER(5)
, COL2  VARCHAR2(3)
);
--==>> Table TBL_TEST4이(가) 생성되었습니다.

-- ※ 이미 만들어져 있는 테이블에
--    부여하려는 제약조건을 위반한 데이터가 포함되어 있을 경우
--    해당 테이블에 제약조건을 추가하는 것을 불가능하다.

-- 제약조건 추가
ALTER TABLE TBL_TEST4
ADD CONSTRAINT TEST4_COL1_PK PRIMARY KEY(COL1);
--==>> Table TBL_TEST4이(가) 변경되었습니다.

-- ○ USER_COSTRAINTS 와 USER_CONS_COLUMNS를 대상으로
--    제약조건이 설정된 소유주, 제약조건명, 테이블명, 제약조건종류, 컬럼명
--    항목을조회한다.
SELECT U.OWNER "소유주"
     , U.CONSTRAINT_NAME "제약조건명"
     , U.TABLE_NAME "테이블명"
     , U.CONSTRAINT_TYPE "제약조건종류"
     , S.COLUMN_NAME "컬럼명"
FROM USER_CONSTRAINTS U, USER_CONS_COLUMNS S
WHERE U.CONSTRAINT_NAME = S.CONSTRAINT_NAME
  AND U.TABLE_NAME = 'TBL_TEST4';
--==>> HR	TEST4_COL1_PK	TBL_TEST4	P	COL1

-- ※ 제약조건확인전용 뷰(VIEW) 생성
CREATE OR REPLACE VIEW VIEW_CONSTCHECK
AS
SELECT UC.OWNER "OWNER"
     , UC.CONSTRAINT_NAME "CONSTRAINT_NAME"
     , UC.TABLE_NAME "TABLE_NAME"
     , UC.CONSTRAINT_TYPE "CONSTRAINT_TYPE"
     , UCC.COLUMN_NAME "COLUMN_NAME"
     , UC.SEARCH_CONDITION "SEARCH_CONDITION"
     , UC.DELETE_RULE "DELETE_RULE"
FROM USER_CONSTRAINTS UC JOIN USER_CONS_COLUMNS UCC
ON UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME;
--==>> View VIEW_CONSTCHECK이(가) 생성되었습니다.

-- ○ 생성된 VIEW 를 통한 제약조건 확인
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME = 'TBL_TEST4';
--==>> HR	TEST4_COL1_PK	TBL_TEST4	P	COL1	

--------------------------------------------------------------------------------
-- ■■■  UNIQUE(UK:U) ■■■--
-- 1. 테이블에서 지정한 컬럼의 데이터가 중복되지 않고 유일할 수 있도록 설정하는 제약조건.
--    PRIMARY KEY와 유사한 제약조건이지만, NULL을 허용한다는 차이점이 있다.
--    내부적으로 PRIMARY KEY와 마찬가지로 UNIQUE INDEX가 자동 생성된다.
--    즉, 하나의 테이블에 UNIQUE 제약조건을 여러개 만드는 것은 가능하다는 것이다.

-- 2. 형식 및 구조
-- ① 컬럼 레벨의 형식
-- 컬럼명 데이터타입 [CONSTRAINT CONSTRAINT명] UNIQUE

-- ② 테이블 레벨의 형식
-- 컬럼명 데이터타입,
-- 컬럼명 데이터타입,
-- CONSTRAINT CONSTRINT명 UNIQUE(컬럼명, ...)

-- ○ UK 지정 실습(① 컬럼 레벨의 형식)
-- 테이블 생성
CREATE TABLE TBL_TEST5
( COL1  NUMBER(5)       PRIMARY KEY
, COL2  VARCHAR2(30)    UNIQUE
);
--==>> Table TBL_TEST5이(가) 생성되었습니다.

-- 제약조건 조회
SELECT *
FROM VIEW_CONSTCHECK
WHERE TABLE_NAME='TBL_TEST5';
/*
HR	SYS_C007052	TBL_TEST5	P	COL1		
HR	SYS_C007053	TBL_TEST5	U	COL2		
*/

-- 데이터 입력
INSERT INTO TBL_TEST5(COL1, COL2) VALUES (1, 'TEST');
INSERT INTO TBL_TEST5(COL1, COL2) VALUES (1, 'TEST'); -- 에러
INSERT INTO TBL_TEST5(COL1, COL2) VALUES (1, 'ABCD'); -- 에러
INSERT INTO TBL_TEST5(COL1, COL2) VALUES (2, 'ABCD'); 
INSERT INTO TBL_TEST5(COL1, COL2) VALUES (3, NULL);
INSERT INTO TBL_TEST5(COL1) VALUES (4);
INSERT INTO TBL_TEST5(COL1, COL2) VALUES (5, 'ABCD'); -- 에러

COMMIT;
--==>>커밋 완료.

SELECT *
FROM TBL_TEST5;
/*
1	TEST
2	ABCD
3	
4	
*/

-- ○ UK 지정 실습(② 테이블 레벨의 형식)
--  테이블 생성
CREATE TABLE TBL_TEST6
( COL1 NUMBER(5)
, COL2 VARCHAR2(30)
, CONSTRAINT TEST6_COL1_PK PRIMARY KEY(COL1)
, CONSTRAINT TEST6_COL2_UK UNIQUE(COL2)
);
--==>> Table TBL_TEST6이(가) 생성되었습니다.

-- 확인부터 이어서 진행

