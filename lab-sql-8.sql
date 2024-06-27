-- Instructions
-- In this lab we will find the customers who were active in consecutive months of May and June. Follow the steps to complete the analysis.
-- Create a table rentals_may to store the data from rental table with information for the month of May.
use sakila;
CREATE TABLE rentals_may AS
SELECT *
FROM rental
WHERE MONTH(rental_date) = 5;
-- Insertar valores en la tabla rentals_may:
INSERT INTO rentals_may
SELECT *
FROM rental
WHERE MONTH(rental_date) = 5;
SElect *
From rentals_may;
-- Crear la tabla rentals_june:
CREATE TABLE rentals_june AS
SELECT *
FROM rental
WHERE MONTH(rental_date) = 6;
SElect *
From rentals_june;
 -- nsertar valores en la tabla rentals_june:
INSERT INTO rentals_june
SELECT *
FROM rental
WHERE MONTH(rental_date) = 6;
SElect *
From rentals_june;
-- Contar el número de alquileres para cada cliente en mayo:
SELECT customer_id, COUNT(*) AS rentals_in_may
FROM rentals_may
GROUP BY customer_id;
-- Contar el número de alquileres para cada cliente en junio:
SELECT customer_id, COUNT(*) AS rentals_in_june
FROM rentals_june
GROUP BY customer_id;

-- Escriba una función que verifique si el cliente tomó prestadas más o menos películas en el mes de junio en comparación con mayo.

-- Sugerencia : para esta parte, puede crear una unión entre los dos data frames creados anteriormente, utilizando la función de combinación disponible para los marcos de datos de pandas. Aquí hay un enlace a la documentación de la función de combinación .

SELECT customer_id, COUNT(*) AS rentals_in_may FROM rentals_may GROUP BY customer_id;
SELECT customer_id, COUNT(*) AS rentals_in_june FROM rentals_june GROUP BY customer_id;

With may as (
	Select customer_id, COUNT(*) AS rentals_in_May
	FROM rentals_may
	group by customer_id
)
, june as (
	Select customer_id, COUNT(*) AS rentals_in_june
	FROM rentals_june
	group by customer_id
)
SELECT coalesce (m.customer_id, j.customer_id) as customer_id, m.rentals_in_May, j.rentals_in_june
FROM may m
INNER JOIN june j
	ON m.customer_id = j.customer_id
WHERE coalesce (m.customer_id, j.customer_id) IN ('{{ customer_parameter|join("', '") }}');











