create database pw_skills;
use pw_skills;

#Q1 --------------------------------------------------------------------
CREATE TABLE employees (
    emp_id   INT AUTO_INCREMENT PRIMARY KEY,
    emp_name VARCHAR(255) NOT NULL,
    age      INT NOT NULL CHECK (age >= 18),
    email    VARCHAR(255) NOT NULL UNIQUE,
    salary   DECIMAL(10,2) DEFAULT 30000
);

#Q2 -------------------------------------------------------------------
/*Q2. Explain the purpose of constraints and how they help maintain data integrity in a database.
Provide examples of common types of constraints.?
-->
Constraints are rules applied to database columns or tables to ensure data accuracy, consistency, 
and reliability, thus maintaining data integrity. They prevent invalid data entry and enforce business
rules automatically at the database level.
Common types of constraints:
PRIMARY KEY: Uniquely identifies each row; cannot be NULL.
NOT NULL: Ensures a column cannot have NULL values.
UNIQUE: Ensures all values in a column are distinct.
FOREIGN KEY: Maintains referential integrity between tables.
CHECK: Enforces a condition on column values (e.g., age ≥ 18).
DEFAULT: Provides a default value if none is specified.
*/

#Q3 -----------------------------------------------------------------------
/*Q3.Why would you apply the NOT NULL constraint to a column? Can a primary key contain NULL values? Justify
your answer.
-->
The NOT NULL constraint is applied to a column to ensure that every row must have a value for that column; 
it prevents missing or unknown data and enforces data integrity, especially for critical fields like IDs or names.

A primary key cannot contain NULL values because it uniquely identifies each row in a table, and NULLs would 
violate this uniqueness and reliability requirement. In SQL, a primary key is automatically treated as NOT NULL.
In summary:
Use NOT NULL to guarantee essential data is always present.
A primary key cannot have NULLs because it must uniquely identify every record and cannot be empty.
*/

#Q4 -------------------------------------------------------------
/*Q4. Explain the steps and SQL commands used to add or remove constraints on an existing table. Provide an
example for both adding and removing a constraint.?alter
-->
To add or remove constraints on an existing table in SQL, you use the ALTER TABLE command.
First, to add a constraint, you write ALTER TABLE followed by the table name, then use the ADD CONSTRAINT clause with the constraint’s name and definition.
For example, to ensure employee ages are at least 21, you would write: ALTER TABLE employee ADD CONSTRAINT chk_age CHECK (employee_age >= 21);
Next, to remove a constraint, you again start with ALTER TABLE and the table name, but this time use the DROP CONSTRAINT clause with the constraint’s name.
For instance, to remove the age check constraint, you would write: ALTER TABLE employee DROP CONSTRAINT chk_age;
*/

#Q5 ------------------------------------------------------
/*Q5.Explain the consequences of attempting to insert, update, or delete data in a way that violates constraints.
Provide an example of an error message that might occur when violating a constraint
-->
When you attempt to insert, update, or delete data in a way that violates a constraint, the database will block the operation and return an error. This prevents invalid, inconsistent, or duplicate data from being saved, which helps maintain data integrity. For example, if you try to insert a NULL into a NOT NULL column, add a duplicate value in a UNIQUE or PRIMARY KEY column, or enter a value that fails a CHECK or FOREIGN KEY constraint, the database will reject the change.

Consequences include:

The specific statement causing the violation is not executed; the rest of the transaction may continue or be rolled back, depending on transaction settings.

An error message is returned, often specifying the type of constraint that was violated and the affected column or table.

Example error messages:

For a NOT NULL violation:
ERROR: Column 'emp_name' cannot accept a NULL value.

For a UNIQUE or PRIMARY KEY violation:
ERROR: Duplicate entry 'john@example.com' for key 'email'.

For a CHECK constraint violation:
The INSERT statement conflicted with the CHECK constraint "CK__PostCode__Code". The statement has been terminated.

For a FOREIGN KEY violation:
ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails.
*/

#Q6 ----------------------------------------

CREATE TABLE products (
    product_id INT,
    product_name VARCHAR(50),
    price DECIMAL(10, 2)
);

