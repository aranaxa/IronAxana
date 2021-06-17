USE sakila;

##################################
####### SQL Lab 1 (Monday) #######
##################################

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

#####################################
####### SQL Lab 2.1 (Tuesday) #######
#####################################

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
	CONCAT(FLOOR(AVG(length) / 60), ' hour(s), ', FLOOR(AVG(length) % 60), ' minute(s)') AS avg_length
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

#####################################
####### SQL Lab 2.2 (Tuesday) #######
#####################################

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
SELECT *
FROM deleted_users;

DELETE FROM customer
WHERE active = 0;

#####################################
####### SQL Lab 3 (Wednesday) #######
#####################################

USE sakila;

# 1. In the actor table, which are the actors whose last names are not repeated? 
# For example if you would sort the data in the table actor by last_name, you would see that there is Christian Arkoyd, Kirsten Arkoyd, and Debbie Arkoyd. These three actors have the same last name. 
# So we do not want to include this last name in our output. Last name "Astaire" is present only one time with actor "Angelina Astaire", hence we would want this in our output list.
SELECT DISTINCT last_name
FROM actor;

# 2. Which last names appear more than once? 
# We would use the same logic as in the previous question but this time we want to include the last names of the actors where the last name was present more than once.
SELECT 
	last_name, 
    COUNT(last_name) AS count_name
FROM actor
GROUP BY last_name
HAVING count_name > 1;

# 3. Using the rental table, find out how many rentals were processed by each employee.
SELECT 
	s.staff_id, 
    COUNT(r.rental_id) AS count_rental
FROM rental r
JOIN staff s
USING(staff_id)
GROUP BY s.staff_id;

# 4. Using the film table, find out how many films were released each year
SELECT 
	release_year, 
    COUNT(title) AS count_year
FROM film
GROUP BY release_year;

# 5. Using the film table, find out for each rating how many films were there.
SELECT 
	rating, 
    COUNT(title) AS count_rating
FROM film
GROUP BY rating;

# 6. What is the average length of films for each rating? Round off the average lengths to two decimal places.
SELECT 
	rating,
    ROUND(AVG(length), 2) AS avg_length
FROM film
GROUP BY rating;

# 7. Which kind of movies (based on rating) have an average duration of two hours or more?
SELECT 
	rating, 
    ROUND(AVG(length), 2) AS avg_length
FROM film
GROUP BY rating
HAVING avg_length >= 120; 

################################################
####### SQL Lab 4 (Wednesday) - Optional #######
################################################

# 1. Inspect the database structure and find the best-fitting table to analyse for the next task.

# 2. Using the tables address and staff and the JOIN command, display the first names, last names, and address of each staff member.
SELECT 
	s.first_name, 
    s.last_name, 
    a.address, 
    c.city, 
    a.district	
FROM address a
JOIN staff s
USING(address_id)
JOIN city c
USING(city_id);

# 3. Using the tables staff and payment and the JOIN command, display the total payment amount by staff member in August of 2005.
SELECT 
	p.staff_id, 
    s.first_name, 
    s.last_name,
    DATE_FORMAT(p.payment_date, '%M %Y') AS month_year,
    SUM(p.amount) AS total_amount
FROM staff s
JOIN payment p
USING(staff_id)
GROUP BY 1, 2, 3, 4
HAVING month_year = 'August 2005';

# 4. Using the tables film and film_actor and the JOIN command, list each film and the number of actors who are listed for that film.
SELECT 
	f.title,
    COUNT(a.actor_id) AS count_actor
FROM film f
JOIN film_actor a
USING(film_id)
GROUP BY f.title;

# 5. Using the tables payment and customer and the JOIN command, list the total paid by each customer. Order the customers by last name and alphabetically.
SELECT 
	c.last_name, 
    c.first_name, 
    SUM(amount) as total_paid
FROM payment p
JOIN customer c
USING(customer_id)
GROUP BY 1, 2
ORDER BY 1;

####################################
####### SQL Lab 5 (Thursday) #######
####################################

# Inspect the database structure and find the best-fitting table to analyse for the next task.

# 1. Use the RANK() and the table of your choice rank films by length (filter out the rows that have nulls or 0s in length column). 
# In your output, only select the columns title, length, and the rank.
SELECT
	title,
    length,
    RANK() OVER (ORDER BY length) AS ranking_length  
FROM film
WHERE length <> 0
OR length IS NOT NULL;

# 2. Build on top of the previous query and rank films by length within the rating category 
# (filter out the rows that have nulls or 0s in length column). 
# In your output, only select the columns title, length, rating and the rank.
SELECT
    title,
    length,
    rating,
    RANK() OVER (PARTITION BY rating ORDER BY length) AS ranking_length  
FROM film
WHERE f.length <> 0
OR f.length IS NOT NULL;

# 3. How many films are there for each of the categories? Inspect the database structure and use appropriate join to write this query.
SELECT 
	c.name AS category,
    COUNT(*) as count_category
FROM film f
JOIN film_category fc
USING(film_id)
JOIN category c
USING(category_id)
GROUP BY 1
ORDER BY 2 DESC;

# 4. Which actor has appeared in the most films?
SELECT 
	CONCAT(a.first_name, ' ', a.last_name) AS actor,
    COUNT(f.title) as count_film
FROM film f
JOIN film_actor fa
USING(film_id)
JOIN actor a
USING(actor_id)
GROUP BY actor
ORDER BY 2 DESC;

# 5. Most active customer (the customer that has rented the most number of films)
SELECT
    c.first_name,
    c.last_name,
    COUNT(r.rental_id) AS count_customer
FROM customer c
JOIN rental r
USING(customer_id)
GROUP BY c.customer_id
ORDER BY 3 DESC;

# Bonus: Which is the most rented film? 
# The answer is Bucket Brotherhood This query might require using more than one join statement. Give it a try. 
# We will talk about queries with multiple join statements later in the lessons.
SELECT
	f.title,
    COUNT(r.rental_id) AS count_film
FROM film f
JOIN inventory i
USING(film_id)
JOIN rental r
USING(inventory_id)
GROUP BY f.title
ORDER BY 2 DESC;