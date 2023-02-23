SELECT   b.development_name, a.tds_num, e.address_line_1 , e.building_num , a.stair_hall , a.apt_num  , a.zzisapt  , a.location  , e.location_type , a.ownergroup
    , a.call_center_type , a.parent , a.wonum , WORKTYPE , c.trade_type , c.craft_description , a.failurecode  , a.problemcode , f.problemcode_desc , a.wopriority
    , reportdate , a.zzcreatedate , a.zzcreate_month_id , a.targstartdate ,  a.schedstart , a.actstart , a.actfinish , a.status , a.statusdate

    , D.disposition_desc , d.disposition_sub_desc , d.work_done_desc, a.zzsubworktype, a.zzsqfeet, a.cause , a.remedy , a.zzrescode, a.last_labtrans_transtype
    , a.total_repairs_done    , a.repairs_done_list , a.vandalism_code , a.zzcourtorder , a.SOURCESYSID , ZZRRPWORKREQUIRED , ZZRRPWORKAMOUNT
    , round( CASE  WHEN d.disposition_desc = 'CLOSED'  THEN a.total_days_to_repair_finish
                                            WHEN d.disposition_desc = 'OPEN'  THEN total_days_open  ELSE NULL END, 2) "Days to Complete Or Still Open"
        , h.kronos_badge_number,    h.firstname,    h.lastname ,    g.start_date_time ,    g.finish_date_time ,    g.transtype

FROM  eisdw.wts_task_fact a, eisdw.nycha_org_dim b,  eisdw.wts_trades_dim c, eisdw.nycha_disposition_dim d,  eisdw.loc_hierarchy_flat e,
                          eisdw.wts_maximo_failurecode_dim f,    EISSTG.WTS_MAXIMO_LABTRANS_STG g,    eisdw.WTS_MAXIMO_LABOR_DIM h ,  EISDW.WTS_MAXIMO_OWNERGROUP_DIM O
 WHERE  a.tds_num = b.tds_num   AND B.ACTIVE_IND = 'Y'   AND B.NEW_BOROUGH_GROUPING <> 'Not Applicable'  AND  a.trade_code = c.trade_code
      AND  a.disposition_sub_code = d.disposition_sub_code   AND a.location = e.location   AND  a.failurecode = f.failurecode  AND  a.problemcode = f.problemcode
          AND a.siteid = g.siteid (+) AND  a.wonum = g.refwo (+)  AND  g.laborcode = h.laborcode (+)   and   a.OWNERGROUP = O.OWNERGROUP
and A.WORKTYPE in ('CM','IN')    and a.tds_num in (26,505,5,48)  and c.CRAFT_DESCRIPTION in ('Carpenter','Electrician','Maintenance','Painter','Plaster','Plumber')
and O.CARPEDIA_SCOPE_IND = '1'    and status_day_id between 20200101 and 20201206   and  disposition_desc in ('OPEN', 'CLOSED')
AND (NVL(a.ZZRESCODE,'Others')) NOT IN ('CREATEDINERROR','DUPLICATE')
