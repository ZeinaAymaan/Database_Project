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
        constraint SA_inheretance foreign key(systemAdminUsername)
        references systemUser(username)
        on delete cascade
        on update cascade,

        );

    create table sportsAssociationManager
        (
        ID int not null Identity primary key,
        sportsAssociationManagerName varchar(20) not null,

        sportsAssociationManagerUsername varchar(20) not null
        constraint SAM_inheretance foreign key(sportsAssociationManagerUsername)
        references systemUser(username)
        on delete cascade
        on update cascade,

        );

    create table Stadium
        (
        ID int not null Identity primary key,
        stadiumName varchar(20) not null,
        stadiumLocation varchar(20) not null,
        Capacity int not null,
        stadiumStatus bit default 'true'
        );


    create table stadiumManager
        (
        ID int not null identity primary key,
        stadiumManagerName varchar(20) not null,

        stadiumManagerUsername varchar(20) not null
        constraint SM_inheretance foreign key(stadiumManagerUsername)
        references systemUser(username)
        on delete cascade
        on update cascade,

        Stadium_ID int not null
        constraint stadium_SM_fk foreign key(Stadium_ID)
        references Stadium(ID)
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
        Name varchar(20) not null,

        Username varchar(20) not null
        constraint CR_inheretance foreign key (Username)
        references systemUser(username)
        on delete cascade
        on update cascade,

        club_ID int not null
        constraint Club_CR_fk foreign key(club_ID) 
        references Club(ID)
        on delete cascade
        on update cascade
        );


    create table Fan
        (
        NationaID VARCHAR(20) not null primary key,
        Name varchar(20) not null,
        Address varchar(20) not null,
        PhoneNumber INT not null,
        BirthDate DATETIME not null,

        username varchar(20) not null
        constraint fan_inheretance_fk foreign key(username)
        references systemUser(username)
        on update cascade
        on delete cascade,

        Status bit not null default 'true'
        );


    create table Match
        (
        ID int not null Identity primary key,
        startTime datetime not null,
        endTime datetime,

        stadium_ID int
        constraint Match_Stadium_fk foreign key(stadium_ID)
        references Stadium(ID)
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
        ID int IDENTITY primary key,
        CR_ID int not null,
        SM_ID int not null,

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
        ticketStatus bit default 'true',

        Match_ID int not null
        constraint Tickets_Match_fk foreign key(Match_ID)
        references Match(ID)
        on delete cascade
        on update cascade,
        );


    CREATE TABLE ticketBuyingTransaction
        (
        NationaID Varchar(20),
        ticketID INT,

        CONSTRAINT buyFanID_fk FOREIGN KEY(NationaID)
        REFERENCES Fan(NationaID)
        on update cascade
        on delete cascade,

        CONSTRAINT buyTicketID_fk FOREIGN KEY (ticketID)
        REFERENCES Ticket(ID)
        on update cascade
        on delete cascade,

        CONSTRAINT buy_pk PRIMARY KEY(NationaID,ticketID)
        );

GO

CREATE PROCEDURE dropAllTables
    AS 

    alter table ticketBuyingTransaction
    drop constraint buy_pk,buyFanID_fk,buyTicketID_fk
    DROP TABLE ticketBuyingTransaction;

    alter table ticket
    drop constraint Tickets_Match_fk;
    DROP TABLE Ticket;

    alter table hostRequest
    drop constraint Request_CR_fk,Request_SM_fk,Request_Match_fk
   
    DROP TABLE hostRequest;

    alter table Match
    drop constraint Match_Stadium_fk;
    alter table Match
    drop constraint Club_Guest_fk;
    alter table Match
    drop constraint Club_Host_fk;
    DROP TABLE Match; 

    alter table fan
    drop constraint fan_inheretance_fk;
    DROP TABLE Fan;

    alter table clubRepresentative
    drop constraint CR_inheretance;
    alter table clubRepresentative
    drop constraint Club_CR_fk;
    DROP TABLE clubRepresentative;

    DROP TABLE Club;

    alter table stadiumManager
    drop constraint SM_inheretance;
    alter table stadiumManager
    drop constraint stadium_SM_fk;
    DROP TABLE stadiumManager;

    DROP TABLE Stadium;

    alter table sportsAssociationManager
    drop constraint SAM_inheretance;
    DROP TABLE sportsAssociationManager; 
    
    alter table systemAdmin
    drop constraint SA_inheretance;
    DROP TABLE systemAdmin;

    DROP TABLE systemUser;

