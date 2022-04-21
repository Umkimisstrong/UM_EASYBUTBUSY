SELECT USER
FROM DUAL;
--==>> SCOTT

-- ○ TBL_입고 테이블의 데이터 입력, 수정, 삭제 시
--    TBL_상품 테이블의 재고수량 변동 트리거 작성
--    트리거 명 : TRG_IBGO

CREATE OR REPLACE TRIGGER TRG_IBGO
    AFTER
    INSERT OR UPDATE OR DELETE ON TBL_입고
    FOR EACH ROW
BEGIN
    IF (INSERTING)
        THEN UPDATE TBL_상품
             SET 재고수량 = 재고수량 + :NEW.입고수량
             WHERE 상품코드 = :NEW.상품코드;
    ELSIF (UPDATING)
        THEN UPDATE TBL_상품
             SET 재고수량 = 재고수량 - :OLD.입고수량 + :NEW.입고수량
             WHERE 상품코드 = :OLD.상품코드;             
    ELSIF (DELETING)             
        THEN UPDATE TBL_상품
             SET 재고수량 = 재고수량 - :OLD.입고수량
             WHERE 상품코드 = :OLD.상품코드;                 
    END IF;
END;
--==>> Trigger TRG_IBGO이(가) 컴파일되었습니다.

-- ○ TBL_출고 테이블의 데이터 입력, 수정, 삭제 시
--    TBL_상품 테이블의 재고수량 변동 트리거 작성
--    트리거 명 : TRG_CHULGO

-- 출고테이블에 데이터가 입력되면,
-- 입력되는 수량만큼(NEW) 상품테이블의 재고수량 차감

-- 출고테이블에 데이터가 수정되면
-- 기존 재고수량에서 최초 차감했던 만큼(OLD) 더해주고, 
-- 새로운 입력값 만큼(NEW) 차감

-- 출고테이블에 데이터가 삭제되면
-- 기존 재고수량에서 최초 차감했던 만큼(OLD) 더해준다.
CREATE OR REPLACE TRIGGER TRG_IBGO
        AFTER
        INSERT OR UPDATE OR DELETE ON TBL_출고
        FOR EACH ROW
DECLARE
BEGIN
    -- 조건문 생성
    -- ( 데이터 입력 )
    IF ( INSERTING )
        THEN UPDATE TBL_상품
             SET 재고수량 = 재고수량 - :NEW.출고수량
             WHERE 상품코드 = :NEW.상품코드;
    -- ( 데이터 수정 )  
    ELSIF (UPDATING)   
        THEN UPDATE TBL_상품
             SET 재고수량 = 재고수량 + :OLD.출고수량 - :NEW.출고수량
             WHERE 상품코드 = :OLD.상품코드;
    -- ( 데이터 삭제 )    
    ELSIF ( DELETING )
        THEN UPDATE TBL_상품
             SET 재고수량 = 재고수량 + :OLD.출고수량
             WHERE 상품코드 = :OLD.상품코드;
    END IF;
    -- 조건문 종료
END;

--------------------------------------------------------------------------------

-- ■■■ PACKAGE(패키지) ■■■ --

-- 1. PL/SQL의 패키지는 관계되는 타입, 프로그램 객체,
--    서브프로그램(PROCEDURE, FUNCTION 등)을
--    논리적으로 묶어놓은 것으로 오라클에서 제공하는
--    패키지 중 하나가 바로 『DBMS_OUTPUT』 이다.

-- 2. 패키지는 서로 유사한 업무에 사용되는 여러개의 프로시저와
--    함수를 하나의 패키지로 만들어 관리함으로써 향후 유지보수가 편리
--    하고 전체 프로그램을 모듈화 할 수 있다는 장점이 있다.

-- 3. 패키지는 명세부(PACKAGE SPECIFICATION)와
--    몸체부(PACKAGE BODY)로 구성되어 있으며
--    명세 부분에는 TYPE, CONSTRAINT, VARIBLE, EXCEPTION, CURSOR,
--    SUBPROGRAM 이 선언되고
--    몸체 부분에는 이들의 실제 내용이 존재한다.
--    그리고, 호출할 때에는 『패키지명.프로시저명』형식의 참조를 이용해야 한다.

-- 4. 형식 및 구조(명세부)
/*
CREATE [OR REPLACE] PACKAGE 패키지명
IS
    전역변수선언;
    커서선언;
    예외선언;
    함수선언;
    프로시저선언;
        :
END 패키지명;
*/

-- 5. 형식 및 구조(몸체부)
/*
CREATE [OR REPLACE] PACKAGE BODY 패키지명
IS
    FUNCTION 함수명[인수 ,...]
    RETURN 자료형
    IS 
        변수선언;
    BEGIN
        함수 몸체 구성 코드;
        RETURN 값;
    END;
    
    PROCEDURE 프로시저명[인수, ...]
    IS
        변수 선언;
    BEGIN
        프로시저 몸체 구성 코드;
    END;
*/

-- 패키지 등록 실습
-- ① 명세부 작성
CREATE OR REPLACE PACKAGE INSA_PACK
IS
    FUNCTION FN_GENDER(V_SSN VARCHAR2)
    RETURN VARCHAR2;
END INSA_PACK;
--==>> Package INSA_PACK이(가) 컴파일되었습니다.

-- ② 몸체부 작성(성별확인연산)
CREATE OR REPLACE PACKAGE BODY INSA_PACK
IS
    FUNCTION FN_GENDER(V_SSN VARCHAR2)
    RETURN VARCHAR2
    IS
        V_RESULT VARCHAR2(20);
    BEGIN
        IF( SUBSTR(V_SSN, 8, 1) IN ('1', '3')    )
            THEN V_RESULT := '남자';
        ELSIF(  SUBSTR(V_SSN, 8, 1) IN ('2', '4')  )    
            THEN V_RESULT := '여자';
        ELSE
            V_RESULT := '확인불가';
        END IF;
        
        RETURN V_RESULT;
    END;
    
END INSA_PACK;









