SELECT USER
FROM DUAL;
--==>> SCOTT

DESC TBL_INSA;

-- ○ TBL_INSA 테이블을 대상으로 신규 데이터 입력 프로시저를 작성한다.
--    NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG
--    으로 구성된 컬럼 중 NUM을 제외한
--     NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG
--     데이터 입력 시
--     NUM 컬럼(사원번호)의 값은
--     기존 부여된 사원 번호의 마지막 번호 그 다음 번호를 자동으로 입력 처리할 수 있는
--     프로시저로 구성한다.
--     프로시저 명 : PRC_INSA_INSERT()
/*
실행 예)
EXEC PRC_INSA_INSERT('양윤정', '970131-2234567', SYSDATE, '서울', '010-8624-4533', '개발부', '대리', 2000000, 2000000);

프로시저 호출로 처리된 결과
1061 양윤정 970131-2234567 SYSDATE 서울 010-8624-4533 개발부 대리 2000000 2000000
가 입력된 것

*/
SELECT *
FROM TBL_INSA;

CREATE OR REPLACE PROCEDURE PRC_INSA_INSERT
( I_NAME        IN TBL_INSA.NAME%TYPE
, I_SSN         IN TBL_INSA.SSN%TYPE
, I_IBSADATE    IN TBL_INSA.IBSADATE%TYPE
, I_CITY        IN TBL_INSA.CITY%TYPE
, I_TEL         IN TBL_INSA.TEL%TYPE
, I_BUSEO       IN TBL_INSA.BUSEO%TYPE
, I_JIKWI       IN TBL_INSA.JIKWI%TYPE
, I_BASICPAY    IN TBL_INSA.BASICPAY%TYPE
, I_SUDANG      IN TBL_INSA.SUDANG%TYPE
)
IS
    I_NUM     TBL_INSA.NUM%TYPE;
BEGIN
    SELECT MAX(NVL(NUM, 0)) + 1 INTO I_NUM
    FROM TBL_INSA;

    INSERT INTO TBL_INSA(NUM, NAME, SSN, IBSADATE, CITY, TEL, BUSEO, JIKWI, BASICPAY, SUDANG)
    VALUES (I_NUM, I_NAME, I_SSN, I_IBSADATE, I_CITY, I_TEL, I_BUSEO, I_JIKWI, I_BASICPAY, I_SUDANG);
        
    COMMIT;
END;
--==>> Procedure PRC_INSA_INSERT이(가) 컴파일되었습니다.

-- ○ TBL_상품, TBL_입고 테이블을 대상으로
--    TBL_입고 테이블에 데이터 입력 시(즉, 입고 이벤트 발생 시)
--    TBL_상품 테이블의 재고수량이 함께 변동될 수 있는 기능을 가진
--    프로시저를 작성한다.
--    단, 이 과정에서 입고번호는 자동 증가 처리한다. (시퀀스 사용 Ⅹ)
--    TBL_입고 테이블 구성 컬럼
--    : 입고번호, 상품코드, 입고일자, 입고수량, 입고단가
--    프로시저 명 : PRC_입고_INSERT(상품코드, 입고수량, 입고단가)
--    

-- 'H001', 30, 400
--  → 입고테이블의 데이터 입력(프로시저 매개변수로 전달받지 못한 나머지 값 → 자동 입력)
--  → 상품테이블의 바밤바 재고수량 30개
CREATE OR REPLACE PROCEDURE  PRC_입고_INSERT
( V_상품코드    IN  TBL_입고.상품코드%TYPE
, V_입고수량    IN  TBL_입고.입고수량%TYPE
, V_입고단가    IN  TBL_입고.입고단가%TYPE
)
IS
    V_입고번호  TBL_입고.입고번호%TYPE;
    
BEGIN
    SELECT NVL(MAX(입고번호), 0) +1 INTO V_입고번호
    FROM TBL_입고;
    
    INSERT INTO TBL_입고 (입고번호, 상품코드, 입고수량, 입고단가)
    VALUES(V_입고번호, V_상품코드, V_입고수량, V_입고단가);
    
    UPDATE TBL_상품
    SET 재고수량 = 재고수량 + V_입고수량
    WHERE 상품코드 = V_상품코드;
    
    -- 에외 처리(트랜잭션 기본..)
    EXCEPTION
        WHEN OTHERS THEN ROLLBACK;

    -- 커밋        
    COMMIT;
END;
--==>> Procedure PRC_입고_INSERT이(가) 컴파일되었습니다.

