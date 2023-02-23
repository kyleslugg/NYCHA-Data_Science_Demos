--SELECT a.wonum, a.parent, to_char(a.zzcreatedate,'mm.dd.yyyy') createdate, to_char(a.actstart,'mm.dd.yyyy') actstart, a.siteid, a.problemcode , a.failurecode , b.transtype, a.zzrescode , a.parent , a.location , a.description, a.changeby, a.zzcraft, a.zzmanagedby, a.zzsourcecreate
--SELECT p_group, wonum, refwo, zzcreatedate , zzcraft, failurecode , problemcode , siteid
SELECT w.SITEID, w.parent parent_wonum, c.wonum SEQ_ST_wonum, w.wonum followup_wonum, TRUNC(w.zzcreatedate) createdate, TRUNC(w.actstart) actstart, w.ZZCRAFT craft, w.FAILURECODE , w.PROBLEMCODE , c.zzcraft SEQ_ST_CRAFT, c.failurecode SEQ_ST_FAILURECODE, c.problemcode SEQ_ST_PROBLEMCODE,  c.transtype SEQ_ST_transtype, c.displayname SEQ_ST_name, c.department
	FROM WORKORDER w
	LEFT JOIN
		(
		SELECT a.wonum, a.parent, a.zzcreatedate, b.transtype, b.displayname, b.status, b.department, b.supervisor, b.personid, a.zzcraft, a.failurecode, a.problemcode 
		from
			(select wonum, parent, zzcreatedate, actstart, zzcraft, failurecode, problemcode 
			from workorder
			where worktype='CM'
			and zzcraft IN ('PAINTER', 'PLASTER','ELECTRCN','ROOFER','EXTERMIN','GLAZIER','CARPENTR','PLUMBER','SUPVPLBR','SUPVPLST','BRKLAYER', 'VENDOR')
			and ownergroup not like '%TEMPO%'
			and istask=0
			AND status = 'CLOSE'
			--and ((siteid='QS' and zzcreatedate>to_date('11.28.2021','MM.DD.YYYY'))
			--or (siteid='BX' and zzcreatedate>to_date('03.13.2022','MM.DD.YYYY')))
			AND siteid IN ('QS', 'BX') AND zzcreatedate > to_date('03.21.2022','MM.DD.YYYY')
			and parent is not NULL) a
		
		LEFT JOIN 
			(SELECT e.refwo, e.LABTRANSID , e.TRANSTYPE, d.personid, d.status, d.displayname, d.department, d.supervisor 
			FROM maximo.LABTRANS e,
			maximo.person d
			WHERE e.LABTRANSID IN
				(SELECT max(labtransid) OVER (PARTITION BY REFWO)
				FROM labtrans)
				AND e.laborcode = d.personid) b
				
		ON a.wonum = b.refwo
		WHERE transtype IN ('NOWORKDONEWITHSEQ', 'WORKWITHSEQ')
		) c
	
	ON  w.parent = c.parent
	WHERE  w.zzcraft IN ('PAINTER', 'PLASTER','ELECTRCN','ROOFER','EXTERMIN','GLAZIER','CARPENTR','PLUMBER','SUPVPLBR','SUPVPLST','BRKLAYER', 'VENDOR')
	and w.ownergroup not like '%TEMPO%'
	and w.istask=0
	AND w.zzcreatedate  > c.zzcreatedate
	AND (w.reportedby = c.personid
	OR w.zzcreatedbyfname||' '||w.zzcreatedbylname = c.displayname) 
	
	ORDER BY siteid, parent_wonum, seq_st_wonum, followup_wonum

	  