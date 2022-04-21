SELECT USER
FROM DUAL;
--==>> SCOTT


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
--> 나는 음수도햇다

-- ○ TBL_INSA 테이블의 급여 계산 전용 함수를 정의한다.
--    급여는 『(기본급*12)+수당』 연산을 기반으로 수행한다.
--    함수명 : FN_PAY(기본급, 수당)
CREATE OR REPLACE FUNCTION FN_PAY(BP NUMBER, SD NUMBER)
RETURN NUMBER
IS
    N_RESULT NUMBER :=1;
BEGIN
    N_RESULT := (NVL(BP, 0)*12) + NVL(SD, 0);
    RETURN N_RESULT;
END;
--==>> Function FN_PAY이(가) 컴파일되었습니다.

-- ○ TBL_INSA 테이블에서 입사일을 기준으로 현재까지의
--    근무년수를 반환하는 함수를 정의한다.
--    단, 근무년수는 소수점 이하 한자리까지 계산한다.
--    함수명 : FN_WORKYEAR(입사일)

CREATE OR REPLACE FUNCTION FN_WORKYEAR(WY DATE)
RETURN NUMBER
IS
    N_RESULT NUMBER;
BEGIN
    N_RESULT := TRUNC((MONTHS_BETWEEN(SYSDATE, WY) / 12), 1);
    RETURN N_RESULT;
END;
--==>> Function FN_WORKYEAR이(가) 컴파일되었습니다.
--------------------------------------------------------------------------------
-- ※ 참고
-- 1. INSERT, UPDATE, DELETE, (MERGE)
--==>> DML(Data Maniputation Language)
-- COMMIT / ROLLBACK 이 필요하다.

-- 2. CREATE, DROP, ALTER, (TRUNCATE)
--==>> DDL(Data Definition Language)
-- 실행하면 자동으로 COMMIT 된다.

-- 3. GRANT, REVOKE
--==>> DCL(Data Control Language)
-- 실행하면 자동으로 COMMIT 된다.

-- 4. COMMIT, ROLLBACK
--==>> TCL(Transaction Control Language)

-- 정적 pl/sql 문 → DML 문, TCL 문만 사용 가능하다.
-- 동적 pl/sql 문 → DML 문, DDL 문, DCL 문, TCL 문 사용 가능하다.

--------------------------------------------------------------------------------

-- ■■■ PROCEDURE(프로시저) ■■■ --

-- 1. PL/SQL 에서 가장 대표적인 구조인 스토어드 프로시저는
--    개발자가 자주 작성해야 하는 업무의 흐름을
--    미리 작성하여 데이터베이스 내에 저장해 두었다가
--    필요할 때 마다 호출하여 실행할 수 있도록  처리해 주는 구문이다.

-- 2. 형식 및 구조
/*
CREATE [OR REPLACE] PROCEDURE 프로시저명
[( 매개변수 IN 데이터타입
 , 매개변수 OUT 데이터타입
 , 매개변수 INOUT 데이터타입
)]
IS
    [-- 주요 변수 선언]
BEGIN
    -- 실행 구문;
    ...
    
    [EXCEPTION
        -- 예외 처리 구문;]
END;
*/

-- ※ FUNCTION 과 비교했을 때 『RETURN 반환자료형』 부분이 존재하지 않으며,
--    『RETURN』문 자체도 존재하지 않으며,
--    프로시저 실행 시 넘겨주게 되는 매개변수의 종류는
--    IN(입력), OUT(출력), INOUT(입출력) 으로 구분된다.
--    
-- 3. 실행 (호출)
/*
EXCE[UTE] 프로시저명[(인수1, 인수2, ...)];
*/

-- ※ 프로시저 실습을 위한 테이블 생성은
--    『20220310_02_scott.sql』 파일 참조~!!!

