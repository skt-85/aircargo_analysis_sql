# aircargo_analysis_sql

Database and Table Creation:

We create a database named aircargo and use it.

We create a table named route_details with columns for route_id, flight_num, origin_airport, destination_airport, aircraft_id, and distance_miles. We ensure that flight_num follows certain constraints, route_id is unique, and distance_miles is greater than 0.

Querying Data:

We perform various SQL queries to display passenger information, calculate passenger counts, revenue, and more.

We use different SQL clauses like SELECT, JOIN, GROUP BY, HAVING, IF, and window functions to extract and manipulate data.

Views:

We create a view named bussiness_class to display business class customers along with the brand of airlines.

Stored Procedures and Functions:

We create stored procedures to get passenger details for specific routes, extract route details based on distance, and group distances traveled by each flight.

We create stored functions to categorize distances, determine if complimentary services are provided, and use cursors to fetch specific records.

Granting Permissions:

We grant access to a new user to perform operations on the aircargo database.

Overall, we learn how to effectively create and manage a database, define tables with constraints, write complex SQL queries, use stored procedures and functions for specific operations, create views, and manage user permissions. This ensures efficient data handling and retrieval in a relational database system
