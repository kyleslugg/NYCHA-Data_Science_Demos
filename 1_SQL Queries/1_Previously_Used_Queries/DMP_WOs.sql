SELECT TO_char(statusdate, 'MM.DD.YYYY'), count(*) c
--failurecode, problemcode description, location, zzcreatedate, ownergroup,STATUS, ZZCREATEDATE, STATUSDATE, WORKTYPE, ZZCRAFT 
FROM WORKORDER
--WHERE FAILURECODE LIKE 'LEAD%'
--PROBLEMCODE LIKE '%LEAD%'
--AND OWNERGROUP LIKE 'TSD%'
where STATUS = 'CLOSE'
AND WORKTYPE = 'CM'
AND ZZSUBWORKTYPE IN ('LBPASMAPT','LBPASMCOM','LBPCOM','LBPDEFCU6','LBPDEFNOCU6','LBPXRF')
AND STATUSDATE > to_date('11.01.2020','mm.dd.yyyy')
group by to_char(statusdate, 'MM.DD.YYYY')
--ORDER BY STATUSDATE