GO

CREATE PROCEDURE clearAllTables
    AS

    ALTER TABLE ticketBuyingTransaction
    DROP CONSTRAINT buyFanID_fk;
    alter table ticketBuyingTransaction
    drop constraint buyTicketID_fk;
    TRUNCATE TABLE ticketBuyingTransaction;

    ALTER TABLE Ticket
    DROP CONSTRAINT Tickets_Match_fk;
    TRUNCATE TABLE Ticket;

    alter table hostRequest
    drop constraint Request_CR_fk;
    alter table hostRequest
    drop constraint Request_SM_fk;
    alter table hostRequest
    drop constraint Request_Match_fk;
    TRUNCATE TABLE hostRequest;

    alter table Match
    drop constraint Match_Stadium_fk;
    alter table Match
    drop constraint Club_Guest_fk;
    alter table Match
    drop constraint Club_Host_fk;
    TRUNCATE TABLE Match;

    alter table fan
    drop constraint fan_inheretance_fk;
    TRUNCATE TABLE Fan;

    alter table clubRepresentative
    drop constraint CR_inheretance;
    alter table clubRepresentative
    drop constraint Club_CR_fk;
    TRUNCATE TABLE clubRepresentative;

    TRUNCATE TABLE Club;

    alter table stadiumManager
    drop constraint SM_inheretance;
    alter table stadiumManager
    drop constraint stadium_SM_fk;
    TRUNCATE TABLE stadiumManager;

    TRUNCATE TABLE Stadium;

    alter table sportsAssociationManager
    drop constraint SAM_inheretance;
    TRUNCATE TABLE sportsAssociationManager;

    alter table systemAdmin
    drop constraint SA_inheretance;
    TRUNCATE TABLE systemAdmin;

    TRUNCATE TABLE systemUser;


    ALTER TABLE ticketBuyingTransaction ADD
    CONSTRAINT buyFanID_fk FOREIGN KEY(NationaID)
    REFERENCES Fan(NationaID)
    on update cascade
    on delete cascade,
    CONSTRAINT buyTicketID_fk FOREIGN KEY (ticketID)
    REFERENCES Ticket(ID)
    on update cascade
    on delete cascade;

    ALTER TABLE Ticket ADD
    CONSTRAINT Tickets_Match_fk foreign key(Match_ID)
    references Match(ID)
    on delete cascade
    on update cascade

    ALTER TABLE hostRequest ADD
    CONSTRAINT Request_CR_fk foreign key(CR_ID)
    references clubRepresentative(ID)
    on delete cascade
    on update cascade,
    constraint Request_SM_fk foreign key(SM_ID)
    references stadiumManager(ID)
    on delete no action
    on update no action,
    constraint Request_Match_fk foreign key(Match_ID)
    references Match(ID)
    on delete cascade
    on update cascade
 
    ALTER TABLE Match ADD
    CONSTRAINT  Match_Stadium_fk foreign key(stadium_ID)
    references Stadium(ID)
    on delete cascade
    on update cascade,
    constraint Club_Guest_fk foreign key(guest_ID)
    references Club(ID)
    on delete no action
    on update no action,
    constraint Club_Host_fk foreign key(Host_ID)
    references Club(ID)
    on delete no action
    on update no action

    ALTER TABLE Fan ADD
    CONSTRAINT fan_inheritence_fk FOREIGN KEY (username)
    REFERENCES systemUser(username)
    ON DELETE CASCADE
    ON UPDATE CASCADE;


    ALTER TABLE clubRepresentative ADD 
    CONSTRAINT CR_inheretance foreign key (username)
    references systemUser(username)
    on delete cascade
    on update cascade,
    constraint Club_CR_fk foreign key(club_ID)
    references Club(ID)
    on delete cascade
    on update cascade;

    ALTER TABLE stadiumManager ADD
    constraint SM_inheretance foreign key(stadiumManagerUsername)
    references systemUser(username)
    on delete cascade
    on update cascade,
    constraint stadium_SM_fk foreign key(Stadium_ID)
    references Stadium(ID)
    on update cascade
    on delete cascade;

    ALTER TABLE sportsAssociationManager ADD
    constraint SAM_inheretance foreign key(sportsAssociationManagerUsername)
    references systemUser(username)
    on delete cascade
    on update cascade;

    ALTER TABLE systemAdmin ADD
    constraint SA_inheretance foreign key(systemAdminUsername)
    references systemUser(username)
    on delete cascade
    on update cascade;

