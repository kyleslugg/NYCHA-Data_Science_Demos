--EISSTG.KRONOS_FIRSTPUNCH_TODAY_STG firstpunch, --Begins in August 2020, still running
--eisdw.kronos_aws_pun_fact --Begins in November 2019, still running
--eisstg.kronos_punches_stg punch, --Through November 2020

SELECT XYZ
FROM TABLENAME
WHERE CLOCKNUM IN 
    (SELECT DEVICENUM, TDS_NUM, SITEADDRESS, FACILITY
    FROM eisdw.kronos_aws_activeclocks_dim
    WHERE TDS_NUM IN ()


--From punch1
SELECT 





eisdw.kronos_aws_activeclocks_dim