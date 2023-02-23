--Query to get Jan-Jul work orders by craft and development tds 
    SELECT 
        w.siteid,
        substr(w.location, 0, 3) AS tds,
        dev.description as development, 
        dev.full_managing as managed_by,
        dev.neighborhood_desc as neighborhood,
        w.status, 
        w.worktype,
        w.zzcraft,
        COUNT(DISTINCT w.wonum) AS count_distinct_wonum
    FROM
        maximo.WORKORDER w,
        maximo.zzdevelopments dev
    WHERE
        w.zzcraft IN (
            'ELECTRCN',
            'PAINTER',
            'PLASTER',
            'BRKLAYER',
            'ROOFER', 
            'EXTERMIN',
            'GLAZIER',
            'CARPENTR',
            'PLUMBER',
            'MAINT'
        )
    AND
        w.zzcreatedate > to_date('31-DEC-2021','DD-MON-YYYY')
    AND
        w.zzcreatedate < to_date('01-AUG-2022','DD-MON-YYYY')
    AND
        substr(w.location, 0, 3) = dev.location
        
    AND 
    	w.status <> 'CAN'
	
	AND 
		w.worktype = 'CM'
    	
    GROUP BY
        substr(w.location, 0, 3),
        w.siteid,
        dev.description, 
        dev.full_managing,
        dev.neighborhood_desc,
        w.status, 
        w.worktype,
        w.zzcraft