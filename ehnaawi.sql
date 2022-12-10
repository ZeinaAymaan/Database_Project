create database ehnaawi;
USE ehnaawi;

GO
CREATE PROCEDURE createAllTables
AS
create table systemUser(
username varchar(20) not null primary key,
password varchar(20) not null
);

create table systemAdmin(
ID int not null Identity primary key,
Name varchar(20) not null,

username varchar(20) not null
constraint SA_inheretance foreign key(username) references systemUser(username)
on delete cascade
on update cascade,

password varchar(20) not null,
);

create table sportsAssociationManager(
ID int not null Identity primary key,
Name varchar(20) not null,

username varchar(20) not null
constraint SAM_inheretance foreign key(username) references systemUser(username)
on delete cascade
on update cascade,

password varchar(20) not null,
);

create table Stadium(
ID int not null Identity primary key,
Name varchar(20) not null,
Location varchar(20) not null,
Capacity int not null,
Status bit not null
);


create table stadiumManager(
ID int not null identity primary key,
Name varchar(20) not null,

username varchar(20) not null
constraint SM_inheretance foreign key(username) references systemUser(username)
on delete cascade
on update cascade,

password varchar(20) not null,

Stadium_ID int not null
constraint stadium_SM_fk foreign key(Stadium_ID) references Stadium(ID)
on update cascade
on delete cascade
);


create table Club(
ID int not null Identity primary key,
Name varchar(20) not null,
Location varchar(20) not null,
);


create table clubRepresentative(
ID int not null Identity primary key,
Name varchar(20) not null,

Username varchar(20) not null
constraint CR_inheretance foreign key (Username) references systemUser(username)
on delete cascade
on update cascade,

Password varchar(20) not null,

club_ID int not null
constraint Club_CR_fk foreign key(club_ID) 
references Club(ID)
on delete cascade
on update cascade
);


create table Fan(
national_ID int not null primary key,
Name varchar(20) not null,
Address varchar(20) not null,
phone_no varchar(20) not null,
birth_date date not null,
Status bit not null
);


create table Match(
ID int not null Identity primary key,
startTime time not null,
endTime time not null,

stadium_ID int not null
constraint Match_Stadium_fk foreign key(stadium_ID)references Stadium(ID)
on delete cascade
on update cascade,

guest_ID int 
constraint Club_Guest_fk foreign key(guest_ID)
references Club(ID)
on delete no action
on update no action,

Host_ID int 
constraint Club_Host_fk foreign key(Host_ID)
references Club(ID)
on delete no action
on update no action,

check(Guest_ID <> Host_ID)

);


create table hostRequest(
ID int IDENTITY,
CR_ID int not null,
SM_ID int not null,

constraint Request_pk primary key(ID),

constraint Request_CR_fk foreign key(CR_ID)
references clubRepresentative(ID)
on delete cascade
on update cascade,

constraint Request_SM_fk foreign key(SM_ID)
references stadiumManager(ID)
on delete no action
on update no action,

Match_ID int not null
constraint Request_Match_fk foreign key(Match_ID)
references Match(ID)
on delete cascade
on update cascade,

Status varchar(20) not null default 'unhandled'
);


create table Ticket(
ID int not null Identity primary key,
Status bit not null,

Match_ID int not null
constraint Tickets_Match_fk foreign key(Match_ID)
references Match(ID)
on delete cascade
on update cascade,
);

CREATE TABLE ticketBuyingTransaction(
fanNationalID INT,
ticketID INT,
CONSTRAINT buyFanID FOREIGN KEY(fanNationalID) REFERENCES Fan(national_ID),
CONSTRAINT buyTicketID FOREIGN KEY (ticketID) REFERENCES Ticket(ID),
CONSTRAINT buy_pk PRIMARY KEY(fanNationalID,ticketID)
);

EXEC createAllTables

GO
CREATE PROCEDURE dropAllTables
AS
         DROP TABLE ticketBuyingTransaction;
         DROP TABLE Ticket;
         DROP TABLE hostRequest;
         DROP TABLE Match;       
         DROP TABLE Fan;
         DROP TABLE clubRepresentative;
         DROP TABLE Club;
         DROP TABLE stadiumManager;
         DROP TABLE Stadium;
         DROP TABLE sportsAssociationManager;         
         DROP TABLE systemAdmin;
         DROP TABLE systemUser;
         
