--1. List all customers who live in Texas (use
--JOINs)
select first_name, last_name, district from customer
left join address on address.address_id = customer.address_id 
where district like 'Texas';

--2. Get all payments above $6.99 with the Customer's Full
--Name
select amount, first_name, last_name from payment
full join customer on customer.customer_id = payment.customer_id 
where amount > 6.99
order by amount;

--3. Show all customers names who have made payments over $175(use
--subqueries)
select first_name,last_name
from customer
where customer_id in (
	select customer_id
from payment
group by customer_id
having sum(amount) > 175
order by sum(amount) desc
);

--4. List all customers that live in Nepal (use the city
--table)
select first_name, last_name from customer
inner join address on address.address_id = customer.address_id 
inner join city on city.city_id = address.city_id
inner join country on country.country_id = city.country_id 
where country like 'Nepal';


--5. Which staff member had the most
--transactions?
select first_name,last_name, count(rental_id) from staff
inner join rental on rental.staff_id = staff.staff_id
group by first_name, last_name 
order by count(rental_id) desc;

--answer: Mike Hillyer with 8,040 over Jon Stephens with 8,004

--6. How many movies of each rating are
--there?
select rating, count(inventory_id) from film
inner join inventory on inventory.film_id = film.film_id 
group by rating
order by count(inventory_id) desc;

--7.Show all customers who have made a single payment
--above $6.99 (Use Subqueries)
select first_name, last_name from customer
where customer_id in (
	select customer_id from payment
	where amount > 6.99
	group by customer_id 
	having count(amount) = 1
);
--8. How many free rentals did our stores give away?
select store.store_id, count(amount) from payment 
inner join staff on staff.staff_id = payment.staff_id 
inner join store on store.store_id = staff.store_id
where amount = 0
group by store.store_id
order by count(amount) desc;
