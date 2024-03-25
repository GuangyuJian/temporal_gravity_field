
function [meanday,meantime,mean_year]=gdut_get_mean_day(year1,year2,day1,day2)

% if year1 == year2
%     meanday = (day1+day2)/2;
% else
%     if (day1+(366-day1+day2)/2)>365 % in latter year
%         year1   = year1 + 1;
%         meanday = day2-(366-day1+day2)/2;
%     else
%         meanday = day1+(366-day1+day2)/2;  % in former year
%     end
% end


% e.g., 20170317-20170414
% time_coverage_start : 2017-03-17 00:00:00
% time_coverage_end   : 2017-04-15 00:00:00 or 2017-04-14 23:59:59

day1=day1-1;
day2=day2;
flag_leap1=365+is_leap_year(year1);
flag_leap2=365+is_leap_year(year2);

time1        = year1 + day1/flag_leap1;
time2        = year2 + day2/flag_leap2;

meantime=round((time1+time2)/2,5);
if meantime-year1<=1
    meanday=(meantime-year1)*flag_leap1;
    mean_year=year1;
else
    meanday=(meantime-year1-1)*flag_leap2;
    mean_year=year2;
end
% meantime-year1-1
end
