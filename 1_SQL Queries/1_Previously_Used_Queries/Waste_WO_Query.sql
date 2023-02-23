select * from workorder
where zzcreatedate>=to_date('01.01.2019','MM.DD.YYYY')
and (FAILURECODE = 'DEBRISSPILL' OR FAILURECODE = 'REGULATEDWASTE' OR PROBLEMCODE = 'DEBRIS')