EXEC dropAllTables

GO
CREATE PROCEDURE clearAllTables
AS
--lazem nsheel kol el foreign key constraints abl ma n-truncate el table
ALTER TABLE ticketBuyingTransaction
DROP CONSTRAINT buyFanID,buyTicketID 
TRUNCATE TABLE ticketBuyingTransaction

ALTER TABLE Ticket
DROP CONSTRAINT Tickets_Match_fk
TRUNCATE TABLE Ticket

ALTER TABLE hostRequest
DROP CONSTRAINT Request_CR_fk, Request_SM_fk, Request_Match_fk
TRUNCATE TABLE hostRequest

ALTER TABLE Match
DROP CONSTRAINT Match_Stadium_fk,Club_Guest_fk,Club_Host_fk
TRUNCATE TABLE Match

TRUNCATE TABLE Fan

ALTER TABLE clubRepresentative
DROP CONSTRAINT CR_inheretance,Club_CR_fk
TRUNCATE TABLE clubRepresentative

TRUNCATE TABLE Club

ALTER TABLE stadiumManager
DROP CONSTRAINT SM_inheretance, stadium_SM_fk
TRUNCATE TABLE stadiumManager

TRUNCATE TABLE Stadium

ALTER TABLE sportsAssociationManager
DROP CONSTRAINT SAM_inheretance
TRUNCATE TABLE sportsAssociationManager

ALTER TABLE systemAdmin
DROP CONSTRAINT SA_inheretance
TRUNCATE TABLE systemAdmin

TRUNCATE TABLE systemUser
--hena baraga3 el constraints 3shan manbawazsh el donya
ALTER TABLE ticketBuyingTransaction ADD
CONSTRAINT buyFanID FOREIGN KEY(fanNationalID) REFERENCES Fan(national_ID),
CONSTRAINT buyTicketID FOREIGN KEY (ticketID) REFERENCES Ticket(ID)

ALTER TABLE Ticket ADD
CONSTRAINT Tickets_Match_fk foreign key(Match_ID) references Match(ID)
on delete cascade
on update cascade

ALTER TABLE hostRequest ADD
CONSTRAINT Request_CR_fk foreign key(CR_ID) references clubRepresentative(ID)
on delete cascade
on update cascade,
constraint Request_SM_fk foreign key(SM_ID)references stadiumManager(ID)
on delete no action
on update no action,
constraint Request_Match_fk foreign key(Match_ID) references Match(ID)
on delete cascade
on update cascade
 
ALTER TABLE Match ADD
CONSTRAINT  Match_Stadium_fk foreign key(stadium_ID) references Stadium(ID)
on delete cascade
on update cascade,
constraint Club_Guest_fk foreign key(guest_ID) references Club(ID)
on delete no action
on update no action,
constraint Club_Host_fk foreign key(Host_ID) references Club(ID)
on delete no action
on update no action

ALTER TABLE clubRepresentative ADD 
CONSTRAINT CR_inheretance foreign key (Username) references systemUser(username)
on delete cascade
on update cascade,
constraint Club_CR_fk foreign key(club_ID) references Club(ID)
on delete cascade
on update cascade

ALTER TABLE stadiumManager ADD
constraint SM_inheretance foreign key(username) references systemUser(username)
on delete cascade
on update cascade,
constraint stadium_SM_fk foreign key(Stadium_ID) references Stadium(ID)
on update cascade
on delete cascade

ALTER TABLE sportsAssociationManager ADD
constraint SAM_inheretance foreign key(username) references systemUser(username)
on delete cascade
on update cascade

ALTER TABLE systemAdmin ADD
constraint SA_inheretance foreign key(username) references systemUser(username)
on delete cascade
on update cascade

EXEC clearAllTables

GO
CREATE VIEW allAssocManagers AS
SELECT username,Name FROM sportsAssociationManager

SELECT* FROM allAssocManagers