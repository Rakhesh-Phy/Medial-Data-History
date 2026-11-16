use project_medical_data_history;
show tables;
select*from admissions;
select*from doctors;
select*from patients;
select*from province_names;
describe patients;

select * from patients;
select first_name, last_name, gender from patients where gender = 'M';
select first_name, last_name from patients where allergies is null;
select first_name from patients where first_name like 'C%';
select first_name, last_name from patients where weight between 100 and 120;
select patient_id, first_name, last_name, 
	case
		when allergies is null then 'NKA' 
        else allergies
	end as allergies from patients;
select concat(first_name, ' ',last_name) as full_name from patients;
select p.first_name, p.last_name, pr.province_name from patients as p join province_names as pr on p.province_id = pr.province_id;
select count(*) as total_patients from patients where year(date(birth_date)) = 2010;
select first_name, last_name, height from patients order by height desc limit 1;
select patient_id, first_name, last_name from patients where patient_id in (1, 45, 534, 879, 1000);
select count(*) as total_admissions from admissions;
select * from admissions;
select * from admissions where date(admission_date) = date(discharge_date);
select count(*) from admissions where patient_id = 579;
select * from patients;
select distinct city from patients where province_id = 'NS';
select first_name, last_name from patients where height >160 and weight>70;
select distinct year(date(birth_date)) as birth_year
from patients where birth_date is not null order by birth_year asc;
select first_name from patients group by first_name having count(first_name)=1;
select patient_id, first_name from patients where first_name like 'S%S' and char_length(first_name) <= 6;
select p.patient_id, p.first_name, p.last_name from patients as p join admissions as a
on p.patient_id = a.patient_id where a.diagnosis = 'Dementia';
select first_name from patients order by length(first_name) asc, first_name asc;
select sum(case when gender = 'M' then 1 else 0 end) as total_male,sum(case when gender = 'f' then 1 else 0 end)
as total_female from patients;
select patient_id, diagnosis, count(*) as total_admissions from admissions 
group by patient_id, diagnosis having count(*) >1 order by patient_id asc;
select city, count(*) as total_patients from patients 
group by city order by total_patients desc, city asc;
select first_name, last_name, 'Patient' as role from patients
union all select first_name, last_name, 'Doctor' as role from doctors;
select allergies, count(*) as total_patients from patients where allergies 
is not null group by allergies order by total_patients desc;
select first_name, last_name, birth_date from patients
where year(date(birth_date)) between 1970 and 1979 order by date(birth_date) asc;
select concat(upper(last_name), ',', lower(first_name)) as full_name
from patients order by first_name desc;
select province_id, sum(height) as total_height from patients 
group by province_id having sum(height) >= 7000;
select max(weight) - min(weight) as weight_difference from patients where last_name = 'Maroni';
select day(date(admission_date)) as admission_day,count(*) as total_admissions from admissions 
group by admission_day order by total_admissions desc;
select floor(weight/10)*10 as weight_group, count(*) as total_patients from patients 
group by weight_group order by weight_group desc;
select patient_id, weight, height, case 
	when weight / power(height / 100, 2) >= 30 then 1 else 0 end as isObese from patients;
select p.patient_id, p.first_name, p.last_name, d.specialty from patients as p 
join admissions as a on p.patient_id = a.patient_id join doctors as d on a.attending_doctor_id = d.doctor_id 
where a.diagnosis = 'Epilepsy' and d.first_name = 'Lisa';