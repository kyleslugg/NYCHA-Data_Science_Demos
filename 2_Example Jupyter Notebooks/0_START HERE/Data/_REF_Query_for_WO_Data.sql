SELECT w.wonum, w.status, w.statusdate, w.ZZCREATEDATE, 
w.location, w.DESCRIPTION, w.FAILURECODE , w.PROBLEMCODE , 
w.JPNUM , w.zzreqnum, w.FIRSTAPPRSTATUS, w.ZZLEADPOSSIBLE , 
w.zzlead,  w.ZZSUBWORKTYPE, w.ZZWORKOWNER ,  w.parent, p.status AS parentstatus, p.STATUSDATE AS parentstatusdate, p.ZZCRAFT AS parentcraft, p.FAILURECODE AS parentfc, p.PROBLEMCODE AS parentpc 
FROM maximo.WORKORDER w ,
maximo.workorder p
WHERE w.ZZCRAFT = 'VENDOR'
AND p.wonum = w.parent
AND w.WORKTYPE = 'CM'
AND w.STATUS NOT IN ('CLOSE','CAN')
AND w.LOCATION LIKE '038.%'
ORDER BY w.STATUSDATE
