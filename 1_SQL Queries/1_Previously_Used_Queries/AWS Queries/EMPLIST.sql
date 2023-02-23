select empdim.employee_id, empdim2.first_name, empdim2.last_name, sched.group_schedule_name, title.title_description, empdim.title_suffix, payloc.shortloc as assigned_work_location
from  
(select employee_id, pay_period, title_number, title_suffix, work_loc 
    from eisdw.hrd_employee_dim 
    where REGEXP_LIKE(employee_id, '^[[:digit:]]+$')
    ) empdim,
    nicedw.nycha_employees_dim empdim2,
eisdw.hrd_title_dim title,
DWBUILD.PAY_LOCATIONS_T payloc,
eisdw.kronos_schedule_fact sched

where empdim.title_number = title.title_number
and empdim.employee_id = 
and empdim.work_loc = payloc.workloC
AND (upper(title.title_description) like '%CARETAKER%'
or title.title_description in ('Supervising Housing Groundskeeper', 'Administrative Housing Superintendent', 'Resident Buildings Superintendent', 'Assistant Resident Buildings Superintendent')) 