GO

CREATE VIEW allAssocManagers 
    AS
    SELECT sportsAssociationManagerUsername 'Username', systemUser.systemUserPassword 'Password',
    sportsAssociationManagerName 'Name'
    FROM sportsAssociationManager sa INNER JOIN systemUser ON systemUser.username=sa.sportsAssociationManagerUsername

GO

CREATE VIEW allClubRepresentatives
    AS
    SELECT cr.Username 'Username',  systemUser.systemUserPassword 'Password',
    cr.Name 'Name',Club.clubName as 'Club Represented'
    FROM clubRepresentative cr INNER JOIN systemUser ON cr.Username=systemUser.username
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
    SELECT F.username 'Username',S.[systemUserPassword] 'Password',
    F.Name 'Name', F.NationaID 'National ID', F.BirthDate 'Birth Date', F.Status
    FROM Fan F INNER JOIN systemUser S ON S.username=F.username

GO

CREATE VIEW allMatches
    AS
    SELECT Club1.clubName as 'Host Club' , Club2.clubName as 'Guest Club',
    startTime 'Start Time'
    FROM Match
    INNER JOIN Club Club1 ON Club1.ID = Match.Host_ID 
    INNER JOIN Club Club2 ON Club2.ID = Match.guest_ID 

GO

CREATE VIEW allTickets
    AS 
    SELECT [Host Club] 'Host Club',
    [Guest Club] 'Guest Club', Stadium.stadiumName as 'Stadium Name', [Start Time]
    FROM allMatches, Match
    INNER JOIN Stadium ON Match.stadium_ID = Stadium.ID

GO

CREATE VIEW allCLubs
    AS
    SELECT clubName 'Name', clubLocation 'Location'
    FROM Club

GO

CREATE VIEW allStadiums
    AS
    SELECT stadiumName 'Name', stadiumLocation 'Location', Capacity 'Capacity', stadiumStatus 'Status'
    FROM Stadium

GO

CREATE VIEW allRequests
    AS
    SELECT cR.Username 'Club Representative Username',
    stadiumManager.stadiumManagerUsername as 'Stadium Manager Username' , Status
    FROM hostRequest
    INNER JOIN stadiumManager ON stadiumManager.ID = hostRequest.SM_ID
    INNER JOIN clubRepresentative cR ON cR.ID = hostRequest.CR_ID

GO


create procedure addAssociationManager 
    @name varchar(20), @username varchar(20), @password varchar(20)
    as
    INSERT INTO systemUser VALUES(@username,@password)
    insert into sportsAssociationManager(sportsAssociationManagerName,sportsAssociationManagerUsername)
    values (@name, @username);

GO

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

GO

CREATE VIEW clubsWithNoMatches 
    as
    select c1.clubName 'Club Name'
    from Club c1 inner join Club c2 on c1.ID = c2.ID
    left outer join Match m on m.Host_ID = c1.ID or m.guest_ID = c2.ID
    where m.Host_ID is null;

GO

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

GO

CREATE PROCEDURE deleteMatchesOnStadium 
    @name varchar(20)
    as
    declare @sID int;
    select @sID = s.ID
    from Stadium s
    where s.stadiumName = @name;

    delete 
    from Match 
    where Match.stadium_ID = @sID and Match.startTime >= CURRENT_TIMESTAMP;

GO

CREATE PROCEDURE addClub
    @name varchar(20), @location varchar(20)
    as
    insert into Club values(@name, @location);

GO