-- Make product_id the primary key
ALTER TABLE products
ADD CONSTRAINT pk_product_id PRIMARY KEY (product_id);

-- Set default value for price
ALTER TABLE products
ALTER COLUMN price SET DEFAULT 50.00;

#Q7 --------------------------------------------------------------------------

SELECT 
    Students.student_name, 
    Classes.class_name
FROM 
    Students
INNER JOIN 
    Classes
ON 
    Students.class_id = Classes.class_id;
/*Explanation:
The query selects the student_name from the Students table and the class_name from the Classes table.
It uses an INNER JOIN to combine rows from both tables where the class_id matches in both tables.*/
    
#Q8 ----------------------------------------------------------------

SELECT 
    Orders.order_id, 
    Customers.customer_name, 
    Products.product_name
FROM 
    Products
LEFT JOIN 
    Orders ON Products.order_id = Orders.order_id
LEFT JOIN 
    Customers ON Orders.customer_id = Customers.customer_id;
/*Explanation:
Start from the Products table to ensure all products are listed.
Use a LEFT JOIN to connect to Orders (so products without orders are included).
Use another LEFT JOIN to get the customer_name from Customers (so if there is no order, customer_name will be NULL).*/

#Q9 -----------------------------------------------------------------------------

SELECT 
    Products.product_name,
    sum(Sales.amount) AS total_sales
FROM 
    Sales
INNER JOIN 
    Products
ON 
    Sales.product_id = Products.product_id
GROUP BY 
    Products.product_name;

#Q10 ---------------------------------------------------------------

SELECT 
    o.order_id,
    c.customer_name,
    od.quantity
FROM 
    Orders o
INNER JOIN 
    Customers c ON o.customer_id = c.customer_id
INNER JOIN 
    Order_Details od ON o.order_id = od.order_id;
/*This query joins:
Orders with Customers on customer_id
Then joins with Order_Details on order_id
to retrieve the order_id, customer_name, and quantity.*/


/*
				-----------------------SQL Queries for Maven Movies DB-----------------------------------
1. Identify the primary keys and foreign keys in Maven Movies DB. Discuss the differences.
Primary Key: Uniquely identifies each record in a table (e.g., customer_id in customer, film_id in film).
Foreign Key: Links one table to another (e.g., customer_id in rental references customer(customer_id)).

2. List all details of actors.
SELECT * FROM actor;

3. List all customer information from DB.
SELECT * FROM customer;

4. List different countries.
SELECT DISTINCT country FROM country;

5. Display all active customers.
SELECT * FROM customer WHERE active = 1;

6. List of all rental IDs for customer with ID 1.
SELECT rental_id FROM rental WHERE customer_id = 1;

7. Display all the films whose rental duration is greater than 5.
SELECT * FROM film WHERE rental_duration > 5;

8. List the total number of films whose replacement cost is greater than $15 and less than $20.
SELECT COUNT(*) FROM film WHERE replacement_cost > 15 AND replacement_cost < 20;

9. Display the count of unique first names of actors.
SELECT COUNT(DISTINCT first_name) FROM actor;

10. Display the first 10 records from the customer table.
SELECT * FROM customer LIMIT 10;

11. Display the first 3 records from the customer table whose first name starts with 'b'.
SELECT * FROM customer WHERE first_name LIKE 'B%' LIMIT 3;

12. Display the names of the first 5 movies which are rated as ‘G’.
SELECT title FROM film WHERE rating = 'G' LIMIT 5;

13. Find all customers whose first name starts with "a".
SELECT * FROM customer WHERE first_name LIKE 'A%';

14. Find all customers whose first name ends with "a".
SELECT * FROM customer WHERE first_name LIKE '%a';

15. Display the list of first 4 cities which start and end with ‘a’.
SELECT * FROM city WHERE city LIKE 'a%a' LIMIT 4;

16. Find all customers whose first name have "Ni" in any position.
SELECT * FROM customer WHERE first_name LIKE '%Ni%';

17. Find all customers whose first name have "r" in the second position.
SELECT * FROM customer WHERE first_name LIKE '_r%';

18. Find all customers whose first name starts with "a" and are at least 5 characters in length.
SELECT * FROM customer WHERE first_name LIKE 'A%' AND LENGTH(first_name) >= 5;

19. Find all customers whose first name starts with "a" and ends with "o".
SELECT * FROM customer WHERE first_name LIKE 'A%o';

20. Get the films with pg and pg-13 rating using IN operator.
SELECT * FROM film WHERE rating IN ('PG', 'PG-13');

21. Get the films with length between 50 to 100 using BETWEEN operator.
SELECT * FROM film WHERE length BETWEEN 50 AND 100;

22. Get the top 50 actors using LIMIT operator.
SELECT * FROM actor LIMIT 50;

23. Get the distinct film IDs from inventory table.
SELECT DISTINCT film_id FROM inventory;
*/

