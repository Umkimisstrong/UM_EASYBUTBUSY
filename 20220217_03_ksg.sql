select user
from dual;
--> KSG


-- ○ 테이블 생성(TBL_ORAUSERTEST)
CREATE TABLE TBL_ORAUSERTEST
( NO        NUMBER(10)
, NAME      VARCHAR2(30)   
);
--==>> 에러 발생
--     (ORA-01031: insufficient privileges)
--> 현재 각자의 이름 계정은 CREATE SESSION 권한만 갖고 있으며
--  테이블 생성 권한은 갖고 있지 않은 상태이다.
--  그러므로 관리자로부터 테이블을 생성할 수 있는 권한을 부여받아야 한다.

--------------------------------------------------
--          ↓↓↓↓↓↓

-- ○ SYS로 부터 테이블 생성권한 부여받은 후
--    다시 테이블 생성(TBL_ORAUSERTEST)
CREATE TABLE TBL_ORAUSERTEST
( NO        NUMBER(10)
, NAME      VARCHAR2(30)   
);
--==>> 에러 발생
--     (ORA-01950: no privileges on tablespace 'TBS_EDUA')
--  할당량 없어요.. 해당 테이블 스페이스(TBS_EDUA)에 대한
--  할당량을 부여받아야 하는 상황이다.. 할당량은 ALTER 즉,
--  기존 할당량에서 변경하는 개념으로 부여해 줘야 한다.

--------------------------------------------------
--            ↓↓↓↓↓

-- ○ SYS로부터 테이블 스페이스(TBS_EDUA)에 대한 할당량 부여받은 후 
--    다시 테이블 생성 (TBL_ORAUSERTEST)
CREATE TABLE TBL_ORAUSERTEST
( NO        NUMBER(10)
, NAME      VARCHAR2(30)   
);
--==>> Table TBL_ORAUSERTEST이(가) 생성되었습니다.

-- ○ 생성된 테이블 조회
SELECT *
FROM TBL_ORAUSERTEST;
--> 테이블의 구조만 확인할 수 있는 상태
--  단, 조회 결과는 없음

-- ○ 자신에게 부여된 할당량 조회
SELECT *
FROM USER_TS_QUOTAS;
--==>> TBS_EDUA	65536	-1	8	-1	NO
-- ※ -『1』 은 무제한을 의미

-- ○ 생성된 테이블(TBL_ORAUSERTEST)이
--    어떤 테이블 스페이스에 저장되어 있는지 조회
SELECT TABLE_NAME, TABLESPACE_NAME
FROM USER_TABLES;
--==>> TBL_ORAUSERTEST	TBS_EDUA










