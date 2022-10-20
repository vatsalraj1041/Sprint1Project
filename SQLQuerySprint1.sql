use ipldata
select * from dbo.deliveries;

-- 1. Top 5 scorers of all time.

select top 5 batsman, sum(batsman_runs) as BatsmanScore 
from dbo.deliveries 
group by batsman 
order by sum(batsman_runs) desc;


-- 2. Top 5 expensive bowlers of all time.
select top 5 bowler, sum(total_runs) as RunsConcedded 
from dbo.deliveries 
group by bowler 
order by sum(total_runs) desc;

--select * from dbo.matches1;
--select * from dbo.deliveries1;



-- 3. Share of various dismissals in a particular season.
select m.season,d.dismissal_kind,count(d.dismissal_kind) as NoOfDismissals from dbo.deliveries d
join dbo.matches m
on d.match_id=m.id
where dismissal_kind <> 'NA'
group by m.season,d.dismissal_kind
order by m.season;


-- 4. Share of tie,no_result matches in a particular season.
select season,
sum(case when result = 'tie' then 1 else 0 end) as no_of_ties,
sum(case when result = 'no result' then 1 else 0 end) as no_of_NoResults 
from dbo.matches
group by season
order by season;

-- 5. Share of sixes,fours,threes,twos,singles,extra_run in total runs scored during a particular season.
--Based on numbers
select season,sum(case when batsman_runs=6 then 1 else 0 end) as Sixes,
sum(case when batsman_runs=4 then 1 else 0 end) as Fours,
sum(case when batsman_runs=3 then 1 else 0 end) as Threes,
sum(case when batsman_runs=2 then 1 else 0 end) as Twos,
sum(case when batsman_runs=1 then 1 else 0 end) as Singles,
sum(extra_runs) as extra_runs,
sum(total_runs) as total_runs
from deliveries d join matches m
on d.match_id=m.id
group by season
order by season;

--Based on runs
select season,sum(case when batsman_runs=6 then 6 else 0 end) as Sixes,
sum(case when batsman_runs=4 then 4 else 0 end) as Fours,
sum(case when batsman_runs=3 then 3 else 0 end) as Threes,
sum(case when batsman_runs=2 then 2 else 0 end) as Twos,
sum(case when batsman_runs=1 then 1 else 0 end) as Singles,
sum(extra_runs) as extra_runs,
sum(total_runs) as total_runs
from deliveries d join matches m
on d.match_id=m.id
group by season
order by season;

select * from deliveries;
select * from matches;

--7. Performance of teams in a particular season.
SELECT A.season,
A.Team as TeamName,
 SUM(CASE WHEN A.Team=A.winner then 1 else 0 end) as Won,
 SUM(CASE WHEN A.Team<>A.winner then 1 else 0 end) as Lost
FROM (SELECT team1 as Team, winner, season
      FROM matches
      UNION ALL
      SELECT team2 as Team, winner, season
      FROM matches
     ) A
GROUP BY A.Team, A.season
order by A.season;

--8. Bowlers who bowled super overs ,their teams and result of match.
use ipldata
select season as Season, bowler as Bowlers , bowling_team as Their_Team,winner as Winning_Team
from deliveries d join matches m
on d.match_id = m.id
where is_super_over=1
order by season;
go