/*
----------------------------------------------------Basic Aggregate Functions-----------------------------------------------
Question 1:
Retrieve the total number of rentals made in the Sakila database.
SELECT COUNT(*) AS total_rentals FROM rental;

Question 2:
Find the average rental duration (in days) of movies rented from the Sakila database.
SELECT AVG(rental_duration) AS average_rental_duration FROM film;

Question 3:
Display the first name and last name of customers in uppercase.
SELECT UPPER(first_name) AS first_name, UPPER(last_name) AS last_name FROM customer;

Question 4:
Extract the month from the rental date and display it alongside the rental ID.
SELECT rental_id, MONTH(rental_date) AS rental_month FROM rental;

Question 5:
Retrieve the count of rentals for each customer (display customer ID and the count of rentals).
SELECT customer_id, COUNT(*) AS rental_count FROM rental GROUP BY customer_id;

Question 6:
Find the total revenue generated by each store.
SELECT store_id, SUM(amount) AS total_revenue FROM payment GROUP BY store_id;

Question 7:
Determine the total number of rentals for each category of movies.
SELECT c.name AS category, COUNT(r.rental_id) AS total_rentals
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
GROUP BY c.name;

Question 8:
Find the average rental rate of movies in each language.
SELECT l.name AS language, AVG(f.rental_rate) AS avg_rental_rate
FROM film f
JOIN language l ON f.language_id = l.language_id
GROUP BY l.name;
*/

/*
----------------------------------------------Joins SQL Queries------------------------------------------------------
Question 9:
Display the title of the movie, customer's first name, and last name who rented it.
SELECT f.title, c.first_name, c.last_name
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN customer c ON r.customer_id = c.customer_id;

Question 10:
Retrieve the names of all actors who have appeared in the film "Gone with the Wind."
SELECT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
WHERE f.title = 'Gone with the Wind';

Question 11:
Retrieve the customer names along with the total amount they've spent on rentals.
SELECT c.first_name, c.last_name, SUM(p.amount) AS total_spent
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id;

Question 12:
List the titles of movies rented by each customer in a particular city (e.g., 'London').
SELECT c.first_name, c.last_name, f.title
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE ci.city = 'London'
GROUP BY c.customer_id, f.title;
*/

/*
------------------------------------------------------Advanced Joins and GROUP BY:---------------------------------------------
Question 13:
SELECT f.title, COUNT(r.rental_id) AS rental_count
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title
ORDER BY rental_count DESC
LIMIT 5;
												Explanation:
The film table is joined with inventory using film_id to link movies to their inventory records.
The inventory table is joined with rental using inventory_id to track rental instances.
COUNT(r.rental_id) counts the number of rentals per movie.
GROUP BY f.film_id, f.title groups the results by movie.
ORDER BY rental_count DESC sorts the results by rental count in descending order.
LIMIT 5 restricts the output to the top 5 most rented movies.

Question 14:
SELECT c.customer_id, c.first_name, c.last_name
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
WHERE i.store_id IN (1, 2)
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(DISTINCT i.store_id) = 2;
													Explanation:
The customer table is joined with rental using customer_id to link customers to their rental records.
The rental table is joined with inventory using inventory_id to access store information.
WHERE i.store_id IN (1, 2) filters for rentals from store 1 or store 2.
GROUP BY c.customer_id, c.first_name, c.last_name groups the results by customer.
HAVING COUNT(DISTINCT i.store_id) = 2 ensures that only customers who rented from both stores are included.

*/

