USE sakila;

#########################
####### SQL Lab 1 #######
#########################

# 1. Review the tables in the database.
# Done

# 2. Explore tables by selecting all columns from each table or using the in built review features for your client.
SELECT *
FROM sakila.actor;

SELECT *
FROM sakila.address;

SELECT *
FROM sakila.category;

SELECT *
FROM sakila.city;

SELECT *
FROM sakila.country;

SELECT *
FROM sakila.customer;

SELECT *
FROM sakila.film;

SELECT *
FROM sakila.film_actor;

SELECT *
FROM sakila.film_category;

SELECT *
FROM sakila.film_text;

SELECT *
FROM sakila.inventory;

SELECT *
FROM sakila.language;

SELECT *
FROM sakila.payment;

SELECT *
FROM sakila.rental;

SELECT *
FROM sakila.staff;

SELECT *
FROM sakila.store;

# 3. Select one column from a table. Get film titles.
SELECT title
FROM sakila.film;

# 4. Select one column from a table and alias it. Get unique list of film languages under the alias language. 
# Note that we are not asking you to obtain the language per each film, 
# but this is a good time to think about how you might get that information in the future.
SELECT DISTINCT name AS language
FROM sakila.language;

# (To obtain the language for each film, you could join the film and language tables.)
SELECT
	f.title,
    l.name AS language
FROM sakila.film f
JOIN sakila.language l
USING(language_id);

# 5.1 Find out how many stores does the company have?
SELECT COUNT(*) AS no_stores
FROM sakila.store;

# 5.2 Find out how many employees staff does the company have?
SELECT COUNT(*) AS no_employees
FROM sakila.staff;

# 5.3 Return a list of employee first names only?
SELECT first_name
FROM sakila.staff;

#########################
####### SQL Lab 2 #######
#########################

# 1. Select all the actors with the first name ‘Scarlett’.
SELECT *
FROM actor
WHERE first_name = 'Scarlett';

# 2. How many films (movies) are available for rent and how many films have been rented?
SELECT COUNT(*) AS count_inventory
FROM inventory;

SELECT COUNT(*) AS count_rental
FROM rental;

# 3. What are the shortest and longest movie duration? Name the values max_duration and min_duration.
SELECT 
	MIN(length) AS min_duration,
    MAX(length) AS max_duration
FROM film;

# 4. What's the average movie duration expressed in format (hours, minutes)?
SELECT 
 CONCAT(FLOOR(AVG(length) / 60), ' hour(s), ', FLOOR(AVG(length) % 60), ' minute(s)') 
FROM film;

# 5. How many distinct (different) actors' last names are there?
SELECT COUNT(DISTINCT (last_name)) AS count_actors
FROM actor;

# 6. Since how many days has the company been operating (check DATEDIFF() function)?
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS days
FROM rental;

# 7. Show rental info with additional columns month and weekday. Get 20 results.
SELECT 
	rental_id,
    rental_date,
	DATE_FORMAT(rental_date, '%M') AS rental_month,
    CASE 
		WHEN DAYOFWEEK(rental_date) = 1 THEN 'Sunday'
        WHEN DAYOFWEEK(rental_date) = 2 THEN 'Monday'
        WHEN DAYOFWEEK(rental_date) = 3 THEN 'Tuesday'
        WHEN DAYOFWEEK(rental_date) = 4 THEN 'Wednesday'
        WHEN DAYOFWEEK(rental_date) = 5 THEN 'Thursday'
        WHEN DAYOFWEEK(rental_date) = 6 THEN 'Friday'
		ELSE 'Saturday'
	END AS rental_weekday,
    inventory_id,
    customer_id,
    return_date,
    DATE_FORMAT(return_date, '%M') AS return_month,
    CASE 
		WHEN DAYOFWEEK(return_date) = 1 THEN 'Sunday'
        WHEN DAYOFWEEK(return_date) = 2 THEN 'Monday'
        WHEN DAYOFWEEK(return_date) = 3 THEN 'Tuesday'
        WHEN DAYOFWEEK(return_date) = 4 THEN 'Wednesday'
        WHEN DAYOFWEEK(return_date) = 5 THEN 'Thursday'
        WHEN DAYOFWEEK(return_date) = 6 THEN 'Friday'
		ELSE 'Saturday'
	END AS return_weekday,
    staff_id,
    last_update
FROM rental;

