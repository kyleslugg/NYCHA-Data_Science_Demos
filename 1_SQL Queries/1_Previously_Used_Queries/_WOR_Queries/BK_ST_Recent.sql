SELECT w.wonum, w.parent, w.siteid, w.location, dev.description as development, dev.full_managing as managed_by, dev.neighborhood_desc as neighborhood, w.status, w.statusdate, w.worktype, w.zzcraft, FAILURECODE, PROBLEMCODE, reportdate, zzcreatedate, SCHEDSTART, APARTMENTS  
FROM maximo.WORKORDER w,
maximo.zzdevelopments dev
WHERE w.zzcraft IN ('VENDOR')
AND w.siteid = 'BK'
AND (w.zzcreatedate > to_date('30-JUN-2020','DD-MON-YYYY')
OR w.STATUSdate > to_date('30-JUN-2020','DD-MON-YYYY'))
and substr(w.location, 0, 3) = dev.location