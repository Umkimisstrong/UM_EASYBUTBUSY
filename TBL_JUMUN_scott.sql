SELECT USER
FROM DUAL;
--==>> SCOTT
--------------------------------------------------------
--  ÆÄÀÏÀÌ »ý¼ºµÊ - ¼ö¿äÀÏ-3¿ù-02-2022   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table TBL_JUMUN
--------------------------------------------------------
-- ¡Û ±âÁ¸ Å×ÀÌºí Á¦°Å
DROP TABLE TBL_JUMUN PURGE;
--==>> Table TBL_JUMUNÀÌ(°¡) »èÁ¦µÇ¾ú½À´Ï´Ù.

  CREATE TABLE "SCOTT"."TBL_JUMUN" 
   (	"JUNO" NUMBER, 
	"JECODE" VARCHAR2(30 BYTE), 
	"JUSU" NUMBER, 
	"JUDAY" DATE DEFAULT SYSDATE    -- ÁÖ¹® ÀÏÀÚ

   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--==>> Table "SCOTT"."TBL_JUMUN"ÀÌ(°¡) »ý¼ºµÇ¾ú½À´Ï´Ù.

-- ¡Û µ¥ÀÌÅÍ ÀÔ·Â
Insert into SCOTT.TBL_JUMUN (JUNO,JECODE,JUSU,JUDAY) values (98778,'»©»©·Î',40,to_date('2022-03-02 14:08:38','YYYY-MM-DD HH24:MI:SS'));
Insert into SCOTT.TBL_JUMUN (JUNO,JECODE,JUSU,JUDAY) values (98779,'¸Àµ¿»ê',20,to_date('2022-03-02 14:09:08','YYYY-MM-DD HH24:MI:SS'));
Insert into SCOTT.TBL_JUMUN (JUNO,JECODE,JUSU,JUDAY) values (98780,'¸ð¿Ë½©',20,to_date('2022-03-02 14:13:43','YYYY-MM-DD HH24:MI:SS'));
Insert into SCOTT.TBL_JUMUN (JUNO,JECODE,JUSU,JUDAY) values (98781,'»©»©·Î',30,to_date('2022-03-02 14:13:47','YYYY-MM-DD HH24:MI:SS'));
Insert into SCOTT.TBL_JUMUN (JUNO,JECODE,JUSU,JUDAY) values (98764,'°í·¡¹ä',10,to_date('2022-03-02 09:29:58','YYYY-MM-DD HH24:MI:SS'));
Insert into SCOTT.TBL_JUMUN (JUNO,JECODE,JUSU,JUDAY) values (98765,'»©»©·Î',20,to_date('2022-03-02 09:30:30','YYYY-MM-DD HH24:MI:SS'));
Insert into SCOTT.TBL_JUMUN (JUNO,JECODE,JUSU,JUDAY) values (98766,'¸Àµ¿»ê',30,to_date('2022-03-02 09:31:08','YYYY-MM-DD HH24:MI:SS'));
Insert into SCOTT.TBL_JUMUN (JUNO,JECODE,JUSU,JUDAY) values (98767,'È¨·±º¼',40,to_date('2022-03-02 09:31:31','YYYY-MM-DD HH24:MI:SS'));
Insert into SCOTT.TBL_JUMUN (JUNO,JECODE,JUSU,JUDAY) values (98768,'¿À°¨ÀÚ',50,to_date('2022-03-02 09:31:56','YYYY-MM-DD HH24:MI:SS'));
Insert into SCOTT.TBL_JUMUN (JUNO,JECODE,JUSU,JUDAY) values (98769,'¿þÇÏ½º',30,to_date('2022-03-02 09:32:23','YYYY-MM-DD HH24:MI:SS'));
Insert into SCOTT.TBL_JUMUN (JUNO,JECODE,JUSU,JUDAY) values (98770,'°í·¡¹ä',20,to_date('2022-03-02 09:33:09','YYYY-MM-DD HH24:MI:SS'));
Insert into SCOTT.TBL_JUMUN (JUNO,JECODE,JUSU,JUDAY) values (98771,'¸Àµ¿»ê',20,to_date('2022-03-02 09:33:37','YYYY-MM-DD HH24:MI:SS'));
Insert into SCOTT.TBL_JUMUN (JUNO,JECODE,JUSU,JUDAY) values (98772,'¿þÇÏ½º',20,to_date('2022-03-02 09:33:55','YYYY-MM-DD HH24:MI:SS'));
Insert into SCOTT.TBL_JUMUN (JUNO,JECODE,JUSU,JUDAY) values (98773,'»©»©·Î',90,to_date('2022-03-02 09:34:19','YYYY-MM-DD HH24:MI:SS'));
Insert into SCOTT.TBL_JUMUN (JUNO,JECODE,JUSU,JUDAY) values (98774,'¿¡ÀÌ½º',20,to_date('2022-03-02 09:34:37','YYYY-MM-DD HH24:MI:SS'));
Insert into SCOTT.TBL_JUMUN (JUNO,JECODE,JUSU,JUDAY) values (98775,'²¿ºÏÄ¨',30,to_date('2022-03-02 09:34:57','YYYY-MM-DD HH24:MI:SS'));
Insert into SCOTT.TBL_JUMUN (JUNO,JECODE,JUSU,JUDAY) values (98776,'¸ð¿Ë½©',30,to_date('2022-03-02 11:28:12','YYYY-MM-DD HH24:MI:SS'));
Insert into SCOTT.TBL_JUMUN (JUNO,JECODE,JUSU,JUDAY) values (98777,'¸ð¿Ë½©',10,to_date('2022-03-02 14:07:49','YYYY-MM-DD HH24:MI:SS'));
--==>> 1 Çà ÀÌ(°¡) »ðÀÔµÇ¾ú½À´Ï´Ù. * 18

-- ¡Û Ä¿¹Ô
COMMIT;
--==>> Ä¿¹Ô ¿Ï·á