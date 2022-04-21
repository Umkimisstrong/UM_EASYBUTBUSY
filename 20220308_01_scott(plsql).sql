SELECT USER
FROM DUAL;
--==>> SCOTT

-- ○ IF문(조건문)
-- IF ~ THEN ~ ELSE ~ END IF;

-- 1. PL / SQL 의 IF문장은 다른언어의 IF 조건문가 거의 유사
--    일치하는 조건에 다라 선택적으로 작업을 수행할 수 있도록 한다.
--    TRUE 이면 THEN 과 ELSE 사이의 문장을 수행
--    FALSE 나 NULL 이면 ELSE 와 END IF; 사이의 문장을 수행

-- 2. 형식 및 구조
/*
IF 조건
   THEN 처리문;
END IF;


IF 조건
    THEN 처리문;
ELSE
    처리문;
END IF;    
*/

/*
IF 조건
   THEN 처리문;
END IF;


IF 조건
    THEN 처리문;
ELSIF 조건
    THEN 처리문;
ELSIF 조건
    THEN 처리문;
ELSE    
    처리문;
END IF;    
*/
SET SERVEROUTPUT ON;

-- ○ 변수에 임의의 값을 대입하고 출력하는 구문 작성
DECLARE
    GRADE CHAR;
BEGIN
    GRADE := 'C';
    --DBMS_OUTPUT.PUT_LINE(GRADE);
    IF GRADE = 'A'
        THEN DBMS_OUTPUT.PUT_LINE('EXCELLENT');
    ELSIF GRADE = 'B'
        THEN DBMS_OUTPUT.PUT_LINE('BEST');
    ELSIF GRADE = 'C'
        THEN DBMS_OUTPUT.PUT_LINE('COOL');    
    ELSE
        DBMS_OUTPUT.PUT_LINE('FAIL');
    END IF;
    
END;
/*
EXCELLENT
PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/


-- ○ CASE 문(조건문)
-- CASE ~ WHEN ~ THEN ~ ELSE ~ END CASE;

-- 1. 형식 및 구조
/*
CASE 변수
    WHEN 값1 THEN 실행문;
    WHEN 값2 THEN 실행문;
    ELSE 실행문;
END CASE;
*/

ACCEPT NUM PROMPT '남자1 여자2 입력하세요';

DECLARE
    SEL NUMBER := &NUM;
    RESULT VARCHAR2(10) := '남자';
BEGIN
    -- 테스트
    --DBMS_OUTPUT.PUT_LINE('SEL : ' || SEL);
    --DBMS_OUTPUT.PUT_LINE('RESULT : ' || RESULT);
    
    -- 연산 및 처리
    /*
    CASE SEL
        WHEN 1
        THEN DBMS_OUTPUT.PUT_LINE('남자입니다.');
        WHEN 2
        THEN DBMS_OUTPUT.PUT_LINE('여자입니다.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('확인불가');
    END CASE;
    */
    
    CASE SEL
        WHEN 1
        THEN RESULT := '남자';
        WHEN 2
        THEN RESULT := '여자';
        ELSE
            RESULT := '확인불가';
    END CASE;
    
    -- 결과 출력
    DBMS_OUTPUT.PUT_LINE('처리 결과는 ' || RESULT || '입니다.');
END;
/*
여자입니다.
*/

-- ※ 외부 입력 처리
-- ACCEPT 구문
-- ACCEPT 변수명 PROMPT '메세지';
-- 외부 변수로부터 입력받은 데이터를 내부 변수에 전달할때
-- 『&외부변수명』 형태로접근하게 ㅗ딘다.

-- ○ 정수 2개를 외부로부터(사용자로부터) 입력받아
--    이들의 덧셈 결과를 출력하는 PL/SQL 구문을 작성한다.
ACCEPT NUM1 PROMPT '첫 번째 정수를 입력하세요';
ACCEPT NUM2 PROMPT '두 번째 정수를 입력하세요';

