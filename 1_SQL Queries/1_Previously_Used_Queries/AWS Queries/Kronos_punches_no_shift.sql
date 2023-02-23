select punch.*, sched.group_schedule_name, title.title_description, empdim.title_suffix, payloc.shortloc as assigned_work_location
from (select punches.*, dates.pay_period 
      from eisstg.kronos_punches_stg punches, 
      (select day_id, pp, lpad((case 
                        when (month_of_year = 12) and (pp = 1) then pp||(cast(substr(year_id, -2) as number)+1) 
                        else pp||substr(year_id, -2)
                        end),4,'0') pay_period
        from (select day_id, 
        year_id, 
        month_of_year, 
        last_value(decode(pay_period, 0, null, 
                                      null, null, 
                                      pay_period)) 
                    ignore nulls over (order by day_id desc rows 
                    between unbounded preceding and current row) pp
              from EISDW.NYCHA_TIME_DAILY_DIM
              where DAY_ID >= 20190101
              order by DAY_ID desc)) dates
        where punches.day_id = dates.day_id) punch, 
(select employee_id, pay_period, title_number, title_suffix, work_loc 
    from eisdw.hrd_employee_dim 
    where REGEXP_LIKE(employee_id, '^[[:digit:]]+$')
    ) empdim,
eisdw.hrd_title_dim title,
DWBUILD.PAY_LOCATIONS_T payloc,
eisdw.kronos_schedule_fact sched

where punch.personnum = trim(leading 0 from empdim.employee_id)
AND punch.pay_period = empdim.pay_period
AND empdim.title_number = title.title_number
and empdim.work_loc = payloc.workloC
and punch.day_id = sched.day_id
and punch.personnum = sched.kronos_badge_number
AND (upper(title.title_description) like '%CARETAKER%'
or title.title_description in ('Supervising Housing Groundskeeper', 'Administrative Housing Superintendent', 'Resident Buildings Superintendent', 'Assistant Resident Buildings Superintendent')) 
order by punch.DAY_ID desc