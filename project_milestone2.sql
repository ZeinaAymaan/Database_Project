create database ehna;

create table S_User(
username varchar(20) not null primary key,
password varchar(20) not null
);

create table System_Admin(
ID int not null Identity primary key,
name varchar(20) not null,
username varchar(20) not null,
password varchar(20) not null,
constraint SA_inheretance foreign key(username) references S_User(username)
);

create table Sports_Assocciation_Manager(
ID int not null Identity primary key,
name varchar(20) not null,
username varchar(20) not null,
password varchar(20) not null,
constraint SAM_inheretance foreign key(username) references S_User(username)
);




