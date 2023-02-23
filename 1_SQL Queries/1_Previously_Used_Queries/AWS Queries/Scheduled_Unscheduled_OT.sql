select hrs.*, empdim.work_loc, payloc.shortloc, titles.title_description, empdim.title_suffix

from eisdw.kronos_hrs_worked_fact hrs,
(select * from eisdw.hrd_employee_dim where REGEXP_LIKE(employee_id, '^[[:digit:]]+$')) empdim,
eisdw.hrd_title_dim titles,
DWBUILD.PAY_LOCATIONS_T payloc

where hrs.kronos_badge_number = cast(empdim.employee_id as number)
and empdim.work_loc = payloc.workloC
and hrs.day_id >= '2019010'
and empdim.title_number = titles.title_number