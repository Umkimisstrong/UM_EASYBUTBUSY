-- 배너 더블클릭하면 그 배너가 메인화면이 된다.(돌아가기 : 더블클릭)

-- 1줄 주석문 처리(단일행 주석문 처리) : "--"

/*
여러줄
(다중행)
주석문
처리
*/

-- ○ 현재 오라클 서버에 접속한 자신의 계정 조회
show user
--==>> USER이(가) "SYS"입니다.
--> sqlplus 상태일 때 사용하는 명령어

select user
from dual;
--==>> SYS

-- 쿼리 구문은 대소문자 구별 x 
-- 요구하는 값은 대소문자 구별 o
SELECT USER
FROM DUAL;
--==>> SYS

-- > from dual : 의미 없음(공백 넣어주는 값으로 해석해볼까??)

select 1+2
from dual;
--==>> 3 


SELECT                        2 + 4
From                         DUAL;
--==>> 6 띄어쓰기 의미없음

--select 1+5 fromdual
--==>> 에러 발생 ( from과 dual을 붙여쓰면 )
--(ORA-00923: FROM keyword not found where expected)


--select 쌍용강북교육센터 F강의장
--From dual
--==>> 에러 발생
--(ORA-00904: "쌍용강북교육센터": invalid identifier)


--select "쌍용강북교육센터 F강의장"
--From dual;
--==>> 에러발생
--(ORA-00972: identifier is too long)

-- 문자열은 ' ~ ' 로 씌우자
select '쌍용강북교육센터 F강의장'
from dual;
--==>> 쌍용강북교육센터 F강의장

select '한 발 한 발 힘겨운 오라클 수업'
from dual;
--==>> 한 발 한 발 힘겨운 오라클 수업

select 3.14 + 3.14
from dual;
--==>> 6.28

select 10*5
from dual;
--==>> 50

select 10*5.0
from dual;
--==>> 50

select 4 / 2
from dual;
--==>> 2

select 4.0 / 2
from dual;
--==>> 2

select 4.0/2.0
from dual;
--==>> 2

select 5/2
from dual;
--==>> 2.5

select 100-23
from dual;
--==>> 77

select 123123123123*2131231231234
from dual;
--==>> 262403845286806665223782
