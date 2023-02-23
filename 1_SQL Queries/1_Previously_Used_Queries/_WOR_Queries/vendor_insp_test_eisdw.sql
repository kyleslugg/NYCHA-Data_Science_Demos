SELECT *
FROM 
(SELECT count(*) OVER (PARTITION BY wmls.REFWO) AS numtrans, wtf.status, wtf.failurecode, wtf.problemcode, wtf.description, 
wmls.LABTRANSID , wmls.refwo, nvl(wtf.parent, wtf.wonum) AS wogroup, wmls.START_DAY_ID , wmls.FINISH_DAY_ID, WTF.STATUSDATE, wtf.actfinish_day_id AS wo_finish_date,
wmls.LABORCODE , wmls.craft, wmls.ENTERBY, wmls.TRANSTYPE, wmls.FIRST_LABTRANS_LABTRANSID, wmls.FIRST_LABTRANS_TRANSTYPE, 
wtf.siteid, wtf.tds_num, wtf.disposition_sub_code, wmls.latest_record_ind
	FROM eisstg.WTS_MAXIMO_LABTRANS_STG wmls,
	(WITH w as 
		(SELECT * 
		FROM eisdw.wts_task_fact
		WHERE zzCRAFT = 'VENDOR'
		and zzcreatedate > to_date('2021.12.31', 'YYYY.MM.DD')
		AND FAILURECODE NOT IN ('DUSTWIPE', 'ASBESTOS', 'LEAD', 'MOLD'))
		
		SELECT * 
		FROM eisdw.wts_task_fact 
		WHERE wonum IN 
			((SELECT wonum FROM w) UNION (SELECT parent FROM w))) wtf
	
	WHERE refwo = wtf.wonum)
	
	WHERE numtrans > 1
	ORDER BY wogroup, refwo, labtransid