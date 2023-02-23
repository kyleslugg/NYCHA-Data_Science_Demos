SELECT geographical_borough_name,
  b.new_borough_grouping Boro,
  deputy_director Neighbd,
  b.consolidated_name ,
  b.consolidated_tds_num,
  b.Development_Name ,
  a.tds_num ,
  E.Address_Line_1 ,
  lpad(a.tds_num,3,'0')
  ||'-'
  ||lpad(a.stair_hall,3,'0')
  || '-'
  ||lpad(a.apt_num,3,'0') ACCOUNT# ,
  a.location ,
  e.location_type,
  a.parent, a.zzisapt,
  a.WONUM,
  a.ownergroup ,
  a.sourcesysid ,
  c.craft_description,
  A.Failurecode ,
  A.problemcode,
  f.Problemcode_Desc ,
  A.Wopriority ,
  A.Reportdate ,
  A.Zzcreatedate ,
  A.Zzcreate_Month_Id ,
  Targstartdate ,
  a.schedstart ,
  a.actstart ,
  a.actfinish ,
  a.status ,
  a.statusdate ,
  a.status_month_id ,
  D.disposition_desc ,
  d.disposition_sub_desc ,
  d.work_done_desc ,
  A.Zzsubworktype ,
  a.cause ,
  a.Remedy ,
  A.Zzrescode ,
  A.Last_Labtrans_Transtype ,
  description,
  a.total_repairs_done ,
  a.repairs_done_list ,
  A.VANDALISM_CODE ,
  a.zzcourtorder ,
  a.zzrrpworkrequired ,
  a.zzrrpworkamount ,
  24*A.total_days_to_repair_finish Hrs_finish,  round((case when D.disposition_desc = 'CLOSED' THEN A.total_days_to_repair_finish 
                      WHEN D.disposition_desc = 'OPEN' THEN A.Total_Days_Open  else null end),2) Days_Complete_OR_OPEN

FROM eisdw.wts_task_fact a,
  eisdw.nycha_org_dim b,
  eisdw.wts_trades_dim c,
  eisdw.nycha_disposition_dim d,
  EISDW.LOC_HIERARCHY_FLAT E,
  EISDW.WTS_MAXIMO_FAILURECODE_DIM F
WHERE a.worktype            = 'CM'
AND A.Tds_Num               = B.Tds_Num
AND B.Active_Ind            = 'Y'
AND B.New_Borough_Grouping <> 'Not Applicable'
AND a.trade_Code            = c.trade_code
AND a.disposition_sub_code  = d.disposition_sub_code
AND a.location              = E.location
AND a.failurecode
  ||'-'
  ||a.problemcode= f.failurecode
  ||'-'
  ||f.problemcode
AND a.Zzcreate_Month_Id BETWEEN 201901 AND 202103
AND craft_description = 'Caretaker'