CREATE PROCEDURE addTicket
    @host varchar(20), @guest varchar(20), @time datetime
    as
    declare @hostID int, @guestID int, @matchID int, @stadiumID int, @capacity int, @counter int;

    select @hostID = c.ID
    from Club c
    where c.clubName = @host;

    select @guestID = c1.ID
    from Club c1
    where c1.clubName = @guest;

    select @matchID = m.ID
    from Match m
    where m.Host_ID = @hostID and m.guest_ID = @guestID and m.startTime = @time;

    select @stadiumID = s.ID
    from Stadium s inner join Match m on m.stadium_ID = s.ID
    where m.ID = @matchID;

    select @capacity = s.Capacity
    from Stadium s
    where s.ID = @stadiumID;

    set @counter = 0;
    while (@counter < @capacity)
        begin
        insert into Ticket(Match_ID) values(@matchID);
        set @counter = @counter + 1
        end
    
GO

CREATE PROCEDURE deleteClub
    @name varchar(20)
    as
    delete from Club where @name = Club.clubName;

GO

CREATE PROCEDURE addStadium
    @name varchar(20), @location varchar(20), @capacity int
    as
    insert into Stadium(stadiumName, stadiumLocation, Capacity)
    values(@name, @location, @capacity);

GO

CREATE PROCEDURE deleteStadium 
    @name varchar(20)
    as
    delete from Stadium where Stadium.stadiumName = @name;

GO

CREATE PROCEDURE blockFan 
    @nationalID VARCHAR(20)
    AS
    UPDATE Fan SET Status ='0' WHERE NationaID= @nationalID;

GO

CREATE PROCEDURE unblockFan 
    @nationalID VARCHAR(20)
    AS
    UPDATE Fan SET Status ='1' WHERE NationaID= @nationalID;    

GO

CREATE PROCEDURE addRepresentative 
    @name varchar(20), @club_name varchar(20), @username varchar(20), @password varchar(20)
    as
    declare @club_ID int
    set @club_ID = (SELECT ID from Club where @club_name = Club.clubName)
    INSERT INTO systemUser VALUES(@username,@password)
    insert into clubRepresentative(Name,club_ID,Username) 
    values(@name, @club_ID,@username)

GO

CREATE FUNCTION viewAvailableStadiumsOn
    (@rtime DATETIME)
    RETURNS @S TABLE (stadiumName VARCHAR(20), stadiumLocation VARCHAR(20), Capacity INT)
    AS
    BEGIN
    INSERT INTO @S
    SELECT stadiumName, stadiumLocation, Capacity 
    FROM Stadium
    WHERE ID NOT IN (SELECT stadium_ID FROM Match WHERE startTime=@rtime) OR
     (SELECT stadium_ID FROM Match WHERE startTime=@rtime) IS NULL
    RETURN ;
    END

GO

CREATE PROCEDURE addHostRequest 
    @cName VARCHAR(20), @Sname VARCHAR(20), @sTime DATETIME
    AS
    DECLARE @cr INT, @sm INT, @matchID int;

    SELECT @cr = clubRepresentative.ID
    FROM clubRepresentative INNER JOIN Club ON clubRepresentative.club_ID = Club.ID 
    INNER JOIN [Match] ON [Match].Host_ID = Club.ID
    WHERE club.clubName = @cName AND Match.startTime = @sTime

    SELECT @sm = stadiumManager.ID
    FROM stadiumManager INNER JOIN Stadium ON stadiumManager.Stadium_ID = Stadium.ID 
    WHERE stadium.stadiumName = @Sname

    select @matchID = m.ID
    from Match m inner join Club c on m.Host_ID = c.ID
    where @sTime = m.startTime and m.stadium_ID IS NULL;

    IF(@Sname IN (select stadiumName from dbo.viewAvailableStadiumsOn (@sTime)) 
    AND @matchID NOT IN (SELECT Match_ID FROM hostRequest WHERE Status='unhandled'OR Status= 'accepted'))
    BEGIN
    INSERT INTO hostRequest(CR_ID, SM_ID, Match_ID) VALUES (@cr, @sm, @matchID)
    END
    
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

