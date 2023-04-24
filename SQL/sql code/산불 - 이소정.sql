select *
from fire f 
	inner join weather w 
	on f.code_id = w.code_id
	inner join code c
	on c.code_id = f.code_id;

/* 년도별 산불 발생현황 */
select c.year, sum(f.fire_count) count, 
	sum(f.fire_area) area, sum(f.fire_cost) cost
from fire f join code c
	on f.code_id = c.code_id
group by c.year
order by 3 desc;

/* 산불이 발생했던 가장 많았던(작았던) 두 개 년도 */
select c.year, sum(f.fire_count) count, sum(f.fire_area) area, 
		avg(w.wind) wind, avg(w.water) water, avg(w.humidity) humidity, 
		avg(w.sunshine) sunshine, avg(w.sunenergy) sunenergy
from fire f 
	inner join weather w 
	on f.code_id = w.code_id
	inner join code c
	on c.code_id = f.code_id
group by c.year
having c.year in (2000, 1996, 2003, 2012) 
order by 3 desc;

/* 지역별 산불 */
select c.local, avg(f.fire_count) count, avg(f.fire_area) area, 
		avg(w.wind) wind, avg(w.water) water, avg(w.humidity) humidity, 
		avg(w.sunshine) sunshine, avg(w.sunenergy) sunenergy
from fire f 
	inner join weather w 
	on f.code_id = w.code_id
	inner join code c
	on c.code_id = f.code_id
group by c.local
order by 2 desc;

/* 지역별 산불과 산림 */
select c.local, avg(f.fire_count), avg(f.fire_area),
		avg(ad.forest_area), avg(ad.density)
from fire f join area_density ad 
	on f.code_id = ad.code_id
	join code c 
	on c.code_id = f.code_id
group by c.local;

/* 연도별 산불과 산림 */
select c.year, avg(f.fire_count), avg(f.fire_area),
		avg(ad.forest_area), avg(ad.density)
from fire f join area_density ad 
	on f.code_id = ad.code_id
	join code c 
	on c.code_id = f.code_id
group by c.year
order by 3 desc;
