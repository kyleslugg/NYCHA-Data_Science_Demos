
SELECT siteid, location, zzcraft, trunc(schedstart) AS startdate, min(reportdate) AS createdate
from
(SELECT wonum, parent, siteid, location, status, statusdate, worktype, zzcraft, FAILURECODE, PROBLEMCODE, reportdate, SCHEDSTART  
FROM maximo.WORKORDER w 
WHERE zzcraft IN ('ELECTRCN', 'PAINTER', 'PLASTER', 'BRKLAYER', 'ROOFER', 'EXTERMIN', 'GLAZIER', 'CARPENTR', 'PLUMBER')
AND status = 'SCHED')
GROUP BY siteid, location, zzcraft, trunc(schedstart)