CREATE PROCEDURE addStadiumManager 
    @name varchar(20), @stadium_name varchar(20), @username varchar(20), @password varchar(20)
    as declare @stadium_ID int
    set @stadium_ID = (SELECT ID from Stadium where @stadium_name = Stadium.stadiumName)
    INSERT INTO systemUser VALUES(@username,@password)
    insert into StadiumManager(stadiumManagerName,Stadium_ID,stadiumManagerUsername) 
    values(@name, @stadium_ID,@username)

GO

CREATE FUNCTION allPendingRequests 
    (@username varchar(20))
    returns @R table (RepresentativeName varchar(20), GuestClubName varchar(20), startTime datetime)
    as begin
    insert into @R
    select Name, Club.clubName, Match.startTime
    from hostRequest hr inner join clubRepresentative cr on hr.CR_ID = cr.id
    inner join stadiumManager sm on hr.SM_ID = sm.ID
    inner join Match on hr.Match_ID = Match.ID
    inner join Club on Match.guest_id = Club.ID 
    where StadiumManagerUsername = @username AND Status = 'unhandled'
    RETURN
    END

GO

CREATE PROCEDURE acceptRequest 
    @username varchar(20), @hostclubname varchar(20), @guestclubname varchar(20), @starttime datetime
    as

    declare @matchID int, @hostID int, @guestID int, @stadiumID int, @sMID int;

    SELECT @sMID= ID
    FROM stadiumManager 
    WHERE stadiumManagerUsername=@username 

    select @hostID = c.ID
    from Club c 
    where @hostclubname = c.clubName;

    select @guestID = c.ID
    from Club c
    where @guestclubname = c.clubName;

    select @matchID = m.ID
    from Match m
    where m.Host_ID = @hostID and m.guest_ID = @guestID and m.startTime = @starttime;

    select @stadiumID = sm.Stadium_ID
    from stadiumManager sm 
    WHERE sm.ID=@sMID
    
    update Match
    set stadium_ID = @stadiumID
    where Match.ID = @matchID and stadium_ID IS NULL;
    
    update hostRequest 
    set Status = 'accepted'
    where hostRequest.Match_ID = @matchID AND SM_ID=@sMID and Status='unhandled';

GO

CREATE PROCEDURE rejectRequest 
    @username varchar(20), @hostclubname varchar(20), @guestclubname varchar(20), @starttime datetime
    as

    declare @matchID int, @hostID int, @guestID int;

    select @hostID = c.ID
    from Match m inner join Club c on c.ID = m.Host_ID
    where @hostclubname = c.clubName;

    select @guestID = c.ID
    from Match m inner join Club c on c.ID = m.guest_ID
    where @guestclubname = c.clubName;

    select @matchID = m.ID
    from Match m
    where m.Host_ID = @hostID and m.guest_ID = @guestID and m.startTime = @starttime;

    update hostRequest 
    set Status = 'rejected'
    where hostRequest.Match_ID = @matchID and Status='unhandled';

GO

CREATE PROCEDURE addFan 
    @name varchar(20), @username varchar(20), @password varchar(20), @nationalid varchar(20), @birthdate datetime, 
    @address varchar(20), @phonenum int
    as insert into systemUser values(@username, @password)
    insert into Fan(Name, username, NationaID, BirthDate, Address, PhoneNumber)
    values(@name, @username, @nationalid, @birthdate, @address, @phonenum)

GO

CREATE FUNCTION upcomingMatchesOfClub
    (@clubname varchar(20))
    returns @M table( HostName varchar(20), GuestName varchar(20), startTime datetime, stadiumName varchar(20))
    as begin
    insert into @M
    select c1.clubName,c2.clubName, Match.startTime, Stadium.stadiumName
    from Match inner join Club c1 on c1.ID = Match.host_ID inner join Club c2 on c2.ID = Match.guest_ID
    inner join Stadium on Stadium.ID = Match.stadium_ID where Match.startTime> CURRENT_TIMESTAMP AND (@clubname = c1.clubName or @clubname = c2.clubName)
    return
    end 

GO

