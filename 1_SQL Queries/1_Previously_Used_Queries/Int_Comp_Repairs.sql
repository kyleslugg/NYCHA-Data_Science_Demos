SELECT w.WONUM, w.LOCATION, w.PROBLEMCODE, w.FAILURECODE, w.ZZCREATEDATE, w.ACTSTART, w.ACTFINISH, w.STATUS, r.REPAIRCODE, r.CHANGEDATE
FROM ZZWOREPAIRSDONE r, WORKORDER w
WHERE w.WONUM = r.WONUM
AND (w.istask=0 and w.worktype='CM' and w.status<>'CAN')
AND ((w.failurecode like '%COMPACTOR%') or w.problemcode like '%COMPACTOR%' or (location like '%COM%'))
AND w.LOCATION not like '%GRND%'
