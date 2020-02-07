create table hibernate_sequence (next_val bigint) engine=MyISAM default charset=UTF8;
insert into hibernate_sequence values ( 1 );
create table user_role (user_id bigint not null, roles varchar(255)) engine=MyISAM default charset=UTF8;
create table users (id bigint not null, active bit not null, email varchar(255), password varchar(255), username varchar(255), first_name varchar(255), last_name varchar(255), primary key (id)) engine=MyISAM default charset=UTF8;
create table catalog (id bigint not null, active bit not null, description varchar(2048), img varchar(255), name varchar(255), primary key (id)) engine=MyISAM default charset=UTF8;
create table singer (id bigint not null, active bit not null, first_name varchar(255), last_name varchar(255), avatar varchar(255) not null default 'default.svg', primary key (id)) engine=MyISAM default charset=UTF8;
create table video (id bigint not null, active bit not null, name varchar(255), image varchar(255), video varchar(255), watched_counter integer not null default 0, added_date_time datetime, singer_id bigint, primary key (id)) engine=MyISAM default charset=UTF8;
alter table user_role add constraint FK_user_role_user foreign key (user_id) references users (id);
alter table video add constraint FK_video_singer foreign key (singer_id) references singer (id);