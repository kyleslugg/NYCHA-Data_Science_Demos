SELECT count(a.WONUM), C.CRAFT_DESCRIPTION
  
FROM eisdw.wts_task_fact a,
  eisdw.nycha_org_dim b,
  eisdw.wts_trades_dim c,
  eisdw.nycha_disposition_dim d,
  EISDW.LOC_HIERARCHY_FLAT E,
  EISDW.WTS_MAXIMO_FAILURECODE_DIM F
WHERE a.worktype            = 'CM'
AND A.ZZISAPT = 0
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
AND a.Zzcreate_Month_Id >= '201901'
and a.failurecode ='EXHAUSTFAN'
and a.problemcode = 'NEEDSCLEANING'
and -- Add sub-query to select only FCPCs where WOs with craft_description 'Caretaker' or 'Supv of Caretakers' >= max(select(count(a.wonum) from LALALALA where LALALA group by c.craft_description))
group by c.craft_description