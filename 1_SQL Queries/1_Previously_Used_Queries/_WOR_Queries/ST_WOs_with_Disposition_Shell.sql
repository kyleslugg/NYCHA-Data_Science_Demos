SELECT a.wonum, to_char(a.zzcreatedate,'mm.dd.yyyy') createdate, to_char(a.actstart,'mm.dd.yyyy') actstart, a.siteid, a.problemcode , a.failurecode , b.transtype, a.zzrescode , a.parent , a.location , a.description, a.changeby, a.zzcraft, a.zzmanagedby, a.zzsourcecreate
from
	(select wonum, problemcode, failurecode, zzrescode, parent, siteid, location, description, changeby, zzcraft, zzmanagedby, zzsourcecreate, zzcreatedate, actstart
	from workorder
	where worktype='CM'
	and zzcraft IN ('PAINTER', 'PLASTER','ELECTRCN','ROOFER','EXTERMIN','GLAZIER','CARPENTR','PLUMBER','SUPVPLBR','SUPVPLST','BRKLAYER', 'VENDOR')
	and ownergroup not like '%TEMPO%'
	and istask=0
	AND status = 'CLOSE'
	and ((siteid='QS' and zzcreatedate>to_date('11.28.2021','MM.DD.YYYY'))
	or (siteid='BX' and zzcreatedate>to_date('03.13.2022','MM.DD.YYYY')))
	and parent is not NULL) a

LEFT JOIN 
	(SELECT refwo, LABTRANSID , TRANSTYPE 
	FROM maximo.LABTRANS
	WHERE LABTRANSID IN
		(SELECT max(labtransid) OVER (PARTITION BY REFWO)
		FROM labtrans)) b
		
ON a.wonum = b.refwo
	  