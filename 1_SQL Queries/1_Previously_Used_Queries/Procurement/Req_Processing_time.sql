SELECT
	rp.*,
	bridge.PO_HEADER_TYPE,
	bridge.PO_NUMBER
FROM
	(
	SELECT
		RQ.RH_APPROVED_DATE,
		RQ.RH_CREATION_DATE,
		rq.RH_LAST_UPDATE_DATE,
		(RQ.RH_APPROVED_DATE-RQ.RH_CREATION_DATE) time_to_approve,
		(RQ.RH_LAST_UPDATE_DATE-RQ.RH_CREATION_DATE) time_to_update,
		RQ.RH_AUTHORIZATION_STATUS,
		RQ.RH_PHAS_FF,
		RQ.RL_LINE_NUM,
		RQ.RL_ITEM_DESCRIPTION,
		RQ.RL_CREATED_BY,
		RQ.RL_LAST_UPDATED_BY,
		RQ.RL_QUANTITY_DELIVERED,
		RQ.RL_QUANTITY_RECEIVED,
		RQ.RL_REQUESTER_EMAIL ,
		RQ.RL_PURCHASE_BASIS ,
		rq.rh_requisition_header_ID,
		loc.LOCATION_CODE,
		loc.DESCRIPTION,
		loc.attribute1 AS borough,
		loc.attribute3 AS dept,
		loc.attribute4 AS unit,
		loc.attribute5 AS cons
	FROM
		ebsdw.ZZPO_REQUISITION_FACT rq
	LEFT JOIN 
	EBSSTG.HR_LOCATIONS_ALL loc
	ON
		rq.RL_DELIVER_TO_LOCATION_ID = loc.SHIP_TO_LOCATION_ID
	WHERE
		rq.RH_CREATION_DATE > to_date('2022.11.01', 'yyyy.mm.dd')
		AND rq.RL_PURCHASE_BASIS = 'SERVICES'
		AND loc.attribute4 = 'Operations') rp
LEFT JOIN
	EBSDW.ZZPO_BRIDGE_DIM bridge
	--dw1.ZZMMD_PROCUREMENT_PO_PURCHASE po
ON
	rp.RH_REQUISITION_HEADER_ID = bridge.requisition_header_id
ORDER BY
	Time_to_update DESC
