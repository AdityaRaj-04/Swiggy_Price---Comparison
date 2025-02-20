create database scraping;
CREATE TABLE swiggy (
    id INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(255),
    Average_Dish_Price VARCHAR(50),
    Address TEXT,
    Cuisine TEXT,
    Rating VARCHAR(10)
);
SELECT * FROM SWIGGY;

SELECT * 
FROM swiggy 
WHERE Name IS NULL OR Name = ''
   OR Average_Dish_Price IS NULL OR `Average_Dish_Price` = ''
   OR Address IS NULL OR Address = ''
   OR Cuisine IS NULL OR Cuisine = ''
   OR Rating IS NULL OR Rating = '';
   
DELETE FROM swiggy 
WHERE Name IS NULL OR Name = ''
   OR Average_Dish_Price IS NULL OR `Average_Dish_Price` = ''
   OR Address IS NULL OR Address = ''
   OR Cuisine IS NULL OR Cuisine = ''
   OR Rating IS NULL OR Rating = '';

-- Average price of all dish
select round(avg(cast(replace(replace(Average_dish_price, '₹', ' '), 'for two', ' ') as unsigned))) as average_price
from swiggy where average_dish_price REGEXP '[0-9]' 
group by name order by average_price desc 
limit 10;

-- Highest price by Restaurant
select name, round(Max(cast(replace(replace(average_dish_price, '₹', ' '), 'for two', ' ') as unsigned))) as Max_price,
 address, cuisine from swiggy
where average_dish_price regexp '[0-9]' 
group by name, address, cuisine order by max_price desc 
limit 5;

-- Lowest price by Restaurant
select name, round(min(cast(replace(replace(average_dish_price, '₹', ' '), 'for two', ' ') as unsigned))) as min_price, 
address, cuisine from swiggy
where average_dish_price regexp '[0-9]' 
group by name, address, cuisine 
order by min_price;

-- Top rated restaurant 
select name, max(rating) as top_rated from swiggy 
group by name order by top_rated desc 
limit 10;

-- Average rated restaurant
select name, avg(rating) as avg_rated from swiggy
 group by name order by avg_rated;
 
-- Top 3 rated reataurant in each cuisine
select name, cuisine, rating 
from ( 
		select name, cuisine, rating, 
				Rank() over(partition by cuisine order by cast(rating as DECIMAL(3,1)) desc) as ranking 
		from swiggy
	)as ranked 
where ranking <= 3 
order by cuisine, 
ranking desc limit 3;



