# SQL_Project_1

The objective of this project its to analyze AdventureWorks data by performing various queries on its database. The SQL tools to be used are:

## Variables, Functions, and Procedures.
* 1. Create a procedure that receives a date parameter and shows the number of orders entered on that date.

* 2. Create a function that calculates the face value of a gross margin determined by the user based on the list price of the products.

* 3. Obtain a list of products in alphabetical order that shows what the list price should be if a gross margin of 20% is to be applied, using the function created in point 2 on the StandardCost field. Also, display the ListPrice field and the difference with the new field created.

* 4. Create a procedure that receives a from date and a to date parameter, and shows a list with the IDs of the ten customers with the highest transportation costs between those dates (Freight field).

* 5. Create a procedure that allows inserting data into the shipmethod table.

## Join Tables
* 1. Obtain a list of contacts who have ordered products from the "Mountain Bikes" subcategory, between 2000 and 2003, whose shipping method is "CARGO TRANSPORT 5".

* 2. Obtain a list of contacts who have ordered products from the "Mountain Bikes" subcategory, between 2000 and 2003, with the quantity of products purchased and ordered by this value, in descending order.

* 3. Obtain a list of the purchase volume (quantity) by year and shipping method.

* 4. Obtain a list by product category, with the total sales value and products sold.

* 5. Obtain a list by country (according to the shipping address), with the total sales value and products sold, only for those countries where more than 15 thousand products were shipped.


## Subqueries, Create Views, Window Function
* 1. Obtain a list of the purchase volume (quantity) per year and shipping method, showing for each record the percentage it represents of the total for the year. Solve using subqueries and window functions, and then compare the difference in query execution time.

* 2. Get a list by product category with the total sales value and products sold, showing for both, their percentage of the total.

* 3. Obtain a list by country (based on shipping address), with the total sales value and products sold, showing for both their percentage relative to the total.

* 4. Create a view with the names of the contacts whose products belong to the "Mountain Bikes" subcategory,  using the "Cargo Transport 5" ship method between the years 2000 and 2003.