--1 Use COALESCE to show revenue per rep — replace any NULL total with 0
SELECT
  rep_name,
  COALESCE(SUM(amount),0) AS revenue
FROM sales_2
GROUP BY rep_name
ORDER BY revenue DESC;

--2 Show average amount per product, rounded to 2 decimal places, sorted highest first
SELECT
  product,
  round(AVG(amount),2) AS avg_amount
FROM sales_2
GROUP BY product
ORDER BY avg_amount DESC;

--3 For each rep show: total sales, count of Phone sales, count of sales above 1000
SELECT
  rep_name,
  count(*) AS total_sales,
  count(CASE WHEN product = 'Phone' THEN 1 END) AS phone_sales,
  count(CASE WHEN amount > 1000 THEN 1 END) AS big_sales
FROM sales_2 
GROUP BY rep_name
ORDER BY rep_name;

--4 Write the "Mistake 1" query (non-grouped column) — observe the result, then fix it
--Mistake 1--
SELECT rep_name,sale_date,
       SUM(amount)
FROM sales_2
GROUP BY rep_name;
--Error because sale_date is not included in GROUP BY or on aggregate function.SQL does not know which value to show for each group.--

--Correct answer--
SELECT rep_name,sale_date,
       SUM(amount) AS total 
FROM sales_2
GROUP BY rep_name,sale_date;

--5 Build the full report from Query 4: COALESCE + ROUND + COUNT(CASE WHEN) + HAVING + ORDER BY alias
SELECT
  rep_name,
  count(*) AS total_sales,
  count(CASE WHEN product = 'Laptop' THEN 1 END) AS laptops,
  COALESCE(ROUND(SUM(amount),2),0) AS revenue,
  COALESCE(ROUND(AVG(amount),2),0) AS avg_sale
FROM sales_2
GROUP BY rep_name
HAVING count (*) >=2
ORDER BY revenue DESC;
