DROP TABLE IF EXISTS OLYMPICS_HISTORY;
CREATE TABLE IF NOT EXISTS OLYMPICS_HISTORY
(
    id          INT,
    name        VARCHAR,
    sex         VARCHAR,
    age         VARCHAR,
    height      VARCHAR,
    weight      VARCHAR,
    team        VARCHAR,
    noc         VARCHAR,
    games       VARCHAR,
    year        INT,
    season      VARCHAR,
    city        VARCHAR,
    sport       VARCHAR,
    event       VARCHAR,
    medal       VARCHAR
);

DROP TABLE IF EXISTS OLYMPICS_HISTORY_NOC_REGIONS;
CREATE TABLE IF NOT EXISTS OLYMPICS_HISTORY_NOC_REGIONS
(
    noc         VARCHAR,
    region      VARCHAR,
    notes       VARCHAR
);

select * from OLYMPICS_HISTORY limit 20 
select * from OLYMPICS_HISTORY_NOC_REGIONS;


--1.How many olympics games have been held?
select count( distinct(games)) from OLYMPICS_HISTORY

--2. List down all Olympics games held so far.?
select distinct year,season,city from OLYMPICS_HISTORY order by year

--3. Mention the total no of nations who participated in each olympics game?
--Problem Statement: SQL query to fetch total no of countries participated in each olympic games.

 with all_countries as
        (select games, nr.region
        from olympics_history oh
        join olympics_history_noc_regions nr ON nr.noc = oh.noc
        group by games, nr.region)
    select games, count(1) as total_countries
    from all_countries
    group by games
    order by games;
	
--Which year saw the highest and lowest no of countries participating in olympics
--Problem Statement: Write a SQL query to return the Olympic Games which had the highest participating countries and the lowest participating countries.

with all_countries as
              (select games, nr.region
              from olympics_history oh
              join olympics_history_noc_regions nr ON nr.noc=oh.noc
              group by games, nr.region),
tot_countries as
              (select games, count(1) as total_countries
              from all_countries
              group by games)
select distinct
      concat(first_value(games) over(order by total_countries)
      , ' - '
      , first_value(total_countries) over(order by total_countries)) as Lowest_Countries,
      concat(first_value(games) over(order by total_countries desc)
      , ' - '
      , first_value(total_countries) over(order by total_countries desc)) as Highest_Countries
      from tot_countries
      order by 1;


with all_countries as
              (select games, nr.region
              from olympics_history oh
              join olympics_history_noc_regions nr ON nr.noc=oh.noc
              group by games, nr.region),
tot_countries as
              (select games, count(1) as total_countries
              from all_countries
              group by games)
select distinct
      concat(first_value(games) over(order by total_countries)
      , ' - '
      , first_value(total_countries) over(order by total_countries)) as Lowest_Countries,
      concat(last_value(games) over(order by total_countries range between unbounded preceding and unbounded following)
      , ' - '
      , last_value(total_countries) over(order by total_countries range between unbounded preceding and unbounded following)) as Highest_Countries
      from tot_countries
      order by 1;
	  

5. Which nation has participated in all of the olympic games
      with tot_games as
              (select count(distinct games) as total_games
              from olympics_history),
          countries as
              (select games, nr.region as country
              from olympics_history oh
              join olympics_history_noc_regions nr ON nr.noc=oh.noc
              group by games, nr.region),
          countries_participated as
              (select country, count(1) as total_participated_games
              from countries
              group by country)
      select cp.*
      from countries_participated cp
      join tot_games tg on tg.total_games = cp.total_participated_games
      order by 1;