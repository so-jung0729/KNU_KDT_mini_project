use team4;

select *
from code;

/* 데이터 타입 변경 */
alter table code modify code_id smallint;
/* pk 설정 */
alter table code add constraint code_pk primary key (code_id);

/* fire table */
alter table fire modify code_id smallint not null;

alter table fire add constraint fire_fk 
	foreign key (code_id) references code(code_id);

alter table fire add constraint fire_pk primary key (code_id);
										
/* 기후 데이터 타입 변경, pk 설정 fk 설정 */
alter table weather modify code_id smallint not null;
alter table weather add constraint weather_fk 
   foreign key (code_id) references code(code_id);
alter table weather add constraint weather_pk primary key (code_id);

/* 산림 데이터 변경 */
alter table area_density modify code_id smallint not null;
alter table area_density add constraint area_density primary key (code_id);
alter table area_density add constraint ad_fk 
   foreign key (code_id) references code(code_id);

/* forestry 데이터 변경 */
alter table forestry modify code_id smallint not null;
alter table forestry add constraint forestry_fk 
   foreign key (code_id) references code(code_id);
alter table forestry add constraint forestry_pk primary key (code_id);

 