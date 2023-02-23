SELECT *
FROM 
(SELECT count(*) OVER (PARTITION BY wmls.REFWO) AS numtrans, wtf.status, wtf.failurecode, wtf.problemcode, wtf.description, 
wmls.LABTRANSID , wmls.refwo, nvl(wtf.parent, wtf.wonum) AS wonumgroup
wmls.STARTDATE  , wmls.FINISHDATE,  WTF.STATUSDATE,
wmls.LABORCODE , wmls.craft, wmls.ENTERBY, wmls.TRANSTYPE
	FROM maximo.labtrans wmls,
		(WITH w AS 
			(SELECT m.* 
				FROM maximo.WORKORDER m
				WHERE m.zzCRAFT = 'VENDOR'
				and m.zzcreatedate > to_date('2021.12.31', 'YYYY.MM.DD')
				AND m.FAILURECODE NOT IN ('DUSTWIPE', 'ASBESTOS', 'LEAD', 'MOLD'))
				
			SELECT * FROM maximo.WORKORDER 
			WHERE wonum IN ((SELECT wonum FROM w) UNION (SELECT parent FROM w))
			
				) wtf
	WHERE refwo = wtf.wonum)
	
	WHERE numtrans > 1
	ORDER BY wonumgroup, refwo, labtransid