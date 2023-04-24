create database team4;
use team4;
show tables;
#데이터 타입 변경
alter table code modify code_id smallint;
alter table area_density modify code_id smallint;

#pk설정
alter table area_density add constraint code_pk primary key (code_id);
alter table area_density modify code_id smallint not null;
alter table area_density add constraint area_density primary key (code_id);
alter table area_density add constraint ad_fk 
   foreign key (code_id) references code(code_id);


#----------------------------------------------------------------------
  
 select * from area_density ad 
  
  
select  c.year,ad.forest_area,ad.density
from area_density ad 
	inner join code c
		on ad.code_id = c.code_id ;
  
  
#1995-2010 면적/ 축적 변화 - 경상
select  c.year,ad.forest_area
from area_density ad 
	inner join code c
		on ad.code_id = c.code_id 
where ad.code_id <=6
order by year ;     																					# 95-00경상도 산림면적 지속적 감소

#95,00,05,15,20 확인 
select  c.year,ad.forest_area
from area_density ad 
	inner join code c
		on ad.code_id = c.code_id 
where ad.code_id in (1,6,11,16,21,26)
order by year; 																							 #전체적으로 소폭 감소, 10-15큰폭 증가

#----------------------------------------------------------------------------
#강원도 확인95-00
select  c.year,ad.forest_area
from area_density ad 
	inner join code c
		on ad.code_id = c.code_id 
where ad.code_id between 29 and 34
order by year ;  #95-00전체적으로 감소(폭이 크진 않음)


#강원도 5년단위 확인
select  c.year,ad.forest_area
from area_density ad 
	inner join code c
		on ad.code_id = c.code_id 
where ad.code_id in (29,34,39,44,49,54)
order by year ;   #중간에 무슨 일이 있었는지 모르겠지만 2배로 늘어남! 


#------------------------------------------ 축적확인

#축적확인 																						#꾸준히 지속적 증가추세95-10
select  c.year,ad.density 
from area_density ad 
	inner join code c
		on ad.code_id = c.code_id 
where ad.code_id <=16
order by year ;   

#축적확인 (강원도) : 꾸준히 지속적 증가추세 95-10
select  c.year,ad.density 
from area_density ad 
	inner join code c
		on ad.code_id = c.code_id 
where ad.code_id between 29 and 44 
order by year ;

#---------------------------------------------------------------------------------------기후와비교
#경상도,강원95-10 일조와비교 일조:지표에 닿는
select  c.year, ad.density , floor(w.sunshine) as sunshine
from area_density ad 
	inner join code c
		on ad.code_id = c.code_id 
	inner join weather w 
		on w.code_id =ad.code_id 
where ad.code_id between 29 and 44
order by sunshine ;                                                                               #2000년대 일조량이 비교적 많음 , 강원도 동일

#--------------------------------------------------------------------------------
#경상과기온 95-10
select  c.year, ad.density , floor(w.temperature) as temperature
from area_density ad 
	inner join code c
		on ad.code_id = c.code_id 
	inner join weather w 
		on w.code_id =ad.code_id 
where ad.code_id <=16
order by w.sunenergy ;																							z  #큰변화 없다between 29 and 44 

-- 강원과 기온
select  c.year, ad.density , floor(w.temperature) as temperature
from area_density ad 
	inner join code c
		on ad.code_id = c.code_id 
	inner join weather w 
		on w.code_id =ad.code_id 
where ad.code_id between 29 and 44
order by w.temperature  ;                                                                          # 기온변화와 큰 영향을 알수 없다 

#--------------------------강수


#경상과 강수
select  c.year, ad.density , floor(w.water) as water 
from area_density ad 
	inner join code c
		on ad.code_id = c.code_id 
	inner join weather w 
		on w.code_id =ad.code_id 
where ad.code_id <=16
order by w.water  ;  

-- 강원과 강수
select  c.year, ad.density , floor(w.water) as water 
from area_density ad 
	inner join code c
		on ad.code_id = c.code_id 
	inner join weather w 
		on w.code_id =ad.code_id 
where ad.code_id between 29 and 44
order by w.water  ;                                                    #강수의 경향성 파악 어려움