/*1. Rank the customers based on the total amount they’ve spent on rentals.
Query:

sql

Copy
SELECT 
    c.customer_id, 
    c.first_name, 
    c.last_name, 
    SUM(p.amount) AS total_spent,
    RANK() OVER (ORDER BY SUM(p.amount) DESC) AS spending_rank
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;
Explanation:

Join customer and payment to get payment amounts per customer.
Use SUM(p.amount) to calculate total spending per customer.
RANK() OVER (ORDER BY SUM(p.amount) DESC) assigns a rank based on total spending, with the highest spender getting rank 1.
*/

/*2. Calculate the cumulative revenue generated by each film over time.
Query:

sql

Copy
SELECT 
    f.title, 
    p.payment_date, 
    p.amount,
    SUM(p.amount) OVER (PARTITION BY f.film_id ORDER BY p.payment_date) AS cumulative_revenue
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
ORDER BY f.title, p.payment_date;
Explanation:

Join film, inventory, rental, and payment to link films to their payments.
SUM(p.amount) OVER (PARTITION BY f.film_id ORDER BY p.payment_date) calculates the cumulative revenue for each film, ordered by payment date.
*/

/*3. Determine the average rental duration for each film, considering films with similar lengths.
Query:

sql

Copy
SELECT 
    f.title, 
    f.length, 
    AVG(r.rental_duration) OVER (PARTITION BY f.length) AS avg_rental_duration
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id, f.title, f.length, r.rental_duration;
Explanation:

Join film, inventory, and rental to access rental durations.
AVG(r.rental_duration) OVER (PARTITION BY f.length) calculates the average rental duration for films grouped by their length.
*/

/*4. Identify the top 3 films in each category based on their rental counts.
Query:

sql

Copy
SELECT 
    c.name AS category_name, 
    f.title, 
    COUNT(r.rental_id) AS rental_count,
    RANK() OVER (PARTITION BY c.category_id ORDER BY COUNT(r.rental_id) DESC) AS rank_in_category
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY c.category_id, c.name, f.film_id, f.title
HAVING RANK() OVER (PARTITION BY c.category_id ORDER BY COUNT(r.rental_id) DESC) <= 3;
Explanation:

Join film, film_category, category, inventory, and rental to link films to categories and rentals.
RANK() OVER (PARTITION BY c.category_id ORDER BY COUNT(r.rental_id) DESC) ranks films within each category by rental count.
HAVING clause filters for the top 3 films per category.*/

/*5. Calculate the difference in rental counts between each customer’s total rentals and the average rentals across all customers.
Query:

sql

Copy
SELECT 
    c.customer_id, 
    c.first_name, 
    c.last_name, 
    COUNT(r.rental_id) AS rental_count,
    AVG(COUNT(r.rental_id)) OVER () AS avg_rental_count,
    COUNT(r.rental_id) - AVG(COUNT(r.rental_id)) OVER () AS rental_diff
FROM customer c
LEFT JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name;
Explanation:

Join customer and rental to count rentals per customer.
AVG(COUNT(r.rental_id)) OVER () calculates the average rental count across all customers.
Subtract the average from each customer’s rental count to get the difference.*/

/*6. Find the monthly revenue trend for the entire rental store over time.
Query:

sql

Copy
SELECT 
    DATE_TRUNC('month', p.payment_date) AS month, 
    SUM(p.amount) AS monthly_revenue,
    SUM(SUM(p.amount)) OVER (ORDER BY DATE_TRUNC('month', p.payment_date)) AS cumulative_revenue
FROM payment p
GROUP BY DATE_TRUNC('month', p.payment_date)
ORDER BY month;
Explanation:

Use DATE_TRUNC('month', p.payment_date) to group payments by month.
SUM(p.amount) calculates the monthly revenue.
SUM(SUM(p.amount)) OVER (ORDER BY DATE_TRUNC('month', p.payment_date)) calculates the cumulative revenue over time.*/

