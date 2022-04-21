Select user
from dual;
--==>>SYS

select '문자열'
from dual;
--==>> 문자열

select 550 + 230
from dual;
--==>>780

select '박현수' + '홍은혜'
from dual;
--==>> 에러발생
--     (ORA-01722: invalid number)


-- ○ 현재 오라클 서버에 존재하는 사용자 계정 상태 조회
select username, account_status
from DBA_USERS;
/*
SYS 	            OPEN
SYSTEM          	OPEN
ANONYMOUS       	OPEN
HR	OPEN
APEX_PUBLIC_USER	LOCKED
FLOWS_FILES     	LOCKED
APEX_040000	        LOCKED
OUTLN	            EXPIRED & LOCKED
DIP	                EXPIRED & LOCKED
ORACLE_OCM	        EXPIRED & LOCKED
XS$NULL	            EXPIRED & LOCKED
MDSYS	            EXPIRED & LOCKED
CTXSYS	            EXPIRED & LOCKED
DBSNMP	            EXPIRED & LOCKED
XDB	                EXPIRED & LOCKED
APPQOSSYS	        EXPIRED & LOCKED
*/


select *
From dba_users;
/*
APEX_040000	47		LOCKED	2014-05-29	2014-11-25	SYSAUX
OUTLN	9		EXPIRED & LOCKED	2022-02-15	2022-02-15	SYSTEM
DIP	14		EXPIRED & LOCKED	2014-05-29	2014-05-29	SYSTEM
ORACLE_OCM	21		EXPIRED & LOCKED	2014-05-29	2014-05-29	SYSTEM
XS$NULL	2147483638		EXPIRED & LOCKED	2014-05-29	2014-05-29	SYSTEM
MDSYS	42		EXPIRED & LOCKED	2014-05-29	2022-02-15	SYSAUX
CTXSYS	32		EXPIRED & LOCKED	2022-02-15	2022-02-15	SYSAUX
DBSNMP	29		EXPIRED & LOCKED	2014-05-29	2014-05-29	SYSAUX
XDB	34		EXPIRED & LOCKED	2014-05-29	2014-05-29	SYSAUX
APPQOSSYS	30		EXPIRED & LOCKED	2014-05-29	2014-05-29	SYSAUX
*/

select username, created
from dba_users;
/*
SYS	2014-05-29
SYSTEM	2014-05-29
ANONYMOUS	2014-05-29
HR	2014-05-29
APEX_PUBLIC_USER	2014-05-29
FLOWS_FILES	2014-05-29
APEX_040000	2014-05-29
OUTLN	2014-05-29
DIP	2014-05-29
ORACLE_OCM	2014-05-29
XS$NULL	2014-05-29
MDSYS	2014-05-29
CTXSYS	2014-05-29
DBSNMP	2014-05-29
XDB	2014-05-29
APPQOSSYS	2014-05-29
*/
---> 『DBA_』로 시작하는 Oracle Data Dictionary View
---   오로지 관리자 권한으로 접속했을 경우에만 조회가 가능하다.
---   아직 데이터 딕셔너리 개념을 잡지 못해도 상관 없다.

-- ○ 『HR』 사용자 계정을 잠금 상태로 설정
Alter user hr account lock;
--==>> User HR이(가) 변경되었습니다.

-- ○ 『HR』 사용자 계정상태 확인
select username, account_status
from dba_users;
--==>> HR	LOCKED  


-- ○ 『HR』 사용자 계정을 잠금 해제
Alter user HR account unlock;
--==>> User HR이(가) 변경되었습니다.

-- ○  『HR』 사용자 계정상태 확인.    
select username, account_status
from dba_users;
--==>> HR	OPEN

--------------------------------------------------------

-- ○ TABLESPACE 생성

-- ※ TABLESPACE 란?
-->   세그먼트(테이블, 인덱스, ..) 를 담아두는(저장)
-->   오라클의 논리적인 저장 구조를 의미한다.

