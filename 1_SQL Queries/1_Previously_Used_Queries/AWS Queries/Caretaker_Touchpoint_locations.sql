select *
from maximo.locations
where type in ('FLOOR', 'STAIRWELL', 'ROOF LANDING', 'LOBBY', 'COMPACTOR ROOM', 'ELEVATOR SHAFT')
and zzdevnum in 
    (select lpad(TDS_NUM, 3, '0')
    from maximo.nycha_org_dim
    where CONSOLIDATED_NAME in ('Breukelen', 'Sumner', 'Wyckoff Gardens'))
and status = 'OPERATING'       
order by LOCATION   