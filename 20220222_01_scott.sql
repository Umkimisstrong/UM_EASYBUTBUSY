SELECT USER
FROM DUAL;
--==>> SCOTT


-- ○ ROUND() 반올림을 처리해 주는 함수
SELECT 48.678 "COL1"
    , ROUND(48.678, 2) "COL2" -- 소숫점이하 둘째자리까지 표현
    , ROUND(48.674, 2) "COL3" -- 소숫점이하 둘째자리까지 표현
    , ROUND(48.674, 1) "COL4" -- 소숫점이하 첫째자리가지 표현
    , ROUND(48.674, 0) "COL5" -- 1의자리까지 표현
    , ROUND(48.674) "COL6"    -- 1의자리까지 표현(0디폴트)
    , ROUND(48.674, -1) "COL7"-- 10의자리까지 표현
    , ROUND(48.674, -2) "COL8"-- 100의자리까지 표현
    , ROUND(48.674, -3) "COL9"-- 1000의자리까지 표현
    , ROUND(1234.1234, -1) "COL10"
    , ROUND(1234.1234, -2) "COL11"
FROM DUAL;

-- ○ TRUNC() 절삭을 처리해 주는 함수

SELECT 48.678 "COL1"
    , TRUNC(48.678, 2) "COL2" -- 소숫점이하 둘째자리까지 표현
    , TRUNC(48.674, 2) "COL3" -- 소숫점이하 둘째자리까지 표현
    , TRUNC(48.674, 1) "COL4" -- 소숫점이하 첫째자리가지 표현
    , TRUNC(48.674, 0) "COL5" -- 1의자리까지 표현
    , TRUNC(48.674) "COL6"    -- 1의자리까지 표현(0디폴트)
    , TRUNC(48.674, -1) "COL7"-- 10의자리까지 표현
    , TRUNC(48.674, -2) "COL8"-- 100의자리까지 표현
    , TRUNC(48.674, -3) "COL9"-- 1000의자리까지 표현
FROM DUAL;

-- ○ MOD()  나머지를 반환하는 함수
SELECT MOD(5, 2) "RESULT"
FROM DUAL;
--==>> 1 

-- ○ POWER() 제곱의 결과를 반환하는 함수
SELECT POWER(5, 3) "RESULT"
FROM DUAL;
--==>> 125

-- ○ SQRT() 루트 결과값을 반환하는 함수
SELECT SQRT(2) "RESULT"
FROM DUAL;
--==>> 1.41421356237309504880168872420969807857

-- ○ LOG() 로그 함수
--    오라클은 상용로그만 지원하는 반면 MSSQL은 상용로그ㆍ자연로그 모두 지원)
SELECT LOG(10, 100) "COL1"
     , LOG(10, 20) "COL2"
FROM DUAL;
--==>> 2	1.30102999566398119521373889472449302677

-- ○ 삼각함수
SELECT SIN(1), COS(1), TAN(1)
FROM DUAL;
/*
0.8414709848078965066525023216302989996233  싸인
0.5403023058681397174009366074429766037354  코싸인
1.55740772465490223050697480745836017308    탄젠트

*/
-- ○ 삼각함수의 역함수(범위 : -1 ~ 1)
SELECT ASIN(0.5), ACOS(0.5), ATAN(0.5)
FROM DUAL;
/*
0.52359877559829887307710723054658381405	 어싸인
1.04719755119659774615421446109316762805	 어코싸인
0.4636476090008061162142562314612144020295   어탄젠트
*/

-- ○ SIGN() 서명 부호 특징
--    연산 결과값이 양수이면 1, 0이면 0, 음수이면 -1 반환
SELECT SIGN(5-2) "COL1", SIGN(5-5) "COL2", SIGN(5-8) "COL3"
FROM DUAL;
--==>> 1	0	-1 
--> 매출이나 수지와 관련하여 적자 및 흑자의 개념을 나타낼때 사용