DECLARE
    SEL1 NUMBER := &NUM1;
    SEL2 NUMBER := &NUM2;
    TOTAL NUMBER := 0;
    
BEGIN
    -- 테스트
    --DBMS_OUTPUT.PUT_LINE('SEL1 : ' || SEL1);
    --DBMS_OUTPUT.PUT_LINE('SEL2 : ' || SEL2);
    
    -- 연산 및 처리
    TOTAL := SEL1 + SEL2; 
    
    -- 결과 출력
    DBMS_OUTPUT.PUT_LINE(SEL1 || ' + ' || SEL2 || ' = ' || TOTAL);
END;
--==>> 20 + 30 = 50

-- ○ 사용자로부터 입력받은 금액을 화폐단위로 구분하여 출력하는 프로그램을 작성한다.
--    단, 반환 금액은 편의상 1천원 미만, 10원 이상만 가능하다고 가정한다.
/*
실행 예)
바인딩 변수 입력 대화창 → 금액 입력 : 990

입력받은 금액 총액 : 990원
화폐단위 : 오백원 1, 백원 4, 오십원 1, 십원 4
*/

ACCEPT WON PROMPT '반환받을 금액(10원이상~1000원미만) 입력';

DECLARE
    REST  NUMBER := &WON;   -- 연산을 위해 입력값을 담아둘 변수
    REST2 NUMBER := &WON;   -- 입력값을 그대로 반환해줄 변수
    
    A NUMBER;
    B NUMBER;
    C NUMBER;
    D NUMBER;
    
BEGIN
        -- ○ 연산 및 처리
    -- REST 를 500으로 나눠서 몫을 취하고 나머지 버린다 → 500원 갯수
    A := TRUNC(REST / 500);
        
    -- REST 를 500으로 나눠서 몫은 버리고 나머지 취한다. → 500원 갯수 확인 후 남은 금액
    REST := MOD(REST, 500);
       
    -- REST 를 100으로 나눠서 몫은 취하고 나머지 버린다. → 500원 갯수 확인 후 남은 금액 중 100원 갯수       
    B := TRUNC(REST / 100);
    
    -- REST 를 100으로 나눠서 몫은 버리고 나머지 취한다. → 100원 갯수 확인 후 남은 금액
    REST := MOD(REST, 100);
    
    -- REST 를 50으로 나눠서 몫은 취하고 나머지 버린다. → 100원 갯수 확인 후 남은 금액 중 50원 갯수       
    C := TRUNC(REST / 50);
    
    -- REST 를 50으로 나눠서 몫은 버리고 나머지 취한다. → 50원 갯수 확인 후 남은 금액
    REST := MOD(REST, 50);
    
    -- REST 를 10으로 나눠서 몫은 취하고 나머지 버린다. → 50원 갯수 확인 후 남은 금액 중 10원 갯수       
    D := TRUNC(REST / 10);
    
    DBMS_OUTPUT.PUT_LINE('입력받은 금액 총액 : ' || REST2 ||'원');
    DBMS_OUTPUT.PUT_LINE('화폐단위 : ' || '오백원 ' || A || ', 백원 ' || B || ', 오십원 ' || C || ', 십원 ' || D);
END;
/*
입력받은 금액 총액 : 990원
화폐단위 : 오백원  1, 백원 4, 오십원 1, 십원 4
PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/

-- ○ 기본 반복문
-- LOOP ~ END LOOP;
-- 1. 조건과 상관없이 무조건 반복하는 구문.
-- 2. 형식 및 구조
/*
LOOP
    -- 실행문
    
    EXIT WHEN 조건; -- 조건이 참인 경우 반복문을 빠져나간다.
END LOOP;
*/
-- 1부터 10까지의 수 출력(LOOP문 활용)
DECLARE
    N NUMBER;
