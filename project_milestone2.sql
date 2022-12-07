create database ehna;


create table S_User(
username varchar(20) not null primary key,
password varchar(20) not null
);


create table System_Admin(
ID int not null Identity primary key,
Name varchar(20) not null,

username varchar(20) not null
constraint SA_inheretance foreign key(username) references S_User(username)
on delete cascade
on update cascade,

password varchar(20) not null,
);


create table Sports_Assocciation_Manager(
ID int not null Identity primary key,
Name varchar(20) not null,

username varchar(20) not null
constraint SAM_inheretance foreign key(username) references S_User(username)
on delete cascade
on update cascade,

password varchar(20) not null,
);


create table Stadium(
ID int not null Identity primary key,
Name varchar(20) not null,
Capacity int not null,
Location varchar(20) not null,
Status bit not null
);


create table Stadium_Manager(
ID int not null identity primary key,
Name varchar(20) not null,

username varchar(20) not null
constraint SM_inheretance foreign key(username) references S_User(username)
on delete cascade
on update cascade,

password varchar(20) not null,

Stadium_ID int not null
constraint stadium_SM_fk foreign key(Stadium_ID)
references Stadium(ID)
on update cascade
on delete cascade
);


create table Club(
ID int not null Identity primary key,
Name varchar(20) not null,
Location varchar(20) not null,
);


create table Club_Representative(
ID int not null Identity primary key,
Name varchar(20) not null,

Username varchar(20) not null
constraint CR_inheretance foreign key (Username)
references S_User(username)
on delete cascade
on update cascade,

Password varchar(20) not null,

Club_ID int not null
constraint Club_CR_fk foreign key(Club_ID) 
references Club(ID)
on delete cascade
on update cascade
);


create table Fan(
Nationa_ID int not null primary key,
Name varchar(20) not null,
Address varchar(20) not null,
Phone_No varchar(20) not null,
Birth_Date date not null,
Status bit not null
);


create table Match(
ID int not null Identity primary key,
Start_Time time not null,
End_Time time not null,

Stadium_ID int not null
constraint Match_Stadium_fk foreign key(Stadium_ID)
references Stadium(ID)
on delete cascade
on update cascade,

Guest_ID int 
constraint Club_Guest_fk foreign key(Guest_ID)
references Club(ID)
on delete no action
on update no action,

Host_ID int 
constraint Club_Host_fk foreign key(Host_ID)
references Club(ID)
on delete no action
on update no action
);

alter table Match
add check(Guest_ID <> Host_ID);


create table Request(
CR_ID int not null,
SM_ID int not null,

constraint Request_pk primary key(CR_ID, SM_ID),

constraint Request_CR_fk foreign key(CR_ID)
references Club_Representative(ID)
on delete cascade
on update cascade,

constraint Request_SM_fk foreign key(SM_ID)
references Stadium_Manager(ID)
on delete no action
on update no action,

Match_ID int not null
constraint Request_Match_fk foreign key(Match_ID)
references Match(ID)
on delete cascade
on update cascade,

Status varchar(20) not null default 'unhandled'
);


create table Tickets(
ID int not null Identity primary key,
Status bit not null,

Match_ID int not null
constraint Tickets_Match_fk foreign key(Match_ID)
references Match(ID)
on delete cascade
on update cascade,

Fan_ID int
constraint Tickets_Fan_fk foreign key(Fan_ID)
references Fan(Nationa_ID)
on delete set null
on update cascade
);



--select * from Stadium_Manager;


SELECT *
FROM sys.objects
WHERE type_desc = 'USER_TABLE'