-- ○ ASCII(), CHR() → 서로 대응(상응)하는 함수
SELECT ASCII('A') "COL1"
     , CHR(65) "COL2"
FROM DUAL;
--==>> 65	A
--> 『 ASCII() 』 : 매개변수로 넘겨받은 문자의 아스키코드값을 반환
--> 『 CHR() 』   : 매개변수로 넘겨받은 아스키코드값으로 해당 문자르 반환한다.


-- ※ 날짜관련 세션 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session이(가) 변경되었습니다.
SELECT SYSDATE "COL1"      -- 2022-02-22 09:44:11
      , SYSDATE + 1 "COL2" -- 2022-02-23 09:44:11	
      , SYSDATE - 2 "COL3" -- 2022-02-20 09:44:11
      , SYSDATE - 30 "COL4"-- 2022-01-23 09:44:11
FROM DUAL;
--==>>

-- ○ 시간 단위 연산
SELECT  SYSDATE   "COL1"           
      , SYSDATE + 1/24 "COL2"  -- 1시간 뒤
      , SYSDATE - 2/24 "COL3"  -- 2시간 전
FROM DUAL;
/*
2022-02-22 09:48:02	
2022-02-22 10:48:02	
2022-02-22 07:48:02
*/
-- ○ 현재 시간과.. 현재시간 기준 1일 2시간 3분 4초 후를 조회하는 쿼리문 구성
-- 방법 1.
SELECT SYSDATE "현재시간" 
    , SYSDATE + 1 + (2/24) + ((1/24)/20) + ((1/24)/900) "연산 후 시간"
FROM DUAL;
/*
===================     ===================
     현재 시간             연산 후 시간
===================     ===================
2022-02-22 10:05:12	    2022-02-23 12:08:16
*/

-- 방법2.
SELECT SYSDATE "현재시간"
     , SYSDATE + ((1*24*60*60) + (2*60*60) + (3*60) + 4) / (24*60*60) "연산 후 시간"
FROM DUAL;
/*
===================     ===================
     현재 시간             연산 후 시간
===================     ===================
2022-02-22 10:19:49	    2022-02-23 12:22:53
*/

-- 날짜 - 날짜 : 연산가능
SELECT TO_DATE('2022-06-20', 'YYYY-MM-DD')
       - TO_DATE('2022-02-22', 'YYYY-MM-DD') "RESULT"
FROM DUAL;
--==>> 118

-- ○ 데이터 타입의 변환
SELECT TO_DATE('2022-06-20', 'YYYY-MM-DD') "RESULT"
FROM DUAL;
--==>> 2022-06-20 00:00:00

SELECT TO_DATE('2022-06-35', 'YYYY-MM-DD') "RESULT"
FROM DUAL;
--==>> 에러 발생
--     ORA-01847: day of month must be between 1 and last day of month

SELECT TO_DATE('2022-02-29', 'YYYY-MM-DD') "RESULT"
FROM DUAL;
--==>> 에러 발생
--     ORA-01839: date not valid for month specified

SELECT TO_DATE('2022-13-29', 'YYYY-MM-DD') "RESULT"
FROM DUAL;
--==>> 에러 발생
--     ORA-01843: not a valid month

-- ※ TO_DATE() 함수를 통해 문자 타입을 날짜 타입으로 변환하는 과정에서
--    내부적으로 해당 날짜에 대한 유효성 검사가 이루어진다.

-- ○ ADD_MONTHS() 개월 수를 더해주는 함수
SELECT SYSDATE "COL1"
     , ADD_MONTHS(SYSDATE, 2) "COL2"
     , ADD_MONTHS(SYSDATE, 3) "COL3"
     , ADD_MONTHS(SYSDATE, -2) "COL4"
     , ADD_MONTHS(SYSDATE, -3) "COL5"
FROM DUAL;