BEGIN
    N := 1;
    
    LOOP
        DBMS_OUTPUT.PUT_LINE(N);
        EXIT WHEN N >= 10;
        N := N + 1;             -- 『JAVA N++;, N+=1;』
    END LOOP;        
END;
/*
1
2
3
4
5
6
7
8
9
10
PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/

-- ○ WHILE 반복문
-- WHILE LOOP ~ END LOOP;

-- 1. 제어 조건이 TRUE 인 동안 일련의 문장을 반복하기 위해
--    WHILE LOOP 구문을 사용한다.
--    조건은 반복이 시작되는 시점에 체크하게 되어
--    LOOP 내의 문장이 한 번도 수행되지 않을 경우도 있다.
--    LOOP 를 시작할 대 조건이 FALSE 이면 반복 문장을 탈출하게 된다.

-- 2. 형식 및 구조
/*
WHILE 조건 LOOP       -- 조건이 참인 경우 반복 수행.
   -- 실행문;
END LOOP;
*/

DECLARE 
    N NUMBER;
BEGIN
    N := 0;
    WHILE N<10 LOOP
        N:= N+1;
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;

-- ○ FOR 반복문
-- FOR LOOP ~ END LOOP;
-- 1. 『시작수』 에서 1씩 증가하여
--    『끝냄수』 가 될 때 까지 반복 수행한다.

-- 2. 형식 및 구조
/*
FOR LOOP
END LOOP
*/

DECLARE
    N NUMBER;
BEGIN
    FOR N IN 1.. 10 LOOP
        DBMS_OUTPUT.PUT_LINE(N);
    END LOOP;
END;
/*
1
2
3
4
5
6
7
8
9
10
PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/

-- ○ 사용자로부터 임의의 단 (구구단) 을 입력받아
--    해당 단수의 구구단을 출력하는 PL/SQL 구문을 작성한다.
/*
실행 예)
바인딩 변수 입력 대화창 → 단을 입력하세요 : 2
2 * 1 = 2
2 * 2 = 4
2 * 3 = 6
  :
2 * 9 = 18
*/

ACCEPT N PROMPT '단을 입력하세요';

DECLARE
    NUM NUMBER := &N;
    K NUMBER;
BEGIN
    K := 1;
    
    LOOP
        DBMS_OUTPUT.PUT_LINE(NUM || ' * ' || K || ' = ' || NUM*K );
        EXIT WHEN K >= 9;
        K := K+1;
    END LOOP;
END;
/*
3 * 1 = 3
3 * 2 = 6
3 * 3 = 9
3 * 4 = 12
3 * 5 = 15
3 * 6 = 18
3 * 7 = 21
3 * 8 = 24
3 * 9 = 27
*/

ACCEPT N PROMPT '단을 입력하세요';

DECLARE
    NUM NUMBER := &N;
    K NUMBER;
BEGIN
    K := 0;
    WHILE K < 9 LOOP
        K := K+1;
        DBMS_OUTPUT.PUT_LINE(NUM || ' * ' || K || ' = ' || NUM*K );
        
    END LOOP;
END;
/*
3 * 1 = 3
3 * 2 = 6
3 * 3 = 9
3 * 4 = 12
3 * 5 = 15
3 * 6 = 18
3 * 7 = 21
3 * 8 = 24
3 * 9 = 27
*/

ACCEPT N PROMPT '단을 입력하세요';

DECLARE
    NUM NUMBER := &N;
    K NUMBER;
BEGIN
    FOR K IN 1.. 9 LOOP
        DBMS_OUTPUT.PUT_LINE(NUM || ' * ' || K || ' = ' || NUM*K );
    END LOOP;
END;
/*
3 * 1 = 3
3 * 2 = 6
3 * 3 = 9
3 * 4 = 12
3 * 5 = 15
3 * 6 = 18
3 * 7 = 21
3 * 8 = 24
3 * 9 = 27
*/


