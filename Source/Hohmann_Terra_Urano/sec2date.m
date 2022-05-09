function  data = sec2date(sec)
%   Estraggo gli anni
    years = floor(sec / year2seconds(1));
%   Estraggo i mesi
    months = floor( mod(sec, year2seconds(1)) / month2seconds(1) );
    years = years + floor(months / 12);
    months = months - 12 * floor(months / 12);
%   Estraggo i giorni
    days = floor( mod(mod(sec, year2seconds(1)), month2seconds(1)) / days2seconds(1) );
    months = months + floor(days / 30);
    days = days - 30 * floor(days / 30);
%   Estraggo le ore
    hours = floor( mod(mod(mod(sec, year2seconds(1)), month2seconds(1)), days2seconds(1))...
        / 3600 );
    days = days + floor(hours / 24);
    hours = hours - 24 * floor(hours / 24);
%   Estraggo i minuti
    minutes = floor( mod((mod(mod(mod(sec, year2seconds(1)), month2seconds(1)), days2seconds(1))), ...
        3600) / 60 );
    hours = hours + floor(minutes / 60);
    minutes = minutes - 60 * floor(minutes / 60);
%   Estraggo i secondi
    seconds = floor( mod(mod((mod(mod(mod(sec, year2seconds(1)), month2seconds(1)), ...
        days2seconds(1))), 3600), 60) );
    minutes = minutes + floor(seconds / 60);
    seconds = seconds - 60 * floor(seconds / 60);
    data = [years, months, days, hours, minutes, seconds]
end