/*
2022-02-22 10:30:09
2022-04-22 10:30:09
2022-05-22 10:30:09	
2021-12-22 10:30:09	
2021-11-22 10:30:09
*/

-- ○ MONTHS_BETWEEN()
--    첫 번째 인자값에서 두 번째 인자값을 뺀 개월 수를 반환한다.
SELECT MONTHS_BETWEEN(SYSDATE, TO_DATE('2002-05-31', 'YYYY-MM-DD')) "RESULT"
FROM DUAL;
--==>> 236.723869847670250896057347670250896057

--> 개월 수의 차이를 반환하는 함수
--  결과값의 부호가 『-』로 반환되었을 경우에는
--  첫 번째 인자값에 해당하는 날짜보다
--  두 번째 인자값에 해당하는 날짜가 『미래』 라는 의미로 확인할 수 있다.

-- ○ NEXT_DAY()
SELECT NEXT_DAY(SYSDATE, '토') "COL1"
FROM DUAL;
--==>> 2022-02-26 10:37:47

-- ※ 세션 설정 변경  (↑ 랭귀지 : 한글이었겠음)
ALTER SESSION SET NLS_DATE_LANGUAGE = 'ENGLISH';
--==>> Session이(가) 변경되었습니다.

SELECT NEXT_DAY(SYSDATE, '토') "COL1"
FROM DUAL;
--==>> 에러 발생
--     ORA-01846: not a valid day of the week

SELECT NEXT_DAY(SYSDATE, 'SAT') "COL1"
FROM DUAL;
--==>> 2022-02-26 10:40:38

ALTER SESSION SET NLS_DATE_LANGUAGE = 'KOREAN';
--==>> Session이(가) 변경되었습니다.

SELECT NEXT_DAY(SYSDATE, 'SAT') "COL1"
FROM DUAL;
--==>> ORA-01846: not a valid day of the week

SELECT NEXT_DAY(SYSDATE, '토') "COL1"
FROM DUAL;
--==>> 2022-02-26 10:43:04

-- ○ LAST_DAY()
-- 해당 날짜가 포함되어있는 그 달의 마지막 날을 반환한다.
SELECT LAST_DAY(SYSDATE) "COL1"
     , LAST_DAY(TO_DATE('2020-02-10', 'YYYY-MM-DD')) "COL2"
FROM DUAL;
/*
2022-02-28 10:44:37	
2020-02-29 00:00:00
*/

-- ※ 세션 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session이(가) 변경되었습니다.

-- ○ 오늘부로... 상기가 군대에 다시 끌려(?)간다...
--    복무 기간은 22개월로 한다.

--   1. 전역 일자를 구한다.

--   2. 하루 꼬박꼬박 3끼 식사를 한다고 가정하면
--      상기가 몇 끼를 먹어야 집에 보내줄까...

SELECT SYSDATE "오늘 날짜"
     , ADD_MONTHS(SYSDATE, 22) "상기의 전역 날짜"
     , 3*TRUNC(((TO_DATE('2023-12-22', 'YYYY-MM-DD')-SYSDATE)), 0)||'끼' "상기의 식사량"
FROM DUAL;
/*
2022-02-22
2023-12-22
2001끼
*/
-- ○ 현재 날짜 및 시각으로부터...
--    수료일(2022-06-20 18:00:00)까지
--    남은 기간을... 다음과 같은 형태로 조회할 수 있도록 쿼리문을 구성한다.
/*
--------------------------------------------------------------------------------
현재시각             | 수료일                |  일   | 시간 |  분 | 초
--------------------------------------------------------------------------------
2022-02-22 11:34:35  | 2022-06-20 18:00:00  |  117  |   7  |  15  | 15
*/
-- ※ 세션설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session이(가) 변경되었습니다.