-- ○ 구구단 전체(2단 ~ 9단) 를 출력하는 PL/SQL 구문을 작성한다.
--    단, 이중 반복문(반복문의 중첩)구문을 활용한다.
/*
실행 예)
== [2단] ==
   :
   
== [9단] ==
9 * 9 = 81
*/

DECLARE
    A NUMBER;
    B NUMBER;
    C NUMBER;
BEGIN
    A := 2;
    B := 1;
    C := 1;
    LOOP
        DBMS_OUTPUT.PUT_LINE('== ['|| A || '단] ==');
            LOOP
                DBMS_OUTPUT.PUT_LINE(A || ' * '|| B || ' = ' || A*B);
                EXIT WHEN B >=9;
                B := B+1;
            END LOOP;
        EXIT WHEN A >= 9;
        B := C;            
        A := A+1;
    END LOOP;
END;
/*
== [2단] ==
2 * 1 = 2
2 * 2 = 4
2 * 3 = 6
2 * 4 = 8
2 * 5 = 10
2 * 6 = 12
2 * 7 = 14
2 * 8 = 16
2 * 9 = 18
== [3단] ==
3 * 1 = 3
3 * 2 = 6
3 * 3 = 9
3 * 4 = 12
3 * 5 = 15
3 * 6 = 18
3 * 7 = 21
3 * 8 = 24
3 * 9 = 27
== [4단] ==
4 * 1 = 4
4 * 2 = 8
4 * 3 = 12
4 * 4 = 16
4 * 5 = 20
4 * 6 = 24
4 * 7 = 28
4 * 8 = 32
4 * 9 = 36
== [5단] ==
5 * 1 = 5
5 * 2 = 10
5 * 3 = 15
5 * 4 = 20
5 * 5 = 25
5 * 6 = 30
5 * 7 = 35
5 * 8 = 40
5 * 9 = 45
== [6단] ==
6 * 1 = 6
6 * 2 = 12
6 * 3 = 18
6 * 4 = 24
6 * 5 = 30
6 * 6 = 36
6 * 7 = 42
6 * 8 = 48
6 * 9 = 54
== [7단] ==
7 * 1 = 7
7 * 2 = 14
7 * 3 = 21
7 * 4 = 28
7 * 5 = 35
7 * 6 = 42
7 * 7 = 49
7 * 8 = 56
7 * 9 = 63
== [8단] ==
8 * 1 = 8
8 * 2 = 16
8 * 3 = 24
8 * 4 = 32
8 * 5 = 40
8 * 6 = 48
8 * 7 = 56
8 * 8 = 64
8 * 9 = 72
== [9단] ==
9 * 1 = 9
9 * 2 = 18
9 * 3 = 27
9 * 4 = 36
9 * 5 = 45
9 * 6 = 54
9 * 7 = 63
9 * 8 = 72
9 * 9 = 81
PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/

DECLARE
    A NUMBER;
    B NUMBER;
    C NUMBER;
BEGIN
    A := 1;
    B := 0;
    C := 0;
    
    WHILE A < 9 LOOP
        A := A+1;
        DBMS_OUTPUT.PUT_LINE('== [' || A || '단] ==');
        WHILE B < 9 LOOP
            B := B+1;
            DBMS_OUTPUT.PUT_LINE(A || ' * ' || B || ' = ' || A * B); 
        END LOOP;
        B := C;
    END LOOP;
END;
/*
== [2단] ==
2 * 1 = 2
2 * 2 = 4
2 * 3 = 6
2 * 4 = 8
2 * 5 = 10
2 * 6 = 12
2 * 7 = 14
2 * 8 = 16
2 * 9 = 18
== [3단] ==
3 * 1 = 3
3 * 2 = 6
3 * 3 = 9
3 * 4 = 12
3 * 5 = 15
3 * 6 = 18
3 * 7 = 21
3 * 8 = 24
3 * 9 = 27
== [4단] ==
4 * 1 = 4
4 * 2 = 8
4 * 3 = 12
4 * 4 = 16
4 * 5 = 20
4 * 6 = 24
4 * 7 = 28
4 * 8 = 32
4 * 9 = 36
== [5단] ==
5 * 1 = 5
5 * 2 = 10
5 * 3 = 15
5 * 4 = 20
5 * 5 = 25
5 * 6 = 30
5 * 7 = 35
5 * 8 = 40
5 * 9 = 45
== [6단] ==
6 * 1 = 6
6 * 2 = 12
6 * 3 = 18
6 * 4 = 24
6 * 5 = 30
6 * 6 = 36
6 * 7 = 42
6 * 8 = 48
6 * 9 = 54
== [7단] ==
7 * 1 = 7
7 * 2 = 14
7 * 3 = 21
7 * 4 = 28
7 * 5 = 35
7 * 6 = 42
7 * 7 = 49
7 * 8 = 56
7 * 9 = 63
== [8단] ==
8 * 1 = 8
8 * 2 = 16
8 * 3 = 24
8 * 4 = 32
8 * 5 = 40
8 * 6 = 48
8 * 7 = 56
8 * 8 = 64
8 * 9 = 72
== [9단] ==
9 * 1 = 9
9 * 2 = 18
9 * 3 = 27
9 * 4 = 36
9 * 5 = 45
9 * 6 = 54
9 * 7 = 63
9 * 8 = 72
9 * 9 = 81
PL/SQL 프로시저가 성공적으로 완료되었습니다.
*/

