
select a.siteid, a.wonum, a.parent, a.zzcreatedate, a.zzcraft, a.failurecode, a.problemcode, a.description, a.ZZRESCODE, b.personid changeby_id, b.displayname changeby_name, b.department changeby_dept, x.consolidated_name, x.tds_num, y.neighborhood_desc 
			from workorder A, 
			person b,
            maximo.nycha_org_dim x, 
            (select distinct zzmanagedby, neighborhood_desc from maximo.zzdevelopments where neighborhood_desc is not NULL) y
    
			where a.worktype='CM'
			and a.zzcraft IN ('PAINTER', 'PLASTER','ELECTRCN','ROOFER','EXTERMIN','GLAZIER','CARPENTR','PLUMBER','SUPVPLBR','SUPVPLST','BRKLAYER', 'VENDOR')
			and a.ownergroup not like '%TEMPO%'
			and a.istask=0
			AND a.status = 'CLOSE'
			AND a.siteid IN ('QS', 'BX') AND a.zzcreatedate > to_date('03.21.2022','MM.DD.YYYY')
			and a.wonum NOT IN (SELECT DISTINCT refwo
								FROM labtrans
								WHERE ((siteid='QS' and transdate>to_date('10.01.2021','MM.DD.YYYY'))
								                        or (siteid='BX' and transdate>to_date('02.01.2022','MM.DD.YYYY')))
								--AND transtype = 'WORK'
								)
			AND a.changeby = b.personid
            and x.consolidated_tds_num = y.zzmanagedby
            and x.tds_num=a.zzmanagedby
								                    