SELECT SYSDATE "현재시각"

     , TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS') "수료일"
     
     , TRUNC(TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS')
       - SYSDATE) "남은 일수(DAY)"
       
     , TRUNC(((TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS')
       - SYSDATE)-TRUNC(TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS')
       - SYSDATE))*24) "남은 시간(HOUR)"
       
     , TRUNC(((((TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS')
       - SYSDATE)-TRUNC(TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS')
       - SYSDATE))*24) - 
       (TRUNC(((TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS')
       - SYSDATE)-TRUNC(TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS')
       - SYSDATE))*24)))*60) "남은 분(MIN)"
       
     , ROUND(((((((TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS')
       - SYSDATE)-TRUNC(TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS')
       - SYSDATE))*24) - 
       (TRUNC(((TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS')
       - SYSDATE)-TRUNC(TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS')
       - SYSDATE))*24)))*60)-
       TRUNC(((((TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS')
       - SYSDATE)-TRUNC(TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS')
       - SYSDATE))*24) - 
       (TRUNC(((TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS')
       - SYSDATE)-TRUNC(TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS')
       - SYSDATE))*24)))*60))*60) "남은 초(SEC)"       
FROM DUAL;
/*
현재시간              수료일               일   시간  분   초
====================  ==================== ===  ====  ==   ==
2022-02-22 12:08:21  2022-06-20 18:00:00  118   5    51   39
*/

-- 『1일 2시간 3분 4초』를 ... 『초』 로 환산하면....
SELECT (1일) + (2시간) + (3분) + (4초)
FROM DUAL;

SELECT (1*24*60*60) + (2*60*60) + (3*60) + (4)
FROM DUAL;
--==>> 93784

-- 『93784초』를... 다시 『일 시간 분 초』로 환산...
SELECT  TRUNC(TRUNC(TRUNC(93784/60)/60)/24) "일"
      , MOD(TRUNC(TRUNC(93784/60)/60), 24) "시간"
      , MOD(TRUNC(93784/60), 60) "분"
      , MOD(93784, 60)  "초"
FROM DUAL;
---> 1	2	3	4


SELECT 수료일자 - 현재일자
FROM DUAL;

SELECT TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS')-SYSDATE
FROM DUAL;
--==>> 118.13244212962962962962962962962962963

