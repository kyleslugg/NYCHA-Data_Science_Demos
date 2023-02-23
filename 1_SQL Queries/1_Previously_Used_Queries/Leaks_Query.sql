WITH PQ AS(
    SELECT PARENT
    FROM WORKORDER
    WHERE ((FAILURECODE LIKE '%LEAK%') OR (PROBLEMCODE LIKE '%LEAK'))
    AND STATUS = 'CLOSE' AND WORKTYPE = 'CM')
    
SELECT * 
FROM WORKORDER 
WHERE (WORKORDER.PARENT IN (SELECT * FROM PQ)
    OR
    WORKORDER.WONUM IN (SELECT * FROM PQ))
    AND WORKORDER.STATUS = 'CLOSE';