/*7. Identify the customers whose total spending on rentals falls within the top 20% of all customers.
Query:

sql

Copy
SELECT 
    customer_id, 
    first_name, 
    last_name, 
    total_spent,
    NTILE(5) OVER (ORDER BY total_spent DESC) AS spending_quintile
FROM (
    SELECT 
        c.customer_id, 
        c.first_name, 
        c.last_name, 
        SUM(p.amount) AS total_spent
    FROM customer c
    JOIN payment p ON c.customer_id = p.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name
) AS subquery
WHERE NTILE(5) OVER (ORDER BY total_spent DESC) = 1;
Explanation:

Subquery calculates total spending per customer.
NTILE(5) OVER (ORDER BY total_spent DESC) divides customers into 5 groups (quintiles) based on spending.
WHERE NTILE(5) = 1 selects the top 20% (top quintile).
		Explanation:

Subquery calculates total spending per customer.
NTILE(5) OVER (ORDER BY total_spent DESC) divides customers into 5 groups (quintiles) based on spending.
WHERE NTILE(5) = 1 selects the top 20% (top quintile).*/

/*8. Calculate the running total of rentals per category, ordered by rental count.
Query:

sql

Copy
SELECT 
    c.name AS category_name, 
    COUNT(r.rental_id) AS rental_count,
    SUM(COUNT(r.rental_id)) OVER (PARTITION BY c.category_id ORDER BY COUNT(r.rental_id) DESC) AS running_total
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY c.category_id, c.name, f.film_id
ORDER BY c.name, rental_count DESC;
Explanation:

Join tables to link categories to rentals.
SUM(COUNT(r.rental_id)) OVER (PARTITION BY c.category_id ORDER BY COUNT(r.rental_id) DESC) calculates the running total of rentals within each category, ordered by rental count.*/

/*9. Find the films that have been rented less than the average rental count for their respective categories.
Query:

sql

Copy
SELECT 
    c.name AS category_name, 
    f.title, 
    COUNT(r.rental_id) AS rental_count,
    AVG(COUNT(r.rental_id)) OVER (PARTITION BY c.category_id) AS avg_rental_count
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY c.category_id, c.name, f.film_id, f.title
HAVING COUNT(r.rental_id) < AVG(COUNT(r.rental_id)) OVER (PARTITION BY c.category_id);
Explanation:

Join tables to link films to categories and rentals.
AVG(COUNT(r.rental_id)) OVER (PARTITION BY c.category_id) calculates the average rental count per category.
HAVING filters for films with rental counts below their category’s average.*/

/*10. Identify the top 5 months with the highest revenue and display the revenue generated in each month.
Query:

sql

Copy
SELECT 
    DATE_TRUNC('month', p.payment_date) AS month, 
    SUM(p.amount) AS monthly_revenue,
    RANK() OVER (ORDER BY SUM(p.amount) DESC) AS revenue_rank
FROM payment p
GROUP BY DATE_TRUNC('month', p.payment_date)
HAVING RANK() OVER (ORDER BY SUM(p.amount) DESC) <= 5
ORDER BY monthly_revenue DESC;
Explanation:

DATE_TRUNC('month', p.payment_date) groups payments by month.
SUM(p.amount) calculates the monthly revenue.
RANK() OVER (ORDER BY SUM(p.amount) DESC) ranks months by revenue.
HAVING clause limits to the top 5 months.*/