CREATE FUNCTION availableMatchesToAttend
    (@starttime datetime)
    returns @T table(Host varchar(20), Guest varchar(20), startTime datetime, stadiumName varchar(20))
    as begin
    insert into @T
    select distinct c1.clubName, c2.clubName, m.startTime, Stadium.stadiumName
    from Match m inner join Club c1 on c1.ID = m.host_ID 
    inner join Club c2 on c2.ID = m.guest_ID
    inner join Stadium on Stadium.ID = m.stadium_ID
    inner join Ticket on m.ID = Ticket.Match_ID
    where m.startTime>= @starttime 
    AND Ticket.ticketStatus = '1';
    
   
    return
    end 

GO

CREATE PROCEDURE purchaseTicket 
    @nationalid varchar(20), @hostname varchar(20), @guestname varchar(20), @starttime datetime
    as
    DECLARE @tID INT
    insert into ticketBuyingTransaction 
    values((SELECT NationaID as nID FROM Fan WHERE NationaID=@nationalid AND Status='1'),
    (select top 1 t.ID from Ticket t inner join Match m on t.Match_ID = m.ID inner join Club c1 on c1.ID = m.host_ID 
    inner join Club c2 on c2.ID = m.guest_ID where m.startTime = @starttime 
    AND c1.clubName= @hostname AND c2.clubName = @guestname AND t.ticketStatus = '1'))
    SET @tID=(select top 1 t.ID from Ticket t inner join Match m on t.Match_ID = m.ID inner join Club c1 on c1.ID = m.host_ID 
    inner join Club c2 on c2.ID = m.guest_ID where m.startTime = @starttime 
    AND c1.clubName= @hostname AND c2.clubName = @guestname AND t.ticketStatus = '1')
    UPDATE Ticket SET ticketStatus='0' WHERE Ticket.ID=@tID

GO

CREATE PROCEDURE updateMatchHost 
    @hName VARCHAR(20), @gName VARCHAR(20), @sTime DATETIME
    AS
    declare @gID int, @hID int
    select @gID = Club.ID from Club where Club.clubName = @gName
    select @hID = Club.ID from Club where Club.clubName = @hName
    update Match set guest_ID = null where @sTime = startTime;
    update Match set Match.host_ID = @gID where @sTime = Match.startTime
    update Match set Match.guest_ID = @hID where @sTime = Match.startTime
    
GO

CREATE VIEW matchesPerTeam
    AS
    SELECT c1.clubName, COUNT(*) 'Number of Matches'
    FROM [Match] INNER JOIN Club c1 ON c1.ID=Match.Host_ID WHERE [Match].startTime<CURRENT_TIMESTAMP
    GROUP BY c1.clubName
    UNION
    SELECT clubName, COUNT(*) 'Number of Matches'
    FROM Club c2 INNER JOIN Match m2 ON c2.ID=m2.guest_ID WHERE [m2].startTime<CURRENT_TIMESTAMP
    GROUP BY c2.clubName

GO

CREATE VIEW clubsNeverMatched
    AS 
    SELECT DISTINCT c1.clubName 'First Club Name', c2.clubName 'Second Club Name '
    FROM Club c1, Club c2
    WHERE c1.clubName < c2.clubName 
    AND c2.ID NOT IN
    (SELECT Host_ID FROM Match WHERE guest_ID=c1.ID and Match.startTime > CURRENT_TIMESTAMP
    UNION 
    SELECT guest_ID FROM Match WHERE c1.ID = HOST_ID and Match.startTime > CURRENT_TIMESTAMP);

GO

CREATE FUNCTION clubsNeverPlayed 
    (@cName VARCHAR(20))
    RETURNS @P TABLE (ncnames VARCHAR(20))
    AS
    BEGIN
    INSERT INTO @P
    SELECT c2.clubName
    FROM Club c2
    WHERE c2.clubName NOT IN (
        SELECT cc.clubName
        FROM [Match] m2 INNER JOIN Club cm ON cm.ID=m2.Host_ID 
            INNER JOIN Club cc ON cc.ID = m2.guest_ID WHERE cm.clubName = @cName)
    AND c2.clubName NOT IN(
        SELECT cm.clubName 
        FROM [Match] m2 INNER JOIN Club cm ON cm.ID=m2.Host_ID 
            INNER JOIN Club cc ON cc.ID = m2.guest_ID WHERE cc.clubName = @cName)
    and c2.clubName <> @cName
    RETURN
    END

