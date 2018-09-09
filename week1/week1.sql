-- Part 1. SQL and NULLs

-- 1. How many airplanes have listed speeds? What is the minimum listed speed and the maximum listed speed?

select count(*) as number_of_listed_planes from planes where speed is not null;

select min(speed) as minimum_speed, max(speed) as maximum_speed from planes;



-- 2. What is the total distance flown by all of the planes in January 2013? What is the total distance flown by all of the planes in January 2013 where the tailnum is missing?

select sum(distance) as total_distance from flights where year=2013 and month=1;

select sum(distance) as total_distance from flights where year=2013 and month=1 and tailnum='';

-- 3. What is the total distance flown for all planes on July 5, 2013 grouped by aircraft manufacturer? Write this statement first using an INNER JOIN, then using a LEFT OUTER JOIN. How do your results compare?
select manufacturer, sum(distance) from flights inner join planes on planes.tailnum = flights.tailnum group by manufacturer;

select manufacturer, sum(distance) from flights left outer join planes on planes.tailnum = flights.tailnum group by manufacturer;
-- Both the queries output are matching except 1 additional record (AIRBUS,67644103) in left outer join which is not present in inner join. 

-- 4. Write and answer at least one question of your own choosing that joins information from at least three of the tables in the flights database.

-- Below is the query to find the list of flights with origin EWR with the airlines name and temperature during the departure
 
select name,tailnum, flights.origin,dest,flights.hour,temp from flights join airlines on flights.carrier=airlines.carrier and origin='EWR' join weather on flights.hour = weather.hour;


-- Part 2. Comparing Performance in Tableau

-- Query to count the number of flights of different airlines which had origin as 'JFK' in 2013

select airlines.name,count(*) into outfile 'op.csv' from flights join airlines on flights.carrier=airlines.carrier and flights.origin='JFK' group by airlines.name ;