-- → FUNCTION 은 입력매개변수밖에없음
-- → PROCEDURE 은 입 / 출력 매개변수 설정가능
--    따라서 IN / OUT 명시
CREATE OR REPLACE PROCEDURE PRC_STUDENT_INSERT
( V_ID      IN TBL_IDPW.ID%TYPE
, V_PW      IN TBL_IDPW.PW%TYPE
, V_NAME    IN TBL_STUDENTS.NAME%TYPE
, V_TEL     IN TBL_STUDENTS.TEL%TYPE
, V_ADDR    IN TBL_STUDENTS.ADDR%TYPE
)
IS
BEGIN
    -- TBL_IDPW 테이블에 데이터 입력(INSERT)
    INSERT INTO TBL_IDPW(ID, PW)
    VALUES(V_ID, V_PW);    
    -- TBL_STUDENTS 테이블에 데이터 입력(INSERT)
    INSERT INTO TBL_STUDENTS(ID, NAME, TEL, ADDR)
    VALUES(V_ID, V_NAME, V_TEL, V_ADDR);    
    -- 커밋
    COMMIT;
END;

-- ※ 프로시저 실습을 위한 테이블 생성은
--    『20220310_02_scott.sql』 파일 참조!!

-- ○ 데이터 입력시 특정 항목의 데이터만 입력하면
--                  ---------
--                  (학번, 이름, 국어점수, 영어점수, 수학점수)
--    내부적으로 다른 추가항목에 대한 처리가 함께 이루어질 수 있도록 하는
--                     ------
--                   (총점, 평균, 등급)
--    프로시저를 작성한다.(생성한다.)
--    프로시저 명 : PRC_SUNGJUK_INSERT()
/*
실행 예)
EXEC PRC_SUNGJUK_INSERT(1, '최선하', 90, 80, 70);

프로시저 호출로 처리된 결과
학번  이름  국어점수    영어점수    수학점수    총점  평균  등급
  1  최선하   90         80          70         240    80    B
*/
CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_INSERT
( V_HAK     IN TBL_SUNGJUK.HAKBUN%TYPE
, V_NAME    IN TBL_SUNGJUK.NAME%TYPE
, V_KOR     IN TBL_SUNGJUK.KOR%TYPE
, V_ENG     IN TBL_SUNGJUK.ENG%TYPE
, V_MAT     IN TBL_SUNGJUK.MAT%TYPE
)
IS
    V_TOT   TBL_SUNGJUK.TOT%TYPE;
    V_AVG   TBL_SUNGJUK.AVG%TYPE;
    V_GRADE   TBL_SUNGJUK.GRADE%TYPE;
BEGIN
    V_TOT := V_KOR + V_ENG + V_MAT;
    V_AVG := V_TOT / 3;
    
    IF V_AVG >= 90
        THEN V_GRADE := 'A';
    ELSIF V_AVG >= 80
        THEN V_GRADE := 'B';
    ELSIF V_AVG >= 70
        THEN V_GRADE := 'C';
    ELSIF V_AVG >= 60
        THEN V_GRADE := 'D';
    ELSE
        V_GRADE := 'F';
    END IF;
    
    
    INSERT INTO TBL_SUNGJUK(HAKBUN, NAME, KOR, ENG, MAT, TOT, AVG, GRADE)
    VALUES (V_HAK, V_NAME, V_KOR, V_ENG, V_MAT, V_TOT, V_AVG, V_GRADE);
    
    COMMIT;
END;
--==>> Procedure PRC_SUNGJUK_INSERT이(가) 컴파일되었습니다.


-- ○ TBL_SUNGJUK 테이블에서 특정 학생의 점수
--    (학번, 국어점수, 영어점수, 수학점수) 데이터 수정 시
--    총점, 평균, 등급까지 함께 수정되는 프로시저를 생성한다.
--    프로시저 명 : PRC_SUNGJUK_UPDATE()
/*
실행 예
EXEC PRC_SUNGJUK_UPDATE(2, 50, 50, 50);
  1  최선하   90         80          70         240    80    B
  2  박현수   50         50          50         150    50    F
*/

