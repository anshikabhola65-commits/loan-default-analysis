# 1. Total number of loans
select 
 count(*) as No_of_loans
from `loan_default_project.loans`

#2. Find the total amount of money lent across all loans.
select
 sum(loan_amount) as Total_amount
from `loan_default_project.loans` 

#3. Find the average loan_amount from the loans table.
select 
 avg(loan_amount) as avg_loan_amount
from `loan_default_project.loans` 

#4. find both the largest and smallest loan amounts
select
 max(loan_amount) as Largest_amount,
 min(loan_amount) as Smallest_amount
from `loan_default_project.loans`

#5. How many loans have the status Default?
select
 count(*) as loan_status
from `loan_default_project.loans`
where loan_status = "Default"  
 
#6. Find the number of loans for each loan purpose.
select
 loan_purpose,
 count(*) as no_of_loans
from `loan_default_project.loans` 
group by loan_purpose 

#7. Find the average loan amount for each loan_purpose.
select
 loan_purpose,
 round(avg(loan_amount),2) as avg_loan_amount
from `loan_default_project.loans`
group by loan_purpose

#8. how many defaulted loans there are for each loan_purpose.
select
 loan_purpose,
 count(*) as no_of_loans
from `loan_default_project.loans`
where loan_status = "Default"
group by loan_purpose

#9. find the number of loans for each employment_type.
select
 employment_type,
 count(*) as no_of_loans
from `loan_default_project.loans`
group by employment_type

#10. find the average credit score for each employment type.
select
 employment_type,
 round(avg(credit_score),2) as avg_credit_score
from `loan_default_project.loans`
group by employment_type

#11. Using the annual_income column, categorize each loan into three income groups:

-- Low Income → annual income less than 500,000
-- Medium Income → annual income 500,000 to 1,000,000
-- High Income → annual income greater than 1,000,000

-- Then find the number of loans in each income group.
select
 case
  when annual_income < 500000 then "Low income"
  when annual_income <= 1000000 then "Medium income"
   else "High income"
 end as income_group,
 COUNT(*) AS no_of_loans
from `loan_default_project.loans`
group by income_group

#12. Using the credit_score column, categorize each loan into four credit-score groups:

-- Poor → below 600
-- Fair → 600–699
-- Good → 700–749
-- Excellent → 750 and above

-- Then find the number of loans in each credit-score group.
select
 case 
  when credit_score < 600 then "Poor"
  when credit_score <= 699 then "Fair"
  when credit_score <= 749 then "Good"
  else "Excellent"
 end as credit_Score_group,
 count(*) as no_of_loans 
from `loan_default_project.loans`
group by credit_Score_group

#13. Using the same four credit-score groups (Poor, Fair, Good, Excellent), find how many defaulted loans belong to each credit-score group.
select
 case 
  when credit_score < 600 then "Poor"
  when credit_score <= 699 then "Fair"
  when credit_score <= 749 then "Good"
  else "Excellent"
 end as credit_Score_group,
 count(*) as no_of_loans 
from `loan_default_project.loans`
where loan_status = "default"
group by credit_Score_group

#14. Using the loans and customers tables, display the following information for each loan:

-- loan_id
-- customer_id
-- customer_name
-- city
-- loan_amount
-- loan_status
select
 l.loan_id,
 c.customer_id,
 c.customer_name,
 c.city,
 l.loan_amount,
 l.loan_status
from `loan_default_project.loans` as l
inner join `loan_default_project.customers` as c 
on l.customer_id = c.customer_id

#15. Using the loans and customers tables, find how many loans were taken in each city.
select
 c.city,
 count(*) as no_of_loans
from `loan_default_project.loans` as l
inner join `loan_default_project.customers` as c
on c.customer_id = l.customer_id
group by c.city

#16. Using the loans and customers tables, find the number of defaulted loans in each city
select
 c.city,
 count(*) as defaulted_loans
from `loan_default_project.loans` as l
inner join `loan_default_project.customers` as c
on c.customer_id = l.customer_id
where l.loan_status = "Default"
group by c.city

#17. Using the loans and customers tables, find the number of defaulted loans for each education level.
select
 education,
 count(*) as no_of_defaulted_loan
from `loan_default_project.loans` as l
inner join `loan_default_project.customers` as c
on c.customer_id = l.customer_id
where l.loan_status = "Default"
group by education

#18. Using the loans and customers tables, find the average loan amount for each city.
select
 c.city,
 round(avg(l.loan_amount),2) as avg_loan_amount
from `loan_default_project.loans` as l
inner join `loan_default_project.customers` as c
on c.customer_id = l.customer_id
group by c.city

#19. Find the number of defaulted loans for each loan purpose, and arrange the results so the loan purpose with the highest number of defaults appears first.
SELECT 
  loan_purpose,
  count(*) as no_of_defaulted_loans
from `loan_default_project.loans`
where loan_status = "Default"
group by loan_purpose
order by no_of_defaulted_loans desc

#19. Find the average loan amount for each employment type and arrange the results from highest to lowest average loan amount.
select
 employment_type,
 avg(loan_amount) as avg_loan_amount
from `loan_default_project.loans`
group by employment_type
order by avg_loan_Amount desc 

#20. Write a query to display the 10 largest loans.
Show these columns:

-- loan_id
-- customer_id
-- loan_amount
-- credit_score
-- loan_status
select
 loan_id,
 customer_id,
 loan_amount,
 credit_score,
 loan_status
from `loan_default_project.loans`
order by loan_amount desc
limit 10

#21. Find loans where both conditions are true:

-- credit_score < 650
-- debt_to_income_ratio > 0.40

-- Display:

-- loan_id
-- customer_id
-- credit_score
-- debt_to_income_ratio
-- loan_amount
-- loan_status
select
 loan_id,
 customer_id,
 credit_score,
 debt_to_income_ratio,
 loan_amount,
 loan_status
from `loan_default_project.loans`
where credit_score < 650
  and debt_to_income_ratio > 0.40

#22. For each employment type, find:

-- employment_type
-- total number of loans
-- number of defaulted loans
-- default rate (%)  
select
  employment_type,
  count(*) as total_loans,
  sum(case
        when loan_status = "Default" then 1
        else 0
      end) as defaulted_loans
from `loan_default_project.loans`
group by employment_type