CREATE TABLESPACE TBS_EDUA            -- 생성하겠다. 테이블스페이스를 ... TBS_EDUA 라는 이름으로
DATAFILE 'C:\TESTDATA\TBS_EDUA01.DBF' -- 물리적 데이터 파일 경로 및 이름
SIZE 4M                               -- 사이즈(용량)
EXTENT MANAGEMENT LOCAL               -- 오라클 서버가 세그먼트를 알아서 관리
SEGMENT SPACE MANAGEMENT AUTO;        -- 세그먼트 공간 관리도 오라클 서버가 자동으로 관리
--==>> TABLESPACE TBS_EDUA이(가) 생성되었습니다.

-- ※ 테이블스페이스 생성 구문을 실행하기 전에
--    해당 경로의 물리적인 디렉터리 생성이 필요하다.
--     C:\TESTDATA

-- ○ 생성된 테이블스페이스 조회
SELECT *
FROM DBA_TABLESPACES;
/*
SYSTEM	8192	65536		1	2147483645	2147483645		65536	ONLINE	PERMANENT
SYSAUX	8192	65536		1	2147483645	2147483645		65536	ONLINE	PERMANENT
UNDOTBS1	8192	65536		1	2147483645	2147483645		65536	ONLINE	UNDO
TEMP	8192	1048576	1048576	1		2147483645	0	1048576	ONLINE	TEMPORARY
USERS	8192	65536		1	2147483645	2147483645		65536	ONLINE	PERMANENT
TBS_EDUA	8192	65536		1	2147483645	2147483645		65536	ONLINE	PERMANENT
*/

-- ○ 파일 용량 정보 조회(물리적인 파일 이름 조회)
SELECT *
FROM DBA_DATA_FILES;
/*
  :
C:\TESTDATA\TBS_EDUA01.DBF	5	TBS_EDUA	4194304	512	AVAILABLE	5	NO	0	0	0	3145728	384	ONLINE
*/

--○오라클 사용자 계정 생성
CREATE USER ksg IDENTIFIED BY java006$
DEFAULT TABLESPACE TBS_EDUA;
--==>> User KSG이(가) 생성되었습니다.
--> ksg 라는 사용자 계정을 생성하겠다.(만들겠다.)
--  이 사용자 계정의 패스워드는 java006$ 로 하겠다.
--  이 계정을 통해 생성하는 오라클 세그먼트는
--  기본적으로 TBS_EDUA 라는 테이블 스페이스에 생성할 수 있도록 설정하겠다.

-- ※ 생성된 오라클 사용자 계정(각자 본인 이름 이니셜 계정)을 통해 접속 시도
--    → 접속 불가(실패)
--    『create session』 권한이 없기 때문에 접속 불가.

-- ○ 생성된 오라클 사용자 계정(각자 본인 이름 이니셜 계정)에
--    오라클 서버 접속이 가능하도록 CREATE SESSION 권한 부여

GRANT CREATE SESSION TO KSG;
--==>> Grant을(를) 성공했습니다.

-- ○ 각자 생성한 오라클 사용자 계정의 시스템 관련 권한 조회
SELECT *
FROM DBA_SYS_PRIVS;
/*
        :
KSG	CREATE SESSION	NO
        :
*/

DROP USER KSK CASCADE;  -- 아까 잘못생성한 KSK 계정 삭제

-- ○ 각자 생성한 오라클 사용자 계정에 테이블 생성이 가능하도록
--    테이블 생성이 가능하도록 CREATE TABLE 권한 부여
GRANT CREATE TABLE TO KSG;
--==>> Grant을(를) 성공했습니다.

-- ○ 각자 생성한 오라클 사용자 계정에
--    테이블 스페이스(TBS_EDUA)에서 사용할 수 있는 공간(할당량) 지정.
ALTER USER KSG
QUOTA UNLIMITED ON TBS_EDUA;
--==>> User KSG이(가) 변경되었습니다.
-------------------------------------------------------------
CREATE USER scott
IDENTIFIED BY tiger;
--==>> User SCOTT이(가) 생성되었습니다.

GRANT CONNECT,RESOURCE,UNLIMITED TABLESPACE TO SCOTT;
--==>> Grant을(를) 성공했습니다.

ALTER USER SCOTT DEFAULT TABLESPACE USERS;
--==>> User SCOTT이(가) 변경되었습니다.

-- Temporary : 임시적
ALTER USER SCOTT TEMPORARY TABLESPACE TEMP;
--==>> User SCOTT이(가) 변경되었습니다.