CREATE OR REPLACE PROCEDURE PRC_SUNGJUK_UPDATE
( U_HAK IN TBL_SUNGJUK.HAKBUN%TYPE
, U_KOR IN TBL_SUNGJUK.KOR%TYPE
, U_ENG IN TBL_SUNGJUK.ENG%TYPE
, U_MAT IN TBL_SUNGJUK.MAT%TYPE
)
IS
  U_TOT     TBL_SUNGJUK.TOT%TYPE;
  U_AVG     TBL_SUNGJUK.AVG%TYPE;
  U_GRADE   TBL_SUNGJUK.GRADE%TYPE;
BEGIN
    U_TOT := U_KOR + U_ENG + U_MAT;
    U_AVG := U_TOT /3;
    
    IF U_AVG >= 90
        THEN U_GRADE := 'A';
    ELSIF U_AVG>= 80
        THEN U_GRADE := 'B';
    ELSIF U_AVG>= 70
        THEN U_GRADE := 'C';
    ELSIF U_AVG>= 60
        THEN U_GRADE := 'D';
    ELSE
         U_GRADE := 'F';
    END IF;
    
    -- UPDATE 쿼리문
    UPDATE  TBL_SUNGJUK
    SET KOR = U_KOR, ENG = U_ENG, MAT = U_MAT
            , TOT = U_TOT, AVG = U_AVG, GRADE = U_GRADE
    WHERE HAKBUN = U_HAK;
    
    -- 커밋
    COMMIT;
END;
--==>> Procedure PRC_SUNGJUK_UPDATE이(가) 컴파일되었습니다.

-- ○ TBL_STUDENTS 테이블에서 전화번호와 주소 데이터를 수정하는(변경하는)
--    프로시저를 작성한다.
--    단, ID 와 PW 가 일치하는 경우에만 수정을 진행할 수 있도록 처리한다.

-- 방법1. -- FLAG 를 세워 조건에 맞게 테이블 업데이트
CREATE OR REPLACE PROCEDURE PRC_STUDENTS_UPDATE
( U_ID IN TBL_IDPW.ID%TYPE 
, U_PW IN TBL_IDPW.PW%TYPE 
, U_TEL IN TBL_STUDENTS.TEL%TYPE
, U_ADDR IN TBL_STUDENTS.ADDR%TYPE
)
IS 
    V_PW    TBL_IDPW.PW%TYPE;
    V_FLAG  NUMBER := 0;
BEGIN

    SELECT PW   INTO V_PW
    FROM TBL_IDPW
    WHERE ID = U_ID;
    
    IF U_PW = V_PW
        THEN V_FLAG :=1;
    ELSE
        V_FLAG :=2;
    END IF;        
    
    UPDATE TBL_STUDENTS
    SET TEL = U_TEL, ADDR = U_ADDR
    WHERE ID = U_ID AND V_FLAG = 1;
    
    -- COMMIT 
    COMMIT;
END;  
--==>> Procedure PRC_STUDENTS_UPDATE이(가) 컴파일되었습니다.

-- 방법2. 조건이포함된 테이블 2개를 조인하여 업데이트.
CREATE OR REPLACE PROCEDURE PRC_STUDENTS_UPDATE
( U_ID IN TBL_IDPW.ID%TYPE 
, U_PW IN TBL_IDPW.PW%TYPE 
, U_TEL IN TBL_STUDENTS.TEL%TYPE
, U_ADDR IN TBL_STUDENTS.ADDR%TYPE
)
IS 
BEGIN
    UPDATE  (SELECT T1.ID, T1.PW, T2.TEL, T2.ADDR
             FROM TBL_IDPW T1 JOIN TBL_STUDENTS T2
             ON T1.ID = T2.ID)T
    SET T.TEL = U_TEL, T.ADDR = U_ADDR
    WHERE T.ID = U_ID
            AND T.PW = U_PW;
    --커밋
    COMMIT;
END;  
--==>> Procedure PRC_STUDENTS_UPDATE이(가) 컴파일되었습니다.
