create database aircargo;
use aircargo;

/* 1. Create an ER diagram for the given airlines database.*/

/* 2. Write a query to create a route_details table using suitable data types for the fields
, such as route_id, flight_num, origin_airport, destination_airport, aircraft_id, 
and distance_miles. Implement the check constraint for the flight number 
and unique constraint for the route_id fields. 
Also, make sure that the distance miles field is greater than 0. */

use aircargo;
   CREATE TABLE route_details (
    route_id INTEGER,
    flight_num INTEGER,
    origin_airport CHAR(3),
    destination_airport CHAR(3),
    aircraft_id VARCHAR(20),
    distance_miles VARCHAR(20)
);
select * from aircargo.customer;
select * from aircargo.passengers_on_flights;

/*	Write a query to display all the passengers (customers) who have travelled in routes 0
1 to 25. Take data from the passengers_on_flights table.*/

SELECT 
    first_name,route_id
FROM
    aircargo.customer
        left JOIN
    aircargo.passengers_on_flights ON aircargo.customer.customer_id = aircargo.passengers_on_flights.customer_id
WHERE
    aircargo.passengers_on_flights.route_id >= 0
        AND aircargo.passengers_on_flights.route_id <= 25
        order by route_id;


/*	Write a query to identify the number of passengers and total revenue in business class
 from the ticket_details table.*/
  
  select * from aircargo.ticket_details;
 
SELECT 
    COUNT(no_of_tickets) AS numberofpassengers,
    SUM(Price_per_ticket) AS totalrevenue
FROM
    aircargo.ticket_details
WHERE
    class_id = 'Bussiness';
 
/*	Write a query to display the full name of the customer by extracting the 
first name and last name from the customer table.*/

select concat_ws(' ' , first_name, last_name) as full_name from customer;

/*	Write a query to extract the customers who have registered and booked a ticket.
 Use data from the customer and ticket_details tables.*/

  
SELECT DISTINCT td.customer_id
FROM
    aircargo.ticket_details as td
        LEFT JOIN
    aircargo.customer as c ON td.customer_id = c.customer_id
WHERE
    td.customer_id IS NOT NULL;
    
    
/*Write a query to identify the customer’s first name and last name
 based on their customer ID and brand (Emirates) from the ticket_details table.*/
 SELECT DISTINCT td.customer_id, concat_ws(' ',first_name, last_name)
FROM
    aircargo.ticket_details as td
        LEFT JOIN
    aircargo.customer as c ON td.customer_id = c.customer_id
WHERE brand = 'Emirates';
 
/*	Write a query to identify the customers who have travelled by Economy Plus class
 using Group By and Having clause on the passengers_on_flights table.*/
 SELECT 
    COUNT(customer_id) AS total_customer
FROM
    passengers_on_flights
GROUP BY class_id
HAVING class_id = 'Economy Plus';
  
	/*Write a query to identify whether the revenue has crossed 10000 
    using the IF clause on the ticket_details table.*/
    SELECT 
    IF(SUM(Price_per_ticket) > 10000,
        'Yes, Revenue has Crossed 10000',
        'no, Revenue has Crossed not 10000') AS Total_Revenue
FROM
    ticket_details;  
    
/*	Write a query to create and grant access to a new user to perform operations on a database.*/
use aircargo;
grant all on *.* to 'user'@'localhost';
#FLUSH PRIVILEGES;

/*	Write a query to find the maximum ticket price for each class using window functions
 on the ticket_details table. */
SELECT 
    MAX(Price_per_ticket) AS maximum_ticket_price
FROM
    ticket_details;

/*	Write a query to extract the passengers whose route ID is 4 by improving the speed
 and performance of the passengers_on_flights table. For the route ID 4, write a query
 to view the execution plan of the passengers_on_flights table.*/
 SELECT 
    customer_id
FROM
    passengers_on_flights
where route_id = 4;
 
 /*	Write a query to calculate the total price of all tickets booked by a customer across
 different aircraft IDs using rollup function.*/
 SELECT 
    customer_id,
    aircraft_id,
    SUM(Price_per_ticket) AS total_price_of_tickets
FROM
    ticket_details
GROUP BY customer_id , aircraft_id WITH ROLLUP;

/*	Write a query to create a view with only business class customers along with the brand of airlines. */

CREATE VIEW bussiness_class AS
    SELECT 
        customer_id, brand
    FROM
        ticket_details
    WHERE
        class_id = 'bussiness';
        select * from bussiness_class;
/*	Write a query to create a stored procedure to get the details of all passengers
 flying between a range of routes defined in run time. Also, return an error message if the table doesn't exist.*/
 
 DELIMITER &&
CREATE PROCEDURE get_total_passengers_()
BEGIN
DECLARE total_passengers INT DEFAULT 0;
SELECT COUNT(*) INTO total_passengers FROM air_cargo.passengers_on_flights;
SELECT total_passengers;
END &&
DELIMITER ;
SHOW PROCEDURE STATUS; 

/*	Write a query to create a stored procedure that extracts all the details
 from the routes table where the travelled distance is more than 2000 miles.*/
 
 delimiter //
 create procedure travelled_miles()
 begin 
 select * from routes where distance_miles > 2000;
 End //
 delimiter ;
 
 show procedure status;
 call travelled_miles;
 
/*	Write a query to create a stored procedure that groups the distance travelled
 by each flight into three categories. The categories are, short distance travel
 (SDT) for >=0 AND <= 2000 miles, intermediate distance travel (IDT) for >2000 AND <=6500,
 and long-distance travel (LDT) for >6500.*/
 
 delimiter //
 create function groups_distances(dist int)
 returns varchar(10) deterministic
 begin
 declare distances_category char(3);
 if dist >= 0 and distance_miles <= 2000 then set distances_category = 'SDT';
 elseif dist >= 2000 and distance_miles <= 6500 then set distances_category = 'IDT';
 elseif dist >= 6500 then set distances_category = 'LDT';
 end if;
 return distances_category;
 end //
 delimiter //;
 SHOW FUNCTION STATUS WHERE Db = DATABASE() AND Name = 'groups_distances';
 select groups_distances(3000) as distances_category;
 
 /*	Write a query to extract ticket purchase date, customer ID, class ID 
and specify if the complimentary services are provided for the specific class
 using a stored function in stored procedure on the ticket_details table. 
Condition: 
	If the class is Business and Economy Plus, then complimentary services are given as Yes, else it is No*/
    SELECT 
    p_date,
    customer_id,
    class_id,
    CASE
        WHEN
            class_id = 'Business'
                OR class_id = 'Economy Plus'
        THEN
            'YES'
        ELSE 'NO'
    END AS Complimentary_Service
FROM
    ticket_details
ORDER BY customer_id;
        
/*Write a query to extract the first record of the customer whose last name ends with 
Scott using a cursor from the customer table.*/

SELECT customer_id, first_name, last_name
FROM customer
WHERE last_name LIKE '%Scott';



