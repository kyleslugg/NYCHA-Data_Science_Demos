select hrs.kronos_badge_number, hrs.day_id, hrs.hours_type, hrs.hours_worked, 
       hrs.group_schedule_name, emp.nyc_title, emp.nyc_title_id, 
       emp.last_name||', '||emp.first_name, emp.work_loc_id, emp.location_name
from eisdw.kronos_hrs_worked_fact hrs,
     (select * from nicedw.nycha_employees_dim where latest_record_ind = 'Y') emp
where hrs.kronos_badge_number = emp.kronos_badge_number
and (emp.kronos_badge_number in (58425, 59114, 60158, 64503, 66538, 67666, 70051, 75301, 76969, 78236, 79222, 80394, 80816, 81549, 81618, 81990, 82164, 83053, 83284, 83381, 83540, 83792, 83976, 84042, 84298, 84936, 85245, 85246, 85752, 86711, 86821, 86924, 379906, 75301, 10423, 83688, 379999, 380448, 61708)
    OR emp.kronos_badge_number in (61497, 63191, 63967, 63981, 66914, 68151, 68871, 72824, 75417, 76418, 76812, 78204, 79131, 79387, 79719, 81093, 82715, 83590, 83861, 84097, 84142, 84142, 84465, 84543, 84794, 84897, 85076, 85682, 86113, 86376, 86485, 86696, 86762, 86952, 1722510, 379838, 84104, 379839, 379922, 380437, 381024, 84100, 85748, 85851, 86090, 86169, 87015, 83981, 62406, 80268, 81142, 76697, 86007)
    OR emp.kronos_badge_number in (7544, 15895, 16583, 55426, 55681, 58287, 60675, 61026, 68621, 70228, 72135, 73304, 74630, 74803, 78565, 80304, 81435, 81971, 82651, 83320, 83681, 83743, 83921, 84620, 85791) --All IDs good, ha-hah!
    )
and day_id >= '20210701' 