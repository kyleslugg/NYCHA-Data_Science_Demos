select hrs.kronos_badge_number, hrs.day_id, hrs.hours_type, hrs.hours_worked, 
       hrs.group_schedule_name, emp.nyc_title, emp.nyc_title_id, 
       emp.last_name||', '||emp.first_name, emp.work_loc_id, emp.location_name
from eisdw.kronos_hrs_worked_fact hrs,
     (select * from nicedw.nycha_employees_dim where latest_record_ind = 'Y') emp
where hrs.kronos_badge_number = emp.kronos_badge_number
and 
    (hrs.kronos_badge_number in 
	(86952, 86762, 78204, 82715, 84794, 
	 86113, 81093, 85076, 86485, 84097, 
	 85682, 63967, 66914, 84465, 79387,
	 84543, 83861, 75417, 83590, 86090, 
	 379839, 84100, 86007, 85748, 379922,
	 85851, 86169, 380437, 381024, 87015,
	 63981, 15410, 76418, 86696, 84104, 
	 379838, 63191, 61497, 79719, 72824, 
	 79131, 76812, 84142, 84897, 86376, 
	 68151, 83981, 62406) --Breukelen

    or hrs.kronos_badge_number in
	(83681, 83921, 70228, 80304, 82651,
	 81435, 83320, 74803, 73304, 74630,
	 81971, 60675, 61026, 58287, 55426,
	 15895, 16583, 68621, 55681, 72135, 7544) --Wyckoff
     
     or hrs.kronos_badge_number in
     (86821, 76969, 83053, 84936, 80394, 
      84298, 83540, 85246, 82164, 84042,
      80816, 78236, 83976, 86924, 85752,
      379906, 79222, 81618, 70051, 67666,
      59114, 81549, 81990, 83792, 83284,
      60158, 64503, 66538, 58425, 12863)) --Sumner
     
and day_id >= '20210701'          