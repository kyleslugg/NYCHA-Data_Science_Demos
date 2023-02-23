select a.wonum, a.zzcreatedate, a.location, a.status, a.jpnum, a.description, b.*
from maximo.workorder a,
maximo.zzworesult b
where a.wonum = b.wonum
and (upper(a.description) like '%DAILY BUILDING%' or upper(a.description) like '%DAILY GROUNDS%')
and substr(a.location, 0, 3) in ('056', '073', '156', '311', '256', '163')
and a.zzcreatedate >= DATE '2021-07-01';



select a.wonum, a.zzcreatedate, a.location, a.status, a.status_date a.jpnum, a.description, B.*
from eisdw.wts_task_fact a,
eisstg.wts_maximo_zzworesult_stg b
where a.wonum = b.wonum
and (upper(a.description) like '%DAILY BUILDING%' or upper(a.description) like '%DAILY GROUNDS%')
and a.tds_num in ('056', '073', '156', '311', '256', '163')
and a.zzcreatedate >= DATE '2021-07-01';


select *--a.wonum, a.zzcreatedate, a.location, a.status, a.jpnum, a.description--, B.*
from eisdw.wts_task_fact a--,
--eisstg.wts_maximo_zzworesult_stg b
where --a.wonum = b.wonum and 
a.description like '%Daily%Building%Inspection%'
and a.tds_num in ('056', '073', '156', '311', '256', '163')
and a.zzcreatedate >= to_date('2021-06-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS')