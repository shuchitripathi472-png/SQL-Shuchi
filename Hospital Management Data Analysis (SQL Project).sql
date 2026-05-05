SELECT * FROM hospital_managment.appointments;

-- Remove invalid billing rows
Select * from billing
where amount = 0;

-- Handle NULL values
select * from appointments
where patient_id is null;

-- Total Patients
select count(*) as total_patients
from patients;

-- Total Doctors
select count(*) as total_doctor
from doctors;

-- Total Appointments
select count(*) as total_appointment
from appointments;

-- Monthly Appointment Trend
select date_format(appointment_date, '%y-%m') as month,
count(*) as total_appointment
from appointments
group by month 
order by month;

--  Patients by Gender

select gender, COUNT(*) AS TOTAL
from patients
GROUP BY gender;

-- Top 10 High-Value Patients
select p.patient_id, sum(b.amount) as total_spent
from patients as p join billing as b on p.patient_id = b.patient_id 
group by p.patient_id
order by total_spent desc
limit 10;

-- Insurance vs Non-Insurance
select
     case 
          when insurance_provider is null then 'No Insurance'
          else 'Has Insurance'
          end as Insurance_staus,
  count(*) as Total 
from patients
group by Insurance_staus;

-- Doctors by Specialization
select specialization, count(*) as  total_doctors
from doctors
group by specialization
order by total_doctors desc;

-- Doctor Workload
select d.doctor_id, concat(d.first_name, ' ',d.last_name) as full_name,
count(a.appointment_id) as total_appointment
from doctors as d join appointments as a on d.doctor_id = a.doctor_id
group by d.doctor_id, concat(d.first_name, ' ',d.last_name)
order by total_appointment desc;

--  Revenue by Payment Method
select payment_method, sum(amount) as revenue
from billing
group by payment_method
order by revenue desc;

-- Paid vs Pending Bills

select payment_status, count(*) as stutus
from billing
group by payment_status;

-- Most Expensive Treatments
select treatment_type, max(cost) as expensive
from treatments 
group by treatment_type
order by expensive desc;

--  Revenue by Treatment
select t.treatment_id, b.bill_id, sum(b.amount) as revenue
from treatments as t join billing as b on t.treatment_id = b.treatment_id 
group by t.treatment_id, b.bill_id
order by revenue desc;

-- Rank Doctors by Revenue
select d.doctor_id, d.first_name, d.last_name, sum(b.amount) as revenue,
rank() over(order by sum(b.amount) desc) as rnk
from doctors as d join appointments as a on d.doctor_id = a.doctor_id
join billing as b on a.patient_id = b.patient_id
group by d.doctor_id, d.first_name, d.last_name;

-- Top 3 Treatments Per Month
select * from (
select t.treatment_type, sum(b.amount) as revenue,
date_format(b.bill_date, '%y-%m') as month, 
row_number() over(partition by date_format(b.bill_date, '%y-%m') 
order by sum(b.amount) desc) as rnk
from treatments as t join billing as b on t.treatment_id = b.treatment_id
group by t.treatment_type, month) as ranked 
where rnk <= 3;

-- Rank Patients by Spending
select p.patient_id, p.first_name, p.last_name, sum(b.amount) as revenue,
dense_rank() over (order by sum(b.amount) desc) as rnk
from patients as p join billing as b on p.patient_id = b.patient_id 
group by p.patient_id, p.first_name, p.last_name;

-- Age Group Segmentation
SELECT 
    CASE 
        WHEN TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) < 18 THEN 'Child'
        WHEN TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE()) BETWEEN 18 AND 60 THEN 'Adult'
        ELSE 'Senior'
    END AS age_group,
COUNT(*) AS total
FROM patients
GROUP BY age_group;