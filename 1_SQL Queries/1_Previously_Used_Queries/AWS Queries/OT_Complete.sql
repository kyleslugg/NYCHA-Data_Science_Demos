select hrs.KRONOS_BADGE_NUMBER, 
title.title_description, 
empdim.title_suffix,
hrs.DAY_ID, hrs.HOURS_TYPE, 
hrs.HOURS_WORKED, 
hrs.GROUP_SCHEDULE_NAME, 
empdim.work_loc, 
payloc.shortloc,
empdim.pay_period

from 
(select hrs.*, dates.pay_period 
      from eisdw.kronos_hrs_worked_fact hrs, 
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
        where hrs.day_id = dates.day_id) hrs, 
(select employee_id, pay_period, title_number, title_suffix, work_loc 
    from eisdw.hrd_employee_dim 
    where REGEXP_LIKE(employee_id, '^[[:digit:]]+$')
    ) empdim,
eisdw.hrd_title_dim title,
DWBUILD.PAY_LOCATIONS_T payloc

where hrs.pay_period = empdim.pay_period
and hrs.kronos_badge_number = cast(empdim.employee_id as number)
and empdim.work_loc = payloc.workloC
and empdim.title_number = title.title_number
AND (upper(title.title_description) like '%CARETAKER%'
or title.title_description in ('Supervising Housing Groundskeeper', 'Administrative Housing Superintendent', 'Resident Buildings Superintendent', 'Assistant Resident Buildings Superintendent')) 
order by hrs.kronos_badge_number, hrs.day_id, empdim.pay_period