# 8. Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.
SELECT 
	*,
    CASE 
		WHEN DAYOFWEEK(rental_date) BETWEEN 2 AND 6  THEN 'workday'
		ELSE 'weekend'
	END AS day_type
FROM rental;

# 9. How many rentals were in the last month of activity?
SELECT 
	DATE_FORMAT(rental_date, '%M %Y') AS rental_month,
    COUNT(*)
FROM rental
GROUP BY rental_month
ORDER BY DATE(rental_month)
;

#########################
####### SQL Lab 3 #######
#########################

# 1. Get release years.
SELECT DISTINCT release_year
FROM film;

# 2. Get all films with ARMAGEDDON in the title.
SELECT *
FROM film
WHERE title LIKE '%armageddon%';

# 3. Get all films which title ends with APOLLO.
SELECT *
FROM film
WHERE title LIKE '%apollo';

# 4. Get 10 the longest films.
SELECT *
FROM film
ORDER BY length DESC
LIMIT 10;

# 5. How many films include Behind the Scenes content?
SELECT COUNT(*) as count_bts
FROM film
WHERE special_features LIKE '%behind the scenes%'
;

# 6. Drop column picture from staff.
ALTER TABLE staff
DROP picture;

# 7. A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly.
SELECT *
FROM staff;

SELECT *
FROM customer
WHERE first_name = 'Tammy'
AND last_name = 'Sanders';

INSERT INTO staff
(staff_id,
first_name,
last_name,
address_id,
email,
store_id,
active,
username,
password,
last_update)
VALUES
(3,
'Tammy',
'Sanders',
79,
'tammy.sanders@sakilacustomer.org',
2,
1,
'Tammy',
NULL,
CURRENT_TIMESTAMP);

# 8. Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1.
# 	 You can use current date for the rental_date column in the rental table. 
#    Hint: Check the columns in the table rental and see what information you would need to add there. 
#    You can query those pieces of information. For eg., you would notice that you need customer_id information as well. 
#    To get that you can use the following query:
# 		select customer_id from sakila.customer
#		where first_name = 'CHARLOTTE' and last_name = 'HUNTER';
# 	 Use similar method to get inventory_id, film_id, and staff_id.
SELECT MAX(rental_id)
FROM rental;

SELECT *
FROM staff;

SELECT *
FROM film f
JOIN inventory i
USING(film_id)
WHERE f.title = 'Academy Dinosaur'
AND i.store_id = 1;

SELECT customer_id 
FROM customer
WHERE first_name = 'CHARLOTTE' 
AND last_name = 'HUNTER';

INSERT INTO rental
(rental_id,
rental_date,
inventory_id,
customer_id,
return_date,
staff_id,
last_update)
VALUES
(16050,
CURRENT_TIMESTAMP,
1,
130,
NULL,
1,
CURRENT_TIMESTAMP);

SELECT *
FROM rental
ORDER BY rental_date DESC
LIMIT 1;

# 9. Delete non-active users, but first, create a backup table deleted_users to store customer_id, email, and the date for the users that would be deleted. Follow these steps:
# 	 Check if there are any non-active users
# 	 Create a table backup table as suggested
# 	 Insert the non active users in the table backup table
# 	 Delete the non active users from the table customer
SELECT 
	customer_id,
    email,
    create_date
FROM customer
WHERE active = 0;

CREATE TABLE deleted_users (
  customer_id smallint unsigned NOT NULL AUTO_INCREMENT,
  email varchar(50) DEFAULT NULL,
  create_date datetime NOT NULL,
  PRIMARY KEY (customer_id)
) ENGINE=InnoDB AUTO_INCREMENT=600 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

# Imported inactive users via CSV file
SELECT customer_id
FROM deleted_users;

DELETE FROM customer
WHERE active = 0;

# Getting the following error:
# Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`sakila`.`payment`, CONSTRAINT `fk_payment_customer` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE RESTRICT ON UPDATE CASCADE)
# Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`sakila`.`rental`, CONSTRAINT `fk_rental_customer` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON DELETE RESTRICT ON UPDATE CASCADE)

DELETE FROM payment
WHERE customer_id IN (16, 64, 124, 169, 241, 271, 315, 368, 406, 446, 482, 510, 534, 558, 592);

DELETE FROM rental
WHERE customer_id IN (16, 64, 124, 169, 241, 271, 315, 368, 406, 446, 482, 510, 534, 558, 592);

# After deleting the records in payment and rental, I can now delete the inactive customers.
DELETE FROM customer
WHERE active = 0;