use team4_db;

/* 데이터 타입 변경, pk 설정 fk 설정 */

alter table weather modify code_id smallint not null;
alter table weather add constraint weather_fk 
   foreign key (code_id) references code(code_id);
alter table weather add constraint weather_pk primary key (code_id);

select * from weather

alter table area_density modify code_id smallint not null;
alter table area_density add constraint area_density primary key (code_id);
alter table area_density add constraint ad_fk 
   foreign key (code_id) references code(code_id);
 
# 기후 변화 확인
# 경상
select c.year, w.temperature
from weather as w
	inner join code as c
	on w.code_id=c.code_id 
where c.local='gyeongsang'
order by w.temperature desc; # 기온 2019,2016 최고 / 1995, 1996 최저

# 강원도
select c.year, w.temperature
from weather as w
	inner join code as c
	on w.code_id=c.code_id 
where c.local='gangwon'
order by w.temperature desc;	# 기온 2015,2016 최고 / 1995, 1996 최저

# 강수량
# 경상
select c.year, w.water
from weather as w
	inner join code as c
	on w.code_id=c.code_id 
where c.local='gyeongsang'
order by w.water desc; # 강수량 2003, 1998, 1999 최고 / 2017, 1995 최저


# 강원
select c.year, w.water
from weather as w
	inner join code as c
	on w.code_id=c.code_id 
where c.local='gangwon'
order by w.water desc;	# 강수량 2003, 2011 최고 / 2014, 2015 최저

# 습도
# 경상
select c.year, w.humidity
from weather as w
	inner join code as c
	on w.code_id=c.code_id 
where c.local='gyeongsang'
order by w.humidity desc; # 습도 2021, 2020, 2003 최고 / 2001, 2000, 2017 최저


# 강원
select c.year, w.humidity
from weather as w
	inner join code as c
	on w.code_id=c.code_id 
where c.local='gangwon'
order by w.humidity desc;	# 습도 1996, 1998, 1995, 2021, 2020 최고 / 2017, 2001, 2005 최저

# 풍속
# 경상
select c.year, w.wind
from weather as w
	inner join code as c
	on w.code_id=c.code_id 
where c.local='gyeongsang'
order by w.wind desc; # 풍속 1995, 2002, 2005 최고 / 2021, 2019, 2022, 2020 최저


# 강원
select c.year, w.wind
from weather as w
	inner join code as c
	on w.code_id=c.code_id 
where c.local='gangwon'
order by w.wind desc;	# 풍속 1999, 2004, 2005 최고 / 2019, 2022, 2021, 2017 최저

# 일조량
# 경상
select c.year, w.sunshine
from weather as w
	inner join code as c
	on w.code_id=c.code_id 
where c.local='gyeongsang'
order by w.sunshine desc; # 일조량 2017, 2022, 2018 최고 / 2003, 1998, 2007 최저


# 강원
select c.year, w.sunshine
from weather as w
	inner join code as c
	on w.code_id=c.code_id 
where c.local='gangwon'
order by w.sunshine desc;	# 일조량 2019, 2018, 2015, 2022 최고 / 2003, 2007, 2006, 2010 최저


# 일사량
# 경상
select c.year, w.sunenergy
from weather as w
	inner join code as c
	on w.code_id=c.code_id 
where c.local='gyeongsang'
order by w.sunenergy desc; # 일사량 2022, 2020, 2019, 2021 최고 /  1998, 2018, 1996 최저


# 강원
select c.year, w.sunenergy
from weather as w
	inner join code as c
	on w.code_id=c.code_id 
where c.local='gangwon'
order by w.sunenergy desc;	 # 일사량 2018, 2017, 2022 최고 / 1998, 2000, 1999 최저 ( 비교적 최근이 높은 편이긴 함 )



