SELECT USER
FROM DUAL;
--==>> SCOTT
SET SERVEROUTPUT ON;

-- ○ TBL_INSA 테이블의 여러명의 데이터 여러 개를 변수에 저장하여 출력
--    (반복문 활용)

DECLARE
    V_INSA  TBL_INSA%ROWTYPE;
    V_NUM TBL_INSA.NUM%TYPE := 1001;
BEGIN
    LOOP
        SELECT NAME, TEL, BUSEO
            INTO V_INSA.NAME, V_INSA.TEL, V_INSA.BUSEO
        FROM TBL_INSA
        WHERE NUM = V_NUM;
        
        DBMS_OUTPUT.PUT_LINE(V_INSA.NAME || '-' || V_INSA.TEL || '-' || V_INSA.BUSEO);
        
        V_NUM := V_NUM + 1;
        EXIT WHEN V_NUM > 1060;
    END LOOP;
END;


-- ■■■ FUNCTION (함수) ■■■ --
-- 1. 함수란 하나 이상의 PL/SQL 문으로 구성된 서브루틴으로
--    코드를 다시 사용할 수 있도록 캡슐화 하는데 사용된다.
--    오라클에서는 오라클에 정의된 기본 제공 함수를 사용하거나
--    직접 스토어드 함수를 만들 수 있다.(→ 사용자 정의 함수)
--    이 사용자 정의 함수는 시스템 함수처럼 쿼리에서 호출하거나
--    저장 프로시저처럼 EXECUTE 문을 통해 실행할 수 있다.

-- 2. 형식 및 구조
/*
CREATE [OR REPLACE] FUNCTION 함수명
[( 매개변수명1 자료형
 , 매개변수명2 자료형
 )]
RETURN 데이터타입
IS
    -- 주료 변수 선언
BEGIN
    -- 실행문 ;
    ...
    RETURN(값);
    
    [EXCEPTION]
        -- 예외처리구문;
END;        
*/

-- ※ 사용자정의 함수(스토어드 함수)는
--    IN 파라미터(입력 매개변수)만 사용할 수 있으며
--    반드시 반환될 값의 데이터타입을 RETURN 문에 선언해야 하고,
--    FUNCTION 은 반드시 단일 값만 반환한다.

-- ○ TBL_INSA 테이블 전용 성별 확인 함수 정의(생성)
-- 함수명 : FN_GENDER()
--                   ↑ SSN(주민등록번호) → '771212-1022432' → 'YYMMDD-NNNNNNN'

CREATE OR REPLACE FUNCTION FN_GENDER( V_SSN VARCHAR2 )  -- 매개변수   : 자릿수(길이) 지정안함
RETURN VARCHAR2                                         -- 반환자료형 : 자릿수(길이) 지정안함                
IS
    -- 선언부   → 주요 변수 선은
    V_RESULT    VARCHAR2(20);
BEGIN
    -- 실행부  → 연산 및 처리
    IF ( SUBSTR(V_SSN, 8, 1) IN ('1', '3')  )
        THEN V_RESULT := '남자';
    ELSIF (  SUBSTR(V_SSN, 8, 1) IN ('2', '4') )    
        THEN V_RESULT := '여자';
    ELSE
        V_RESULT := '성별확인불가';
    END IF;
    
    -- 결과값 반환   CHECK~!!
    RETURN V_RESULT;
END;
--==>> Function FN_GENDER이(가) 컴파일되었습니다.

-- ○ 임의의 정수 두 개를 매개변수 (입력파라미터)로 넘겨받아 → (A, B)
--    A 의 B 승의 값을 반환하는 사용자 정의 함수를 작성한다.
--    단, 기존의 오라클 내장 함수를 이용하지 않고, 반복문을 활용
--    함수명 : FN_POW()
/*
사용 예)
SELECT FN_POW(10, 3)
FROM DUAL;
--==>> 1000
*/



CREATE OR REPLACE FUNCTION FN_POW(N1 NUMBER, N2 NUMBER)
RETURN NUMBER
IS
    N_RESULT    NUMBER :=1;
    K   NUMBER;
BEGIN
    IF N2 >= 0
        THEN FOR K IN 1.. N2 LOOP
                N_RESULT := N_RESULT * N1;
             END LOOP;
    ELSIF N2 < 0
            THEN FOR K IN -1.. N2 LOOP
                N_RESULT := N1 * 0.1;
             END LOOP;
    ELSE  
        N_RESULT := 0;
    END IF;        
    
    -- 최종 결과값 반환
    RETURN N_RESULT;
END;
--==>> Function FN_POW이(가) 컴파일되었습니다.
--> 이건 반만 만든거야.. 음수인경우도 생각해야지
--> 나는 음수도햇다

