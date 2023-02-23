SELECT
a.WONUM ,
a.PARENT ,
b.TRANSDATE ,
b.LABTRANSID ,
b.LATEST_RECORD_IND ,
b.FIRST_LABTRANS_LABTRANSID ,
b.FIRST_LABTRANS_TRANSTYPE ,
b.TRANSTYPE ,
b.SITEID ,
b.LABORCODE ,
b.CRAFT ,
b.START_DAY_ID ,
b.START_DATE_TIME ,
b.FINISH_DATE_TIME ,
b.TOTAL_LABOR_HRS ,
c.KRONOS_BADGE_NUMBER ,
c.WORKLOCATION,
c.WORKGROUP,
c.DEPARTMENT
from
(SELECT b.GEOGRAPHICAL_BOROUGH_NAME ,
      b.new_borough_grouping ,
      b.CONSOLIDATED_NAME ,
      b.DEVELOPMENT_NAME ,
      a.TDS_NUM ,
      E.ADDRESS_LINE_1 ,
      E.BUILDING_NUM ,
      a.stair_hall ,
      CASE
        WHEN a.ZZISAPT = 1
        THEN (LPAD(A.TDS_NUM,3,'0')
          ||'-'
          ||LPAD(A.STAIR_HALL,3,'0')
          || '-'
          ||LPAD(A.APT_NUM,3,'0'))
        ELSE NULL
      END ACCOUNTNO ,
      E.ZONE Hurricane_ZONE ,
      a.APT_NUM ,
      a.ZZISAPT ,
      a.location ,
      e.location_type ,
      a.OWNERGROUP ,
      a.CALL_CENTER_TYPE ,
      a.parent,
      a.WONUM ,
      a.ZZCRAFT ,
      c.trade_type ,
      c.craft_description ,
      F.FAILURE_CATEGORY_NAME,
      a.FAILURECODE ,
      a.PROBLEMCODE ,
      F.PROBLEMCODE_DESC,
      a.WOPRIORITY ,
      A.PRIORITY ,
      A.reportdate ,
      a.ZZCREATEDATE ,
      A.ZZCREATE_MONTH_ID ,
      a.schedstart ,
      a.ACTSTART ,
      a.actfinish ,
      ROUND(a.ACTLABHRS,4) ACT_LAB_HRS ,
      a.status ,
      A.STATUSDATE ,
      a.STATUS_MONTH_ID ,
      D.disposition_desc ,
      d.disposition_sub_desc ,
      d.work_done_desc ,
      a.ZZSUBWORKTYPE ,
      A.ZZSQFEET ,
      a.cause ,
      a.Remedy ,
      A.ZZRESCODE ,
      a.LAST_LABTRANS_TRANSTYPE ,
      a.total_repairs_done ,
      a.repairs_done_list ,
      A.VANDALISM_CODE ,
      A.ZZCOURTORDER ,
      a.SOURCESYSID ,
      A.ZZRRPWORKREQUIRED ,
      A.ZZRRPWORKAMOUNT ,
      a.TOTAL_WORKORDERS,
      ROUND(a.total_days_to_repair_finish , 2) DAYS_TO_REPAIR
    FROM eisdw.wts_task_fact a,
      eisdw.nycha_org_dim b,
      eisdw.wts_trades_dim c,
      eisdw.nycha_disposition_dim d,
      EISDW.LOC_HIERARCHY_FLAT E,
      EISDW.WTS_MAXIMO_FAILURECODE_DIM F
    WHERE A.WORKTYPE            = 'CM'
    AND A.TDS_NUM               = B.TDS_NUM
    AND B.ACTIVE_IND            ='Y'
    AND B.NEW_BOROUGH_GROUPING <> 'Not Applicable'
    AND a.trade_Code            = c.trade_code
    AND a.disposition_sub_code  = d.disposition_sub_code
    AND A.LOCATION              = E.LOCATION
    AND  ( A.FAILURECODE || '-' || A.PROBLEMCODE )  = ( F.FAILURECODE || '-' || F.PROBLEMCODE )
    AND d.DISPOSITION_DESC = 'CLOSED'
    AND a.ZZCREATE_MONTH_ID >= 202001
    AND a.ZZCREATE_MONTH_ID <= 202012) A, -- You'll need to either rename or nest the above query here

EISSTG.WTS_MAXIMO_LABTRANS_STG B ,
EISDW.WTS_MAXIMO_LABOR_DIM C
WHERE
a.WONUM = b.REFWO
AND b.laborcode = c.laborcode ;