DECLARE
    A NUMBER;
    B NUMBER;
    C NUMBER;
BEGIN
    FOR A IN 2..9 LOOP
        DBMS_OUTPUT.PUT_LINE('== [' || A || '단] ==');
        FOR B IN 1..9 LOOP
            DBMS_OUTPUT.PUT_LINE(A || ' * ' || B || ' = ' || A*B);
        END LOOP;
    END LOOP;
END;
/*
== [2단] ==
2 * 1 = 2
2 * 2 = 4
2 * 3 = 6
2 * 4 = 8
2 * 5 = 10
2 * 6 = 12
2 * 7 = 14
2 * 8 = 16
2 * 9 = 18
== [3단] ==
3 * 1 = 3
3 * 2 = 6
3 * 3 = 9
3 * 4 = 12
3 * 5 = 15
3 * 6 = 18
3 * 7 = 21
3 * 8 = 24
3 * 9 = 27
== [4단] ==
4 * 1 = 4
4 * 2 = 8
4 * 3 = 12
4 * 4 = 16
4 * 5 = 20
4 * 6 = 24
4 * 7 = 28
4 * 8 = 32
4 * 9 = 36
== [5단] ==
5 * 1 = 5
5 * 2 = 10
5 * 3 = 15
5 * 4 = 20
5 * 5 = 25
5 * 6 = 30
5 * 7 = 35
5 * 8 = 40
5 * 9 = 45
== [6단] ==
6 * 1 = 6
6 * 2 = 12
6 * 3 = 18
6 * 4 = 24
6 * 5 = 30
6 * 6 = 36
6 * 7 = 42
6 * 8 = 48
6 * 9 = 54
== [7단] ==
7 * 1 = 7
7 * 2 = 14
7 * 3 = 21
7 * 4 = 28
7 * 5 = 35
7 * 6 = 42
7 * 7 = 49
7 * 8 = 56
7 * 9 = 63
== [8단] ==
8 * 1 = 8
8 * 2 = 16
8 * 3 = 24
8 * 4 = 32
8 * 5 = 40
8 * 6 = 48
8 * 7 = 56
8 * 8 = 64
8 * 9 = 72
== [9단] ==
9 * 1 = 9
9 * 2 = 18
9 * 3 = 27
9 * 4 = 36
9 * 5 = 45
9 * 6 = 54
9 * 7 = 63
9 * 8 = 72
9 * 9 = 81
*/














