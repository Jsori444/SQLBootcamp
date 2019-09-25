use JPeck_2019


-- 1.	Write a query to return a “report” of all users and their roles	
	select u.Name as 'Users', r.Name as 'Role' from db2_users u
	join db2_roles r on u.RoleId = r.Id

-- 2.	Write a query to return all classes and the count of guests that hold those classes
	select tbl.name as 'Classes', count(tbl.name) as 'Guests with this class' 
	from (
		select c.name, g.guestid from db2_classes c 
		left join db2_class cc on c.classId = cc.classid
		left join DB2_Guests g on cc.guestId = g.guestId
		) tbl
	group by tbl.name

-- 3.	Write a query that returns all guests ordered by name (ascending) and their classes and corresponding levels. Add a column that labels them beginner (lvl 1-5), intermediate (5-10) and expert (10+) for their classes (Don’t alter the table for this)
	select g.name, cs.name, c.level,  
			case	
				when c.level <= 5 then 'Beginner'
				when c.level < 10 then 'Intermediate'
				when c.level >= 10 then 'Expert'
				else '???????'
			end as Ranking
	from db2_class c
		inner join db2_guests g on g.guestId = c.guestId
		inner join db2_classes cs on c.classid = cs.classId
	order by g.name asc

-- 4.	Write a function that takes a level and returns a “grouping” from question 3 (e.g. 1-5, 5-10, 10+, etc)
	select dbo.class5AssignmentFunc1(0) as 'Ranking'

-- 5.	Write a function that returns a report of all open rooms (not used) on a particular day (input) and which tavern they belong to 
	
-- 6.	Modify the same function from 5 to instead return a report of prices in a range (min and max prices) - Return Rooms and their taverns based on price inputs
-- 7.	Write a command that uses the result from 6 to Create a Room in another tavern that undercuts (is less than) the cheapest room by a penny - thereby making the new room the cheapest one

