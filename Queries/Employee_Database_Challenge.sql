--Create a table with all the retirement-age employees at the company.
SELECT e.emp_no, e.first_name, e.last_name, t.title, t.from_date, t.to_date
INTO retirement_titles
FROM public.employees as e
INNER JOIN public.titles as t
ON e.emp_no = t.emp_no
WHERE e.birth_date >= '1/1/1952' AND e.birth_date <= '12/31/1955'
ORDER BY emp_no, to_date DESC;

--Create a table of the most current title for only current employees. 
SELECT DISTINCT r.emp_no, r.first_name, r.last_name, r.title
INTO unique_titles
FROM public.retirement_titles as r
WHERE r.to_date = '01/01/9999'
ORDER BY r.emp_no;

--Count the number of retiring-age employees with each job title.
SELECT COUNT(u.title), u.title 
INTO retiring_titles
FROM unique_titles as u
GROUP BY u.title
ORDER BY COUNT(u.title) DESC;

--Create a table of current employees born in 1965 and their employment dates.
SELECT e.emp_no, e.first_name, e.last_name, e.birth_date, d.from_date, d.to_date
INTO employ_dates
FROM public.employees as e
INNER JOIN public.dept_emp as d
ON e.emp_no = d.emp_no
WHERE e.birth_date >= '01/01/1965' AND e.birth_date <= '12/31/1965' AND d.to_date = '01/01/9999';

--Add their current titles and order by employee number.
SELECT n.emp_no, n.first_name, n.last_name, n.birth_date, n.from_date, n.to_date, t.title
INTO mentorship_eligibility
FROM employ_dates as n
INNER JOIN public.titles as t
ON n.emp_no = t.emp_no
WHERE t.to_date = '01/01/9999'
ORDER BY emp_no;