---
/*
### 1. First Normal Form (1NF)
**Question:** Identify a table in the Sakila database that violates 1NF. Explain how you would normalize it to achieve 1NF.

**Answer:**  
1NF requires that all column values are atomic (no repeating groups or arrays) and each column contains values of a single type.

In the Sakila database, the `film` table has a column `special_features`, which can contain multiple values (e.g., "Trailers,Commentaries,Deleted Scenes") in a single cell, violating 1NF.

**Normalization to 1NF:**  
- Create a new table, `film_special_features`, to store each special feature separately.
- Structure: `film_id` (foreign key referencing `film`), `special_feature` (one feature per row).
- Remove the `special_features` column from the `film` table.

**Example Transformation:**
- Before: `film(film_id, ..., special_features)` where `special_features` = "Trailers,Commentaries".
- After:  
  - `film(film_id, ...)` (no `special_features` column).  
  - `film_special_features(film_id, special_feature)` with rows like `(1, 'Trailers')`, `(1, 'Commentaries')`.
*/
---
/*
### 2. Second Normal Form (2NF)
**Question:** Choose a table in Sakila and describe how you would determine whether it is in 2NF. If it violates 2NF, explain the steps to normalize it.

**Answer:**  
2NF requires that a table is in 1NF and all non-key attributes are fully functionally dependent on the entire primary key (no partial dependencies).

Let’s consider the `film_actor` table in Sakila:  
- Primary key: `(actor_id, film_id)` (composite key).  
- Attributes: `actor_id`, `film_id`, `last_update`.

**Check for 2NF:**  
- `last_update` depends on the entire key `(actor_id, film_id)`, as it tracks when the specific actor-film association was updated.  
- There are no non-key attributes that depend on only part of the key (e.g., just `actor_id` or `film_id`).  

Thus, `film_actor` is already in 2NF.

**Hypothetical Violation Example:**  
If `film_actor` had an attribute `actor_name` (dependent only on `actor_id`), this would violate 2NF because `actor_name` depends on part of the key (`actor_id`), not the whole key `(actor_id, film_id)`.

**Normalization Steps (for the hypothetical case):**  
- Move `actor_name` to the `actor` table: `actor(actor_id, actor_name, ...)`.  
- Remove `actor_name` from `film_actor`, leaving `film_actor(actor_id, film_id, last_update)`.

Since `film_actor` in Sakila doesn’t violate 2NF, no normalization is needed here.
*/
---
/*
### 3. Third Normal Form (3NF)
**Question:** Identify a table in Sakila that violates 3NF. Describe the transitive dependencies present and outline the steps to normalize the table to 3NF.

**Answer:**  
3NF requires that a table is in 2NF and has no transitive dependencies (a non-key attribute depending on another non-key attribute through the primary key).

Consider the `rental` table in Sakila:  
- Primary key: `rental_id`.  
- Attributes: `rental_id`, `rental_date`, `inventory_id`, `customer_id`, `return_date`, `staff_id`, `last_update`.

**Transitive Dependency:**  
- The `rental` table references `customer_id`, but if we hypothetically added `customer_email` (from the `customer` table) to `rental`, then:  
  - `customer_email` depends on `customer_id` (not directly on `rental_id`).  
  - `customer_id` depends on `rental_id`.  
  - This creates a transitive dependency: `rental_id → customer_id → customer_email`.

**Normalization to 3NF:**  
- Move `customer_email` to the `customer` table: `customer(customer_id, customer_email, ...)`.  
- Keep `rental` as `rental(rental_id, rental_date, inventory_id, customer_id, return_date, staff_id, last_update)` and join with `customer` when needed.

In the actual Sakila schema, `rental` doesn’t have such a transitive dependency, but this example illustrates the process. A real violation isn’t present in the standard Sakila tables, as they’re generally well-normalized.
*/
---
/*
### 4. Normalization Process
**Question:** Take a specific table in Sakila and guide through the process of normalizing it from the initial unnormalized form up to at least 2NF.

**Answer:**  
Let’s use the `film` table and focus on the `special_features` column, which violates 1NF (as identified earlier).

**Step 1: Normalize to 1NF**  
- Issue: `special_features` contains multiple values (e.g., "Trailers,Commentaries").  
- Solution:  
  - Create a new table `film_special_features(film_id, special_feature)`.  
  - For each film, split `special_features` into separate rows.  
  - Remove `special_features` from `film`.  
- Result:  
  - `film(film_id, title, description, release_year, language_id, rental_duration, rental_rate, length, replacement_cost, rating, last_update)`.  
  - `film_special_features(film_id, special_feature)`.

**Step 2: Normalize to 2NF**  
- Check `film` table:  
  - Primary key: `film_id`.  
  - All attributes (`title`, `description`, etc.) depend fully on `film_id`. No partial dependencies exist.  
- Check `film_special_features`:  
  - Primary key: `(film_id, special_feature)`.  
  - No other attributes exist, so no partial dependencies.  

Both tables are now in 2NF. The `film` table was already in 2NF after removing `special_features`, and `film_special_features` is also in 2NF.
*/
---
/*
### 5. CTE Basics
**Question:** Write a query using a CTE to retrieve the distinct list of actor names and the number of films they have acted in from the `actor` and `film_actor` tables.

**Answer:**  
```sql
WITH ActorFilmCount AS (
    SELECT 
        a.actor_id, 
        a.first_name, 
        a.last_name, 
        COUNT(fa.film_id) AS film_count
    FROM actor a
    JOIN film_actor fa ON a.actor_id = fa.actor_id
    GROUP BY a.actor_id, a.first_name, a.last_name
)
SELECT 
    first_name, 
    last_name, 
    film_count
FROM ActorFilmCount
ORDER BY film_count DESC;
```
- The CTE `ActorFilmCount` joins `actor` and `film_actor`, groups by actor, and counts their films.  
- The main query selects from the CTE and orders by the number of films.
*/
---
/*
### 6. CTE with Joins
**Question:** Create a CTE that combines information from the `film` and `language` tables to display the film title, language name, and rental rate.

**Answer:**  
```sql
WITH FilmLanguage AS (
    SELECT 
        f.title, 
        l.name AS language_name, 
        f.rental_rate
    FROM film f
    JOIN language l ON f.language_id = l.language_id
)
SELECT 
    title, 
    language_name, 
    rental_rate
FROM FilmLanguage
ORDER BY rental_rate DESC;
```
- The CTE `FilmLanguage` joins `film` and `language` to get the film title, language name, and rental rate.  
- The main query selects from the CTE and orders by rental rate.
*/
---
/*
### 7. CTE for Aggregation
**Question:** Write a query using a CTE to find the total revenue generated by each customer (sum of payments) from the `customer` and `payment` tables.

**Answer:**  
```sql
WITH CustomerRevenue AS (
    SELECT 
        c.customer_id, 
        c.first_name, 
        c.last_name, 
        SUM(p.amount) AS total_revenue
    FROM customer c
    JOIN payment p ON c.customer_id = p.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name
)
SELECT 
    first_name, 
    last_name, 
    total_revenue
FROM CustomerRevenue
ORDER BY total_revenue DESC;
```
- The CTE `CustomerRevenue` joins `customer` and `payment`, groups by customer, and sums their payments.  
- The main query selects from the CTE and orders by total revenue.
*/
---
/*
### 8. CTE with Window Function
**Question:** Utilize a CTE with a window function to rank films based on their rental duration from the `film` table.

**Answer:**  
```sql
WITH FilmRank AS (
    SELECT 
        title, 
        rental_duration, 
        RANK() OVER (ORDER BY rental_duration DESC) AS duration_rank
    FROM film
)
SELECT 
    title, 
    rental_duration, 
    duration_rank
FROM FilmRank
ORDER BY duration_rank;
```
- The CTE `FilmRank` uses the `RANK()` window function to rank films by `rental_duration` in descending order.  
- The main query selects from the CTE and orders by rank.
*/
---
/*
### 9. CTE and Filtering
**Question:** Create a CTE to list customers who have made more than two rentals, and then join this CTE with the `customer` table to retrieve additional customer details.

**Answer:**  
```sql
WITH CustomerRentals AS (
    SELECT 
        customer_id, 
        COUNT(*) AS rental_count
    FROM rental
    GROUP BY customer_id
    HAVING COUNT(*) > 2
)
SELECT 
    c.first_name, 
    c.last_name, 
    c.email, 
    cr.rental_count
FROM CustomerRentals cr
JOIN customer c ON cr.customer_id = c.customer_id
ORDER BY cr.rental_count DESC;
```
- The CTE `CustomerRentals` groups rentals by `customer_id`, counts rentals, and filters for customers with more than 2 rentals.  
- The main query joins the CTE with `customer` to get additional details like `first_name`, `last_name`, and `email`.

---
I'll solve each of the remaining questions (10, 11, and 12) using the Sakila database, focusing on CTEs as requested. Let's dive in.
*/
---
/*
### 10. CTE for Date Calculations
**Question:** Write a query using a CTE to find the total number of rentals made each month, considering the `rental_date` from the `rental` table.

**Answer:**  
```sql
WITH MonthlyRentals AS (
    SELECT 
        DATE_TRUNC('month', rental_date) AS rental_month, 
        COUNT(*) AS rental_count
    FROM rental
    GROUP BY DATE_TRUNC('month', rental_date)
)
SELECT 
    TO_CHAR(rental_month, 'YYYY-MM') AS month, 
    rental_count
FROM MonthlyRentals
ORDER BY rental_month;
```
- The CTE `MonthlyRentals` uses `DATE_TRUNC('month', rental_date)` to group rentals by month (e.g., truncating `2025-05-30` to `2025-05-01`).  
- It counts the number of rentals per month.  
- The main query formats the month as `YYYY-MM` (e.g., `2025-05`) and orders by `rental_month`.

---

### 11. CTE and Self-Join
**Question:** Create a CTE to generate a report showing pairs of actors who have appeared in the same film together, using the `film_actor` table.

**Answer:**  
```sql
WITH ActorPairs AS (
    SELECT 
        fa1.actor_id AS actor1_id, 
        fa2.actor_id AS actor2_id, 
        fa1.film_id
    FROM film_actor fa1
    JOIN film_actor fa2 
        ON fa1.film_id = fa2.film_id 
        AND fa1.actor_id < fa2.actor_id
)
SELECT 
    a1.first_name || ' ' || a1.last_name AS actor1, 
    a2.first_name || ' ' || a2.last_name AS actor2, 
    f.title AS film_title
FROM ActorPairs ap
JOIN actor a1 ON ap.actor1_id = a1.actor_id
JOIN actor a2 ON ap.actor2_id = a2.actor_id
JOIN film f ON ap.film_id = f.film_id
ORDER BY ap.film_id, ap.actor1_id, ap.actor2_id;
```
- The CTE `ActorPairs` performs a self-join on `film_actor` to find pairs of actors (`actor1_id`, `actor2_id`) who worked on the same `film_id`.  
- The condition `fa1.actor_id < fa2.actor_id` avoids duplicate pairs (e.g., (1,2) and (2,1)).  
- The main query joins with `actor` to get actor names and `film` to get the film title, then orders the results.

---

### 12. CTE for Recursive Search
**Question:** Implement a recursive CTE to find all employees in the `staff` table who report to a specific manager, considering the `reports_to` column.

**Answer:**  
```sql
WITH RECURSIVE StaffHierarchy AS (
    -- Anchor: Start with the specific manager
    SELECT 
        staff_id, 
        first_name, 
        last_name, 
        reports_to, 
        0 AS level
    FROM staff
    WHERE staff_id = 1  -- Replace with the specific manager's staff_id
    UNION ALL
    -- Recursive part: Find employees who report to the manager (or their subordinates)
    SELECT 
        s.staff_id, 
        s.first_name, 
        s.last_name, 
        s.reports_to, 
        sh.level + 1
    FROM staff s
    JOIN StaffHierarchy sh ON s.reports_to = sh.staff_id
)
SELECT 
    staff_id, 
    first_name, 
    last_name, 
    reports_to, 
    level
FROM StaffHierarchy
WHERE staff_id != 1  -- Exclude the manager themselves, if desired
ORDER BY level, staff_id;
```
- The recursive CTE `StaffHierarchy` starts with the anchor member: the specific manager (e.g., `staff_id = 1`).  
- The recursive part joins `staff` with `StaffHierarchy` to find employees who report to the manager, then their subordinates, and so on.  
- The `level` column tracks the hierarchy depth (0 for the manager, 1 for direct reports, 2 for their reports, etc.).  
- The main query selects the hierarchy and orders by `level` and `staff_id`.  
- Note: Replace `staff_id = 1` with the actual manager’s `staff_id`.
/*