-- ■■■ PROCEDURE 내에서의 예외처리 ■■■ -- 
-- ○ TBL_MEMBER 테이블에 데이터를 입력하는 프로시저를 작성
--    단, 이 프로시저를 통해 데이터를 입력할 경우
--    CITY(지역) 항목에 '서울', '경기', '대전' 만 입력이 가능하도록 구성한다.
--    이 지역 외의 다른 지역을 프로시저 호출을 통해 입력하고자 하는 경우
--    (즉, 입력을 시도하는 경우)
--    예외에 대한 처리를 하려고 한다.
--    프로시저 명 : PRC_MEMBER_INSERT()
/*
EXEC PRC_MEMBER_INSERT('임소민', '010-1111-1111', '서울');
--==>> 데이터 입력 ○
EXEC PRC_MEMBER_INSERT('이연주', '010-2222-2222', '부산');
--==>> 데이터 입력 Ⅹ
*/

CREATE OR REPLACE PROCEDURE PRC_MEMBER_INSERT
( V_NAME    IN  TBL_MEMBER.NAME%TYPE
, V_TEL     IN  TBL_MEMBER.TEL%TYPE
, V_CITY    IN  TBL_MEMBER.CITY%TYPE
)
IS
    -- 선언부(주요 변수 선언) "예외도 변수다"
    -- 실행 영역의 쿼리문 수행을 위해 필요한 변수 선언
    V_NUM   TBL_MEMBER.NUM%TYPE;
    
    -- 사용자 정의 예외에 대한 변수 선언 CHECK~!~!
    -- EXCEPTION 타입의 USER_DEFINE_ERROR 생성
    USER_DEFINE_ERROR   EXCEPTION;
    
BEGIN
    -- 프로시저를 통해 입력 처리를 정상적으로 진행해야 할 데이터인지 아닌지의 여부를
    -- 가장 먼저 확인할 수 있도록 코드 구성
    IF  ( V_CITY NOT IN ('서울', '경기', '대전') )  
        -- 서울, 경기, 대전 이 없다면 예외 발생 CHECK~!!
        -- 예외 발생시키는것 → 예외를 일으키는것(RAISE)
        THEN RAISE USER_DEFINE_ERROR;
    END IF;
    
    SELECT NVL(MAX(NUM), 0) + 1 INTO V_NUM
    FROM TBL_MEMBER;
    
    -- 쿼리문 구성 → INSERT
    INSERT INTO TBL_MEMBER(NUM, NAME, TEL, CITY)
    VALUES(V_NUM, V_NAME, V_TEL, V_CITY);
    
    -- 예외 처리 구문
    EXCEPTION
        WHEN USER_DEFINE_ERROR
            THEN RAISE_APPLICATION_ERROR(-20001, '서울,경기,대전만 입력이 가능합니다.');
                ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;

    -- 커밋
    COMMIT;
END;
--==>> Procedure PRC_MEMBER_INSERT이(가) 컴파일되었습니다.

-- ○ TBL_출고 테이블에 데이터 입력 시(즉, 출고 이벤트 발생 시)
--    TBL_상품 테이블의 재고수량이 변동되는 프로시저를 작성한다.
--    단, 출고번호는 입고번호와 마찬가지로 자동증가
--    또한, 출고수량이 재고수량보다 많은 경우
--    출고 액션을 취소할 수 있도록 처리한다.(출고가 이루어지지않도록.. 예외)

/*
실행 예)
EXEC PRC_출고_INSERT('H001', 10, 600);

-- 현재 상품 테이블의 바밤바 재고수량 50개
EXEC PRC_출고_INSERT('H001', 60, 600);
--==>> 에러 발생
--     재고 부족
*/


CREATE OR REPLACE PROCEDURE PRC_출고_INSERT
( V_상품코드    IN  TBL_출고.상품코드%TYPE 
, V_출고수량    IN  TBL_출고.출고수량%TYPE 
, V_출고단가    IN  TBL_출고.출고단가%TYPE 
)
IS
    V_출고번호   TBL_출고.출고번호%TYPE;
    V_재고수량   TBL_상품.재고수량%TYPE;
    USER_INSERT_ERROR   EXCEPTION;
