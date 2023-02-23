select hrs.*, empdim.work_loc, payloc.shortloc, titles.title_description, empdim.title_suffix, empdim.pay_period

from eisdw.kronos_hrs_worked_fact hrs,
(select * from eisdw.hrd_employee_dim where REGEXP_LIKE(employee_id, '^[[:digit:]]+$')) empdim,
eisdw.hrd_title_dim titles,
DWBUILD.PAY_LOCATIONS_T payloc

where hrs.kronos_badge_number = cast(empdim.employee_id as number)
and EMPDIM.work_loc in (212, 538, 272)
and empdim.work_loc = payloc.workloC
and hrs.day_id >= '2019010'
and empdim.title_number = titles.title_number
and titles.TITLE_DESCRIPTION IN ('Assistant Resident Buildings Superintendent', 'Caretaker', 'Chief Caretaker', 'Resident Buildings Superintendent', 'Supervisor Housing Groundskeeper', 'Supervisor of Housing Caretakers')

--and 
--hrs.kronos_badge_number = trim(leading 0 from empdim.employee_id)

--and firstpunch.person_num = trim(leading 0 from empdim.employee_id)