SELECT
	w3.*,
	l.*
FROM
	(
	SELECT
		*
	FROM
		(
		SELECT
			/*+ CURSOR_SHARING_EXACT */
				w.wonum,
				w.status,
				wo2.statusdate,
				wo2.ZZCREATEDATE,
				wo2.location,
				wo2.DESCRIPTION,
				wo2.FAILURECODE ,
				wo2.PROBLEMCODE ,
				wo2.ZZSUBWORKTYPE,
				wo2.ZZWORKOWNER ,
				wo2.parent,
				p.status AS parentstatus,
				p.STATUSDATE AS parentstatusdate,
				p.ZZCRAFT AS parentcraft,
				p.FAILURECODE AS parentfc,
				p.PROBLEMCODE AS parentpc,
				disp.disposition_sub_code,
				w.CHANGEBY
			FROM
				maximo.wostatus w,
				maximo.workorder wo2,
				maximo.workorder p,
				(SELECT wonum, disposition_sub_code FROM eisdw.wts_task_fact@NICEDW.REGRESS.RDBMS.DEV.US.ORACLE.COM) disp
			WHERE
				w.WOSTATUSID = (
				SELECT
					max(w2.wostatusid)
				FROM
					maximo.wostatus w2
				WHERE
					w.WONUM = w2.WONUM)
				AND w.wonum = wo2.wonum
				AND p.wonum = wo2.parent
				AND w.WONUM = disp.wonum
				AND wo2.OWNERGROUP LIKE 'DEV%'
				AND wo2.STATUS = 'CLOSE'
				AND wo2.ZZCRAFT = 'VENDOR'
				AND wo2.STATUSDATE  > to_date('2021.12.31', 'YYYY.MM.DD')) a
	LEFT JOIN (
		SELECT
			L1 AS BOROUGH,
			NEIGHBORHOOD,
			DEVELOPMENT_NAME,
			TDS_NUM,
			CONSOLIDATED_TDS_NUM
		FROM
			eisdw.LOC_HIERARCHY_FLAT@NICEDW.REGRESS.RDBMS.DEV.US.ORACLE.COM
		WHERE
			LOCATION_TYPE = 'DEVELOPMENT') b
ON
		substr(a.location, 0, 3) = b.tds_num

)w3
LEFT JOIN
(
	SELECT
		first_name,
		last_name,
		kronos_badge_number,
		NYC_TITLE,
		LOCATION_NAME
	FROM
		nicedw.nycha_employees_dim@NICEDW.REGRESS.RDBMS.DEV.US.ORACLE.COM
	WHERE
		LATEST_record_ind = 'Y') l
ON
	to_number(w3.changeby DEFAULT -1 ON CONVERSION ERROR) = l.kronos_badge_number