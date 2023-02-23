SELECT *
FROM --dw1.ZZMMD_PROCUREMENT_BL_REL zpbr  

eisdw.poreq_req_summary_fact--dw1.ZZMMD_PROCUREMENT_PO_PURCHASE zppp --dw1.ZZMMD_ALL_CONTRACTS_DATA zacd  --dw1.ZZMMD_ALL_OPEN_REQS zaor 

--ebsdw.ZZPO_AGREEMENT_FACT zaf ebsdw.ZZPO_PO_REQ_EXPENDITURE_FACT zpref ebsdw.ZZPO_REQUISITION_FACT zrf 

-- EBSDW.ZZPO_BRIDGE_DIM zbd --Connects PO numbers with REQ numbers with REQ Header numbers, etc., for reqs with POs issued