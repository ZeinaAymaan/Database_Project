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
on delete cascade
on update cascade
);

create table Sports_Assocciation_Manager(
ID int not null Identity primary key,
name varchar(20) not null,
username varchar(20) not null,
password varchar(20) not null,
constraint SAM_inheretance foreign key(username) references S_User(username)
on delete cascade
on update cascade
);

create table Stadium_Manager(
ID int not null identity primary key,
name varchar(20) not null,
username varchar(20) not null,
password varchar(20) not null,
constraint SM_inheretance foreign key(username) references S_User(username)
on delete cascade
on update cascade
);

create table Stadium(
ID int not null Identity primary key,
Name varchar(20) not null,
Capacity int not null,
Location varchar(20) not null,
Status varchar(20) not null
);







