select e.location, e.siteid, e.failurecode, e.problemcode, e.numstchildren, f.displayname, f.enterdate, e.consolidated_name, e.neighborhood_desc, e.wonum, e.status, e.statusdate, e.zzcreatedate, e.actstart, e.actfinish
from

(select a.location, a.siteid, a.failurecode, a.statusdate, a.problemcode, a.wonum, a.description, a.status, a.zzmanagedby, a.zzcraft, a.worktype, a.changeby, a.zzcreatedate, a.numstchildren, a.actstart, a.actfinish, b.consolidated_name, b.neighborhood_desc

from
    (select w.*, relevant_wos.numstchildren
    from workorder w,
        (select distinct parent, numstchildren from
        (
            select parent, zzcraft, count(*) over (partition by parent) as numstchildren, count(distinct datecreated) over (partition by parent) as uniquedates from
            (
                select distinct parent, zzcraft, TRUNC(zzcreatedate) datecreated from
                (
                    select problemcode, failurecode, parent, location, description, changeby, zzcraft, zzmanagedby, zzsourcecreate, zzcreatedate
                    from workorder
                    where worktype='CM'
                    and zzcraft IN ('PAINTER', 'PLASTER','ELECTRCN','ROOFER','EXTERMIN','GLAZIER','CARPENTR','PLUMBER','SUPVPLBR','SUPVPLST','BRKLAYER', 'VENDOR')
                    and ownergroup not like '%TEMPO%'
                    and istask=0
                    and ((siteid='QS' and zzcreatedate>to_date('11.28.2021','MM.DD.YYYY'))
                        or (siteid='BX' and zzcreatedate>to_date('03.13.2022','MM.DD.YYYY')))
                    and parent is not null
                    and zzsourcecreate like '%MOBILE%'
                    )
                  )  
                )
            where numstchildren >= 1 and uniquedates = 1
             ) relevant_wos
    where w.wonum = relevant_wos.parent
    and zzcraft='MAINT' and worktype='CM' and status='CLOSE'
    and ((siteid='QS' and actfinish>to_date('11.28.2021','MM.DD.YYYY'))
                        or (siteid='BX' and actfinish>to_date('03.13.2022','MM.DD.YYYY')))
    )a

left join

(select x.consolidated_name, x.tds_num, y.neighborhood_desc 
    from maximo.nycha_org_dim x, 
    (select distinct zzmanagedby, neighborhood_desc from maximo.zzdevelopments where neighborhood_desc is not NULL) y
    
    where x.consolidated_tds_num = y.zzmanagedby) b

on b.tds_num=a.zzmanagedby)  e

left join
(select c.laborcode, c.craft, c.enterby, c.enterdate, c.startdatetime, c.finishdatetime, c.location, c.zzsourcecreate, c.zzsourcechange, c.refwo, d.personid, d.status, d.displayname, d.department, d.supervisor

from maximo.labtrans c, maximo.person d

where d.personid=c.laborcode
) f

on f.refwo=e.wonum
where to_char(f.enterdate,'mm.dd.yyyy')=to_char(e.statusdate,'mm.dd.yyyy')
order by consolidated_name