use loans;

select * from loan_data;

-- Total Loan Disbursed by Status

select
	loan_status,
	sum(loan_amount),
	count(*) as loan_count
from loan_data
group by loan_status;


-- Default Rate by Grade
select
	grade,
    count(*) as total_loans,
    sum(case when loan_status = "charged off" then 1 else 0 end) as defaulted_loans,
    round(100* sum(case when loan_status = "charged off" then 1 else 0 end) / count(*), 2) as default_rate
from loan_data
group by grade;

-- Default Rate by State
select
	address_state,
    count(*) as total_loans,
    sum(case when loan_status = "charged off" then 1 else 0 end) as default_loans,
    round(100 * sum(case when loan_status = "charged off" then 1 else 0 end) / count(*) , 2) as default_rate
from loan_data
group by address_state
order by default_rate desc;


-- Interest Earned
select
	sum(total_payment - loan_amount) as total_interest_earned
from loan_data
where loan_status = "fully paid";


-- Interest Earned by Loan Term
select
	term_months,
    SUM(loan_amount) AS total_loan_disbursed,
	sum(total_payment - loan_amount) as total_interest_earned
from loan_data
where loan_status = "fully paid"
group by term_months
order by term_months;



-- Average DTI and Interest Rate by Grade
select
	grade,
    round(avg(dti),2) as average_dti,
    round(avg(int_rate), 2) as average_int_rate
from loan_data
group by grade
order by average_int_rate;


-- By Income Group
select
	case
      when annual_income < 30000 then "low_income"
      when annual_income between 30000 and 700000 then "mid_income"
      else "high_income"
      end as income_groups,
	count(*) as total_loans,
    sum(case when loan_status = "charged off" then 1 else 0 end) as defaulte_loans,
    round(100 * sum(case when loan_status = "charged off" then 1 else 0 end) / count(*), 2) as default_rate,
	round(avg(total_payment - loan_amount), 2) as int_earned
from loan_data
group by income_groups;
	
-- By Loan Term
select
	term_months,
    count(*) as total_loans,
    sum(case when loan_status = "charged off" then 1 else 0 end) as defaulte_loans,
    round(100 * sum(case when loan_status = "charged off" then 1 else 0 end) / count(*), 2) as default_rate,
	round(avg(total_payment - loan_amount), 2) as int_earned
from loan_data
group by term_months;


-- By Employment Length
select
	emp_length_years,
    count(*) as total_loans,
    sum(case when loan_status = "charged off" then 1 else 0 end) as defaulte_loans,
    round(100 * sum(case when loan_status = "charged off" then 1 else 0 end) / count(*), 2) as default_rate,
	round(avg(total_payment - loan_amount), 2) as int_earned
from loan_data
group by emp_length_years
order by default_rate;