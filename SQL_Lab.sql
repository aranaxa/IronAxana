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