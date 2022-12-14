create database ehnaawi;
USE ehnaawi;

GO
CREATE PROCEDURE createAllTables
    AS
    create table systemUser
        (
        username varchar(20) not null primary key,
        systemUserPassword varchar(20) not null
        );

    create table systemAdmin
        (
        ID int not null Identity primary key,
        systemAdminName varchar(20) not null,

        systemAdminUsername varchar(20) not null
        constraint SA_inheretance foreign key(systemAdminUsername) references systemUser(username)
        on delete cascade
        on update cascade,

        --systemAdminpassword varchar(20) not null,
        );

    create table sportsAssociationManager
        (
        ID int not null Identity primary key,
        sportsAssociationManagerName varchar(20) not null,

        sportsAssociationManagerUsername varchar(20) not null
        constraint SAM_inheretance foreign key(sportsAssociationManagerUsername) references systemUser(username)
        on delete cascade
        on update cascade,

        --password varchar(20) not null,
        );

    create table Stadium
        (
        ID int not null Identity primary key,
        stadiumName varchar(20) not null,
        stadiumLocation varchar(20) not null,
        Capacity int not null,
        stadiumStatus bit default 'false'
        );


    create table stadiumManager
        (
        ID int not null identity primary key,
        stadiumManagerName varchar(20) not null,

        stadiumManagerUsername varchar(20) not null
        constraint SM_inheretance foreign key(stadiumManagerUsername) references systemUser(username)
        on delete cascade
        on update cascade,

        --stadiumManagerPassword varchar(20) not null,

        Stadium_ID int not null
        constraint stadium_SM_fk foreign key(Stadium_ID) references Stadium(ID)
        on update cascade
        on delete cascade
        );


    create table Club      
        (
        ID int not null Identity primary key,
        clubName varchar(20) not null,
        clubLocation varchar(20) not null,
        );


    create table clubRepresentative
        (
        ID int not null Identity primary key,
        clubRepresentativeName varchar(20) not null,

        clubRepresentativeUsername varchar(20) not null
        constraint CR_inheretance foreign key (clubRepresentativeUsername) references systemUser(username)
        on delete cascade
        on update cascade,

        --clubRepresentativePassword varchar(20) not null,

        club_ID int not null
        constraint Club_CR_fk foreign key(club_ID) 
        references Club(ID)
        on delete cascade
        on update cascade
        );


    create table Fan
        (
        fanNationalID VARCHAR(20) not null primary key,
        fanName varchar(20) not null,
        fanAddress varchar(20) not null,
        fanPhoneNo varchar(20) not null,
        fanBirthDate date not null,
        fanUsername VARCHAR (20) NOT NULL CONSTRAINT fanInheritence FOREIGN KEY (fanUsername)
        REFERENCES systemUser(username) ON DELETE CASCADE ON UPDATE CASCADE,
        --fanPassword VARCHAR(20) NOT NULL,
        Status bit not null
        );


    create table Match
        (
        ID int not null Identity primary key,
        startTime datetime not null,
        endTime datetime,

        stadium_ID int
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


    create table hostRequest
        (
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


    create table Ticket
        (
        ID int not null Identity primary key,
        ticketStatus bit default 'false',

        Match_ID int not null
        constraint Tickets_Match_fk foreign key(Match_ID)
        references Match(ID)
        on delete cascade
        on update cascade,
        );

    CREATE TABLE ticketBuyingTransaction
        (
        fanNationalID Varchar(20),
        ticketID INT,
        CONSTRAINT buyFanID FOREIGN KEY(fanNationalID) REFERENCES Fan(fanNationalID),
        CONSTRAINT buyTicketID FOREIGN KEY (ticketID) REFERENCES Ticket(ID),
        CONSTRAINT buy_pk PRIMARY KEY(fanNationalID,ticketID)
        );

    go

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
         
EXEC dropAllTables;


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

    ALTER TABLE Fan
    DROP CONSTRAINT fanInheritence
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

    ALTER TABLE Fan ADD
    CONSTRAINT fanInheritence FOREIGN KEY (fanUsername)
    REFERENCES systemUser(username) ON DELETE CASCADE ON UPDATE CASCADE

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

    go

EXEC clearAllTables

GO
CREATE VIEW allAssocManagers 
    AS
    SELECT sportsAssociationManagerUsername 'Username',
    sportsAssociationManagerName 'Name'FROM sportsAssociationManager
    GO


GO
CREATE VIEW allClubRepresentatives
    AS
    SELECT cr.clubRepresentativeUsername 'Username',
    cr.clubRepresentativeName 'Name',Club.clubName as 'Club Represented'
    FROM clubRepresentative cr
    INNER JOIN Club ON cr.club_ID = Club.ID

GO
CREATE VIEW allStadiumManagers
    AS
    SELECT sm.stadiumManagerUsername 'Username',s.[systemUserPassword] 'Password',
    sm.stadiumManagerName 'Name', Stadium.stadiumName as 'Stadium Managed'
    FROM stadiumManager sm
    INNER JOIN Stadium ON sm.Stadium_ID = Stadium.ID
    INNER JOIN systemUser s ON sm.stadiumManagerUsername=s.username

GO
CREATE VIEW allFans
    AS 
    SELECT F.fanUsername 'Username',S.[systemUserPassword] 'Password',
    F.fanName 'Name', F.fanNationalID 'National ID', F.fanBirthDate 'Birth Date', F.Status
    FROM Fan F INNER JOIN systemUser S ON S.username=F.fanUsername

Go
CREATE VIEW allMatches
    AS
    SELECT Club1.clubName as 'First Competing Club' , Club2.clubName as 'Second Competing Club',
    startTime 'Start Time'
    FROM Match
    INNER JOIN Club Club1 ON Club1.ID = Match.Host_ID 
    INNER JOIN Club Club2 ON Club2.ID = Match.guest_ID 
GO

CREATE VIEW allTickets
    AS 
    SELECT [First Competing Club] 'Host Club',
    [Second Competing Club] 'Guest Club', Stadium.stadiumName as 'Stadium Name', [Start Time]
    FROM allMatches, Match
    INNER JOIN Stadium ON Match.stadium_ID = Stadium.ID
GO

CREATE VIEW allCLubs
    AS
    SELECT clubName 'Name', clubLocation 'Location'
    FROM Club
Go

CREATE VIEW allStadiums
    AS
    SELECT stadiumName 'Name', stadiumLocation 'Location', Capacity 'Capacity', stadiumStatus 'Status'
    FROM Stadium
GO

CREATE VIEW allRequests
    AS
    SELECT cR.clubRepresentativeUsername 'Club Representative Username',
    stadiumManager.stadiumManagerUsername as 'Stadium Manager Username' , Status
    FROM hostRequest
    INNER JOIN stadiumManager ON stadiumManager.ID = hostRequest.SM_ID
    INNER JOIN clubRepresentative cR ON cR.ID = hostRequest.CR_ID
GO

--END of 2.2

create procedure addAssociationManager 
    @name varchar(20), @username varchar(20), @password varchar(20)
    as
    INSERT INTO systemUser VALUES(@username,@password)
    insert into sportsAssociationManager(sportsAssociationManagerName,sportsAssociationManagerUsername)
    values (@name, @username);

    go

create procedure addNewMatch
@club1 varchar(20), @club2 varchar(20),@time datetime, @endtime DATETIME 
as
declare @hostID int;
declare @guestID int;

select @hostID = c.ID
from Club c
where (c.clubName = @club1);

select @guestID = c2.ID
from Club c2
where (c2.clubName = @club2);

insert into Match(startTime, endTime, Host_ID, guest_ID)
values(@time, @endtime, @hostID, @guestID);


--exec addNewMatch 'Madrid', 'Barcelona', 'Madrid', '2002-11-25 06:00'


--insert into Match (guest_ID, Host_ID, startTime) values (1,2,'2020-12-13 06:00');
--insert into Club values ('Madrid', 'Spain');
--insert into Club values ('Barcelona', 'Spain');
--select * from Match;

go
CREATE VIEW clubsWithNoMatches as
    select c.clubName
    from Club c left outer join Match m on m.Host_ID = c.ID
    where m.Host_ID is null and EXISTS ( SELECT c1.clubName
    from Club c1 left outer join Match m1 on m1.guest_ID = c1.ID
    where m1.guest_ID is null)
    go

CREATE PROCEDURE deleteMatch 
    @club1 varchar(20), @club2 varchar(20)
    as
    declare @hostID int;
    declare @guestID int;

    select @hostID = c.ID
    from Match m inner join Club c on c.ID = m.Host_ID
    where (c.clubName = @club1 );

    select @guestID = c.ID
    from Match m inner join Club c on c.ID = m.guest_ID
    where (c.clubName = @club2);

    delete from Match 
    where Match.Host_ID = @hostID and Match.guest_ID = @guestID;

    go

CREATE PROCEDURE deleteMatchesOnStadium 
    @name varchar(20)
    as

    declare @sID int;

    select @sID = s.ID
    from Stadium s
    where s.stadiumName = @name;


    --declare @currDate datetime;
    --SELECT @currDate = DATEADD(dd, 0, DATEDIFF(dd, 0, GETDATE()));


    delete 
    from Match 
    where Match.stadium_ID = @sID and Match.startTime >= CURRENT_TIMESTAMP;

    go

CREATE PROCEDURE addClub
    @name varchar(20), @location varchar(20)
    as

    insert into Club values(@name, @location);
    go

CREATE PROCEDURE addTicket
    @host varchar(20), @guest varchar(20), @time datetime
    as
    declare @hostID int, @guestID int, @matchID int;

    select @hostID = c.ID
    from Club c
    where c.clubName = @host;

    select @guestID = c1.ID
    from Club c1
    where c1.clubName = @guest;

    select @matchID = m.ID
    from Match m
    where m.Host_ID = @hostID and m.guest_ID = @guestID and m.startTime = @time;

    insert into Ticket(Match_ID) values(@matchID);
    go

CREATE PROCEDURE deleteClub
     @name varchar(20)
    as
    delete from Club where @name = Club.clubName;
    go

CREATE PROCEDURE addStadium
    @name varchar(20), @location varchar(20), @capacity int
    as
    insert into Stadium(stadiumName, stadiumLocation, Capacity)
    values(@name, @location, @capacity);
    go

create procedure deleteStadium 
    @name varchar(20)
    as
    delete from Stadium where Stadium.stadiumName = @name;
    go

CREATE PROCEDURE blockFan 
    @nationalID VARCHAR(20)
    AS
    UPDATE Fan SET Status ='0' WHERE fanNationalID= @nationalID;
    GO
CREATE PROCEDURE unblockFan 
    @nationalID VARCHAR(20)
    AS
    UPDATE Fan SET Status ='1' WHERE fanNationalID= @nationalID;    
    GO

CREATE PROCEDURE addRepresentative 
    @name varchar(20), @club_name varchar(20), @username varchar(20), @password varchar(20)
    as
    declare @club_ID int
    set @club_ID = (SELECT ID from Club where @club_name = Club.clubName)
    INSERT INTO systemUser VALUES(@username,@password)
    insert into clubRepresentative(clubRepresentativeName,club_ID,clubRepresentativeUsername) 
    values(@name, @club_ID,@username)
    go
CREATE FUNCTION viewAvailableStadiumsOn
    (@rtime DATETIME)
    RETURNS @S TABLE (sname VARCHAR(20) , sloc VARCHAR(20), cap INT)
    AS BEGIN
    INSERT INTO @S
    SELECT stadiumName, stadiumLocation, Capacity 
    FROM Stadium LEFT OUTER JOIN [Match] ON [Match].stadium_ID=Stadium.ID
    WHERE Stadium.[stadiumStatus]='1' AND [Match].ID NOT IN (SELECT ID FROM [Match] WHERE startTime=@rtime)
    RETURN;
    END
    GO
CREATE PROCEDURE addHostRequest 
    @cName VARCHAR(20), @Sname VARCHAR(20), @sTime DATETIME
    AS
    DECLARE @cr INT, @sm INT
    SELECT @cr=clubRepresentative.ID
    FROM clubRepresentative INNER JOIN Club ON clubRepresentative.club_ID=Club.ID 
    INNER JOIN [Match] ON [Match].Host_ID=Club.ID
    WHERE clubName=@cName AND startTime=@sTime

    SELECT @sm=stadiumManager.ID
    FROM stadiumManager INNER JOIN Stadium ON stadiumManager.Stadium_ID = Stadium.ID 
    WHERE stadiumName=@Sname

    INSERT INTO hostRequest(CR_ID, SM_ID) VALUES (@cr, @sm)
    GO
CREATE FUNCTION allUnassignedMatches
    (@cName VARCHAR(20))
    RETURNS @M TABLE(guestClubName VARCHAR(20), startTime DATETIME)
    AS BEGIN
    INSERT INTO @M
    SELECT C2.clubName, startTime
    FROM Club C1 INNER JOIN [Match] ON C1.ID=[Match].Host_ID
    INNER JOIN Club C2 ON C2.ID=[Match].guest_ID
    WHERE C1.clubName= @cName AND stadium_ID IS NULL
    RETURN;
    END
    GO

create procedure dropAllProceduresFunctionsViews
    As
    drop procedure createAllTables;
    drop procedure dropAllTables;
    drop procedure clearAllTables;
    drop procedure addAssociationManager;
    drop procedure addNewMatch;
    drop procedure deleteMatch;
    drop procedure deleteMatchesOnStadium;
    drop procedure addClub;
    drop procedure addTicket;
    drop procedure deleteClub;
    drop procedure addStadium;
    drop procedure deleteStadium;
    DROP PROCEDURE blockFan;
    DROP PROCEDURE unblockFan;
    DROP PROCEDURE addRepresentative;
    DROP PROCEDURE addHostRequest;

    drop view allAssocManagers;
    drop view allClubRepresentatives;
    drop view allCLubs;
    drop view allFans;
    drop view allMatches;
    drop view allRequests;
    drop view allStadiumManagers;
    drop view allStadiums;
    drop view allTickets;
    drop view clubsWithNoMatches;

    DROP FUNCTION viewAvailableStadiumsOn;
    DROP FUNCTION allUnassignedMatches;

    GO


-- Drop the database 'DatabaseName'
-- Connect to the 'master' database to run this snippet
USE master
GO
-- Uncomment the ALTER DATABASE statement below to set the database to SINGLE_USER mode if the drop database command fails because the database is in use.
ALTER DATABASE ehnaawi SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
-- Drop the database if it exists
DROP DATABASE ehnaawi
GO 

create procedure addStadiumManager @name varchar(20), @stadium_name varchar(20), @username varchar(20), @password varchar(20)
as declare @stadium_ID int
    set @stadium_ID = (SELECT ID from Stadium where @stadium_name = Stadium.Name)
    INSERT INTO systemUser VALUES(@username,@password)
    insert into StadiumManager(stadiumManagerName,Stadium_ID,stadiumManagerUsername) 
    values(@name, @stadium_ID,@username)
    go



create function allPendingRequests (@username varchar(20))
returns @R table (rname varchar(20), gcname varchar(20), starttime datetime)
as begin
insert into @R
select clubRepresentativeName, Club.clubName, Match.startTime
from hostRequest hr inner join clubRepresentative cr on hr.CR_ID = cr.id inner join stadiumManager sm on hr.SM_ID = sm.ID
inner join Match on hr.Match_ID = Match.ID inner join Club on Match.guest_id = Club.ID 
where StadiumManagerUsername = @username AND Status = 'unhandled'
RETURN
END
GO

create procedure acceptRequest @username varchar(20), @hostclubname varchar(20), @guestclubname varchar(20), @starttime datetime
as update hostRequest set Status = 'accepted' where Status in (select Status from hostRequest hr inner join Match on hr.Match_ID = Match.ID 
inner Join Club c1 on c1.ID = Match.host_ID inner join Club c2 on c2.ID = Match.guest_ID inner join stadiumManager sm on hr.SM_ID = sm.ID
where @username = sm.stadiumManagerUsername AND @hostclubname = c1.clubName AND @guestclubname = c2.clubName AND @starttime = Match.startTime)
go

create procedure rejectRequest @username varchar(20), @hostclubname varchar(20), @guestclubname varchar(20), @starttime datetime
as update hostRequest set Status = 'rejected' where Status in (select Status from hostRequest hr inner join Match on hr.Match_ID = Match.ID 
inner Join Club c1 on c1.ID = Match.host_ID inner join Club c2 on c2.ID = Match.guest_ID inner join stadiumManager sm on hr.SM_ID = sm.ID
where @username = sm.stadiumManagerUsername AND @hostclubname = c1.clubName AND @guestclubname = c2.clubName AND @starttime = Match.startTime)
go

create procedure addFan @name varchar(20), @username varchar(20), 
@password varchar(20), @nationalid varchar(20), @birthdate varchar(20), @address varchar(20), @phonenum int
as insert into systemUser values(@username, @password)
insert into Fan(fanName, fanUsername, fanNationalID, fanBirthDate, fanAddress, fanPhoneNo)
values(@name, @username, @nationalid, @birthdate, @address, @phonenum)
go

create function upcomingMatchesOfClub (@clubname varchar(20))
returns @M table( c1name varchar(20), c2name varchar(20), starttime datetime, stadiumname varchar(20))
as begin
insert into @M
select c1.clubName,c2.clubName, Match.startTime, Stadium.stadiumName
from Match inner join Club c1 on c1.ID = Match.host_ID inner join Club c2 on c2.ID = Match.guest_ID
inner join Stadium on Stadium.ID = Match.stadium_ID where Match.startTime> CURRENT_TIMESTAMP AND (@clubname = c1.clubName or @clubname = c2.clubName)
return
end 
go


create function availableMatchesToAttend
    (@starttime datetime)
    returns @T table(c1name varchar(20), c2name varchar(20), starttime datetime, stadiumname varchar(20))
    as begin
    insert into @T
    select c1.clubName, c2.clubName, m.startTime, Stadium.stadiumName from Match m inner join Club c1 on c1.ID = m.host_ID 
    inner join Club c2 on c2.ID = m.guest_ID
    inner join Stadium on Stadium.ID = m.stadium_ID inner join Ticket on m.ID = Ticket.Match_ID where m.startTime> @starttime 
    AND Ticket.ID = any(select ID from Ticket where Match_ID = m.ID AND ticketStatus = '1')
    return
    end 
    go

create procedure purchaseTicket 
    @nationalid varchar(20), @hostname varchar(20), @guestname varchar(20), @starttime datetime
    as
    DECLARE @tID INT
    insert into ticketBuyingTransaction 
    values(
    (select top 1 t.ID from Ticket t inner join Match m on t.Match_ID = m.ID inner join Club c1 on c1.ID = m.host_ID 
    inner join Club c2 on c2.ID = m.guest_ID where m.startTime = @starttime 
    AND c1.clubName= @hostname AND c2.clubName = @guestname AND t.ticketStatus = '1'),
    (SELECT fanNationalID as nID FROM Fan WHERE fanNationalID=@nationalid AND Status='1'))
    SET @tID=(select top 1 t.ID from Ticket t inner join Match m on t.Match_ID = m.ID inner join Club c1 on c1.ID = m.host_ID 
    inner join Club c2 on c2.ID = m.guest_ID where m.startTime = @starttime 
    AND c1.clubName= @hostname AND c2.clubName = @guestname AND t.ticketStatus = '1')
    UPDATE Ticket SET ticketStatus='0' WHERE Ticket.ID=@tID
    GO
CREATE PROCEDURE updateMatchHost 
    @hName VARCHAR(20), @gName VARCHAR(20), @sTime DATETIME
    AS









