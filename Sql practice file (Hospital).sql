Create database hospital;

-- The following questionS are answered in reference to the database name hospital --

use hospital;

#1.write a SQL query to identify the physicians who are the department heads. Return Department name as “Department” and
#Physician name as “Physician”.

select *
from department;

select * 
from physician;

select 
d.name as "DEPARTMENT",
P.name as "PHYSICIAN"
FROM department AS D
INNER JOIN PHYSICIAN AS P
ON D.HEAD = P.EMPLOYEEID;

select 
d.name as "DEPARTMENT",
P.name as "PHYSICIAN"
FROM department AS D, PHYSICIAN AS P
WHERE D.HEAD = P.EMPLOYEEID;

-- FROM THE QUERY GIVES US THE INFORMATION ABOUT PHYSICIAN WHO ARE HEAD OF THEIR DEPARTMENT --

#2. write a SQL query to locate the floor and block where room number 212 is located. Return block floor as "Floor" and block 
#code as "Block".

SELECT blockfloor AS "Floor",
	   blockcode as "block"
from room
where roomnumber = 212;

-- FROM THE QUERY WE GET TO KNOW THE EXACT LOCATION WHERE ROOM NO 212 IS LOCATED --

#3. write a SQL query to count the number of unavailable rooms. Return count as "Number of unavailable rooms".

SELECT count(*) "Number of unavailable rooms"
FROM Room
WHERE unavailable='t';

-- THE QUERY GIVES US THE INFORMATION ABOUT NUMBER OF ROOMS UNAVAILABLE IN THE HOSPITAL --

#4. write a SQL query to identify the physician and the department with which he or she is affiliated. Return Physician name as "Physician",
#and department name as "Department". 

SELECT P.NAME AS "PHYSICIAN",
	   D.NAME AS "DEPARTMENT"
FROM PHYSICIAN AS P 
INNER JOIN affiliated_with AS A
ON P.EMPLOYEEID = A.physician
INNER JOIN DEPARTMENT AS D
ON A.department = D.DEPARTMENTID;

--  THIS QUERY FETCHS THE DETAIL ABOUT PHYSICIAN AND THEIR RESPECTED DEPARTMENT --

#5. write a SQL query to find those physicians who have received special training. Return Physician name as “Physician”, 
#treatment procedure name as "Treatment".

SELECT p.name "Physician",
	   c.name "Treatment"
FROM physician p,
     procedures c,
	 trained_in t
WHERE t.physician = p.employeeid
  AND t.treatment = c.code;
  
 -- WITH THE HELP OF ABOVE QUERY WE GET TO KNOW ABOUT THE PHYSICIAN WHO HAS GOT SPECIAL TRAINING --
 
#6. write a SQL query to find those physicians who are yet to be affiliated. Return Physician name as "Physician", 
#Position, and department as "Department". 

select P.name as "physician",
	   D.name as "department",
       P.position 
from physician as p
inner join affiliated_with as a 
on a.physician = p.employeeid
inner join department as d
on a.department = d.departmentid
where primaryaffiliation="f";

-- ABOVE QUERY GIVES DETAIL ABOUT PHYSICIAN WHO ARE YET TO BE AFFILIATED --

#7. write a SQL query to identify physicians who are not specialists. Return Physician name as "Physician", position as "Designation".

select p.name as "physician",
	   p.position as "department"
from physician as p 
left join trained_in as t
on p.employeeid = t.physician
where t.treatment is null ;
  
-- WITH THE HELP OF ABOVE QUERY WE GET TO KNOW ABOUT THE PHYSICIAN WHO HAS NOT GOT ANY SPECIAL TRAINING --

#8. write a SQL query to identify the patients and the number of physicians with whom they have scheduled appointments. Return Patient 
#name as "Patient", number of Physicians as "Appointment for No. of Physicians".

SELECT P.name AS "Patient",
       count(t.patient) "Appointment for No. of Physicians"
FROM appointment t
INNER JOIN patient P ON t.patient= P.ssn
GROUP BY P.name
HAVING count(t.patient)>1;

-- FROM ABOVE QUERY WE GET THE INFORMATION ABOUT THE NUMBER OF PATIENTS AND NO. OF PHYSICIAN WITH WHOM THEY HAVE APPOINMENT--

#9. write a SQL query to count the number of unique patients who have been scheduled for examination room 'C'.Return unique patients 
#as "No. of patients got appointment for room C". 

SELECT count(DISTINCT patient) AS "No. of patients got appointment for room C"
FROM appointment
WHERE examinationroom='C';

-- THIS QUERY HELPS US TO FETCH THE NO. OF UNIQUE PATIENTS WHO HAS GOT APPOINMENT SCHEDULE FOR ROOM C --

#10. write a SQL query to identify the nurses and the room in which they will assist the physicians. Return Nurse Name as
#"Name of the Nurse" and examination room as "Room No.". 

SELECT n.name AS "Name of the Nurse",
       a.examinationroom AS "Room No."
FROM nurse AS n
JOIN appointment a ON a.prepnurse=n.employeeid;
 
-- TO IDENTIFY THE NURSE AND THE ROOM IN WHICH THEY WILL ASSIST THE PHYSICIAN THIS QUERY IS USED --

#11. write a SQL query to locate the patients' treating physicians and medications. Return Patient name as "Patient", Physician name as 
#"Physician", Medication name as "Medication". 

SELECT t.name AS "Patient",
       p.name AS "Physician",
       m.name AS "Medication"