-- 수료일까지 남은기간 확인(단위 : 초)
SELECT (TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS')-SYSDATE)
        * (24*60*60)
FROM DUAL;
--==>> 10205687.00000000000000000000000000000002

SELECT  SYSDATE "현재시각"
      , TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS') "수료일"
      , TRUNC(TRUNC(TRUNC((TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS')-SYSDATE)
        * (24*60*60)/60)/60)/24) "일"
      , MOD(TRUNC(TRUNC((TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS')-SYSDATE)
        * (24*60*60)/60)/60), 24) "시간"
      , MOD(TRUNC((TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS')-SYSDATE)
        * (24*60*60)/60), 60) "분"
      , ROUND(MOD((TO_DATE('2022-06-20 18:00:00', 'YYYY-MM-DD HH24:MI:SS')-SYSDATE)
        * (24*60*60), 60))  "초"
FROM DUAL;

-- ○ 각자 태어난 날짜 및 시각으로부터... 현재까지
--    얼마만큼의 시간을 살고 있는지...
--    다음과 같은 형태로 조회할 수 있도록 쿼리문을 구성한다.
/*
-------------------------------------------------------------------------------
현재시각             | 생년월일              |  일   | 시간 |  분 | 초
--------------------------------------------------------------------------------
2022-02-22 11:34:35  | 1996-10-04 01:00:00  |   ??   |   7  |  15  | 15
*/
-- 『전체 일수』 를 『일 시 분 초』로 나누는 연산

SELECT SYSDATE "현재시각"
      , TO_DATE('1996-10-04 01:00:00', 'YYYY-MM-DD HH24:MI:SS')  "생년월일"
      , TRUNC((SYSDATE) -  TO_DATE('1996-10-04 01:00:00', 'YYYY-MM-DD HH24:MI:SS'))   "살아온 일수"
      
      , TRUNC(((SYSDATE) -  TO_DATE('1996-10-04 01:00:00', 'YYYY-MM-DD HH24:MI:SS')
        - TRUNC((SYSDATE) -  TO_DATE('1996-10-04 01:00:00', 'YYYY-MM-DD HH24:MI:SS')))*24)   "살아온 시간"
        
      , TRUNC(((((SYSDATE) -  TO_DATE('1996-10-04 01:00:00', 'YYYY-MM-DD HH24:MI:SS')
        - TRUNC((SYSDATE) -  TO_DATE('1996-10-04 01:00:00', 'YYYY-MM-DD HH24:MI:SS')))*24)
        - (TRUNC(((SYSDATE) -  TO_DATE('1996-10-04 01:00:00', 'YYYY-MM-DD HH24:MI:SS')
        - TRUNC((SYSDATE) -  TO_DATE('1996-10-04 01:00:00', 'YYYY-MM-DD HH24:MI:SS')))*24))) * 60)   "살아온 분"
        
      , ROUND(((((((SYSDATE) -  TO_DATE('1996-10-04 01:00:00', 'YYYY-MM-DD HH24:MI:SS')
        - TRUNC((SYSDATE) -  TO_DATE('1996-10-04 01:00:00', 'YYYY-MM-DD HH24:MI:SS')))*24)
        - (TRUNC(((SYSDATE) -  TO_DATE('1996-10-04 01:00:00', 'YYYY-MM-DD HH24:MI:SS')
        - TRUNC((SYSDATE) -  TO_DATE('1996-10-04 01:00:00', 'YYYY-MM-DD HH24:MI:SS')))*24))) * 60)
        -TRUNC(((((SYSDATE) -  TO_DATE('1996-10-04 01:00:00', 'YYYY-MM-DD HH24:MI:SS')
        - TRUNC((SYSDATE) -  TO_DATE('1996-10-04 01:00:00', 'YYYY-MM-DD HH24:MI:SS')))*24)
        - (TRUNC(((SYSDATE) -  TO_DATE('1996-10-04 01:00:00', 'YYYY-MM-DD HH24:MI:SS')
        - TRUNC((SYSDATE) -  TO_DATE('1996-10-04 01:00:00', 'YYYY-MM-DD HH24:MI:SS')))*24))) * 60))*60)  "살아온 초"
FROM DUAL;


SELECT (SYSDATE - TO_DATE('1996-10-04 01:00:00', 'YYYY-MM-DD HH24:MI:SS'))
FROM DUAL;


-- 여태까지 살아온 날을 초로 환산

SELECT (SYSDATE - TO_DATE('1996-10-04 01:00:00', 'YYYY-MM-DD HH24:MI:SS'))
       * (24*60*60)
FROM DUAL;

-- 『초』를 『일, 시, 분, 초』 로 나누는 연산

SELECT SYSDATE "현재시각"
      , TO_DATE('1996-10-04 01:00:00', 'YYYY-MM-DD HH24:MI:SS')   "생년월일"
      , TRUNC(TRUNC(TRUNC((SYSDATE - TO_DATE('1996-10-04 01:00:00', 'YYYY-MM-DD HH24:MI:SS'))  * (24*60*60) / 60) / 60)/24)   "일"
      , MOD(TRUNC(TRUNC((SYSDATE - TO_DATE('1996-10-04 01:00:00', 'YYYY-MM-DD HH24:MI:SS')) * (24*60*60) / 60) / 60), 24) "시"
      , MOD(TRUNC((SYSDATE - TO_DATE('1996-10-04 01:00:00', 'YYYY-MM-DD HH24:MI:SS'))  * (24*60*60)/60), 60)  "분"
      , MOD((SYSDATE - TO_DATE('1996-10-04 01:00:00', 'YYYY-MM-DD HH24:MI:SS'))  * (24*60*60), 60)  "초"
FROM DUAL;

-- ○세션 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';
--==>> Session이(가) 변경되었습니다.
-- ※ 날짜 데이터를 대상으로 반올림, 절삭 등의 연산을 수행할 수 있다.

-- ○ 날짜 반올림
SELECT SYSDATE "COL1"                  -- 2022-02-22 → 기본 현재 날짜
     , ROUND(SYSDATE, 'YEAR') "COL2"   -- 2022-01-01 → 년도까지 유효한 데이터(상반기/하반기 기준)
     , ROUND(SYSDATE, 'MONTH') "COL3"  -- 2022-03-01 → 월까지 유효한 데이터(15일기준)
     , ROUND(SYSDATE, 'DD') "COL4"     -- 2022-02-23 → 일까지 유효한 데이터(정오 기준)
     , ROUND(SYSDATE, 'DAY') "COL5"    -- 2022-02-20 → 일까지 유효한 데이터(수요일 정오기준)
     , ROUND(SYSDATE) "COL6"    
FROM DUAL;     

-- ○ 날짜 절삭
SELECT SYSDATE "COL1"                  -- 2022-02-22 → 기본 현재 날짜
     , TRUNC(SYSDATE, 'YEAR') "COL2"   -- 2022-01-01 → 년도까지 유효한 데이터
     , TRUNC(SYSDATE, 'MONTH') "COL3"  -- 2022-02-01 → 월까지 유효한 데이터
     , TRUNC(SYSDATE, 'DD') "COL4"     -- 2022-02-22 → 일까지 유효한 데이터
     , TRUNC(SYSDATE, 'DAY') "COL5"    -- 2022-02-20 → 그 전 주에 해당하는 일요일
     , TRUNC(SYSDATE) "COL6"  
FROM DUAL;     


-- ■■■ 변환 함수 ■■■ --

-- TO_CHAR()    : 숫자나 날짜 데이터를 문자 타입으로 변환시켜주는 함수
-- TO_DATE()    : 문자 데이터를 날짜 타입으로 변환시켜주는 함수
-- TO_NUMBER()  : 문자 데이터를 숫자 타입으로 변환시켜주는 함수

-- ※ 날짜나 통화 형식이 맞지 않을 경우..
--    설정값을 통해 세션을 설정하여 사용할 수 있다.
ALTER SESSION SET NLS_LANGUAGE = 'KOREAN';
ALTER SESSION SET NLS_DATE_LANGUAGE = 'KOREAN';
ALTER SESSION SET NLS_CURRENCY = '\';
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';

-- ○ 날짜형 → 문자형
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') "COL1"    --2022-02-22
     , TO_CHAR(SYSDATE, 'YYYY') "COL2"          --2022
     , TO_CHAR(SYSDATE, 'YEAR') "COL3"          --TWENTY TWENTY-TWO
     , TO_CHAR(SYSDATE, 'MM') "COL4"            --02
     , TO_CHAR(SYSDATE, 'MONTH') "COL5"         --2월 
     , TO_CHAR(SYSDATE, 'MON') "COL6"           --2월 
     , TO_CHAR(SYSDATE, 'DD') "COL7"            --22
     , TO_CHAR(SYSDATE, 'MM-DD') "COL8"         --02-22
     , TO_CHAR(SYSDATE, 'DAY') "COL9"           --화요일
     , TO_CHAR(SYSDATE, 'DY') "COL10"           --화
     , TO_CHAR(SYSDATE, 'HH24') "COL11"         --16
     , TO_CHAR(SYSDATE, 'HH') "COL12"           --04
     , TO_CHAR(SYSDATE, 'HH AM') "COL13"        --04 오후
     , TO_CHAR(SYSDATE, 'HH PM') "COL14"        --04 오후
     , TO_CHAR(SYSDATE, 'MI') "COL15"           --19
     , TO_CHAR(SYSDATE, 'SS') "COL16"           --49
     , TO_CHAR(SYSDATE, 'SSSSS') "COL17"        --58789
     , TO_CHAR(SYSDATE, 'Q') "COL18"            --1(분기)
FROM DUAL;

-- 숫자와 문자의 구분 : 숫자의 경우 우측정렬, 문자의 경우 좌측정렬됨

SELECT 7    "CO1"
      , '7' "COL2"
      , TO_CHAR(7) "COL3"
FROM DUAL;
--==>> 7 7	7

SELECT '4' "COL1"
      , TO_NUMBER('4') "COL2"
      , 4 "COL3"
      , TO_NUMBER('04') "COL4"
FROM DUAL;
--==>> 4	4	4	4

SELECT TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY'))
FROM DUAL;
--==>> 2022

-- ○ EXTRACT()
SELECT TO_CHAR(SYSDATE, 'YYYY') "COL1"     -- 2022(문자형) → 연도를 추출하여 문자 타입으로 반환
     , TO_CHAR(SYSDATE, 'MM') "COL2"       -- 02(문자형) → 월을 추출하여 문자 타입으로 반환
     , TO_CHAR(SYSDATE, 'DD') "COL3"       -- 22(문자형) → 일을 추출하여 문자 타입으로 반환
     , EXTRACT(YEAR FROM SYSDATE) "COL4"   -- 2022(숫자형)  → 연도를 추출하여 숫자 타입으로 반환
     , EXTRACT(MONTH FROM SYSDATE) "COL5"   -- 2(숫자형)  → 월을 추출하여 숫자 타입으로 반환
     , EXTRACT(DAY FROM SYSDATE) "COL6"   -- 22(숫자형)  → 일을 추출하여 숫자 타입으로 반환
FROM DUAL;
--==>> 연,월,일 제외 항목은 불가

-- ○ TO_CHAR() 활용 → 형식 맞춤 표기 결과값 반환
SELECT 60000 "COL1"
     , TO_CHAR(60000, '99,999') "COL2"
     , TO_CHAR(60000, '$99,999') "COL3"
     , TO_CHAR(60000, 'L99,999') "COL4"
     , LTRIM(TO_CHAR(60000, 'L99,999')) "COL5"
FROM DUAL;
--> 통화의 경우 국가의 단위마다 표현길이가 다르기 때문에
   -- 오라클 내에서 공간을 많이 확보해준 것임(LTRIM 사용해서 없애주면좋음)

-- ※ 세션 설정 변경
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--==>> Session이(가) 변경되었습니다.

-- ○ 현재 시간을 기준으로 1일 2시간 3분 4초 후를 조회한다.

SELECT SYSDATE "현재 시간"
     , SYSDATE + 1+ (2/24) + (3/(24*60)) + (4/(24*60*60)) "1일 2시간 3분 4초 후"
FROM DUAL;
/*
2022-02-22 16:48:22	
2022-02-23 18:51:26
*/

-- ○ 현재 시간을 기준으로 1년 2개월 3일 4시간 5분 6초 후를 조회한다.
-- TO_YMINTERVAL(), TO_DSINTERVAL()

SELECT SYSDATE "현재시간"
     , SYSDATE + TO_YMINTERVAL('01-02') + TO_DSINTERVAL('003 04:05:06')
FROM DUAL;

--------------------------------------------------------------------------------
-- ○ CASE 구문(조건문, 분기문)
/*
CASE
WHEN
THEN
ELSE
END
*/
SELECT CASE 5+2 WHEN 4 THEN '5+2=4' ELSE '5+2는 몰라요' END
FROM DUAL;
--==>> 5+2는 몰라요

SELECT CASE 5+2 WHEN 7 THEN '5+2=7' ELSE '5+2=6' END
FROM DUAL;
--==>> 5+2=7

SELECT CASE 1+1 WHEN 2 THEN '1+1=2' 
                WHEN 3 THEN '1+1=3'
                WHEN 4 THEN '1+1=4'
                ELSE '난산수싫어'
        END "RESULT"
FROM DUAL;
--==>> 1+1=2

SELECT CASE WHEN 5+2=4 THEN '5+2=4'
            WHEN 6-3=2 THEN '6-3=2'
            WHEN 7*1=8 THEN '7*1=8'
            WHEN 6/2=3 THEN '6/2=3'
            ELSE '모르겠네'
            END "RESULT"
FROM DUAL;
--==> 6/2=3

-- ○ DECODE()

SELECT DECODE(5-2, 1, '5-2=1', 2, '5-2=2', 3, '5-2=3', '5-2는 몰라요') "RESULT"
FROM DUAL;
--==>> 5-2=3

-- ○ CASE WHEN THEN ELSE END 활용
SELECT CASE WHEN 5<2 THEN '5<2'
            WHEN 5>2 THEN '5>2'
            ELSE '5와2는 비교불가'
         END  "RESULT"
FROM DUAL;
--==>> 5>2

SELECT CASE WHEN 5<2 OR 3>1 AND 2=2 THEN '은혜만세'
            WHEN 5>2 OR 2=3 THEN '문정만세'
            ELSE '호석만세'
         END  "RESULT"
FROM DUAL;
--==>> 은혜만세

-- ↓ 연산
SELECT CASE WHEN F OR 3>1 AND 2=2 THEN '은혜만세'
            WHEN 5>2 OR 2=3 THEN '문정만세'
            ELSE '호석만세'
         END  "RESULT"
FROM DUAL;

SELECT CASE WHEN F OR T AND 2=2 THEN '은혜만세'
            WHEN 5>2 OR 2=3 THEN '문정만세'
            ELSE '호석만세'
         END  "RESULT"
FROM DUAL;

SELECT CASE T AND 2=2 THEN '은혜만세'
            WHEN 5>2 OR 2=3 THEN '문정만세'
            ELSE '호석만세'
         END  "RESULT"
FROM DUAL;

SELECT CASE T AND T THEN '은혜만세'
            WHEN 5>2 OR 2=3 THEN '문정만세'
            ELSE '호석만세'
         END  "RESULT"
FROM DUAL;

SELECT CASE T THEN '은혜만세'
            WHEN 5>2 OR 2=3 THEN '문정만세'
            ELSE '호석만세'
         END  "RESULT"
FROM DUAL;
-----------------------------------------------------------
SELECT CASE WHEN 3<1 AND 5<2 OR 3>1 AND 2=2 THEN '현수만세'
            WHEN 5<2 AND 2=3 THEN '이삭만세'
            ELSE '태형만세'
    END "RESULT"
FROM DUAL;
--==>> 현수만세

SELECT CASE WHEN 3<1 AND (5<2 OR 3>1) AND 2=2 THEN '현수만세'
            WHEN 5<2 AND 2=3 THEN '이삭만세'
            ELSE '태형만세'
    END "RESULT"
FROM DUAL;
--==>> 태형만세

SELECT *
FROM TBL_SAWON;

-- ○ TBL_SAWON 테이블을 활용하여 다음과 같은 항목들을 조회할 수 있도록
--    쿼리문을 구성한다.
--    사원번호, 사원명, 주민번호, 성별, 입사일

SELECT SANO "사원번호"
     , SANAME "사원명"
     , JUBUN "주민번호"
     , CASE WHEN SUBSTR(JUBUN, 7, 1) = '1' OR SUBSTR(JUBUN, 7, 1) = '3' THEN '남성'
            WHEN SUBSTR(JUBUN, 7, 1) = '2' OR SUBSTR(JUBUN, 7, 1) = '4' THEN '여성'
            ELSE '외계인'
            END "성별"
     , HIREDATE "입사일"
FROM TBL_SAWON;




-- ○
-- ○
-- ○