GO

CREATE FUNCTION matchWithHighestAttendance
    () RETURNS @P TABLE (hcname VARCHAR(20), gcname VARCHAR(20))
    AS BEGIN
    DECLARE @mID INT
    SELECT  @mID=Match_ID FROM Ticket  WHERE ticketStatus='0' GROUP BY Match_ID 
    HAVING  COUNT(ID) =
    (
    SELECT  TOP 1 COUNT(ID) totalCount
    FROM    Ticket 
    WHERE   ticketStatus='0'
    GROUP   BY Match_ID 
    ORDER BY totalCount DESC 
    )
    INSERT INTO @P
    SELECT c1.clubName, c2.clubName FROM [Match] INNER JOIN Club c1 ON c1.ID=[Match].Host_ID INNER JOIN Club c2 ON c2.ID= [Match].guest_ID
    WHERE @mID=[Match].ID
    RETURN
    END 

GO

CREATE FUNCTION matchesRankedByAttendance    
    () RETURNS @P TABLE (hcname VARCHAR(20), gcname VARCHAR(20))
    AS 
    BEGIN
    INSERT INTO @P
    SELECT c1.clubName 'Host Club',c2.clubName 'Guest Club' 
    FROM Ticket t INNER JOIN [Match] ON t.Match_ID = [Match].ID INNER JOIN Club c1 ON c1.ID = [Match].Host_ID 
        INNER JOIN Club c2 ON c2.ID = [Match].guest_ID
    WHERE ticketStatus = '0' AND [Match].startTime < CURRENT_TIMESTAMP
    GROUP BY c1.clubName,c2.clubName 
    ORDER BY COUNT(t.ID) DESC
    RETURN
    END

GO

CREATE FUNCTION requestsFromClub
    (@sName VARCHAR(20), @cName VARCHAR(20))
    RETURNS @F TABLE (hname VARCHAR(20), gname VARCHAR(20))
    AS BEGIN

    declare @sID int, @hostID int, @matchID int, @crID int, @smID int;

    select @hostID = c.ID
    from Club c
    where c.clubName = @cName;

    select @crID = cr.ID
    from clubRepresentative cr inner join Club c on cr.club_ID = c.ID
    where c.ID = @hostID;

    select @sID = s.ID
    from Stadium s
    where s.stadiumName = @sName;

    select @smID = sm.ID
    from stadiumManager sm inner join Stadium s on sm.Stadium_ID = s.ID
    where s.stadiumName = @sName;

    INSERT INTO @F 

    select @cName, c.clubName
    from hostRequest hr inner join Match m on hr.ID = m.ID
    inner join Club c on c.ID = m.guest_ID
    where hr.Status = 'unhandled' and hr.CR_ID = @crID and hr.SM_ID = @smID;

    RETURN
    END

GO 

CREATE PROCEDURE dropAllProceduresFunctionsViews
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
    DROP PROCEDURE addStadiumManager
    DROP PROCEDURE acceptRequest
    DROP PROCEDURE rejectRequest
    DROP PROCEDURE addFan
    DROP PROCEDURE purchaseTicket
    DROP PROCEDURE updateMatchHost

    drop view allAssocManagers;
    drop view allClubRepresentatives;
    drop view allStadiumManagers;
    drop view allCLubs;
    drop view allFans;
    drop view allMatches;
    drop view allRequests;
    drop view allStadiums;
    drop view allTickets;
    drop view clubsWithNoMatches;
    DROP VIEW matchesPerTeam
    DROP VIEW clubsNeverMatched

    DROP FUNCTION viewAvailableStadiumsOn;
    DROP FUNCTION allUnassignedMatches;
    DROP FUNCTION allPendingRequests;
    DROP FUNCTION upcomingMatchesOfClub
    DROP FUNCTION availableMatchesToAttend
    DROP FUNCTION clubsNeverPlayed;
    DROP FUNCTION matchWithHighestAttendance;
    DROP FUNCTION matchesRankedByAttendance;
    DROP FUNCTION requestsFromClub;

GO