FROM patient T
INNER JOIN prescribes AS S
ON S.patient = T.ssn
INNER JOIN physician AS P 
ON S.physician = P.employeeid
INNER JOIN medication AS M 
ON S.medication = M.code;

-- FROM THE ABOVE QUERY WE CAN LOCATE THE PATIENTS' TREATING PHYSICIANS AND MEDICATIONS --

#12. write a SQL query to count the number of available rooms in each block. Sort the result-set on ID of the block. Return ID of the 
#block as "Block", count number of available rooms as "Number of available rooms".

SELECT blockcode AS "Block",
       count(*) "Number of available rooms"
FROM room
WHERE available='f'
GROUP BY blockcode
ORDER BY blockcode;

-- ABOVE QUERY HELPS TO COUNT THE NUMBER OF AVAILABLE ROOMS IN EACH BLOCK. --

#13. write a SQL query to count the number of available rooms for each floor in each block. Sort the result-set on floor ID, ID of the block. 
#Return the floor ID as "Floor", ID of the block as "Block", and number of available rooms as "Number of available rooms".

SELECT blockfloor AS "Floor",
       blockcode AS "Block",
       count(*) "Number of available rooms"
FROM room
WHERE unavailable='f'
GROUP BY blockfloor,
         blockcode
ORDER BY blockfloor,
        blockcode;
        
-- TO COUNT THE NUMBER OF AVAILABLE ROOMS FOR EACH FLOOR IN EACH BLOCK THIS QUERY CAN BE USED.-- 
       
# 14. write a SQL query to count the number of rooms that are unavailable in each block and on each floor. Sort the result-set on
# block floor, block code. Return the floor ID as "Floor", block ID as "Block", and number of unavailable as “Number of unavailable rooms"

select blockfloor as "FLOOR",
	   Blockcode as "block",
       count(*) as "number of unavailable rooms"
from room
where unavailable = "t"
group by blockfloor, blockcode
order by blockcode, blockcode;

-- THE QUERY FETCHES INFORMATION REGARDING THE NUMBER OF ROOMS UNAAVAILABLE ON THE FLOORS OR EACH BLOCK ARE AS FOLLOWS--

#15. write a SQL query to find the name of the patients, their block, floor, and room number where they admitted.

SELECT p.name as "Patient",
       s.room as "Room",
       r.blockfloor as "Floor",
       r.blockcode as "Block"
FROM stay as s
JOIN patient p ON s.patient=p.ssn
JOIN room r ON s.room=r.roomnumber;

-- THE QUERY GIVES DATA REGARDING THE PATIENTS ADMITTED ALONG WITH THEIR BLOCK, FLOOR AND ROOM NUMBER.--

#16. write a SQL query to find all physicians who have performed a medical procedure but are not certified to do so.
# Return Physician name as "Physician"
select p.name as 'Patient',
a.name as 'Physician'
FROM patient as p
INNER JOIN prescribes as b
ON p.ssn = b.patient
INNER JOIN physician as a 
ON a.employeeid = b.physician;

-- THE ABOVE QUERY FETCHES DATA REGUARDING HE FOLLOWING ARE THE PHYSICIANS WHO HAVE PERFORMED A ,--
-- EDICAL PROCEDURE BUT ARE NOT CERTIFIED TO DO SO--

#17. write a SQL query to determine which patients have been prescribed medication by their primary care physician.
# Return Patient name as "Patient", and Physician Name as "Physician".
SELECT pt.name AS "Patient",
       p.name AS "Physician"
FROM patient pt
JOIN prescribes pr ON pr.patient=pt.ssn
JOIN physician p ON pt.pcp=p.employeeid
WHERE pt.pcp=pr.physician
  AND pt.pcp=p.employeeid;
  
-- THE ABOVE QUERY GIVES INFORMATION REGUARDING THE FOLLOWING PATIENTS HAVE BEEN PRESCRIBED MEDICATION BY THEIR --
-- PRIMARY HEALTHCARE PHYSICIANS --
  
#18.write a SQL query to find those patients who have undergone a procedure costing more than $5,000, as well as the name of the physician who has provided primary care, should be identified. 
#Return name of the patient as "Patient", name of the physician as "Primary Physician", and cost for the procedure as "Procedure Cost".
SELECT pt.name AS " Patient ",
p.name AS "Primary Physician",
pd.cost AS " Procedure Cost"
FROM patient pt
JOIN undergoes u 
ON u.patient=pt.ssn
JOIN physician p 
ON pt.pcp=p.employeeid
JOIN procedures pd 
ON u.procedure=pd.code
WHERE pd.cost>5000;

-- THE ABOVE QUERY FETCHES INFORMATION REGUARDING THE PATIENTS ALONG WITH THEIR PHYSICIANS WHO'S MEDICAL PROCEDURE COSTS MORE THAN $5000.--

#19. write a SQL query to identify those patients whose primary care is provided by a physician who is not the head of any department. 
# Return Patient name as "Patient", Physician Name as "Primary care Physician".
SELECT pt.name AS "Patient",
       p.name AS "Primary care Physician"
FROM patient pt
JOIN physician p ON pt.pcp=p.employeeid
WHERE pt.pcp NOT IN
    (SELECT head
     FROM department);
     
-- THE QUERY FETCHES DATA REGUARDING THE PATIENTS WHO'S PRIMARY CARE ARE PROVIDES BY 
-- PHYSICIANS WHO ARE NOT THE HEAD OF ANY DEPARTMENT.--