BEGIN
    -- 재고수량 얻기
    -- 쿼리문 수행 이전에 수행 여부를 확인하는 과정에서
    -- 재고수량 파악 → 기존 재고를 확인하는 과정이 선행되어야 한다.
    -- 그래야 프로시저 호출 시 넘겨받는 출고수량과 비교 가능하기 때문이다.
    SELECT 재고수량 INTO V_재고수량
    FROM TBL_상품
    WHERE 상품코드 = V_상품코드;
    
    -- 조건문
    -- 출고 정상적으로 진행해 줄 것인지에 대한 여부 확인
    -- 위에서 파악한 재고수량보다 현재 프로시저에서 넘겨받은 출고수량이 많으면
    -- 예외발생 !!
    IF  (V_출고수량 > V_재고수량)
        THEN  RAISE USER_INSERT_ERROR;
    END IF;
    
    ------------------- 쿼리문 구성 INSERT (TBL_출고) ------------
    -- 출고번호 얻기
    SELECT NVL(MAX(출고번호), 0) + 1 INTO V_출고번호
    FROM TBL_출고;
    
    -- 데이터 입력
    INSERT INTO TBL_출고 (출고번호, 상품코드, 출고수량, 출고단가)
    VALUES(V_출고번호, V_상품코드, V_출고수량, V_출고단가);
    
    ------------------- 쿼리문 구성 UPDATE (TBL_상품) ------------
    -- 재고빼기
    UPDATE  TBL_상품
    SET 재고수량 = 재고수량 - V_출고수량
    WHERE 상품코드 = V_상품코드;
    
    -- 예외처리
    EXCEPTION
        WHEN USER_INSERT_ERROR
            THEN RAISE_APPLICATION_ERROR(-20002, '재고부족');
                ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
          
    -- 커밋  
    COMMIT;
END;

-- ○ TBL_출고 테이블에서 출고수량을 수정(변경)하는 프로시저를 작성한다.
--    프로시저 명 PRC_출고_UPDATE()
/*
실행 예)
EXEC PRC_출고_UPDATE(출고번호, 변경할수량);
*/
--> 기존 출고 수량이 3개인 경우
--> TBL_출고 테이블은 출고 수량이 3으로 입력되는 정보가 입력되잇고
--> TBL_상품 테이블은 3만큼 수량이 빠진상태이다.

--> 출고 수량을 5로 변경한다는 의미는 :
--  TBL_출고 테이블에 입력된 3이라는 정보를 5로 바꾸고
--  TBL_상품 테이블은 (5-3) 만큼 더 빼줘야 한다는 것이다.


CREATE OR REPLACE PROCEDURE PRC_출고_UPDATE
( V_출고번호    IN TBL_출고.출고번호%TYPE
, V_변경할수량  IN TBL_출고.출고수량%TYPE 
)
IS
    USER_INSERT_ERROR   EXCEPTION;
    V_기존출고수량    TBL_출고.출고수량%TYPE;
    V_상품코드        TBL_상품.상품코드%TYPE;
    V_재고수량        TBL_상품.재고수량%TYPE;
BEGIN
    -- 해당 상품코드 얻어내기
    SELECT 상품코드 INTO V_상품코드
    FROM TBL_출고
    WHERE 출고번호 = V_출고번호;
    
    -- 재고수량 얻어내기
    SELECT 재고수량 INTO V_재고수량
    FROM TBL_상품
    WHERE 상품코드 = V_상품코드;
    
    -- 조건문(출고가 재고보다 많은경우 에러발생)
    IF (V_재고수량 < V_변경할수량)
        THEN RAISE USER_INSERT_ERROR;
    END IF;
    
    
    -- 기존출고수량 얻어내기
    SELECT 출고수량 INTO V_기존출고수량
    FROM  TBL_출고
    WHERE 출고번호 = V_출고번호;
    
   
    -- 출고테이블 업데이트
    UPDATE TBL_출고
    SET 출고수량 = V_변경할수량
    WHERE 출고번호 = V_출고번호;
    
    -- 상품테이블 업데이트
    UPDATE TBL_상품
    SET 재고수량 = (재고수량) - (V_변경할수량 - V_기존출고수량)
    WHERE 상품코드 = (SELECT 상품코드
                      FROM TBL_출고
                      WHERE 출고번호 = V_출고번호);
    
    -- 예외처리
    EXCEPTION
        WHEN USER_INSERT_ERROR
            THEN RAISE_APPLICATION_ERROR(-20003, '변경할수량이 재고수량보다 많습니다.');
                ROLLBACK;
        WHEN OTHERS
            THEN ROLLBACK;
            
    COMMIT;
    
END;
--==>> Procedure PRC_출고_UPDATE이(가) 컴파일되었습니다.

