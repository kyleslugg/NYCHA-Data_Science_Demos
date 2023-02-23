SELECT b.new_borough_grouping,

  b.CONSOLIDATED_NAME ,

  b.DEVELOPMENT_NAME ,

  a.TDS_NUM ,

  E.ADDRESS_LINE_1 ,

  E.BUILDING_NUM ,

  a.stair_hall ,

  a.APT_NUM ,

  a.ZZISAPT,

  a.location ,

  e.location_type ,

  a.OWNERGROUP ,

  a.CALL_CENTER_TYPE ,

  a.parent ,

  a.WONUM,

  A.WORKTYPE ,

  c.trade_type ,

  c.craft_description ,

  a.FAILURECODE ,

  a.PROBLEMCODE ,

  PROBLEMCODE_DESC ,

  a.WOPRIORITY,

  A.reportdate ,

  a.ZZCREATEDATE ,

  ZZCREATE_MONTH_ID ,

  TARGSTARTDATE,

  a.schedstart,

  a.ACTSTART,

  a.actfinish ,

a.status ,

  A.STATUSDATE ,

  STATUS_MONTH_ID,

  a.ZZSUBWORKTYPE,

  A.ZZSQFEET ,

  A.CAUSE,

  a.Remedy ,

  A.ZZRESCODE ,

  a.LAST_LABTRANS_TRANSTYPE,

  a.total_repairs_done ,

  a.repairs_done_list ,

  A.VANDALISM_CODE ,

  A.ZZCOURTORDER ,

  a.SOURCESYSID ,

  A.ZZRRPWORKREQUIRED ,

  A.ZZRRPWORKAMOUNT,

  ROUND(

  CASE

    WHEN d.disposition_desc ='CLOSED'

    THEN a.total_days_to_repair_finish

    WHEN d.disposition_desc ='OPEN'

    THEN a.total_days_open

    ELSE NULL

  END,2) "Days to Complete Or Still Open"

FROM eisdw.wts_task_fact a,

  eisdw.nycha_org_dim b,

  eisdw.wts_trades_dim c,

  eisdw.nycha_disposition_dim d,

  EISDW.LOC_HIERARCHY_FLAT E,

  EISDW.WTS_MAXIMO_FAILURECODE_DIM F

WHERE A.TDS_NUM                   = B.TDS_NUM

AND a.trade_Code                  = c.trade_code

AND a.disposition_sub_code        = d.disposition_sub_code

AND A.LOCATION                    = E.LOCATION

AND A.FAILURECODE                 = F.FAILURECODE

AND A.PROBLEMCODE                 = F.PROBLEMCODE

AND B.ACTIVE_IND                  = 'Y'

AND B.NEW_BOROUGH_GROUPING       <> 'Not Applicable'

AND A.WORKTYPE                    = 'CM'

  ;
